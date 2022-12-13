define( [ "dojo/_base/declare"], function(declare) {
	
	return declare("km.oitems.mobile.js.OitemsSelectorMixin", null, {
		templURL : "/km/oitems/mobile/resource/tmpl/oitemselector.jsp",
		
		postCreate: function(){
			this.inherited(arguments);
		},
		
	});
	
});