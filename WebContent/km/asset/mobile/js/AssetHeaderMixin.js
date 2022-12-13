define(
		[ "dojo/_base/declare", "mui/nav/NavBarStore", "dojo/request",
			"mui/util", "dojo/text!./tmpl/header.html", "dojo/string",
			"dojo/dom-construct", "dojo/Deferred", "dojo/when",
			"dojo/_base/lang", "dojo/_base/json", "dojo/_base/array",
			"dojo/dom-style", "dojox/mobile/_css3", "dojo/dom-attr",
			"dojo/topic", 'dojox/mobile/TransitionEvent','mui/i18n/i18n!km-asset'],
		function(declare, Nav, request, util, tmpl, string, domConstruct,
				Deferred, when, lang, json, array, domStyle, css3, domAttr,
				topic,TransitionEvent,msg) {

			return declare(
					"km.asset.AssetHeaderMixin",
					null,
					{
							
						navCount : 2,
						SCROLL_UP : '/km/asset/scrollup',
						SCROLL_DOWN : '/km/asset/scrolldown',
						SCROLL_TOP : '/mui/list/toTop',

						li : '<li data-item="${slideId}"><div><h3>${count}</h3><h4>${text}</h4></div></li>',

						buildRendering : function() {
							this.inherited(arguments);
							this.subscribe('/mui/nav/onComplete', 'onComplete');

							this.subscribe(this.SCROLL_UP, 'scrollup');
							this.subscribe(this.SCROLL_DOWN, 'scrolldown');
						},

						scrollup : function(obj, evt) {
							domStyle.set(this.headerNode, {
								'height' : 0
							});
							domStyle.set(this.navNode, {
								'height' : '4rem'
							});
						},

						scrolldown : function(obj, evt) {
							domStyle.set(this.headerNode, {
								'height' : window._header_height + 'px'
							});
							domStyle.set(this.navNode, {
								'height' : 0
							});
							if (!evt || !evt.evt)
								return;
							var navItem = this.getNav().getChildren()[0];
							navItem.setSelected();
							navItem.defaultClickAction(evt.evt);
							topic.publish(this.SCROLL_TOP, this, {
								time : 0
							});
						},

						onComplete : function(obj, items) {
							if (!items)
								return;
							when(this.requestNav(items), lang.hitch(this,
									this.buildNav));
						},
						
						buildNav : function() {
							var ls = [];
							array.forEach(this.navSource,
									function(item, index) {
										ls.push(string.substitute(this.li, {
											count : item['count']?item['count']:"<div class='muiSearchButton mui mui-search'></div>",
											text : item['text'],
											slideId : item['slideId']
										}))
									}, this);
							ls.push(string.substitute(this.li, {
								count : "<div class='muiSearchButton mui mui-search'></div>",
								text : msg['mui.kmAssetCard.page.search'],
								slideId : "cardSearch"
							}))
							
							this.headerNode = domConstruct.toDom(string
									.substitute(tmpl, {
										name : this.name,
										imgUrl : this.imgUrl,
										nav : ls.join('')
									}));

							domConstruct.place(this.headerNode, this.domNode,
									'last');
							this.navNode = domConstruct.create('div', {
								className : 'muiGroupHeaderNav'
							}, this.domNode);

							var children = this.getChildren();
							array.forEach(children, function(item) {
								domConstruct.place(item.domNode, this.navNode,
										'last');
							}, this);
							window._header_height = this.domNode.offsetHeight;

							// 切换nav标签事件
							this.connect(this.headerNode, 'click',
									'_onNavClick');
						},

						_onNavClick : function(evt) {
							var target = evt.target;
							while (target) {
								var itemId = domAttr.get(target, 'data-item');
								if (itemId) {
									if(itemId !='cardSearch'){
										//document.getElementById("tabBar").style.display="block";
									var len = this.getNav().getChildren().length;
									for(var i = 0 ; i < len; i ++) {
										var navItem = this.getNav().getChildren()[i];
										if(navItem.itemId == itemId) {
											topic.publish(this.SCROLL_UP, this, {});
											navItem.setSelected();
											navItem.defaultClickAction(evt);
											break;
										}
									}
									break;
								}else{
									var opts = {
											transition : 'slide',
											transitionDir:1,
											moveTo:'cardSearchView'
										};
									new TransitionEvent(evt.target, opts).dispatch();
									//document.getElementById("tabBar").style.display="none";
								 }
							   }
								target = target.parentNode;
							}
						},

						getNav : function() {
							if (this.navClaz)
								return this.navClaz;
							var children = this.getChildren();
							
							for (var i = 0; i < children.length; i++) {
								if (children[i] instanceof Nav)
									return this.navClaz = children[i];
							}
						},

						navIndex : 0,
						
						requestNav : function(items) {
							this.nav_leng = Math.min(items.length,
									this.navCount);
							this.deferred = new Deferred();
							this.navSource = [];
							for (var i = 0; i < this.nav_leng; i++) {
								this.navIndex++;
								var item = items[i];
								var text = item['text'];
								var count = item['count'];
								var slideId = item['itemId'];
								this.navSource.push({
									text : text,
									count: count,
									slideId:slideId
								});
								if (this.nav_leng == this.navIndex)
									this.deferred.resolve();
							}
							return this.deferred.promise;
						},
						
						startup : function() {
							window.___header_height = this.domNode.offsetHeight;
							this.inherited(arguments);
						},

						makeTranslateStr : function(to) {
							var y = to.y;
							return "translate3d(0," + y + ",0px)";
						},

						// 让惯性变得平滑
						smooth : function(dom) {
							var cssKey = css3['transition'];
							domStyle.set(dom, cssKey,
									' -webkit-transform 100ms linear');
							this.defer(function() {
								domStyle.set(dom, cssKey, '')
							}, 100);
						},

						scrollTo : function(dom, to, smooth) {
							if (smooth)
								this.smooth(dom);
							var s = dom.style;
							s[css3.name("transform")] = this
									.makeTranslateStr(to);
						}
					});
		});