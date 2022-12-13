define([ "dojo/_base/declare",
		"sys/mportal/module/mobile/containers/header/CardMixin",
        "mui/i18n/i18n!km-asset:kmAssetApply.create.my",
        "mui/i18n/i18n!km-asset:kmAssetApply.approval.my",
        "mui/i18n/i18n!km-asset:kmAssetApply.approved.my"
        ], function(declare, CardMixin, Msg1, Msg2, Msg3) {
	return declare("km.asset.module.main.Statistical", [ CardMixin ], {

		datas : {
			menus : [ 
			          [ 
			           {
							countUrl: "/km/asset/km_asset_index/kmAssetIndex.do?method=list&q.mydoc=create&q.except=docStatus%3A00",
							countPath: "page.totalSize",
							text : Msg1["kmAssetApply.create.my"], // 我发起的
							href : "/km/asset/mobile/apply_asset/index.jsp#path=0"
						}, 
						{
							countUrl: "/km/asset/km_asset_index/kmAssetIndex.do?method=list&q.mydoc=approval&q.except=docStatus%3A00",
							countPath: "page.totalSize",
							text : Msg2["kmAssetApply.approval.my"], // 待我审的
							href : "/km/asset/mobile/apply_asset/index.jsp#path=1"
						}, 
						{
							countUrl: "/km/asset/km_asset_index/kmAssetIndex.do?method=list&q.mydoc=approved&q.except=docStatus%3A00",
							countPath: "page.totalSize",
							text : Msg3["kmAssetApply.approved.my"], // 我已审的
							href : "/km/asset/mobile/apply_asset/index.jsp#path=2"
						}			           
			          ] 
			]
		}

	})
})
