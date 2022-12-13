define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/FeedbackItemMixin"
	], function(declare, _TemplateItemListMixin, FeedbackItemMixin) {
	
	return declare("km.supervise.list.FeedbackItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: FeedbackItemMixin
	});
});