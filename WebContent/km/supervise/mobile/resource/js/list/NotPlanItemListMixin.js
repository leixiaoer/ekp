define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/NotPlanItemMixin"
	], function(declare, _TemplateItemListMixin, NotPlanItemMixin) {
	
	return declare("km.supervise.list.NotPlanItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: NotPlanItemMixin
	});
});