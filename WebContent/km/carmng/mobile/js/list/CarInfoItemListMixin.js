define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/carmng/mobile/js/list/item/CarInfoItemMixin"
	], function(declare, _TemplateItemListMixin, CarInfoItemMixin) {
	
	return declare("km.carmng.list.CarInfoItemListMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: CarInfoItemMixin
	});
});