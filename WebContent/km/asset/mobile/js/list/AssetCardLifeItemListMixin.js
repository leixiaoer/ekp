define([ "dojo/_base/declare", "mui/list/_TemplateItemListMixin",
		"km/asset/mobile/js/list/item/AssetCardLifeItemMixin" ], function(declare,
		_TemplateItemListMixin, AssetCardLifeItemMixin) {

	return declare("km.asset.AssetCardLifeItemListMixin", [ _TemplateItemListMixin ], {

		itemRenderer : AssetCardLifeItemMixin
	});
});