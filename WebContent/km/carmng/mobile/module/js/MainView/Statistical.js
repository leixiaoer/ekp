define(["dojo/_base/declare", "sys/mportal/module/mobile/containers/header/CardMixin", "mui/i18n/i18n!km-carmng:kmCarmng.tree"], 
function(declare, CardMixin, Msg) {
	return declare("", [CardMixin], {
		datas:{
			menus: [
				[
					{
						text: Msg["kmCarmng.tree.my.submit"], //我提交的
						countUrl:"/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=create&rowsize=1", 
						countPath:"page.totalSize", 
						href: "/km/carmng/mobile/km_carmng_apply/#path=0"
					},
					{
						text: Msg["kmCarmng.tree.my.approval"], //待我审的
						countUrl:"/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=approval&rowsize=1", 
						countPath:"page.totalSize", 
						href: "/km/carmng/mobile/km_carmng_apply/#path=1"
					},
					{
						text: Msg["kmCarmng.tree.my.approved"], //我已审的
						countUrl:"/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=approved&rowsize=1", 
						countPath:"page.totalSize", 
						href: "/km/carmng/mobile/km_carmng_apply/#path=2"
					}
				]
			]
		}
	})
})
