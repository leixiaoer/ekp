/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare", "mui/i18n/i18n!km-carmng:*"], function(declare, Msg) {
  return declare("km.carmng.CarDispatchInfoPropertyMixin", null, {
    filters: [      
		{
	        filterType: "FilterRadio",
	        name: "fdFlag",
	        subject: Msg["kmCarmng.tree.car.information2"],
	        options: [
	           {name: Msg["mui.kmCarmngDispatchersInfo.fdFlag1"], value: "0"}
	          ,{name: Msg["mui.kmCarmngDispatchersInfo.fdFlag2"], value: "1"}
	          ,{name: Msg["mui.kmCarmngDispatchersInfo.fdFlag3"], value: "2"}
	        ]
	    }
    ]
  })
})
