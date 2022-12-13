define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/ApprovalItemMixin"
	], function(declare, _TemplateItemListMixin, ApprovalItemMixin) {
	
	return declare("km.supervise.list.ApprovalItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: ApprovalItemMixin
	});
});