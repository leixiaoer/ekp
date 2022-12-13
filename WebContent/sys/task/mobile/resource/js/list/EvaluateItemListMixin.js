define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"sys/task/mobile/resource/js/list/item/EvaluateItemMixin",
	"sys/task/mobile/resource/js/list/_CollpaseListItemMixin",
	"mui/i18n/i18n!sys-task:mui.sysTaskMain"
	], function(declare, _TemplateItemListMixin, EvaluateItemMixin,_CollpaseListItemMixin,Msg) {
	
	return declare("sys.task.list.EvaluateItemListMixin", [_TemplateItemListMixin,_CollpaseListItemMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: EvaluateItemMixin,
		
		nodataText: Msg['mui.sysTaskMain.no.evaluate'],
			
		nodataIcon:'mui mui_taskComment'	
			
	});
});