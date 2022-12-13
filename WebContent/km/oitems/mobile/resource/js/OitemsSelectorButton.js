define([
	"dojo/_base/declare",
	"dojox/mobile/Button",
	"mui/form/_CategoryBase",
	"dojox/mobile/sniff"
	], function(declare, Button, CategoryBase, has) {

	return declare("km.oitems.mobile.js.OitemsSelectorButton", [Button, CategoryBase], {
		
		key: '_oitemSelect',
		
		buildRendering:function(){
			this.inherited(arguments);
			this.domNode.dojoClick = !has('ios');
		},
		
		postCreate : function() {
			this.inherited(arguments);
			this.eventBind();
		},
		
		_onClick : function(evt) {
			this.defer(function(){
				this._selectCate();
			}, 350);
		}
	});
});