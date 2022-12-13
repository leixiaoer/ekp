define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/i18n/i18n!km-asset:kmAsset.mobile.tab.change.asset.all",
        "mui/i18n/i18n!:status"], function(declare, Memory, Msg, statusMsg) {
  return declare("km.asset.mobile.changeAsset.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
        	{ 
        		url : "/km/asset/km_asset_apply_change/kmAssetApplyChange.do?method=list&orderby=fdCreateDate&ordertype=down", 
        		text : Msg["kmAsset.mobile.tab.change.asset.all"]
        	},
        	{ 
        		url : "/km/asset/km_asset_apply_change/kmAssetApplyChange.do?method=list&q.docStatus=20&orderby=fdCreateDate&ordertype=down",
        		text : statusMsg["status.examine"]
        	},
        	{ 
        		url : "/km/asset/km_asset_apply_change/kmAssetApplyChange.do?method=list&q.docStatus=30&orderby=fdCreateDate&ordertype=down",
        		text : statusMsg["status.publish"]
        	},
        	{ 
        		url : "/km/asset/km_asset_apply_change/kmAssetApplyChange.do?method=list&q.docStatus=11&orderby=fdCreateDate&ordertype=down", 
        		text : statusMsg["status.refuse"]
        	},
        	{ 
        		url : "/km/asset/km_asset_apply_change/kmAssetApplyChange.do?method=list&q.docStatus=10&orderby=fdCreateDate&ordertype=down",
        		text : statusMsg["status.draft"]
        	}
        ]
    })
  })
})