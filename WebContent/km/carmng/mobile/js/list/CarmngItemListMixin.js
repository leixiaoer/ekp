define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/carmng/mobile/js/list/item/CarmngItemMixin"
	], function(declare, _TemplateItemListMixin, CarmngItemMixin) {
	
	return declare("km.carmng.list.CarmngItemListMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: CarmngItemMixin
	});
});