package com.landray.kmss.geesun.annual.util.alterfield;

/**
 * 记录一条字段的修改记录
 *
 */
public class AlterFieldRecord {
	/**
	 * 该字段显示的值
	 */
	private String text;
	
	/**
	 * 修改前值
	 */
	private Object valueBeforAlter;
	
	/**
	 * 修改后的值
	 */
	private Object valueAfterAlter;

	/**
	 * 该字段显示的值
	 */
	public String getText() {
		return text;
	}
	
	/**
	 * 该字段显示的值
	 */
	public void setText(String text) {
		this.text = text;
	}

	/**
	 * 修改前值
	 */
	public Object getValueBeforAlter() {
		return valueBeforAlter;
	}

	/**
	 * 修改前值
	 */
	public void setValueBeforAlter(Object valueBeforAlter) {
		this.valueBeforAlter = valueBeforAlter;
	}

	/**
	 * 修改后的值
	 */
	public Object getValueAfterAlter() {
		return valueAfterAlter;
	}

	/**
	 * 修改后的值
	 */
	public void setValueAfterAlter(Object valueAfterAlter) {
		this.valueAfterAlter = valueAfterAlter;
	}

}
