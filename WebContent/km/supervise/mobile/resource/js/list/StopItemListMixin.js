define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/StopItemMixin"
	], function(declare, _TemplateItemListMixin, StopItemMixin) {
	
	return declare("km.supervise.list.StopItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: StopItemMixin
	});
});