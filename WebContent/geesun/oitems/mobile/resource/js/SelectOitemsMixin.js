define(['dojo/_base/declare', 'dojo/_base/lang', 'dojo/_base/array', 
        'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/query', 
        'dijit/registry', 'mui/form/_ValidateMixin'], 
		function(declare, lang, array, dom, domAttr, domStyle, query, registry, _ValidateMixin){

	return declare('km.oitems.mobile.js.SelectOitemsMixin', [_ValidateMixin], {
			
		validate: function(elements){
			
			var flag = true;
			
			if(query('.selectedOitemRow').length < 1) {
				domStyle.set(dom.byId('selectOitemTips'), 'display', 'block');
				flag = false;
			} else {
				domStyle.set(dom.byId('selectOitemTips'), 'display', 'none');
			}
			
			return this.inherited(arguments) && flag;
			
		}
		
	});

});
