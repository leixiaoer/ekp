define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"sys/lbpmperson/mobile/resource/js/FastReviewTodoListItem"
	], function(declare, _TemplateItemListMixin, fastReviewTodoListItem) {
	
	return declare("sys.lbpmperson.mobile.FastReviewTodoList", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: fastReviewTodoListItem
	});
});