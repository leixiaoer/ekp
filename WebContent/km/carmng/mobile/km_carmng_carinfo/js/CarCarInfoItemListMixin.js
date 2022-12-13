define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/carmng/mobile/km_carmng_carinfo/js/CarCarInfoItemMixin"
	], function(declare, _TemplateItemListMixin, CarCarInfoItemMixin) {
	
	return declare("km.carmng.list.CarCarInfoItemMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: CarCarInfoItemMixin
	});
});