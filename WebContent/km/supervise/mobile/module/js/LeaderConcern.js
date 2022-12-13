/**
 * 领导关注
 */
define(["mui/i18n/i18n!km-supervise:*"], function(msg) {
  return {
    icon: "muis-supervise-leader",
    text: msg["py.lingDaoGuanZhu"],
    createView: function() {
      return  '<div data-dojo-type="mui/header/Header" data-dojo-mixins="sys/mportal/module/mobile/containers/card/TileMixin" data-dojo-props="height:\'4.4rem\'" class="muiHeaderNav">'
            		+'<div data-dojo-type="mui/nav/MobileCfgNavBar" data-dojo-props="channelName:\'LeaderConcern\'"'
            			+'data-dojo-mixins="km/supervise/mobile/resource/js/header/LeaderConcernNavMixin">'
            			+'</div>'

            		+'<div data-dojo-type="mui/search/SearchButtonBar" '
            			+'data-dojo-props="modelName:\'com.landray.kmss.km.supervise.model.KmSuperviseMain\'">'
            		+'</div>'
            	+'</div>'

        		+'<div data-dojo-type="mui/header/NavHeader" data-dojo-props="channelName:\'LeaderConcern\'">'
        			+'<div data-dojo-type="mui/sort/SortItem" '
        				+'data-dojo-props="name:\'fdApprovalTime\',subject:\'立项时间\',value:\'down\'">'
        			+'</div>'
        			+'<div data-dojo-type="mui/sort/SortItem" '
        				+'data-dojo-props="name:\'fdStartTime\',subject:\'开始时间\',value:\'\'">'
        			+'</div>'
		
	        		+'<div class="muiHeaderItemRight" '
	        			+'data-dojo-type="mui/catefilter/FilterItem" '
	        			+'data-dojo-mixins="mui/syscategory/SysCategoryMixin" '
	        			+'data-dojo-props="modelName: \'com.landray.kmss.km.supervise.model.KmSuperviseTemplet\',catekey: \'categoryId\',prefix: \'\'"></div>'
        		+'</div>'
        		
            	+'<div data-dojo-type="mui/list/NavView" data-dojo-props="channelName:\'LeaderConcern\'">'
            		+'<ul data-dojo-type="mui/list/HashJsonStoreList" class="muiList" '
            			+'data-dojo-mixins="km/supervise/mobile/resource/js/list/LeaderConcernItemListMixin">'
            		+'</ul>'
            	+'</div>'
            	
      }
  }
})
