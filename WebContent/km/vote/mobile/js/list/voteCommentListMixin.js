define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/vote/mobile/js/list/item/voteCommentItemMixin"
	], function(declare, _TemplateItemListMixin, VoteItemMixin) {
	
	return declare("km.vote.list.VoteCommentListMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: VoteItemMixin
	});
});
