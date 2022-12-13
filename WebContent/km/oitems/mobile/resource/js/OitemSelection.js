define([ 'dojo/_base/declare', 'mui/iconUtils', 'dojo/_base/array', 'mui/category/CategorySelection', 'dojo/topic', 'dojo/_base/lang', 'dojo/dom-construct'],
	function(declare, iconUtils, array, CategorySelection, topic, lang, domConstruct) {
		var selection = declare('km.oitems.mobile.js.OitemSelection',[ CategorySelection ],{
	
			_initSelection:function(){
				var ctx = this;
				
				topic.publish('km/oitems/selectedoitem/get', function(selectedOitems) {
					array.forEach(selectedOitems || [],function(item){
						ctx._addSelItme(ctx, lang.mixin(item, {
							label: item.title || item.fdName
						}));
					});
				})
				
			},
			
			_buildSelItem:function(item){
				var selDom = domConstruct.create("div",{'id': this.itemPrefix + item.fdId , 'className':'muiCateSecItem'});
				var iconArea = domConstruct.create("div",{'className':'muiCateSecItemIcon'},selDom);
				var iconNode = domConstruct.create("div",{'className':'muiCateIcon'},iconArea);
				this.buildIcon(iconNode, item);
				domConstruct.create("div",{'className':'muiCateSecItemLabel','innerHTML':item.label},selDom);
				return selDom;
			},
	
			buildIcon : function(iconNode, item) {
				iconUtils.setIcon('mui mui-file-text', null, null, null,
					iconNode);
			},
			
			_calcCurSel:function(){
				return this.cateSelArr;
			}
		});
		return selection;
	}
);