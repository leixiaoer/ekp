define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/UndertakeAndSupItemMixin"
	], function(declare, _TemplateItemListMixin, UndertakeAndSupItemMixin) {
	
	return declare("km.supervise.list.UndertakeAndSupItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: UndertakeAndSupItemMixin
	});
});