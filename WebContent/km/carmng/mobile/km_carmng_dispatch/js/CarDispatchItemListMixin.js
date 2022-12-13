define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/carmng/mobile/km_carmng_dispatch/js/CarDispatchItemMixin"
	], function(declare, _TemplateItemListMixin, CarDispatchItemMixin) {
	
	return declare("km.carmng.list.CarDispatchItemMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: CarDispatchItemMixin
	});
});