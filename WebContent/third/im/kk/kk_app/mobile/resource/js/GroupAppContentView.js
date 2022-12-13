define(
		[ "dojo/_base/declare", "dojox/mobile/View", "dojo/dom-style","dojo/dom-attr",
				"dojo/dom-class", "dojo/_base/window", "dijit/registry",
				"dojo/_base/array", "dojo/topic","dojo/query"],
		function(declare, View, domStyle,domAttr, domClass, win, registry, array,topic,query) {
			var claz = declare(
					"third.kk.GroupAppContentView",
					[ View ],
					{

						buildRendering : function() {
							this.inherited(arguments);
							this.subscribe('/third/kk/groupApp/navItem/changed', 'onItemSelected');
						},

						startup : function() {
							if (this._started)
								return;
							this.findAppBar();
							this.inherited(arguments);
							var key = '';
							if(this.enableTaskTransfer=='true'){
								key = 'task';
							}
							if(!key && this.enableCalendarTransfer=='true'){
								key = 'calendar';
							}
							topic.publish('/mui/navitem/selected',this,{key:key});
						},

						// 搜索fixed为bottom或top的节点
						findAppBar : function() {
							if (this.domNode.parentNode) {
								for (var i = 0, len = this.domNode.parentNode.childNodes.length; i < len; i++) {
									c = this.domNode.parentNode.childNodes[i];
									this.checkFixedBar(c);
								}
							}
						},

						checkFixedBar : function(node) {
							if (node.nodeType === 1) {
								var fixed = node.getAttribute("fixed")
										|| node
												.getAttribute("data-mobile-fixed")
										|| (registry.byNode(node) && registry
												.byNode(node).fixed);
								if (fixed === "top") {
									domClass.add(node, "mblFixedHeaderBar");
									this.fixedHeader = node;
								} else if (fixed === "bottom") {
									domClass.add(node, "mblFixedBottomBar");
									this.fixedFooter = node;
								}
							}
						},

						width : '100%',
						resize : function() {
							this.footerHeight = window._footerHeight = (this.fixedFooter) ? this.fixedFooter.offsetHeight
									: 0;
							this.headerHeight = 38;
							domStyle.set(this.domNode, 'height',
									win.global.innerHeight - this.footerHeight
											- this.headerHeight + 'px');
							array.forEach(this.getChildren(), function(child) {
								if (child.resize)
									child.resize();
							});
						},
						onItemSelected : function(evt){
							var iframeNode = query('iframe',this.domNode)[0];
							domAttr.set(iframeNode,'src',evt.href);
						}
					});
			return claz;
		});