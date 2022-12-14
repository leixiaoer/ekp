/**
 * SyntaxHighlighter http://alexgorbatchev.com/
 * 
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/wiki/SyntaxHighlighter:Donate
 * 
 * @version 2.1.382 (June 24 2010)
 * 
 * @copyright Copyright (C) 2004-2009 Alex Gorbatchev.
 * 
 * @license This file is part of SyntaxHighlighter.
 * 
 * SyntaxHighlighter is free software: you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 * 
 * SyntaxHighlighter is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * SyntaxHighlighter. If not, see <http://www.gnu.org/copyleft/lesser.html>.
 */
if (!window.SyntaxHighlighter) {
	var SyntaxHighlighter = function() {
		var a = {
			defaults : {
				"class-name" : "",
				"first-line" : 1,
				"pad-line-numbers" : true,
				"highlight" : null,
				"smart-tabs" : true,
				"tab-size" : 4,
				"gutter" : true,
				"toolbar" : true,
				"collapse" : false,
				"auto-links" : true,
				"light" : false,
				"wrap-lines" : true,
				"html-script" : false
			},
			config : {
				useScriptTags : true,
				clipboardSwf : null,
				toolbarItemWidth : 16,
				toolbarItemHeight : 16,
				bloggerMode : false,
				stripBrs : false,
				tagName : "pre",
				strings : {
					expandSource : "show source",
					viewSource : "view source",
					copyToClipboard : "copy to clipboard",
					copyToClipboardConfirmation : "The code is in your clipboard now",
					print : "print",
					help : "?",
					alert : "SyntaxHighlighter\n\n",
					noBrush : "Can't find brush for: ",
					brushNotHtmlScript : "Brush wasn't configured for html-script option: ",
					aboutDialog : '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>About SyntaxHighlighter</title></head><body style="font-family:Geneva,Arial,Helvetica,sans-serif;background-color:#fff;color:#000;font-size:1em;text-align:center;"><div style="text-align:center;margin-top:3em;"><div style="font-size:xx-large;">SyntaxHighlighter</div><div style="font-size:.75em;margin-bottom:4em;"><div>version 2.1.382 (June 24 2010)</div><div><a href="http://alexgorbatchev.com" target="_blank" style="color:#0099FF;text-decoration:none;">http://alexgorbatchev.com</a></div><div>If you like this script, please <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2930402" style="color:#0099FF;text-decoration:none;">donate</a> to keep development active!</div></div><div>JavaScript code syntax highlighter.</div><div>Copyright 2004-2009 Alex Gorbatchev.</div></div></body></html>'
				},
				debug : false
			},
			vars : {
				discoveredBrushes : null,
				spaceWidth : null,
				printFrame : null,
				highlighters : {}
			},
			brushes : {},
			regexLib : {
				multiLineCComments : /\/\*[\s\S]*?\*\//gm,
				singleLineCComments : /\/\/.*$/gm,
				singleLinePerlComments : /#.*$/gm,
				doubleQuotedString : /"([^\\"\n]|\\.)*"/g,
				singleQuotedString : /'([^\\'\n]|\\.)*'/g,
				multiLineDoubleQuotedString : /"([^\\"]|\\.)*"/g,
				multiLineSingleQuotedString : /'([^\\']|\\.)*'/g,
				xmlComments : /(&lt;|<)!--[\s\S]*?--(&gt;|>)/gm,
				url : /&lt;\w+:\/\/[\w-.\/?%&=@:;]*&gt;|\w+:\/\/[\w-.\/?%&=@:;]*/g,
				phpScriptTags : {
					left : /(&lt;|<)\?=?/g,
					right : /\?(&gt;|>)/g
				},
				aspScriptTags : {
					left : /(&lt;|<)%=?/g,
					right : /%(&gt;|>)/g
				},
				scriptScriptTags : {
					left : /(&lt;|<)\s*script.*?(&gt;|>)/gi,
					right : /(&lt;|<)\/\s*script\s*(&gt;|>)/gi
				}
			},
			toolbar : {
				create : function(d) {
					var h = document.createElement("DIV"), b = a.toolbar.items;
					h.className = "toolbar";
					for (var c in b) {
						var f = b[c], g = new f(d), e = g.create();
						d.toolbarCommands[c] = g;
						if (e == null) {
							continue
						}
						if (typeof(e) == "string") {
							e = a.toolbar.createButton(e, d.id, c)
						}
						e.className += "item " + c;
						h.appendChild(e)
					}
					return h
				},
				createButton : function(f, c, g) {
					var d = document.createElement("a"), i = d.style, e = a.config, h = e.toolbarItemWidth, b = e.toolbarItemHeight;
					d.href = "#" + g;
					d.title = f;
					d.highlighterId = c;
					d.commandName = g;
					d.innerHTML = f;
					if (isNaN(h) == false) {
						i.width = h + "px"
					}
					if (isNaN(b) == false) {
						i.height = b + "px"
					}
					d.onclick = function(j) {
						try {
							a.toolbar.executeCommand(this, j || window.event,
									this.highlighterId, this.commandName)
						} catch (j) {
							a.utils.alert(j.message)
						}
						return false
					};
					return d
				},
				executeCommand : function(f, g, b, e, d) {
					var c = a.vars.highlighters[b], h;
					if (c == null || (h = c.toolbarCommands[e]) == null) {
						return null
					}
					return h.execute(f, g, d)
				},
				items : {
					expandSource : function(b) {
						this.create = function() {
							if (b.getParam("collapse") != true) {
								return
							}
							return a.config.strings.expandSource
						};
						this.execute = function(d, e, c) {
							var f = b.div;
							d.parentNode.removeChild(d);
							f.className = f.className.replace("collapsed", "")
						}
					},
					viewSource : function(b) {
						this.create = function() {
							return a.config.strings.viewSource
						};
						this.execute = function(d, g, c) {
							var f = a.utils.fixInputString(b.originalCode)
									.replace(/</g, "&lt;"), e = a.utils
									.popup("", "_blank", 750, 400,
											"location=0, resizable=1, menubar=0, scrollbars=1");
							f = a.utils.unindent(f);
							e.document.write("<pre>" + f + "</pre>");
							e.document.close()
						}
					},
					copyToClipboard : function(d) {
						var e, c, b = d.id;
						this.create = function() {
							var g = a.config;
							if (g.clipboardSwf == null) {
								return null
							}
							function l(o) {
								var m = "";
								for (var n in o) {
									m += "<param name='" + n + "' value='"
											+ o[n] + "'/>"
								}
								return m
							}
							function f(o) {
								var m = "";
								for (var n in o) {
									m += " " + n + "='" + o[n] + "'"
								}
								return m
							}
							var k = {
								width : g.toolbarItemWidth,
								height : g.toolbarItemHeight,
								id : b + "_clipboard",
								type : "application/x-shockwave-flash",
								title : a.config.strings.copyToClipboard
							}, j = {
								allowScriptAccess : "always",
								wmode : "transparent",
								flashVars : "highlighterId=" + b,
								menu : "false"
							}, i = g.clipboardSwf, h;
							if (/msie/i.test(navigator.userAgent)) {
								h = "<object" + f({
									classid : "clsid:d27cdb6e-ae6d-11cf-96b8-444553540000",
									codebase : "http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0"
								}) + f(k) + ">" + l(j) + l({
											movie : i
										}) + "</object>"
							} else {
								h = "<embed" + f(k) + f(j) + f({
											src : i
										}) + "/>"
							}
							e = document.createElement("div");
							e.innerHTML = h;
							return e
						};
						this.execute = function(g, i, f) {
							var j = f.command;
							switch (j) {
								case "get" :
									var h = a.utils.unindent(a.utils
											.fixInputString(d.originalCode)
											.replace(/&lt;/g, "<").replace(
													/&gt;/g, ">").replace(
													/&amp;/g, "&"));
									if (window.clipboardData) {
										window.clipboardData.setData("text", h)
									} else {
										return a.utils.unindent(h)
									}
								case "ok" :
									a.utils
											.alert(a.config.strings.copyToClipboardConfirmation);
									break;
								case "error" :
									a.utils.alert(f.message);
									break
							}
						}
					},
					printSource : function(b) {
						this.create = function() {
							return a.config.strings.print
						};
						this.execute = function(e, g, d) {
							var f = document.createElement("IFRAME"), h = null;
							if (a.vars.printFrame != null) {
								document.body.removeChild(a.vars.printFrame)
							}
							a.vars.printFrame = f;
							f.style.cssText = "position:absolute;width:0px;height:0px;left:-500px;top:-500px;";
							document.body.appendChild(f);
							h = f.contentWindow.document;
							c(h, window.document);
							h.write('<div class="'
									+ b.div.className.replace("collapsed", "")
									+ ' printing">' + b.div.innerHTML
									+ "</div>");
							h.close();
							f.contentWindow.focus();
							f.contentWindow.print();
							function c(j, m) {
								var k = m.getElementsByTagName("link");
								for (var l = 0; l < k.length; l++) {
									if (k[l].rel.toLowerCase() == "stylesheet"
											&& /shCore\.css$/.test(k[l].href)) {
										j
												.write('<link type="text/css" rel="stylesheet" href="'
														+ k[l].href
														+ '"></link>')
									}
								}
							}
						}
					}
				}
			},
			utils : {
				indexOf : function(e, b, d) {
					d = Math.max(d || 0, 0);
					for (var c = d; c < e.length; c++) {
						if (e[c] == b) {
							return c
						}
					}
					return -1
				},
				guid : function(b) {
					return b + Math.round(Math.random() * 1000000).toString()
				},
				merge : function(e, d) {
					var b = {}, c;
					for (c in e) {
						b[c] = e[c]
					}
					for (c in d) {
						b[c] = d[c]
					}
					return b
				},
				toBoolean : function(b) {
					switch (b) {
						case "true" :
							return true;
						case "false" :
							return false
					}
					return b
				},
				popup : function(f, e, g, c, d) {
					var b = (screen.width - g) / 2, i = (screen.height - c) / 2;
					d += ", left=" + b + ", top=" + i + ", width=" + g
							+ ", height=" + c;
					d = d.replace(/^,/, "");
					var h = window.open(f, e, d);
					h.focus();
					return h
				},
				addEvent : function(d, b, c) {
					if (d.attachEvent) {
						d["e" + b + c] = c;
						d[b + c] = function() {
							d["e" + b + c](window.event)
						};
						d.attachEvent("on" + b, d[b + c])
					} else {
						d.addEventListener(b, c, false)
					}
				},
				alert : function(b) {
					alert(a.config.strings.alert + b)
				},
				findBrush : function(f, h) {
					var g = a.vars.discoveredBrushes, b = null;
					if (g == null) {
						g = {};
						for (var d in a.brushes) {
							var c = a.brushes[d].aliases;
							if (c == null) {
								continue
							}
							a.brushes[d].name = d.toLowerCase();
							for (var e = 0; e < c.length; e++) {
								g[c[e]] = d
							}
						}
						a.vars.discoveredBrushes = g
					}
					b = a.brushes[g[f]];
					if (b == null && h != false) {
						a.utils.alert(a.config.strings.noBrush + f)
					}
					return b
				},
				eachLine : function(d, e) {
					var b = d.split("\n");
					for (var c = 0; c < b.length; c++) {
						b[c] = e(b[c])
					}
					return b.join("\n")
				},
				trimFirstAndLastLines : function(b) {
					return b.replace(/^[ ]*[\n]+|[\n]*[ ]*$/g, "")
				},
				parseParams : function(h) {
					var d, c = {}, e = new XRegExp("^\\[(?<values>(.*?))\\]$"), f = new XRegExp(
							"(?<name>[\\w-]+)" + "\\s*:\\s*" + "(?<value>"
									+ "[\\w-%#]+|" + "\\[.*?\\]|" + '".*?"|'
									+ "'.*?'" + ")\\s*;?", "g");
					while ((d = f.exec(h)) != null) {
						var g = d.value.replace(/^['"]|['"]$/g, "");
						if (g != null && e.test(g)) {
							var b = e.exec(g);
							g = b.values.length > 0
									? b.values.split(/\s*,\s*/)
									: []
						}
						c[d.name] = g
					}
					return c
				},
				decorate : function(c, b) {
					if (c == null || c.length == 0 || c == "\n") {
						return c
					}
					c = c.replace(/</g, "&lt;");
					c = c.replace(/ {2,}/g, function(d) {
								var e = "";
								for (var f = 0; f < d.length - 1; f++) {
									e += "&nbsp;"
								}
								return e + " "
							});
					if (b != null) {
						c = a.utils.eachLine(c, function(d) {
									if (d.length == 0) {
										return ""
									}
									var e = "";
									d = d.replace(/^(&nbsp;| )+/, function(f) {
												e = f;
												return ""
											});
									if (d.length == 0) {
										return e
									}
									return e + '<code class="' + b + '">' + d
											+ "</code>"
								})
					}
					return c
				},
				padNumber : function(d, c) {
					var b = d.toString();
					while (b.length < c) {
						b = "0" + b
					}
					return b
				},
				measureSpace : function() {
					var c = document.createElement("div"), h, j = 0, f = document.body, d = a.utils
							.guid("measureSpace"), i = '<div class="', g = "</div>", e = "</span>";
					c.innerHTML = i + 'syntaxhighlighter">' + i + 'lines">' + i
							+ 'line">' + i + "content"
							+ '"><span class="block"><span id="' + d
							+ '">&nbsp;' + e + e + g + g + g + g;
					f.appendChild(c);
					h = document.getElementById(d);
					if (/opera/i.test(navigator.userAgent)) {
						var b = window.getComputedStyle(h, null);
						j = parseInt(b.getPropertyValue("width"))
					} else {
						j = h.offsetWidth
					}
					f.removeChild(c);
					return j
				},
				processTabs : function(d, e) {
					var c = "";
					for (var b = 0; b < e; b++) {
						c += " "
					}
					return d.replace(/\t/g, c)
				},
				processSmartTabs : function(f, g) {
					var b = f.split("\n"), e = "\t", c = "";
					for (var d = 0; d < 50; d++) {
						c += "                    "
					}
					function h(i, k, j) {
						return i.substr(0, k) + c.substr(0, j)
								+ i.substr(k + 1, i.length)
					}
					f = a.utils.eachLine(f, function(i) {
								if (i.indexOf(e) == -1) {
									return i
								}
								var k = 0;
								while ((k = i.indexOf(e)) != -1) {
									var j = g - k % g;
									i = h(i, k, j)
								}
								return i
							});
					return f
				},
				fixInputString : function(c) {
					var b = /<br\s*\/?>|&lt;br\s*\/?&gt;/gi;
					if (a.config.bloggerMode == true) {
						c = c.replace(b, "\n")
					}
					if (a.config.stripBrs == true) {
						c = c.replace(b, "")
					}
					return c
				},
				trim : function(b) {
					return b.replace(/^\s+|\s+$/g, "")
				},
				unindent : function(j) {
					var c = a.utils.fixInputString(j).split("\n"), h = new Array(), f = /^\s*/, e = 1000;
					for (var d = 0; d < c.length && e > 0; d++) {
						var b = c[d];
						if (a.utils.trim(b).length == 0) {
							continue
						}
						var g = f.exec(b);
						if (g == null) {
							return j
						}
						e = Math.min(g[0].length, e)
					}
					if (e > 0) {
						for (var d = 0; d < c.length; d++) {
							c[d] = c[d].substr(e)
						}
					}
					return c.join("\n")
				},
				matchesSortCallback : function(c, b) {
					if (c.index < b.index) {
						return -1
					} else {
						if (c.index > b.index) {
							return 1
						} else {
							if (c.length < b.length) {
								return -1
							} else {
								if (c.length > b.length) {
									return 1
								}
							}
						}
					}
					return 0
				},
				getMatches : function(f, g) {
					function h(i, j) {
						return [new a.Match(i[0], i.index, j.css)]
					}
					var d = 0, c = null, b = [], e = g.func ? g.func : h;
					while ((c = g.regex.exec(f)) != null) {
						b = b.concat(e(c, g))
					}
					return b
				},
				processUrls : function(d) {
					var b = "&lt;", c = "&gt;";
					return d.replace(a.regexLib.url, function(e) {
								var g = "", f = "";
								if (e.indexOf(b) == 0) {
									f = b;
									e = e.substring(b.length)
								}
								if (e.indexOf(c) == e.length - c.length) {
									e = e.substring(0, e.length - c.length);
									g = c
								}
								return f + '<a href="' + e + '">' + e + "</a>"
										+ g
							})
				},
				getSyntaxHighlighterScriptTags : function() {
					var c = document.getElementsByTagName("script"), b = [];
					for (var d = 0; d < c.length; d++) {
						if (c[d].type == "syntaxhighlighter") {
							b.push(c[d])
						}
					}
					return b
				},
				stripCData : function(c) {
					var d = "<![CDATA[", b = "]]>", f = a.utils.trim(c), e = false;
					if (f.indexOf(d) == 0) {
						f = f.substring(d.length);
						e = true
					}
					if (f.indexOf(b) == f.length - b.length) {
						f = f.substring(0, f.length - b.length);
						e = true
					}
					return e ? f : c
				}
			},
			highlight : function(h, f) {
				function e(s) {
					var q = [];
					for (var r = 0; r < s.length; r++) {
						q.push(s[r])
					}
					return q
				}
				var b = f ? [f] : e(document
						.getElementsByTagName(a.config.tagName)), j = "innerHTML", n = null, l = a.config;
				if (l.useScriptTags) {
					b = b.concat(a.utils.getSyntaxHighlighterScriptTags())
				}
				if (b.length === 0) {
					return
				}
				for (var g = 0; g < b.length; g++) {
					var k = b[g], d = a.utils.parseParams(k.className), o, c, p;
					d = a.utils.merge(h, d);
					o = d["brush"];
					if (o == null) {
						continue
					}
					if (d["html-script"] == "true"
							|| a.defaults["html-script"] == true) {
						n = new a.HtmlScript(o);
						o = "htmlscript"
					} else {
						var m = a.utils.findBrush(o);
						if (m) {
							o = m.name;
							n = new m()
						} else {
							continue
						}
					}
					c = k[j];
					if (l.useScriptTags) {
						c = a.utils.stripCData(c)
					}
					d["brush-name"] = o;
					n.highlight(c, d);
					p = n.div;
					if (a.config.debug) {
						p = document.createElement("textarea");
						p.value = n.div.innerHTML;
						p.style.width = "70em";
						p.style.height = "30em"
					}
					k.parentNode.replaceChild(p, k)
				}
			},
			all : function(b) {
				a.utils.addEvent(window, "load", function() {
							a.highlight(b)
						})
			}
		};
		a.Match = function(d, b, c) {
			this.value = d;
			this.index = b;
			this.length = d.length;
			this.css = c;
			this.brushName = null
		};
		a.Match.prototype.toString = function() {
			return this.value
		};
		a.HtmlScript = function(b) {
			var d = a.utils.findBrush(b), c, h = new a.brushes.Xml(), g = null;
			if (d == null) {
				return
			}
			c = new d();
			this.xmlBrush = h;
			if (c.htmlScript == null) {
				a.utils.alert(a.config.strings.brushNotHtmlScript + b);
				return
			}
			h.regexList.push({
						regex : c.htmlScript.code,
						func : f
					});
			function e(k, l) {
				for (var i = 0; i < k.length; i++) {
					k[i].index += l
				}
			}
			function f(r, l) {
				var k = r.code, q = [], p = c.regexList, n = r.index
						+ r.left.length, s = c.htmlScript, t;
				for (var o = 0; o < p.length; o++) {
					t = a.utils.getMatches(k, p[o]);
					e(t, n);
					q = q.concat(t)
				}
				if (s.left != null && r.left != null) {
					t = a.utils.getMatches(r.left, s.left);
					e(t, r.index);
					q = q.concat(t)
				}
				if (s.right != null && r.right != null) {
					t = a.utils.getMatches(r.right, s.right);
					e(t, r.index + r[0].lastIndexOf(r.right));
					q = q.concat(t)
				}
				for (var m = 0; m < q.length; m++) {
					q[m].brushName = d.name
				}
				return q
			}
		};
		a.HtmlScript.prototype.highlight = function(b, c) {
			this.xmlBrush.highlight(b, c);
			this.div = this.xmlBrush.div
		};
		a.Highlighter = function() {
		};
		a.Highlighter.prototype = {
			getParam : function(d, c) {
				var b = this.params[d];
				return a.utils.toBoolean(b == null ? c : b)
			},
			create : function(b) {
				return document.createElement(b)
			},
			findMatches : function(e, d) {
				var b = [];
				if (e != null) {
					for (var c = 0; c < e.length; c++) {
						if (typeof(e[c]) == "object") {
							b = b.concat(a.utils.getMatches(d, e[c]))
						}
					}
				}
				return b.sort(a.utils.matchesSortCallback)
			},
			removeNestedMatches : function() {
				var f = this.matches;
				for (var e = 0; e < f.length; e++) {
					if (f[e] === null) {
						continue
					}
					var b = f[e], d = b.index + b.length;
					for (var c = e + 1; c < f.length && f[e] !== null; c++) {
						var g = f[c];
						if (g === null) {
							continue
						} else {
							if (g.index > d) {
								break
							} else {
								if (g.index == b.index && g.length > b.length) {
									this.matches[e] = null
								} else {
									if (g.index >= b.index && g.index < d) {
										this.matches[c] = null
									}
								}
							}
						}
					}
				}
			},
			createDisplayLines : function(b) {
				var n = b.split("\n"), l = parseInt(this.getParam("first-line")), h = this
						.getParam("pad-line-numbers"), m = this.getParam(
						"highlight", []), f = this.getParam("gutter");
				b = "";
				if (h == true) {
					h = (l + n.length - 1).toString().length
				} else {
					if (isNaN(h) == true) {
						h = 0
					}
				}
				for (var g = 0; g < n.length; g++) {
					var o = n[g], c = /^(&nbsp;|\s)+/.exec(o), k = "alt"
							+ (g % 2 == 0 ? 1 : 2), d = a.utils.padNumber(
							l + g, h), e = a.utils.indexOf(m, (l + g)
									.toString()) != -1, j = null;
					if (c != null) {
						j = c[0].toString();
						o = o.substr(j.length)
					}
					o = a.utils.trim(o);
					if (o.length == 0) {
						o = "&nbsp;"
					}
					if (e) {
						k += " highlighted"
					}
					b += '<div class="line '
							+ k
							+ '">'
							+ "<table>"
							+ "<tr>"
							+ (f ? '<td class="number"><code>' + d
									+ "</code></td>" : "")
							+ '<td class="content">'
							+ (j != null ? '<code class="spaces">'
									+ j.replace(" ", "&nbsp;") + "</code>" : "")
							+ o + "</td>" + "</tr>" + "</table>" + "</div>"
				}
				return b
			},
			processMatches : function(b, h) {
				var j = 0, l = "", c = a.utils.decorate, k = this.getParam(
						"brush-name", "");
				function e(m) {
					var i = m ? (m.brushName || k) : k;
					return i ? i + " " : ""
				}
				for (var f = 0; f < h.length; f++) {
					var g = h[f], d;
					if (g === null || g.length === 0) {
						continue
					}
					d = e(g);
					l += c(b.substr(j, g.index - j), d + "plain")
							+ c(g.value, d + g.css);
					j = g.index + g.length
				}
				l += c(b.substr(j), e() + "plain");
				return l
			},
			highlight : function(c, e) {
				var j = a.config, k = a.vars, b, g, h, d = "important";
				this.params = {};
				this.div = null;
				this.lines = null;
				this.code = null;
				this.bar = null;
				this.toolbarCommands = {};
				this.id = a.utils.guid("highlighter_");
				k.highlighters[this.id] = this;
				if (c === null) {
					c = ""
				}
				this.params = a.utils.merge(a.defaults, e || {});
				if (this.getParam("light") == true) {
					this.params.toolbar = this.params.gutter = false
				}
				this.div = b = this.create("DIV");
				this.lines = this.create("DIV");
				this.lines.className = "lines";
				className = "syntaxhighlighter";
				b.id = this.id;
				if (this.getParam("collapse")) {
					className += " collapsed"
				}
				if (this.getParam("gutter") == false) {
					className += " nogutter"
				}
				if (this.getParam("wrap-lines") == false) {
					this.lines.className += " no-wrap"
				}
				className += " " + this.getParam("class-name");
				className += " " + this.getParam("brush-name");
				b.className = className;
				this.originalCode = c;
				this.code = a.utils.trimFirstAndLastLines(c)
						.replace(/\r/g, " ");
				h = this.getParam("tab-size");
				this.code = this.getParam("smart-tabs") == true ? a.utils
						.processSmartTabs(this.code, h) : a.utils.processTabs(
						this.code, h);
				this.code = a.utils.unindent(this.code);
				if (this.getParam("toolbar")) {
					this.bar = this.create("DIV");
					this.bar.className = "bar";
					this.bar.appendChild(a.toolbar.create(this));
					b.appendChild(this.bar);
					var i = this.bar;
					function f() {
						i.className = "bar"
					}
					b.onmouseover = function() {
						f();
						i.className = "bar show"
					};
					b.onmouseout = function() {
						f()
					}
				}
				b.appendChild(this.lines);
				this.matches = this.findMatches(this.regexList, this.code);
				this.removeNestedMatches();
				c = this.processMatches(this.code, this.matches);
				c = this.createDisplayLines(a.utils.trim(c));
				if (this.getParam("auto-links")) {
					c = a.utils.processUrls(c)
				}
				this.lines.innerHTML = c
			},
			getKeywords : function(b) {
				b = b.replace(/^\s+|\s+$/g, "").replace(/\s+/g, "|");
				return "\\b(?:" + b + ")\\b"
			},
			forHtmlScript : function(b) {
				this.htmlScript = {
					left : {
						regex : b.left,
						css : "script"
					},
					right : {
						regex : b.right,
						css : "script"
					},
					code : new XRegExp("(?<left>" + b.left.source + ")"
									+ "(?<code>.*?)" + "(?<right>"
									+ b.right.source + ")", "sgi")
				}
			}
		};
		return a
	}()
}
if (!window.XRegExp) {
	(function() {
		var e = {
			exec : RegExp.prototype.exec,
			match : String.prototype.match,
			replace : String.prototype.replace,
			split : String.prototype.split
		}, d = {
			part : /(?:[^\\([#\s.]+|\\(?!k<[\w$]+>|[pP]{[^}]+})[\S\s]?|\((?=\?(?!#|<[\w$]+>)))+|(\()(?:\?(?:(#)[^)]*\)|<([$\w]+)>))?|\\(?:k<([\w$]+)>|[pP]{([^}]+)})|(\[\^?)|([\S\s])/g,
			replaceVar : /(?:[^$]+|\$(?![1-9$&`']|{[$\w]+}))+|\$(?:([1-9]\d*|[$&`'])|{([$\w]+)})/g,
			extended : /^(?:\s+|#.*)+/,
			quantifier : /^(?:[?*+]|{\d+(?:,\d*)?})/,
			classLeft : /&&\[\^?/g,
			classRight : /]/g
		}, b = function(j, g, h) {
			for (var f = h || 0; f < j.length; f++) {
				if (j[f] === g) {
					return f
				}
			}
			return -1
		}, c = /()??/.exec("")[1] !== undefined, a = {};
		XRegExp = function(o, i) {
			if (o instanceof RegExp) {
				if (i !== undefined) {
					throw TypeError("can't supply flags when constructing one RegExp from another")
				}
				return o.addFlags()
			}
			var i = i || "", f = i.indexOf("s") > -1, k = i.indexOf("x") > -1, p = false, r = [], h = [], g = d.part, l, j, n, m, q;
			g.lastIndex = 0;
			while (l = e.exec.call(g, o)) {
				if (l[2]) {
					if (!d.quantifier.test(o.slice(g.lastIndex))) {
						h.push("(?:)")
					}
				} else {
					if (l[1]) {
						r.push(l[3] || null);
						if (l[3]) {
							p = true
						}
						h.push("(")
					} else {
						if (l[4]) {
							m = b(r, l[4]);
							h.push(m > -1 ? "\\"
									+ (m + 1)
									+ (isNaN(o.charAt(g.lastIndex))
											? ""
											: "(?:)") : l[0])
						} else {
							if (l[5]) {
								h.push(a.unicode ? a.unicode.get(l[5], l[0]
												.charAt(1) === "P") : l[0])
							} else {
								if (l[6]) {
									if (o.charAt(g.lastIndex) === "]") {
										h.push(l[6] === "["
												? "(?!)"
												: "[\\S\\s]");
										g.lastIndex++
									} else {
										j = XRegExp.matchRecursive("&&"
														+ o.slice(l.index),
												d.classLeft, d.classRight, "",
												{
													escapeChar : "\\"
												})[0];
										h.push(l[6] + j + "]");
										g.lastIndex += j.length + 1
									}
								} else {
									if (l[7]) {
										if (f && l[7] === ".") {
											h.push("[\\S\\s]")
										} else {
											if (k && d.extended.test(l[7])) {
												n = e.exec
														.call(
																d.extended,
																o
																		.slice(g.lastIndex
																				- 1))[0].length;
												if (!d.quantifier.test(o
														.slice(g.lastIndex - 1
																+ n))) {
													h.push("(?:)")
												}
												g.lastIndex += n - 1
											} else {
												h.push(l[7])
											}
										}
									} else {
										h.push(l[0])
									}
								}
							}
						}
					}
				}
			}
			q = RegExp(h.join(""), e.replace.call(i, /[sx]+/g, ""));
			q._x = {
				source : o,
				captureNames : p ? r : null
			};
			return q
		};
		XRegExp.addPlugin = function(f, g) {
			a[f] = g
		};
		RegExp.prototype.exec = function(k) {
			var h = e.exec.call(this, k), g, j, f;
			if (h) {
				if (c && h.length > 1) {
					f = new RegExp("^" + this.source + "$(?!\\s)", this
									.getNativeFlags());
					e.replace.call(h[0], f, function() {
								for (j = 1; j < arguments.length - 2; j++) {
									if (arguments[j] === undefined) {
										h[j] = undefined
									}
								}
							})
				}
				if (this._x && this._x.captureNames) {
					for (j = 1; j < h.length; j++) {
						g = this._x.captureNames[j - 1];
						if (g) {
							h[g] = h[j]
						}
					}
				}
				if (this.global && this.lastIndex > (h.index + h[0].length)) {
					this.lastIndex--
				}
			}
			return h
		}
	})()
}
RegExp.prototype.getNativeFlags = function() {
	return (this.global ? "g" : "") + (this.ignoreCase ? "i" : "")
			+ (this.multiline ? "m" : "") + (this.extended ? "x" : "")
			+ (this.sticky ? "y" : "")
};
RegExp.prototype.addFlags = function(a) {
	var b = new XRegExp(this.source, (a || "") + this.getNativeFlags());
	if (this._x) {
		b._x = {
			source : this._x.source,
			captureNames : this._x.captureNames
					? this._x.captureNames.slice(0)
					: null
		}
	}
	return b
};
RegExp.prototype.call = function(a, b) {
	return this.exec(b)
};
RegExp.prototype.apply = function(b, a) {
	return this.exec(a[0])
};
XRegExp.cache = function(c, a) {
	var b = "/" + c + "/" + (a || "");
	return XRegExp.cache[b] || (XRegExp.cache[b] = new XRegExp(c, a))
};
XRegExp.escape = function(a) {
	return a.replace(/[-[\]{}()*+?.\\^$|,#\s]/g, "\\$&")
};
XRegExp.matchRecursive = function(p, d, s, f, b) {
	var b = b || {}, v = b.escapeChar, k = b.valueNames, f = f || "", q = f
			.indexOf("g") > -1, c = f.indexOf("i") > -1, h = f.indexOf("m") > -1, u = f
			.indexOf("y") > -1, f = f.replace(/y/g, ""), d = d instanceof RegExp
			? (d.global ? d : d.addFlags("g"))
			: new XRegExp(d, "g" + f), s = s instanceof RegExp ? (s.global
			? s
			: s.addFlags("g")) : new XRegExp(s, "g" + f), i = [], a = 0, j = 0, n = 0, l = 0, m, e, o, r, g, t;
	if (v) {
		if (v.length > 1) {
			throw SyntaxError("can't supply more than one escape character")
		}
		if (h) {
			throw TypeError("can't supply escape character when using the multiline flag")
		}
		g = XRegExp.escape(v);
		t = new RegExp("^(?:" + g + "[\\S\\s]|(?:(?!" + d.source + "|"
						+ s.source + ")[^" + g + "])+)+", c ? "i" : "")
	}
	while (true) {
		d.lastIndex = s.lastIndex = n
				+ (v ? (t.exec(p.slice(n)) || [""])[0].length : 0);
		o = d.exec(p);
		r = s.exec(p);
		if (o && r) {
			if (o.index <= r.index) {
				r = null
			} else {
				o = null
			}
		}
		if (o || r) {
			j = (o || r).index;
			n = (o ? d : s).lastIndex
		} else {
			if (!a) {
				break
			}
		}
		if (u && !a && j > l) {
			break
		}
		if (o) {
			if (!a++) {
				m = j;
				e = n
			}
		} else {
			if (r && a) {
				if (!--a) {
					if (k) {
						if (k[0] && m > l) {
							i.push([k[0], p.slice(l, m), l, m])
						}
						if (k[1]) {
							i.push([k[1], p.slice(m, e), m, e])
						}
						if (k[2]) {
							i.push([k[2], p.slice(e, j), e, j])
						}
						if (k[3]) {
							i.push([k[3], p.slice(j, n), j, n])
						}
					} else {
						i.push(p.slice(e, j))
					}
					l = n;
					if (!q) {
						break
					}
				}
			} else {
				d.lastIndex = s.lastIndex = 0;
				throw Error("subject data contains unbalanced delimiters")
			}
		}
		if (j === n) {
			n++
		}
	}
	if (q && !u && k && k[0] && p.length > l) {
		i.push([k[0], p.slice(l), l, p.length])
	}
	d.lastIndex = s.lastIndex = 0;
	return i
};
SyntaxHighlighter.brushes.AS3 = function() {
	var b = "class interface function package";
	var a = "-Infinity ...rest Array as AS3 Boolean break case catch const continue Date decodeURI "
			+ "decodeURIComponent default delete do dynamic each else encodeURI encodeURIComponent escape "
			+ "extends false final finally flash_proxy for get if implements import in include Infinity "
			+ "instanceof int internal is isFinite isNaN isXMLName label namespace NaN native new null "
			+ "Null Number Object object_proxy override parseFloat parseInt private protected public "
			+ "return set static String super switch this throw true try typeof uint undefined unescape "
			+ "use void while with";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /\b([\d]+(\.[\d]+)?|0x[a-f0-9]+)\b/gi,
				css : "value"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "color3"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "keyword"
			}, {
				regex : new RegExp("var", "gm"),
				css : "variable"
			}, {
				regex : new RegExp("trace", "gm"),
				css : "color1"
			}];
	this.forHtmlScript(SyntaxHighlighter.regexLib.scriptScriptTags)
};
SyntaxHighlighter.brushes.AS3.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.AS3.aliases = ["actionscript3", "as3"];
SyntaxHighlighter.brushes.Bash = function() {
	var b = "if fi then elif else for do done until while break continue case function return in eq ne gt lt ge le";
	var a = "alias apropos awk basename bash bc bg builtin bzip2 cal cat cd cfdisk chgrp chmod chown chroot"
			+ "cksum clear cmp comm command cp cron crontab csplit cut date dc dd ddrescue declare df "
			+ "diff diff3 dig dir dircolors dirname dirs du echo egrep eject enable env ethtool eval "
			+ "exec exit expand export expr false fdformat fdisk fg fgrep file find fmt fold format "
			+ "free fsck ftp gawk getopts grep groups gzip hash head history hostname id ifconfig "
			+ "import install join kill less let ln local locate logname logout look lpc lpr lprint "
			+ "lprintd lprintq lprm ls lsof make man mkdir mkfifo mkisofs mknod more mount mtools "
			+ "mv netstat nice nl nohup nslookup open op passwd paste pathchk ping popd pr printcap "
			+ "printenv printf ps pushd pwd quota quotacheck quotactl ram rcp read readonly renice "
			+ "remsync rm rmdir rsync screen scp sdiff sed select seq set sftp shift shopt shutdown "
			+ "sleep sort source split ssh strace su sudo sum symlink sync tail tar tee test time "
			+ "times touch top traceroute trap tr true tsort tty type ulimit umask umount unalias "
			+ "uname unexpand uniq units unset unshar useradd usermod users uuencode uudecode v vdir "
			+ "vi watch wc whereis which who whoami Wget xargs yes";
	this.findMatches = function(d, c) {
		c = c.replace(/&gt;/g, ">").replace(/&lt;/g, "<");
		this.code = c;
		return SyntaxHighlighter.Highlighter.prototype.findMatches.apply(this,
				[d, c])
	};
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLinePerlComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "keyword"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "functions"
			}]
};
SyntaxHighlighter.brushes.Bash.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Bash.aliases = ["bash", "shell"];
SyntaxHighlighter.brushes.ColdFusion = function() {
	var b = "Abs ACos AddSOAPRequestHeader AddSOAPResponseHeader AjaxLink AjaxOnLoad ArrayAppend ArrayAvg ArrayClear ArrayDeleteAt "
			+ "ArrayInsertAt ArrayIsDefined ArrayIsEmpty ArrayLen ArrayMax ArrayMin ArraySet ArraySort ArraySum ArraySwap ArrayToList "
			+ "Asc ASin Atn BinaryDecode BinaryEncode BitAnd BitMaskClear BitMaskRead BitMaskSet BitNot BitOr BitSHLN BitSHRN BitXor "
			+ "Ceiling CharsetDecode CharsetEncode Chr CJustify Compare CompareNoCase Cos CreateDate CreateDateTime CreateObject "
			+ "CreateODBCDate CreateODBCDateTime CreateODBCTime CreateTime CreateTimeSpan CreateUUID DateAdd DateCompare DateConvert "
			+ "DateDiff DateFormat DatePart Day DayOfWeek DayOfWeekAsString DayOfYear DaysInMonth DaysInYear DE DecimalFormat DecrementValue "
			+ "Decrypt DecryptBinary DeleteClientVariable DeserializeJSON DirectoryExists DollarFormat DotNetToCFType Duplicate Encrypt "
			+ "EncryptBinary Evaluate Exp ExpandPath FileClose FileCopy FileDelete FileExists FileIsEOF FileMove FileOpen FileRead "
			+ "FileReadBinary FileReadLine FileSetAccessMode FileSetAttribute FileSetLastModified FileWrite Find FindNoCase FindOneOf "
			+ "FirstDayOfMonth Fix FormatBaseN GenerateSecretKey GetAuthUser GetBaseTagData GetBaseTagList GetBaseTemplatePath "
			+ "GetClientVariablesList GetComponentMetaData GetContextRoot GetCurrentTemplatePath GetDirectoryFromPath GetEncoding "
			+ "GetException GetFileFromPath GetFileInfo GetFunctionList GetGatewayHelper GetHttpRequestData GetHttpTimeString "
			+ "GetK2ServerDocCount GetK2ServerDocCountLimit GetLocale GetLocaleDisplayName GetLocalHostIP GetMetaData GetMetricData "
			+ "GetPageContext GetPrinterInfo GetProfileSections GetProfileString GetReadableImageFormats GetSOAPRequest GetSOAPRequestHeader "
			+ "GetSOAPResponse GetSOAPResponseHeader GetTempDirectory GetTempFile GetTemplatePath GetTickCount GetTimeZoneInfo GetToken "
			+ "GetUserRoles GetWriteableImageFormats Hash Hour HTMLCodeFormat HTMLEditFormat IIf ImageAddBorder ImageBlur ImageClearRect "
			+ "ImageCopy ImageCrop ImageDrawArc ImageDrawBeveledRect ImageDrawCubicCurve ImageDrawLine ImageDrawLines ImageDrawOval "
			+ "ImageDrawPoint ImageDrawQuadraticCurve ImageDrawRect ImageDrawRoundRect ImageDrawText ImageFlip ImageGetBlob ImageGetBufferedImage "
			+ "ImageGetEXIFTag ImageGetHeight ImageGetIPTCTag ImageGetWidth ImageGrayscale ImageInfo ImageNegative ImageNew ImageOverlay ImagePaste "
			+ "ImageRead ImageReadBase64 ImageResize ImageRotate ImageRotateDrawingAxis ImageScaleToFit ImageSetAntialiasing ImageSetBackgroundColor "
			+ "ImageSetDrawingColor ImageSetDrawingStroke ImageSetDrawingTransparency ImageSharpen ImageShear ImageShearDrawingAxis ImageTranslate "
			+ "ImageTranslateDrawingAxis ImageWrite ImageWriteBase64 ImageXORDrawingMode IncrementValue InputBaseN Insert Int IsArray IsBinary "
			+ "IsBoolean IsCustomFunction IsDate IsDDX IsDebugMode IsDefined IsImage IsImageFile IsInstanceOf IsJSON IsLeapYear IsLocalHost "
			+ "IsNumeric IsNumericDate IsObject IsPDFFile IsPDFObject IsQuery IsSimpleValue IsSOAPRequest IsStruct IsUserInAnyRole IsUserInRole "
			+ "IsUserLoggedIn IsValid IsWDDX IsXML IsXmlAttribute IsXmlDoc IsXmlElem IsXmlNode IsXmlRoot JavaCast JSStringFormat LCase Left Len "
			+ "ListAppend ListChangeDelims ListContains ListContainsNoCase ListDeleteAt ListFind ListFindNoCase ListFirst ListGetAt ListInsertAt "
			+ "ListLast ListLen ListPrepend ListQualify ListRest ListSetAt ListSort ListToArray ListValueCount ListValueCountNoCase LJustify Log "
			+ "Log10 LSCurrencyFormat LSDateFormat LSEuroCurrencyFormat LSIsCurrency LSIsDate LSIsNumeric LSNumberFormat LSParseCurrency LSParseDateTime "
			+ "LSParseEuroCurrency LSParseNumber LSTimeFormat LTrim Max Mid Min Minute Month MonthAsString Now NumberFormat ParagraphFormat ParseDateTime "
			+ "Pi PrecisionEvaluate PreserveSingleQuotes Quarter QueryAddColumn QueryAddRow QueryConvertForGrid QueryNew QuerySetCell QuotedValueList Rand "
			+ "Randomize RandRange REFind REFindNoCase ReleaseComObject REMatch REMatchNoCase RemoveChars RepeatString Replace ReplaceList ReplaceNoCase "
			+ "REReplace REReplaceNoCase Reverse Right RJustify Round RTrim Second SendGatewayMessage SerializeJSON SetEncoding SetLocale SetProfileString "
			+ "SetVariable Sgn Sin Sleep SpanExcluding SpanIncluding Sqr StripCR StructAppend StructClear StructCopy StructCount StructDelete StructFind "
			+ "StructFindKey StructFindValue StructGet StructInsert StructIsEmpty StructKeyArray StructKeyExists StructKeyList StructKeyList StructNew "
			+ "StructSort StructUpdate Tan TimeFormat ToBase64 ToBinary ToScript ToString Trim UCase URLDecode URLEncodedFormat URLSessionFormat Val "
			+ "ValueList VerifyClient Week Wrap Wrap WriteOutput XmlChildPos XmlElemNew XmlFormat XmlGetNodeType XmlNew XmlParse XmlSearch XmlTransform "
			+ "XmlValidate Year YesNoFormat";
	var c = "cfabort cfajaximport cfajaxproxy cfapplet cfapplication cfargument cfassociate cfbreak cfcache cfcalendar "
			+ "cfcase cfcatch cfchart cfchartdata cfchartseries cfcol cfcollection cfcomponent cfcontent cfcookie cfdbinfo "
			+ "cfdefaultcase cfdirectory cfdiv cfdocument cfdocumentitem cfdocumentsection cfdump cfelse cfelseif cferror "
			+ "cfexchangecalendar cfexchangeconnection cfexchangecontact cfexchangefilter cfexchangemail cfexchangetask "
			+ "cfexecute cfexit cffeed cffile cfflush cfform cfformgroup cfformitem cfftp cffunction cfgrid cfgridcolumn "
			+ "cfgridrow cfgridupdate cfheader cfhtmlhead cfhttp cfhttpparam cfif cfimage cfimport cfinclude cfindex "
			+ "cfinput cfinsert cfinterface cfinvoke cfinvokeargument cflayout cflayoutarea cfldap cflocation cflock cflog "
			+ "cflogin cfloginuser cflogout cfloop cfmail cfmailparam cfmailpart cfmenu cfmenuitem cfmodule cfNTauthenticate "
			+ "cfobject cfobjectcache cfoutput cfparam cfpdf cfpdfform cfpdfformparam cfpdfparam cfpdfsubform cfpod cfpop "
			+ "cfpresentation cfpresentationslide cfpresenter cfprint cfprocessingdirective cfprocparam cfprocresult "
			+ "cfproperty cfquery cfqueryparam cfregistry cfreport cfreportparam cfrethrow cfreturn cfsavecontent cfschedule "
			+ "cfscript cfsearch cfselect cfset cfsetting cfsilent cfslider cfsprydataset cfstoredproc cfswitch cftable "
			+ "cftextarea cfthread cfthrow cftimer cftooltip cftrace cftransaction cftree cftreeitem cftry cfupdate cfwddx "
			+ "cfwindow cfxml cfzip cfzipparam";
	var a = "all and any between cross in join like not null or outer some";
	this.regexList = [{
				regex : new RegExp("--(.*)$", "gm"),
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.xmlComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : new RegExp(this.getKeywords(b), "gmi"),
				css : "functions"
			}, {
				regex : new RegExp(this.getKeywords(a), "gmi"),
				css : "color1"
			}, {
				regex : new RegExp(this.getKeywords(c), "gmi"),
				css : "keyword"
			}]
};
SyntaxHighlighter.brushes.ColdFusion.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.ColdFusion.aliases = ["coldfusion", "cf"];
SyntaxHighlighter.brushes.Cpp = function() {
	var c = "ATOM BOOL BOOLEAN BYTE CHAR COLORREF DWORD DWORDLONG DWORD_PTR "
			+ "DWORD32 DWORD64 FLOAT HACCEL HALF_PTR HANDLE HBITMAP HBRUSH "
			+ "HCOLORSPACE HCONV HCONVLIST HCURSOR HDC HDDEDATA HDESK HDROP HDWP "
			+ "HENHMETAFILE HFILE HFONT HGDIOBJ HGLOBAL HHOOK HICON HINSTANCE HKEY "
			+ "HKL HLOCAL HMENU HMETAFILE HMODULE HMONITOR HPALETTE HPEN HRESULT "
			+ "HRGN HRSRC HSZ HWINSTA HWND INT INT_PTR INT32 INT64 LANGID LCID LCTYPE "
			+ "LGRPID LONG LONGLONG LONG_PTR LONG32 LONG64 LPARAM LPBOOL LPBYTE LPCOLORREF "
			+ "LPCSTR LPCTSTR LPCVOID LPCWSTR LPDWORD LPHANDLE LPINT LPLONG LPSTR LPTSTR "
			+ "LPVOID LPWORD LPWSTR LRESULT PBOOL PBOOLEAN PBYTE PCHAR PCSTR PCTSTR PCWSTR "
			+ "PDWORDLONG PDWORD_PTR PDWORD32 PDWORD64 PFLOAT PHALF_PTR PHANDLE PHKEY PINT "
			+ "PINT_PTR PINT32 PINT64 PLCID PLONG PLONGLONG PLONG_PTR PLONG32 PLONG64 POINTER_32 "
			+ "POINTER_64 PSHORT PSIZE_T PSSIZE_T PSTR PTBYTE PTCHAR PTSTR PUCHAR PUHALF_PTR "
			+ "PUINT PUINT_PTR PUINT32 PUINT64 PULONG PULONGLONG PULONG_PTR PULONG32 PULONG64 "
			+ "PUSHORT PVOID PWCHAR PWORD PWSTR SC_HANDLE SC_LOCK SERVICE_STATUS_HANDLE SHORT "
			+ "SIZE_T SSIZE_T TBYTE TCHAR UCHAR UHALF_PTR UINT UINT_PTR UINT32 UINT64 ULONG "
			+ "ULONGLONG ULONG_PTR ULONG32 ULONG64 USHORT USN VOID WCHAR WORD WPARAM WPARAM WPARAM "
			+ "char bool short int __int32 __int64 __int8 __int16 long float double __wchar_t "
			+ "clock_t _complex _dev_t _diskfree_t div_t ldiv_t _exception _EXCEPTION_POINTERS "
			+ "FILE _finddata_t _finddatai64_t _wfinddata_t _wfinddatai64_t __finddata64_t "
			+ "__wfinddata64_t _FPIEEE_RECORD fpos_t _HEAPINFO _HFILE lconv intptr_t "
			+ "jmp_buf mbstate_t _off_t _onexit_t _PNH ptrdiff_t _purecall_handler "
			+ "sig_atomic_t size_t _stat __stat64 _stati64 terminate_function "
			+ "time_t __time64_t _timeb __timeb64 tm uintptr_t _utimbuf "
			+ "va_list wchar_t wctrans_t wctype_t wint_t signed";
	var a = "break case catch class const __finally __exception __try "
			+ "const_cast continue private public protected __declspec "
			+ "default delete deprecated dllexport dllimport do dynamic_cast "
			+ "else enum explicit extern if for friend goto inline "
			+ "mutable naked namespace new noinline noreturn nothrow "
			+ "register reinterpret_cast return selectany "
			+ "sizeof static static_cast struct switch template this "
			+ "thread throw true false try typedef typeid typename union "
			+ "using uuid virtual void volatile whcar_t while";
	var b = "assert isalnum isalpha iscntrl isdigit isgraph islower isprint"
			+ "ispunct isspace isupper isxdigit tolower toupper errno localeconv "
			+ "setlocale acos asin atan atan2 ceil cos cosh exp fabs floor fmod "
			+ "frexp ldexp log log10 modf pow sin sinh sqrt tan tanh jmp_buf "
			+ "longjmp setjmp raise signal sig_atomic_t va_arg va_end va_start "
			+ "clearerr fclose feof ferror fflush fgetc fgetpos fgets fopen "
			+ "fprintf fputc fputs fread freopen fscanf fseek fsetpos ftell "
			+ "fwrite getc getchar gets perror printf putc putchar puts remove "
			+ "rename rewind scanf setbuf setvbuf sprintf sscanf tmpfile tmpnam "
			+ "ungetc vfprintf vprintf vsprintf abort abs atexit atof atoi atol "
			+ "bsearch calloc div exit free getenv labs ldiv malloc mblen mbstowcs "
			+ "mbtowc qsort rand realloc srand strtod strtol strtoul system "
			+ "wcstombs wctomb memchr memcmp memcpy memmove memset strcat strchr "
			+ "strcmp strcoll strcpy strcspn strerror strlen strncat strncmp "
			+ "strncpy strpbrk strrchr strspn strstr strtok strxfrm asctime "
			+ "clock ctime difftime gmtime localtime mktime strftime time";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /^ *#.*/gm,
				css : "preprocessor"
			}, {
				regex : new RegExp(this.getKeywords(c), "gm"),
				css : "color1 bold"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "functions bold"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "keyword bold"
			}]
};
SyntaxHighlighter.brushes.Cpp.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Cpp.aliases = ["cpp", "c"];
SyntaxHighlighter.brushes.CSharp = function() {
	var b = "abstract as base bool break byte case catch char checked class const "
			+ "continue decimal default delegate do double else enum event explicit "
			+ "extern false finally fixed float for foreach get goto if implicit in int "
			+ "interface internal is lock long namespace new null object operator out "
			+ "override params private protected public readonly ref return sbyte sealed set "
			+ "short sizeof stackalloc static string struct switch this throw true try "
			+ "typeof uint ulong unchecked unsafe ushort using virtual void while";
	function a(c, e) {
		var d = (c[0].indexOf("///") == 0) ? "color1" : "comments";
		return [new SyntaxHighlighter.Match(c[0], c.index, d)]
	}
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLineCComments,
				func : a
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineCComments,
				css : "comments"
			}, {
				regex : /@"(?:[^"]|"")*"/g,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /^\s*#.*/gm,
				css : "preprocessor"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "keyword"
			}, {
				regex : /\bpartial(?=\s+(?:class|interface|struct)\b)/g,
				css : "keyword"
			}, {
				regex : /\byield(?=\s+(?:return|break)\b)/g,
				css : "keyword"
			}];
	this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags)
};
SyntaxHighlighter.brushes.CSharp.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.CSharp.aliases = ["c#", "c-sharp", "csharp"];
SyntaxHighlighter.brushes.CSS = function() {
	function a(f) {
		return "\\b([a-z_]|)" + f.replace(/ /g, "(?=:)\\b|\\b([a-z_\\*]|\\*|)")
				+ "(?=:)\\b"
	}
	function c(f) {
		return "\\b" + f.replace(/ /g, "(?!-)(?!:)\\b|\\b()") + ":\\b"
	}
	var d = "ascent azimuth background-attachment background-color background-image background-position "
			+ "background-repeat background baseline bbox border-collapse border-color border-spacing border-style border-top "
			+ "border-right border-bottom border-left border-top-color border-right-color border-bottom-color border-left-color "
			+ "border-top-style border-right-style border-bottom-style border-left-style border-top-width border-right-width "
			+ "border-bottom-width border-left-width border-width border bottom cap-height caption-side centerline clear clip color "
			+ "content counter-increment counter-reset cue-after cue-before cue cursor definition-src descent direction display "
			+ "elevation empty-cells float font-size-adjust font-family font-size font-stretch font-style font-variant font-weight font "
			+ "height left letter-spacing line-height list-style-image list-style-position list-style-type list-style margin-top "
			+ "margin-right margin-bottom margin-left margin marker-offset marks mathline max-height max-width min-height min-width orphans "
			+ "outline-color outline-style outline-width outline overflow padding-top padding-right padding-bottom padding-left padding page "
			+ "page-break-after page-break-before page-break-inside pause pause-after pause-before pitch pitch-range play-during position "
			+ "quotes right richness size slope src speak-header speak-numeral speak-punctuation speak speech-rate stemh stemv stress "
			+ "table-layout text-align top text-decoration text-indent text-shadow text-transform unicode-bidi unicode-range units-per-em "
			+ "vertical-align visibility voice-family volume white-space widows width widths word-spacing x-height z-index";
	var b = "above absolute all always aqua armenian attr aural auto avoid baseline behind below bidi-override black blink block blue bold bolder "
			+ "both bottom braille capitalize caption center center-left center-right circle close-quote code collapse compact condensed "
			+ "continuous counter counters crop cross crosshair cursive dashed decimal decimal-leading-zero default digits disc dotted double "
			+ "embed embossed e-resize expanded extra-condensed extra-expanded fantasy far-left far-right fast faster fixed format fuchsia "
			+ "gray green groove handheld hebrew help hidden hide high higher icon inline-table inline inset inside invert italic "
			+ "justify landscape large larger left-side left leftwards level lighter lime line-through list-item local loud lower-alpha "
			+ "lowercase lower-greek lower-latin lower-roman lower low ltr marker maroon medium message-box middle mix move narrower "
			+ "navy ne-resize no-close-quote none no-open-quote no-repeat normal nowrap n-resize nw-resize oblique olive once open-quote outset "
			+ "outside overline pointer portrait pre print projection purple red relative repeat repeat-x repeat-y rgb ridge right right-side "
			+ "rightwards rtl run-in screen scroll semi-condensed semi-expanded separate se-resize show silent silver slower slow "
			+ "small small-caps small-caption smaller soft solid speech spell-out square s-resize static status-bar sub super sw-resize "
			+ "table-caption table-cell table-column table-column-group table-footer-group table-header-group table-row table-row-group teal "
			+ "text-bottom text-top thick thin top transparent tty tv ultra-condensed ultra-expanded underline upper-alpha uppercase upper-latin "
			+ "upper-roman url visible wait white wider w-resize x-fast x-high x-large x-loud x-low x-slow x-small x-soft xx-large xx-small yellow";
	var e = "[mM]onospace [tT]ahoma [vV]erdana [aA]rial [hH]elvetica [sS]ans-serif [sS]erif [cC]ourier mono sans serif";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.multiLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /\#[a-fA-F0-9]{3,6}/g,
				css : "value"
			}, {
				regex : /(-?\d+)(\.\d+)?(px|em|pt|\:|\%|)/g,
				css : "value"
			}, {
				regex : /!important/g,
				css : "color3"
			}, {
				regex : new RegExp(a(d), "gm"),
				css : "keyword"
			}, {
				regex : new RegExp(c(b), "g"),
				css : "value"
			}, {
				regex : new RegExp(this.getKeywords(e), "g"),
				css : "color1"
			}];
	this.forHtmlScript({
				left : /(&lt;|<)\s*style.*?(&gt;|>)/gi,
				right : /(&lt;|<)\/\s*style\s*(&gt;|>)/gi
			})
};
SyntaxHighlighter.brushes.CSS.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.CSS.aliases = ["css"];
SyntaxHighlighter.brushes.Delphi = function() {
	var a = "abs addr and ansichar ansistring array as asm begin boolean byte cardinal "
			+ "case char class comp const constructor currency destructor div do double "
			+ "downto else end except exports extended false file finalization finally "
			+ "for function goto if implementation in inherited int64 initialization "
			+ "integer interface is label library longint longword mod nil not object "
			+ "of on or packed pansichar pansistring pchar pcurrency pdatetime pextended "
			+ "pint64 pointer private procedure program property pshortstring pstring "
			+ "pvariant pwidechar pwidestring protected public published raise real real48 "
			+ "record repeat set shl shortint shortstring shr single smallint string then "
			+ "threadvar to true try type unit until uses val var varirnt while widechar "
			+ "widestring with word write writeln xor";
	this.regexList = [{
				regex : /\(\*[\s\S]*?\*\)/gm,
				css : "comments"
			}, {
				regex : /{(?!\$)[\s\S]*?}/gm,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.singleLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /\{\$[a-zA-Z]+ .+\}/g,
				css : "color1"
			}, {
				regex : /\b[\d\.]+\b/g,
				css : "value"
			}, {
				regex : /\$[a-zA-Z0-9]+\b/g,
				css : "value"
			}, {
				regex : new RegExp(this.getKeywords(a), "gmi"),
				css : "keyword"
			}]
};
SyntaxHighlighter.brushes.Delphi.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Delphi.aliases = ["delphi", "pascal", "pas"];
SyntaxHighlighter.brushes.Erlang = function() {
	var a = "after and andalso band begin bnot bor bsl bsr bxor "
			+ "case catch cond div end fun if let not of or orelse "
			+ "query receive rem try when xor" + " module export import define";
	this.regexList = [{
				regex : new RegExp("[A-Z][A-Za-z0-9_]+", "g"),
				css : "constants"
			}, {
				regex : new RegExp("\\%.+", "gm"),
				css : "comments"
			}, {
				regex : new RegExp("\\?[A-Za-z0-9_]+", "g"),
				css : "preprocessor"
			}, {
				regex : new RegExp("[a-z0-9_]+:[a-z0-9_]+", "g"),
				css : "functions"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "keyword"
			}]
};
SyntaxHighlighter.brushes.Erlang.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Erlang.aliases = ["erl", "erlang"];
SyntaxHighlighter.brushes.Groovy = function() {
	var d = "as assert break case catch class continue def default do else extends finally "
			+ "if in implements import instanceof interface new package property return switch "
			+ "throw throws try while public protected private static";
	var c = "void boolean byte char short int long float double";
	var b = "null";
	var a = "allProperties count get size "
			+ "collect each eachProperty eachPropertyName eachWithIndex find findAll "
			+ "findIndexOf grep inject max min reverseEach sort "
			+ "asImmutable asSynchronized flatten intersect join pop reverse subMap toList "
			+ "padRight padLeft contains eachMatch toCharacter toLong toUrl tokenize "
			+ "eachFile eachFileRecurse eachB yte eachLine readBytes readLine getText "
			+ "splitEachLine withReader append encodeBase64 decodeBase64 filterLine "
			+ "transformChar transformLine withOutputStream withPrintWriter withStream "
			+ "withStreams withWriter withWriterAppend write writeLine "
			+ "dump inspect invokeMethod print println step times upto use waitForOrKill "
			+ "getText";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /""".*"""/g,
				css : "string"
			}, {
				regex : new RegExp("\\b([\\d]+(\\.[\\d]+)?|0x[a-f0-9]+)\\b",
						"gi"),
				css : "value"
			}, {
				regex : new RegExp(this.getKeywords(d), "gm"),
				css : "keyword"
			}, {
				regex : new RegExp(this.getKeywords(c), "gm"),
				css : "color1"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "constants"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "functions"
			}];
	this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags)
};
SyntaxHighlighter.brushes.Groovy.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Groovy.aliases = ["groovy"];
SyntaxHighlighter.brushes.Java = function() {
	var a = "abstract assert boolean break byte case catch char class const "
			+ "continue default do double else enum extends "
			+ "false final finally float for goto if implements import "
			+ "instanceof int interface long native new null "
			+ "package private protected public return "
			+ "short static strictfp super switch synchronized this throw throws true "
			+ "transient try void volatile while";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLineCComments,
				css : "comments"
			}, {
				regex : /\/\*([^\*][\s\S]*)?\*\//gm,
				css : "comments"
			}, {
				regex : /\/\*(?!\*\/)\*[\s\S]*?\*\//gm,
				css : "preprocessor"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /\b([\d]+(\.[\d]+)?|0x[a-f0-9]+)\b/gi,
				css : "value"
			}, {
				regex : /(?!\@interface\b)\@[\$\w]+\b/g,
				css : "color1"
			}, {
				regex : /\@interface\b/g,
				css : "color2"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "keyword"
			}];
	this.forHtmlScript({
				left : /(&lt;|<)%[@!=]?/g,
				right : /%(&gt;|>)/g
			})
};
SyntaxHighlighter.brushes.Java.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Java.aliases = ["java"];
SyntaxHighlighter.brushes.JavaFX = function() {
	var b = "Boolean Byte Character Double Duration "
			+ "Float Integer Long Number Short String Void";
	var a = "abstract after and as assert at before bind bound break catch class "
			+ "continue def delete else exclusive extends false finally first for from "
			+ "function if import in indexof init insert instanceof into inverse last "
			+ "lazy mixin mod nativearray new not null on or override package postinit "
			+ "protected public public-init public-read replace return reverse sizeof "
			+ "step super then this throw true try tween typeof var where while with "
			+ "attribute let private readonly static trigger";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : /(-?\.?)(\b(\d*\.?\d+|\d+\.?\d*)(e[+-]?\d+)?|0x[a-f\d]+)\b\.?/gi,
				css : "color2"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "variable"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "keyword"
			}];
	this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags)
};
SyntaxHighlighter.brushes.JavaFX.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.JavaFX.aliases = ["jfx", "javafx"];
SyntaxHighlighter.brushes.JScript = function() {
	var a = "break case catch continue " + "default delete do else false  "
			+ "for function if in instanceof "
			+ "new null return super switch "
			+ "this throw true try typeof var while with";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /\s*#.*/gm,
				css : "preprocessor"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "keyword"
			}];
	this.forHtmlScript(SyntaxHighlighter.regexLib.scriptScriptTags)
};
SyntaxHighlighter.brushes.JScript.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.JScript.aliases = ["js", "jscript", "javascript"];
SyntaxHighlighter.brushes.Perl = function() {
	var a = "abs accept alarm atan2 bind binmode chdir chmod chomp chop chown chr "
			+ "chroot close closedir connect cos crypt defined delete each endgrent "
			+ "endhostent endnetent endprotoent endpwent endservent eof exec exists "
			+ "exp fcntl fileno flock fork format formline getc getgrent getgrgid "
			+ "getgrnam gethostbyaddr gethostbyname gethostent getlogin getnetbyaddr "
			+ "getnetbyname getnetent getpeername getpgrp getppid getpriority "
			+ "getprotobyname getprotobynumber getprotoent getpwent getpwnam getpwuid "
			+ "getservbyname getservbyport getservent getsockname getsockopt glob "
			+ "gmtime grep hex index int ioctl join keys kill lc lcfirst length link "
			+ "listen localtime lock log lstat map mkdir msgctl msgget msgrcv msgsnd "
			+ "oct open opendir ord pack pipe pop pos print printf prototype push "
			+ "quotemeta rand read readdir readline readlink readpipe recv rename "
			+ "reset reverse rewinddir rindex rmdir scalar seek seekdir select semctl "
			+ "semget semop send setgrent sethostent setnetent setpgrp setpriority "
			+ "setprotoent setpwent setservent setsockopt shift shmctl shmget shmread "
			+ "shmwrite shutdown sin sleep socket socketpair sort splice split sprintf "
			+ "sqrt srand stat study substr symlink syscall sysopen sysread sysseek "
			+ "system syswrite tell telldir time times tr truncate uc ucfirst umask "
			+ "undef unlink unpack unshift utime values vec wait waitpid warn write";
	var b = "bless caller continue dbmclose dbmopen die do dump else elsif eval exit "
			+ "for foreach goto if import last local my next no our package redo ref "
			+ "require return sub tie tied unless untie until use wantarray while";
	this.regexList = [{
				regex : new RegExp("#[^!].*$", "gm"),
				css : "comments"
			}, {
				regex : new RegExp("^\\s*#!.*$", "gm"),
				css : "preprocessor"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : new RegExp("(\\$|@|%)\\w+", "g"),
				css : "variable"
			}, {
				regex : new RegExp(this.getKeywords(a), "gmi"),
				css : "functions"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "keyword"
			}];
	this.forHtmlScript(SyntaxHighlighter.regexLib.phpScriptTags)
};
SyntaxHighlighter.brushes.Perl.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Perl.aliases = ["perl", "Perl", "pl"];
SyntaxHighlighter.brushes.Php = function() {
	var a = "abs acos acosh addcslashes addslashes "
			+ "array_change_key_case array_chunk array_combine array_count_values array_diff "
			+ "array_diff_assoc array_diff_key array_diff_uassoc array_diff_ukey array_fill "
			+ "array_filter array_flip array_intersect array_intersect_assoc array_intersect_key "
			+ "array_intersect_uassoc array_intersect_ukey array_key_exists array_keys array_map "
			+ "array_merge array_merge_recursive array_multisort array_pad array_pop array_product "
			+ "array_push array_rand array_reduce array_reverse array_search array_shift "
			+ "array_slice array_splice array_sum array_udiff array_udiff_assoc "
			+ "array_udiff_uassoc array_uintersect array_uintersect_assoc "
			+ "array_uintersect_uassoc array_unique array_unshift array_values array_walk "
			+ "array_walk_recursive atan atan2 atanh base64_decode base64_encode base_convert "
			+ "basename bcadd bccomp bcdiv bcmod bcmul bindec bindtextdomain bzclose bzcompress "
			+ "bzdecompress bzerrno bzerror bzerrstr bzflush bzopen bzread bzwrite ceil chdir "
			+ "checkdate checkdnsrr chgrp chmod chop chown chr chroot chunk_split class_exists "
			+ "closedir closelog copy cos cosh count count_chars date decbin dechex decoct "
			+ "deg2rad delete ebcdic2ascii echo empty end ereg ereg_replace eregi eregi_replace error_log "
			+ "error_reporting escapeshellarg escapeshellcmd eval exec exit exp explode extension_loaded "
			+ "feof fflush fgetc fgetcsv fgets fgetss file_exists file_get_contents file_put_contents "
			+ "fileatime filectime filegroup fileinode filemtime fileowner fileperms filesize filetype "
			+ "floatval flock floor flush fmod fnmatch fopen fpassthru fprintf fputcsv fputs fread fscanf "
			+ "fseek fsockopen fstat ftell ftok getallheaders getcwd getdate getenv gethostbyaddr gethostbyname "
			+ "gethostbynamel getimagesize getlastmod getmxrr getmygid getmyinode getmypid getmyuid getopt "
			+ "getprotobyname getprotobynumber getrandmax getrusage getservbyname getservbyport gettext "
			+ "gettimeofday gettype glob gmdate gmmktime ini_alter ini_get ini_get_all ini_restore ini_set "
			+ "interface_exists intval ip2long is_a is_array is_bool is_callable is_dir is_double "
			+ "is_executable is_file is_finite is_float is_infinite is_int is_integer is_link is_long "
			+ "is_nan is_null is_numeric is_object is_readable is_real is_resource is_scalar is_soap_fault "
			+ "is_string is_subclass_of is_uploaded_file is_writable is_writeable mkdir mktime nl2br "
			+ "parse_ini_file parse_str parse_url passthru pathinfo readlink realpath rewind rewinddir rmdir "
			+ "round str_ireplace str_pad str_repeat str_replace str_rot13 str_shuffle str_split "
			+ "str_word_count strcasecmp strchr strcmp strcoll strcspn strftime strip_tags stripcslashes "
			+ "stripos stripslashes stristr strlen strnatcasecmp strnatcmp strncasecmp strncmp strpbrk "
			+ "strpos strptime strrchr strrev strripos strrpos strspn strstr strtok strtolower strtotime "
			+ "strtoupper strtr strval substr substr_compare";
	var c = "and or xor array as break case "
			+ "cfunction class const continue declare default die do else "
			+ "elseif enddeclare endfor endforeach endif endswitch endwhile "
			+ "extends for foreach function include include_once global if "
			+ "new old_function return static switch use require require_once "
			+ "var while abstract interface public implements extends private protected throw";
	var b = "__FILE__ __LINE__ __METHOD__ __FUNCTION__ __CLASS__";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /\$\w+/g,
				css : "variable"
			}, {
				regex : new RegExp(this.getKeywords(a), "gmi"),
				css : "functions"
			}, {
				regex : new RegExp(this.getKeywords(b), "gmi"),
				css : "constants"
			}, {
				regex : new RegExp(this.getKeywords(c), "gm"),
				css : "keyword"
			}];
	this.forHtmlScript(SyntaxHighlighter.regexLib.phpScriptTags)
};
SyntaxHighlighter.brushes.Php.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Php.aliases = ["php"];
SyntaxHighlighter.brushes.Plain = function() {
};
SyntaxHighlighter.brushes.Plain.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Plain.aliases = ["text", "plain"];
SyntaxHighlighter.brushes.Python = function() {
	var c = "and assert break class continue def del elif else "
			+ "except exec finally for from global if import in is "
			+ "lambda not or pass print raise return try yield while";
	var a = "__import__ abs all any apply basestring bin bool buffer callable "
			+ "chr classmethod cmp coerce compile complex delattr dict dir "
			+ "divmod enumerate eval execfile file filter float format frozenset "
			+ "getattr globals hasattr hash help hex id input int intern "
			+ "isinstance issubclass iter len list locals long map max min next "
			+ "object oct open ord pow print property range raw_input reduce "
			+ "reload repr reversed round set setattr slice sorted staticmethod "
			+ "str sum super tuple type type unichr unicode vars xrange zip";
	var b = "None True False self cls class_";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLinePerlComments,
				css : "comments"
			}, {
				regex : /^\s*@\w+/gm,
				css : "decorator"
			}, {
				regex : /(['\"]{3})([^\1])*?\1/gm,
				css : "comments"
			}, {
				regex : /"(?!")(?:\.|\\\"|[^\""\n])*"/gm,
				css : "string"
			}, {
				regex : /'(?!')(?:\.|(\\\')|[^\''\n])*'/gm,
				css : "string"
			}, {
				regex : /\+|\-|\*|\/|\%|=|==/gm,
				css : "keyword"
			}, {
				regex : /\b\d+\.?\w*/g,
				css : "value"
			}, {
				regex : new RegExp(this.getKeywords(a), "gmi"),
				css : "functions"
			}, {
				regex : new RegExp(this.getKeywords(c), "gm"),
				css : "keyword"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "color1"
			}];
	this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags)
};
SyntaxHighlighter.brushes.Python.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Python.aliases = ["py", "python"];
SyntaxHighlighter.brushes.Ruby = function() {
	var a = "alias and BEGIN begin break case class def define_method defined do each else elsif "
			+ "END end ensure false for if in module new next nil not or raise redo rescue retry return "
			+ "self super then throw true undef unless until when while yield";
	var b = "Array Bignum Binding Class Continuation Dir Exception FalseClass File::Stat File Fixnum Fload "
			+ "Hash Integer IO MatchData Method Module NilClass Numeric Object Proc Range Regexp String Struct::TMS Symbol "
			+ "ThreadGroup Thread Time TrueClass";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLinePerlComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /\b[A-Z0-9_]+\b/g,
				css : "constants"
			}, {
				regex : /:[a-z][A-Za-z0-9_]*/g,
				css : "color2"
			}, {
				regex : /(\$|@@|@)\w+/g,
				css : "variable bold"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "keyword"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "color1"
			}];
	this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags)
};
SyntaxHighlighter.brushes.Ruby.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Ruby.aliases = ["ruby", "rails", "ror", "rb"];
SyntaxHighlighter.brushes.Scala = function() {
	var b = "val sealed case def true trait implicit forSome import match object null finally super "
			+ "override try lazy for var catch throw type extends class while with new final yield abstract "
			+ "else do if return protected private this package false";
	var a = "[_:=><%#@]+";
	this.regexList = [{
				regex : SyntaxHighlighter.regexLib.singleLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineCComments,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineSingleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineDoubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : /0x[a-f0-9]+|\d+(\.\d+)?/gi,
				css : "value"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "keyword"
			}, {
				regex : new RegExp(a, "gm"),
				css : "keyword"
			}]
};
SyntaxHighlighter.brushes.Scala.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Scala.aliases = ["scala"];
SyntaxHighlighter.brushes.Sql = function() {
	var b = "abs avg case cast coalesce convert count current_timestamp "
			+ "current_user day isnull left lower month nullif replace right "
			+ "session_user space substring sum system_user upper user year";
	var c = "absolute action add after alter as asc at authorization begin bigint "
			+ "binary bit by cascade char character check checkpoint close collate "
			+ "column commit committed connect connection constraint contains continue "
			+ "create cube current current_date current_time cursor database date "
			+ "deallocate dec decimal declare default delete desc distinct double drop "
			+ "dynamic else end end-exec escape except exec execute false fetch first "
			+ "float for force foreign forward free from full function global goto grant "
			+ "group grouping having hour ignore index inner insensitive insert instead "
			+ "int integer intersect into is isolation key last level load local max min "
			+ "minute modify move name national nchar next no numeric of off on only "
			+ "open option order out output partial password precision prepare primary "
			+ "prior privileges procedure public read real references relative repeatable "
			+ "restrict return returns revoke rollback rollup rows rule schema scroll "
			+ "second section select sequence serializable set size smallint static "
			+ "statistics table temp temporary then time timestamp to top transaction "
			+ "translation trigger true truncate uncommitted union unique update values "
			+ "varchar varying view when where with work";
	var a = "all and any between cross in join like not null or outer some";
	this.regexList = [{
				regex : /--(.*)$/gm,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineDoubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineSingleQuotedString,
				css : "string"
			}, {
				regex : new RegExp(this.getKeywords(b), "gmi"),
				css : "color2"
			}, {
				regex : new RegExp(this.getKeywords(a), "gmi"),
				css : "color1"
			}, {
				regex : new RegExp(this.getKeywords(c), "gmi"),
				css : "keyword"
			}]
};
SyntaxHighlighter.brushes.Sql.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Sql.aliases = ["sql"];
SyntaxHighlighter.brushes.Vb = function() {
	var a = "AddHandler AddressOf AndAlso Alias And Ansi As Assembly Auto "
			+ "Boolean ByRef Byte ByVal Call Case Catch CBool CByte CChar CDate "
			+ "CDec CDbl Char CInt Class CLng CObj Const CShort CSng CStr CType "
			+ "Date Decimal Declare Default Delegate Dim DirectCast Do Double Each "
			+ "Else ElseIf End Enum Erase Error Event Exit False Finally For Friend "
			+ "Function Get GetType GoSub GoTo Handles If Implements Imports In "
			+ "Inherits Integer Interface Is Let Lib Like Long Loop Me Mod Module "
			+ "MustInherit MustOverride MyBase MyClass Namespace New Next Not Nothing "
			+ "NotInheritable NotOverridable Object On Option Optional Or OrElse "
			+ "Overloads Overridable Overrides ParamArray Preserve Private Property "
			+ "Protected Public RaiseEvent ReadOnly ReDim REM RemoveHandler Resume "
			+ "Return Select Set Shadows Shared Short Single Static Step Stop String "
			+ "Structure Sub SyncLock Then Throw To True Try TypeOf Unicode Until "
			+ "Variant When While With WithEvents WriteOnly Xor";
	this.regexList = [{
				regex : /'.*$/gm,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : /^\s*#.*$/gm,
				css : "preprocessor"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "keyword"
			}];
	this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags)
};
SyntaxHighlighter.brushes.Vb.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Vb.aliases = ["vb", "vbnet"];
SyntaxHighlighter.brushes.Lua = function() {
	var a = "and break do else elseif end false for function if in "
			+ "local nil not or repeat return then true until while";
	var b = "_G _VERSION assert collectgarbage dofile error getfenv "
			+ "getmetatable ipairs load module next pairs pcall print "
			+ " rawequal rawget rawset require select setfenv setmetatable "
			+ "tonumber tostring type unpack xpcall "
			+ "coroutine.create coroutine.resume coroutine.running "
			+ "coroutine.status coroutine.wrap coroutine.yield "
			+ "debug.debug debug.getfenv debug.gethook debug.getinfo "
			+ "debug.getlocal debug.getmetatable debug.getregistry "
			+ "debug.getupvalue debug.setfenv debug.sethook debug.setlocal "
			+ "debug.setmetatable debug.setupvalue debug.traceback "
			+ "file:close file:flush file:lines file:read file:seek "
			+ "file:setvbuf file:write"
			+ "io.close io.flush io.input io.lines io.open io.output "
			+ "io.popen io.read io.stderr io.stdin io.stdout io.tmpfile "
			+ "io.type io.write "
			+ "math.abs math.acos math.asin math.atan math.atan2 math.ceil "
			+ "math.cos math.cosh math.deg math.exp math.floor math.fmod "
			+ "math.frexp math.huge math.ldexp math.log math.log10 math.max "
			+ "math.min math.modf math.pi math.pow math.rad math.random "
			+ "math.randomseed math.sin math.sinh math.sqrt math.tan math.tanh "
			+ "os.clock os.date os.difftime os.execute os.exit os.getenv os.remove "
			+ "os.rename os.setlocale os.time os.tmpname "
			+ "package.cpath package.loaded package.loaders package.loadlib "
			+ "package.path package.preload package.seeall "
			+ "string.byte string.char string.dump string.find string.format "
			+ "string.gmatch string.gsub string.len string.lower string.match "
			+ "string.rep string.reverse string.sub string.upper table.concat "
			+ "table.insert table.maxn table.remove table.sort";
	this.regexList = [{
				regex : /--.*/gm,
				css : "comments"
			}, {
				regex : /--\[\[[\S\s]*\]\]/gm,
				css : "comments"
			}, {
				regex : SyntaxHighlighter.regexLib.doubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.singleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineDoubleQuotedString,
				css : "string"
			}, {
				regex : SyntaxHighlighter.regexLib.multiLineSingleQuotedString,
				css : "string"
			}, {
				regex : new RegExp(this.getKeywords(a), "gm"),
				css : "keyword"
			}, {
				regex : new RegExp(this.getKeywords(b), "gm"),
				css : "functions"
			}]
};
SyntaxHighlighter.brushes.Lua.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Lua.aliases = ["lua"];
SyntaxHighlighter.brushes.Xml = function() {
	function a(e, i) {
		var f = SyntaxHighlighter.Match, h = e[0], c = new XRegExp(
				"(&lt;|<)[\\s\\/\\?]*(?<name>[:\\w-\\.]+)", "xg").exec(h), b = [];
		if (e.attributes != null) {
			var d, g = new XRegExp("(?<name> [\\w:\\-\\.]+)" + "\\s*=\\s*"
							+ "(?<value> \".*?\"|'.*?'|\\w+)", "xg");
			while ((d = g.exec(h)) != null) {
				b.push(new f(d.name, e.index + d.index, "color1"));
				b.push(new f(d.value,
						e.index + d.index + d[0].indexOf(d.value), "string"))
			}
		}
		if (c != null) {
			b.push(new f(c.name, e.index + c[0].indexOf(c.name), "keyword"))
		}
		return b
	}
	this.regexList = [{
		regex : new XRegExp(
				"(\\&lt;|<)\\!\\[[\\w\\s]*?\\[(.|\\s)*?\\]\\](\\&gt;|>)", "gm"),
		css : "color2"
	}, {
		regex : SyntaxHighlighter.regexLib.xmlComments,
		css : "comments"
	}, {
		regex : new XRegExp(
				"(&lt;|<)[\\s\\/\\?]*(\\w+)(?<attributes>.*?)[\\s\\/\\?]*(&gt;|>)",
				"sg"),
		func : a
	}]
};
SyntaxHighlighter.brushes.Xml.prototype = new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Xml.aliases = ["xml", "xhtml", "xslt", "html"];