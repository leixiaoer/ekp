define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/FinishItemMixin"
	], function(declare, _TemplateItemListMixin, FinishItemMixin) {
	
	return declare("km.supervise.list.FinishItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: FinishItemMixin
	});
});