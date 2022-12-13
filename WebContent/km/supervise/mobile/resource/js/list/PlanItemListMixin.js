define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/PlanItemMixin"
	], function(declare, _TemplateItemListMixin, PlanItemMixin) {
	
	return declare("km.supervise.list.PlanItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: PlanItemMixin
	});
});