define([ "dojo/_base/declare", "mui/list/_TemplateItemListMixin",
		"km/asset/mobile/js/list/item/AssetTaskItemMixin" ], function(declare,
		_TemplateItemListMixin, AssetTaskItemMixin) {

	return declare("km.asset.AssetTaskItemListMixin", [ _TemplateItemListMixin ], {

		itemRenderer : AssetTaskItemMixin
	});
});