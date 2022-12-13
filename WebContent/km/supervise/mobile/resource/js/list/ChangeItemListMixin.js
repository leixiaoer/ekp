define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/ChangeItemMixin"
	], function(declare, _TemplateItemListMixin, ChangeItemMixin) {
	
	return declare("km.supervise.list.ChangeItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: ChangeItemMixin
	});
});