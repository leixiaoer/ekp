define(["dojo/_base/declare", "mui/i18n/i18n!km-carmng:*"], function(declare, Msg) {
	return declare("", null, {
		datas: [
		    [
		        {
		        	icon: "muis-send",
		        	text: Msg["kmCarmng.mobile.header.dispatch"], //待用车调度
		        	href: "/km/carmng/mobile/km_carmng_dispatch/",
		            countUrl: "/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=listByDispatchers",
		            countPath:"page.totalSize"
		        },
		        {
		            icon: "muis-accept",
		            text: Msg["table.kmCarmngDispatchersInfo"], //调度信息
		            href: "/km/carmng/mobile/km_carmng_dispatch_info/"
		        },
		        {
		        	icon: "muis-car",
		        	text: Msg["table.kmCarmngInfomation"], //车辆信息
		        	href: "/km/carmng/mobile/km_carmng_carinfo/"
		        }
		    ]
	    ]
	})
})
