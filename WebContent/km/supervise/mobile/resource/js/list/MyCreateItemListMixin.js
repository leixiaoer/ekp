define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/MyCreateItemMixin"
	], function(declare, _TemplateItemListMixin, MyCreateItemMixin) {
	
	return declare("km.supervise.list.MyCreateItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: MyCreateItemMixin
	});
});