define([
	"dojo/_base/declare", 
	"dojo/_base/lang", 
	'dojo/topic', 
	'dojo/dom-construct',
	'dojo/query',
	'dojo/_base/array',
	'dojox/mobile/SwapView',
	'dojo/parser',
	"dijit/registry",
	"dojo/dom-class",
	"dojo/dom-style",
	"dojox/mobile/viewRegistry",
	"mui/util"
	], function(declare, lang, topic, domCtr, query, array,
				SwapView, parser,registry,domClass, domStyle,viewRegistry,util) {
	
	return declare("km.asset._ViewNavSwapMixin", null, {
		
		SCROLL_UP : '/km/asset/scrollup',
		SCROLL_DOWN : '/km/asset/scrolldown',
		
		
		postCreate : function() {
			this.inherited(arguments);
			this.subscribe('/dojox/mobile/viewChanged', 'handleViewChanged');
			this.subscribe('/mui/nav/onComplete', 'handleNavOnComplete');
			this.subscribe(this.SCROLL_DOWN, 'scrolldown');
			this.subscribe(this.SCROLL_UP, 'scrollup');
		},

		startup : function(){
			if(this._started){ return; }
			this.inherited(arguments);
			this.initSwap();
		},
		
		handleNavOnComplete: function(widget, items) {
			this.refNavBar = widget;
			this.generateSwapList(widget.getChildren());
			this.refNavBar.getChildren()[0].setSelected();
		},
		
		
		initSwap: function() {
			var swap = this.getChildren()[0];
			var scorll = swap.getChildren()[0];
			scorll.reload();
			scorll.resize();
			this.currView = swap;
			swap.reloadTime = new Date().getTime();
		},
		
		
		
		generateSwapList: function(items) {
			array.forEach(items, function(item, i) {
				item.moveTo = this.getChildren()[i].id; // 绑定view跳转
			}, this);
			this.resize();
		},
		
		
		handleViewChanged: function(view) {
			if (!(view instanceof SwapView)) {
				return;
			}
			//document.getElementById("tabBar").style.display="block";
			array.forEach(this.getChildren(), function(child,index) {
				if (child === view) {
					var reloadTime = view.reloadTime || 0;
					var nowTime = new Date().getTime();
					var needLoad = (this.currView != view) && (reloadTime == 0);
					this.currView = view;
					view.containerNode.style.paddingTop = "0";
					this.onSwapViewChanged(view);
					if (needLoad&&view.getChildren()[0].id!='cardSearchView') {
						view.reloadTime = nowTime;
						view.getChildren()[0].reload();
					}
					return false;
				}
			}, this);
		},
		
		onSwapViewChanged: function(view) {
			this.inherited(arguments);
			if (this.refNavBar) {
				var index = array.indexOf(this.getChildren(), view);
				this.refNavBar.getChildren()[index].setSelected();
			}
		},
		
		scrolldown : function(obj, evt) {
			topic.publish('/mui/list/toTop', this , {time:0});
		},
		scrollup : function(obj, evt) {
			//this.initSwap();
			//alert(1111);
			//debugger;
			//query("#myCardView").style("height",400);
			//debugger;
			//this.resize();
			//domStyle.
		},
		
		resize: function() {
			this.inherited(arguments);
			var viewNodes = query('.mblView', this.domNode);
			array.forEach(viewNodes, function(item) {
				var view = viewRegistry.getEnclosingView(item);
				view.height = util.getScreenSize().h - window.___header_height
						- window._footerHeight + 'px';
			}, this);
			if(this.domNode.parentNode){
				var node, len, i, _fixedAppFooter;
				for(i = 0, len = this.domNode.parentNode.childNodes.length; i < len; i++){
					node = this.domNode.parentNode.childNodes[i];
					if(node.nodeType === 1){
						var fixed = node.getAttribute("fixed")
							|| node.getAttribute("data-mobile-fixed")
							|| (registry.byNode(node) && registry.byNode(node).fixed);
						if(fixed === "bottom"){
							domClass.add(node, "mblFixedBottomBar");
							_fixedAppFooter = node;
						}
					}
				}
			}
			array.forEach(this.getChildren(), function(child){
				if(child.resize){
					if (!child._fixedAppFooter) {
						child._fixedAppFooter = _fixedAppFooter;
						child.getChildren()[0]._fixedAppFooter = _fixedAppFooter;
					}
					child.resize();
				}
			});
		}
		
	});
});