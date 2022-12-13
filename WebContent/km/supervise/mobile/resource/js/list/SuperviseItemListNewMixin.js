define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/SuperviseItemNewMixin"
	], function(declare, _TemplateItemListMixin, SuperviseItemNewMixin) {
	
	return declare("km.supervise.list.SuperviseItemListNewMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: SuperviseItemNewMixin
	});
});