define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/TemplateItemMixin"
	], function(declare, _TemplateItemListMixin, TemplateItemMixin) {
	
	return declare("km.supervise.list.TemplateItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: TemplateItemMixin
	});
});