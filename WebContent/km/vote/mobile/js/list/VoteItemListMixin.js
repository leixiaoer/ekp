define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/vote/mobile/js/list/item/VoteItemMixin"
	], function(declare, _TemplateItemListMixin, VoteItemMixin) {
	
	return declare("km.vote.list.VoteItemListMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: VoteItemMixin
	});
});