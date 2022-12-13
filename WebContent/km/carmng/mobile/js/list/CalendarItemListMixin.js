define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	dojoConfig.baseUrl+"km/carmng/mobile/js/list/item/CalendarItemMixin.js"
	], function(declare, _TemplateItemListMixin, KmCarmngItemMixin) {
	
	return declare("km.carmng.list.CalendarItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: KmCarmngItemMixin
	});
});