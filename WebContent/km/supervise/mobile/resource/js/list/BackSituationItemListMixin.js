define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/BackSituationItemMixin"
	], function(declare, _TemplateItemListMixin, BackSituationItemMixin) {
	
	return declare("km.supervise.list.BackSituationItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: BackSituationItemMixin
	});
});