define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/LeaderConcernItemMixin"
	], function(declare, _TemplateItemListMixin, LeaderConcernItemMixin) {
	
	return declare("km.supervise.list.LeaderConcernItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: LeaderConcernItemMixin
	});
});