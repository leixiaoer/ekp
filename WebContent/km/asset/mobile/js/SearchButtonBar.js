define( [ "dojo/_base/declare", "mui/header/HeaderItem", "mui/folder/_Folder",
		"km/asset/mobile/js/SearchBarDialogMixin" ], function(declare, HeaderItem, Folder,
		SearchBarDialogMixin) {

	return declare("km.asset.SearchButtonBar",
			[ HeaderItem, Folder, SearchBarDialogMixin ], {

				icon : "mui mui-search",

				baseClass : "muiSearchButton"

			});
});
