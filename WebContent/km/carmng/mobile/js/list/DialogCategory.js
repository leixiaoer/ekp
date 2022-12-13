define( [ "mui/tabbar/TabBarButton","dojo/_base/declare", "dojo/_base/array", "dojo/topic", "dojo/on", "dojo/touch",
          "dojo/dom-construct", "dojo/dom-class", "dojo/query","km/carmng/mobile/js/selectdialog/_DialogCategoryBase", "dojo/_base/lang","dojo/dom-style"],
		function(TabBarButton,declare, array, topic, on, touch, domConstruct, domClass,
				query, CategoryBase, lang,domStyle) {
			var _field = declare("km.carmng.DialogCategory", [TabBarButton,CategoryBase ], {
				
				postCreate : function() {
					this.inherited(arguments);
					this.eventBind();
				},
				
				_onClick : function(evt) {
					this.defer(function(){
						this._selectCate();
					}, 350);
				},
				returnDialog:function(srcObj , evt){
					this.inherited(arguments);
					if(srcObj.key == this.key){
						this.curIds = "";
						this.curNames = "";
					}
				}
			});
			return _field;
		});