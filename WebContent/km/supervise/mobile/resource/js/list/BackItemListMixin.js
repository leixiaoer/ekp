define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/BackItemMixin"
	], function(declare, _TemplateItemListMixin, BackItemMixin) {
	
	return declare("km.supervise.list.BackItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: BackItemMixin
	});
});