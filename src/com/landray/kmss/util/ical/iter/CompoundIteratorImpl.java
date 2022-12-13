// Copyright (C) 2006 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package com.landray.kmss.util.ical.iter;

import java.util.Collection;
import java.util.Comparator;
import java.util.NoSuchElementException;
import java.util.PriorityQueue;

import com.landray.kmss.util.ical.values.DateValue;

/**
 * a recurrence iterator that combines others. Some may be inclusions, and some
 * may be exclusions.
 * 
 * @author mikesamuel+svn@gmail.com (Mike Samuel)
 */
final class CompoundIteratorImpl implements RecurrenceIterator {

	/** a queue that keeps the earliest dates at the head */
	private PriorityQueue<HeapElement> queue;
	private HeapElement pending;
	/**
	 * the number of inclusions on queue. We keep track of this so that we don't
	 * have to drain the exclusions to conclude that the series is exhausted.
	 */
	private int nInclusionsRemaining;

	/**
	 * A generator that will generate only dates that are generated by
	 * inclusions and will not generate any dates that are generated by
	 * exclusions -- i.e. exclusions trump inclusions.
	 * 
	 * @param inclusions
	 *            iterators whose elements should be included unless explicitly
	 *            excluded. non null without null elements.
	 * @param exclusions
	 *            iterators whose elements should not be included. non null
	 *            without null elements.
	 */
	CompoundIteratorImpl(Collection<RecurrenceIterator> inclusions,
			Collection<RecurrenceIterator> exclusions) {
		queue = new PriorityQueue<HeapElement>(inclusions.size()
				+ exclusions.size(), HeapElement.CMP);
		for (RecurrenceIterator it : inclusions) {
			HeapElement el = new HeapElement(true, it);
			if (el.shift()) {
				queue.add(el);
				++nInclusionsRemaining;
			}
		}
		for (RecurrenceIterator it : exclusions) {
			HeapElement el = new HeapElement(false, it);
			if (el.shift()) {
				queue.add(el);
			}
		}
	}

	public boolean hasNext() {
		requirePending();
		return null != pending;
	}

	public DateValue next() {
		requirePending();
		if (null == pending) {
			throw new NoSuchElementException();
		}
		DateValue head = pending.head();
		reattach(pending);
		pending = null;
		return head;
	}

	public void remove() {
		throw new UnsupportedOperationException();
	}

	public void advanceTo(DateValue newStart) {
		long newStartCmp = DateValueComparison.comparable(newStart);
		if (null != pending) {
			if (pending.comparable() >= newStartCmp) {
				return;
			}
			pending.advanceTo(newStart);
			reattach(pending);
			pending = null;
		}

		// Pull each element off the stack in turn, and advance it.
		// Once we reach one we don't need to advance, we're done
		while (0 != nInclusionsRemaining && !queue.isEmpty()
				&& queue.peek().comparable() < newStartCmp) {
			HeapElement el = queue.poll();
			el.advanceTo(newStart);
			reattach(el);
		}
	}

	/**
	 * if the given element's iterator has more data, then push back onto the
	 * heap.
	 */
	private void reattach(HeapElement el) {
		if (el.shift()) {
			queue.add(el);
		} else if (el.inclusion) {
			// if we have no live inclusions, then the rest are exclusions which
			// we
			// can safely discard.
			if (0 == --nInclusionsRemaining) {
				queue.clear();
			}
		}
	}

	/**
	 * make sure that pending contains the next inclusive HeapElement that
	 * doesn't match any exclusion, and remove any dupes of it.
	 */
	private void requirePending() {
		if (null != pending) {
			return;
		}

		long exclusionComparable = Long.MIN_VALUE;
		while (0 != nInclusionsRemaining && !queue.isEmpty()) {
			// find a candidate that is not excluded
			HeapElement inclusion = null;
			do {
				HeapElement candidate = queue.poll();
				if (candidate.inclusion) {
					if (exclusionComparable != candidate.comparable()) {
						inclusion = candidate;
						break;
					}
				} else {
					exclusionComparable = candidate.comparable();
				}
				reattach(candidate);
				if (0 == nInclusionsRemaining) {
					return;
				}
			} while (!queue.isEmpty());
			if (inclusion == null) {
				return;
			}
			long inclusionComparable = inclusion.comparable();

			// Check for any following exclusions and for duplicates.
			// We could change the sort order so that exclusions always preceded
			// inclusions, but that would be less efficient and would make the
			// ordering different than the comparable value.
			boolean excluded = exclusionComparable == inclusionComparable;
			while (!queue.isEmpty()
					&& queue.peek().comparable() == inclusionComparable) {
				HeapElement match = queue.poll();
				excluded |= !match.inclusion;
				reattach(match);
				if (0 == nInclusionsRemaining) {
					return;
				}
			}
			if (!excluded) {
				pending = inclusion;
				return;
			} else {
				reattach(inclusion);
			}
		}
	}

}

final class HeapElement {
	/**
	 * should iterators items be included in the series or should they nullify
	 * any matched items included by other series.
	 */
	final boolean inclusion;
	/** the {@link DateValueComparison#comparable} for {@link #head}. */
	private long comparable;
	/** the last value removed from it. In utc. */
	private DateValue head;
	private RecurrenceIterator it;

	HeapElement(boolean inclusion, RecurrenceIterator it) {
		this.inclusion = inclusion;
		this.it = it;
	}

	/** the last value removed from the iterator. */
	DateValue head() {
		return head;
	}

	/**
	 * A given HeapElement may be compared to many others as it bubbles towards
	 * the heap's root, so we cache this for each HeapElement.
	 */
	long comparable() {
		return comparable;
	}

	/**
	 * discard the current, and return true iff there is another head to replace
	 * it.
	 */
	boolean shift() {
		if (!it.hasNext()) {
			return false;
		}
		head = it.next();
		comparable = DateValueComparison.comparable(head);
		return true;
	}

	/**
	 * advance the underlying iterator to the given date value a la
	 * {@link RecurrenceIterator#advanceTo}.
	 */
	void advanceTo(DateValue dvUtc) {
		it.advanceTo(dvUtc);
	}

	@Override
	public String toString() {
		return "[" + head.toString()
				+ (inclusion ? ", inclusion]" : ", exclusion]");
	}

	/** compares to heap elements by comparing their heads. */
	static Comparator<HeapElement> CMP = new Comparator<HeapElement>() {
		public int compare(HeapElement a, HeapElement b) {
			long ac = a.comparable(), bc = b.comparable();
			return ac < bc ? -1 : ac == bc ? 0 : 1;
		}
	};

}
