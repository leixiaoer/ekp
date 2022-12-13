define([ "dojo/_base/declare", "mui/list/_TemplateItemListMixin",
		"km/asset/mobile/js/list/item/AssetCardItemMixin" ], function(declare,
		_TemplateItemListMixin, AssetCardItemMixin) {

	return declare("km.asset.AssetCardItemListMixin", [ _TemplateItemListMixin ], {

		itemRenderer : AssetCardItemMixin
	});
});