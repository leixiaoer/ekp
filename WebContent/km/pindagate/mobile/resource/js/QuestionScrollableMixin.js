define(["dojo/_base/declare","dijit/_Container","dojox/mobile/_ScrollableMixin","dojo/dom-construct","dojo/dom-style","dojo/dom-geometry"],
		function(declare,Container,_ScrollableMixin,domConstruct,domStyle,domGeometry){
	
	return declare("km.pindagate.QuestionResponseScrollableMixin",[Container,_ScrollableMixin],{
			
		buildRendering:function(){
			this.inherited(arguments);
			this.containerNode = domConstruct.create("div",{}, this.domNode);
			this.subscribe('km/pindagate/paging','pagingResize');
			this.subscribe('km/pindagate/touchEnd','touchEndHandle');
			this.subscribe('km/pindagate/slideTo','__slideTo');
		},
		
		resize:function(e){
			this.inherited(arguments);
			if(this.domNode.offsetParent){
				var h = domGeometry.getContentBox(this.domNode.offsetParent).h - domGeometry.getPadExtents(this.domNode).h +120+ "px";
				this.domNode.style.height = h;
			}
		},
		
		pagingResize:function(){
			this.resize();
		},
		
		touchEndHandle:function(){
			this.slideTo({y:0} , 0, 'linear');
		},
		
		__slideTo : function(evt){
			this.slideTo({y: evt.y } , 0, 'linear');
		}
		
	});
});