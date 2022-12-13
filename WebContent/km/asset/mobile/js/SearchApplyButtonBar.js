define( [ "dojo/_base/declare", "mui/header/HeaderItem", "mui/folder/_Folder",
  		"mui/search/SearchBarDialogMixin" ], function(declare, HeaderItem, Folder,
  		SearchBarDialogMixin) {

  	return declare("km.asset.SearchApplyButtonBar",
  			[ HeaderItem, Folder, SearchBarDialogMixin ], {

  				icon : "",

  				baseClass : "muiApplySearchButton"

  			});
  });
