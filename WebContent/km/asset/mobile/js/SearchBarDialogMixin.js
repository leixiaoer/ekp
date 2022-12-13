define( [ "dojo/_base/declare","dojo/dom-style", "dojo/dom-construct", "dojo/dom-class", "dojo/topic",
          "mui/util", "dojo/touch", "dojox/mobile/_css3",'dojox/mobile/TransitionEvent'  ],
        function(declare, domStyle, domConstruct, domClass, topic, util, touch, css3,TransitionEvent) {
	return declare("km.asset.SearchBarDialogMixin", null , {
			//模块标识
			modelName : "",
			
			searchCancelEvt : "/mui/search/cancel",

			searchShowEvt : "/mui/searchbar/show",
			
			show:function(evt){
				//alert();
				var opts = {
						transition : 'slide',
						transitionDir:1,
						moveTo:'cardSearchView'
					};
				new TransitionEvent(evt.target, opts).dispatch();
				//document.getElementById("tabBar").style.display="none";
			},
			
			hideSearchBar : function(srcObj) {
				alert();
				domStyle.set(this.searchNodeDiv,css3.name('transform'),'translate3d(100%, 0, 0)');
				this.defer(function() {
						domStyle.set(this.searchNodeDiv, {
							display : 'none'
						});
					}, 410);
			}
	});
});