define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/carmng/mobile/js/list/item/CarApplyItemMixin"
	], function(declare, _TemplateItemListMixin, CarApplyItemMixin) {
	
	return declare("km.carmng.list.CarApplyItemMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: CarApplyItemMixin
	});
});