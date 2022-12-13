define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/i18n/i18n!km-asset:kmAssetApply.create.my",
        "mui/i18n/i18n!km-asset:kmAssetApply.approval.my",
        "mui/i18n/i18n!km-asset:kmAssetApply.approved.my",
        "mui/i18n/i18n!km-asset:kmAsset.drafts"], function(declare, Memory, Msg1, Msg2, Msg3, Msg4) {
  return declare("km.asset.mobile.applyAsset.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/asset/km_asset_index/kmAssetIndex.do?method=list&q.mydoc=create&q.except=docStatus%3A00&orderby=fdCreateDate&ordertype=down", 
	        		text : Msg1["kmAssetApply.create.my"]
	        	},
	        	{ 
	        		url : "/km/asset/km_asset_index/kmAssetIndex.do?method=list&q.mydoc=approval&q.except=docStatus%3A00&orderby=fdCreateDate&ordertype=down", 
	        		text : Msg2["kmAssetApply.approval.my"],
	        		headerTemplate : "/km/asset/mobile/apply_asset/js/header/ApprovalHeaderTemplate.js"
	        	},
	        	{ 
	        		url : "/km/asset/km_asset_index/kmAssetIndex.do?method=list&q.mydoc=approved&q.except=docStatus%3A00&orderby=fdCreateDate&ordertype=down",
	        		text : Msg3["kmAssetApply.approved.my"]
	        	},
	        	{ 
	        		url : "/km/asset/km_asset_index/kmAssetIndex.do?method=list&q.mydoc=create&q.docStatus=10&q.status=draft&orderby=fdCreateDate&ordertype=down", 
	        		text : Msg4["kmAsset.drafts"],
	        		headerTemplate : "/km/asset/mobile/apply_asset/js/header/ApprovalHeaderTemplate.js"
	        	}
        ]
    })
  })
})