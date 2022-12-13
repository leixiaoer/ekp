define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/SupervisePlanItemMixin"
	], function(declare, _TemplateItemListMixin, SysTaskItemMixin) {
	
	return declare("km.supervise.list.SupervisePlanItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: SysTaskItemMixin
	});
});