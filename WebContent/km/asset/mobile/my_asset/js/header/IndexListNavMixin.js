define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/i18n/i18n!km-asset:kmAssetCard.all",
        "mui/i18n/i18n!km-asset:fdAssetStatus.enums"], function(declare, Memory, assetMsg, statusMsg) {
  return declare("km.asset.mobile.myAsset.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&q.mycard=responsible&orderby=fdCode", 
	        		text : assetMsg["kmAssetCard.all"]
	        	},
	        	{ 
	        		url : "/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&q.mycard=responsible&fdAssetStatus=1&orderby=fdCode", 
	        		text : statusMsg["fdAssetStatus.enums.status1"]
	        	},
	        	{ 
	        		url : "/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&q.mycard=responsible&fdAssetStatus=2&orderby=fdCode", 
	        		text : statusMsg["fdAssetStatus.enums.status2"]
	        	},
	        	{ 
	        		url : "/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&q.mycard=responsible&fdAssetStatus=3&orderby=fdCode", 
	        		text : statusMsg["fdAssetStatus.enums.status3"]
	        	},
	        	{ 
	        		url : "/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&q.mycard=responsible&fdAssetStatus=4&orderby=fdCode", 
	        		text : statusMsg["fdAssetStatus.enums.status4"]
	        	},
	        	{ 
	        		url : "/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&q.mycard=responsible&fdAssetStatus=5&orderby=fdCode", 
	        		text : statusMsg["fdAssetStatus.enums.status5"]
	        	}
        ]
    })
  })
})