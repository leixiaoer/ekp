define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/ManageAndChargeItemMixin"
	], function(declare, _TemplateItemListMixin, ManageAndChargeItemMixin) {
	
	return declare("km.supervise.list.ManageAndChargeItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: ManageAndChargeItemMixin
	});
});