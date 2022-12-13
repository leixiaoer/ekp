define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/PlanAndBackItemMixin"
	], function(declare, _TemplateItemListMixin, PlanAndBackItemMixin) {
	
	return declare("km.supervise.list.PlanAndBackItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: PlanAndBackItemMixin
	});
});