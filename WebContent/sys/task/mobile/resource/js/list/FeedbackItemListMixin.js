define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"sys/task/mobile/resource/js/list/item/FeedbackItemMixin",
	"sys/task/mobile/resource/js/list/_CollpaseListItemMixin",
	"mui/i18n/i18n!sys-task:mui.sysTaskMain"
	], function(declare, _TemplateItemListMixin, FeedbackItemMixin,_CollpaseListItemMixin,Msg) {
	
	return declare("sys.task.list.FeedbackItemListMixin", [_TemplateItemListMixin,_CollpaseListItemMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: FeedbackItemMixin,
		
		nodataText: Msg['mui.sysTaskMain.no.feedback'],
		
		nodataIcon:'mui mui_taskFeedback'
		
	});
});