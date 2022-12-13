define([
        "dojo/_base/declare",
        "dojox/mobile/TabBar",
        "dojo/dom-class",
        "dojo/dom-style",
        "dojo/_base/lang",
    	"dojo/dom-geometry",
    	"dojo/_base/array"
	], function(declare, TabBar, domClass, domStyle, lang, domGeometry, array) {
	
	return declare("mui.tabbar.TabBar", [TabBar], {
		
		fill: 'always',		
		
		resize: function(size){
			if(!this._resized)
			   this.resizeByGrid(size);
		},
		
		initWidth:60,
		
		intiDraftBtnWidth:0,
		
		resizeByGrid: function(size) {
			var i, w, h;
			var _self = this;
			if(size && size.w){
				w = size.w;
			}else{
				w = domGeometry.getMarginBox(this.domNode).w;
				var draftButtonWidth = Math.floor(w/4);
				if (!this.intiDraftBtnWidth) {
					this.intiDraftBtnWidth = draftButtonWidth;
				}
				var childLength = this.getChildren().length;
				var buttonNum = childLength;
				array.forEach(this.getChildren(), function(child, i) {
					if(child.domNode.className && child.domNode.className.indexOf("muiSplitterButton")>0){
						if(!(child.totalCopies && child.totalCopies > 0 && child.proportion && child.proportion > 0)){
							w = w - domGeometry.getMarginBox(child.domNode).w;
							childLength = childLength -1;
						}
					}
					if(child.domNode.className && child.domNode.className.indexOf("muiBarFloatLeftButton")>0){
						w = w-_self.initWidth;
						childLength = childLength -1;
					}
					if(child.domNode.className && child.domNode.className.indexOf("muiBarFloatRightButton")>0){
						w = w-_self.initWidth;
						childLength = childLength -1;
					}
					if(child.domNode.className && child.domNode.className.indexOf("muiBarSaveDraftButton")>0){
						if(!child._resized){
							if (!draftButtonWidth) {
								draftButtonWidth = this.intiDraftBtnWidth;
							}
							child.domNode.style.width = draftButtonWidth + "px";
						}
						w = w - draftButtonWidth;
						childLength = childLength -1;
					}
					if(domStyle.get(child.domNode,"display") == 'none'){
						childLength = childLength -1;
					}
				});
			}
			domClass.toggle(this.domNode, "mblTabBarNoIcons",
							!array.some(this.getChildren(), function(w){ return w.iconNode1; }));
			domClass.toggle(this.domNode, "mblTabBarNoText",
							!array.some(this.getChildren(), function(w){ return w.label; }));
			
			domClass.add(this.domNode, "muiTabBarGrid");
			var cellWidth = w;
			
			//tabbar隐藏的时候不计算赋值，解决缺陷#64344
			if(w > 0){
				cellWidth = w / childLength - 2;

				array.forEach(this.getChildren(), function(child, i) {
					if(child.totalCopies && child.totalCopies > 0 && child.proportion && child.proportion > 0){//按钮占比
						//新的按钮占比控制
						cellWidth = (w/child.totalCopies * child.proportion);
						if((child.domNode.className.indexOf("muiSplitterButton") < 0 
								&& child.domNode.className.indexOf("muiBarFloatLeftButton") < 0 
								&& child.domNode.className.indexOf("muiBarFloatRightButton") < 0
								&& child.domNode.className.indexOf("muiBarSaveDraftButton") < 0) || child.domNode.className.indexOf("muiSplitterButton") >= 0 ){
							child.domNode.style.width = (cellWidth) + "px";
						}
					}else{
						if(child.domNode.className.indexOf("muiSplitterButton") < 0 
								&& child.domNode.className.indexOf("muiBarFloatLeftButton") < 0 
								&& child.domNode.className.indexOf("muiBarFloatRightButton") < 0
								&& child.domNode.className.indexOf("muiBarSaveDraftButton") < 0){
							child.domNode.style.width = (cellWidth ) + "px";
						}
					}
				});
			}
			
			
			if(size && size.w) {
				domGeometry.setMarginBox(this.domNode, size);
			}
		}
	});
});