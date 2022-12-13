define([ "dojo/_base/declare",'dojo/dom-style','dojo/window'],
		function(declare,domStyle,win){
	
	return declare("sys.task.mobile.resource.js.ResizeViewMixin", null, {
		
		hasResize:false,
		
		buildRendering:function(){
			this.inherited(arguments);
			this.subscribe('/mui/navitem/_selected','resizeView');
		},
		
		resizeView:function(obj){
			var id = obj.moveTo || obj.id;
			if(!this.hasResize && id == this.id ){
				var parent = this.getParent(),
					winBox = win.getBox(),
					domOffsetTop = this._getDomOffsetTop(obj.domNode),
					h = winBox.h - domOffsetTop;
				domStyle.set(this.domNode, {
					'min-height' : h + 'px'
				});
				this.hasResize = true;
			}
		},
		
		_getDomOffsetTop:function(node){
			 var offsetParent = node;
			 var nTp = 0;
			 while (offsetParent!=null && offsetParent!=document.body) { 
				 nTp += offsetParent.offsetTop; 
				 offsetParent = offsetParent.offsetParent; 
			 } 
			 return nTp+ 50 ;
		}
		
	});
});