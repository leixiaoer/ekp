define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/MySuperviseItemMixin"
	], function(declare, _TemplateItemListMixin, MySuperviseItemMixin) {
	
	return declare("km.supervise.list.MySuperviseItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: MySuperviseItemMixin
	});
});