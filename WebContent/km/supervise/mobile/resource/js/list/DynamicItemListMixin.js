define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/DynamicItemMixin"
	], function(declare, _TemplateItemListMixin, DynamicItemMixin) {
	
	return declare("km.supervise.list.DynamicItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: DynamicItemMixin
	});
});