define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/ListItemMixin"
	], function(declare, _TemplateItemListMixin, kmSuperviseItemMixin) {
	
	return declare("km.supervise.list.CalendarItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: kmSuperviseItemMixin
	});
});