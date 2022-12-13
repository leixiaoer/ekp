/**
 * 导师面板
 */
define(["mui/createUtils","mui/i18n/i18n!km-supervise:*"], function(createUtils,msg) {
  return {
    icon: "muis-supervise-all",
    text: msg["py.DuBanALL"],
    createView: function() {
      return '<div data-dojo-type="mui/header/Header" data-dojo-props="height:\'4.4rem\'" class="muiHeaderNav">'
				+'<div data-dojo-type="mui/nav/MobileCfgNavBar" data-dojo-props="channelName:\'AllSupervise\'"'
					+'data-dojo-mixins="km/supervise/mobile/resource/js/header/SuperviseNavStatusMixin">'
				+'</div>'
		
				+'<div data-dojo-type="mui/search/SearchButtonBar" '
					+'data-dojo-props="modelName:\'com.landray.kmss.km.supervise.model.KmSuperviseMain\'">'
				+'</div>'
			+'</div>'
	
			+'<div data-dojo-type="mui/header/NavHeader" data-dojo-props="channelName:\'AllSupervise\'">'
				+'<div data-dojo-type="mui/sort/SortItem" '
					+'data-dojo-props="name:\'fdApprovalTime\',subject:\'立项时间\',value:\'down\'">'
				+'</div>'
				+'<div data-dojo-type="mui/sort/SortItem" '
					+'data-dojo-props="name:\'fdStartTime\',subject:\'开始时间\',value:\'\'">'
				+'</div>'
				
				+'<div class="muiHeaderItemRight" '
					+'data-dojo-type="mui/catefilter/FilterItem" '
					+'data-dojo-mixins="mui/syscategory/SysCategoryMixin" '
					+'data-dojo-props="modelName: \'com.landray.kmss.km.supervise.model.KmSuperviseTemplet\',catekey: \'cateId\',prefix: \'\'"></div>'
				+'</div>'
				
			+'<div data-dojo-type="mui/list/NavView" data-dojo-props="channelName:\'AllSupervise\'">'
				+'<ul data-dojo-type="mui/list/HashJsonStoreList" class="muiList" '
					+'data-dojo-mixins="km/supervise/mobile/resource/js/list/SuperviseItemListNewMixin">'
				+'</ul>'
			+'</div>'
    }
  }
})
