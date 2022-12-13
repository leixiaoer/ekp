define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/RemarkItemMixin"
	], function(declare, _TemplateItemListMixin, RemarkItemMixin) {
	
	return declare("km.supervise.list.RemarkItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: RemarkItemMixin
	});
});