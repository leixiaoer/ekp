define([ "dojo/_base/declare", "mui/list/_TemplateItemListMixin",
		"km/asset/mobile/js/list/item/AssetCardPersonnelItemMixin" ], function(declare,
		_TemplateItemListMixin, AssetCardPersonnelItemMixin) {

	return declare("km.asset.AssetCardPersonnelListMixin", [ _TemplateItemListMixin ], {

		itemRenderer : AssetCardPersonnelItemMixin
	});
});