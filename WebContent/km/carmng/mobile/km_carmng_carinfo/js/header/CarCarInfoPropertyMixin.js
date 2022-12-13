/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare", "mui/i18n/i18n!km-carmng:*"], function(declare, Msg) {
  return declare("km.carmng.CarCarInfoPropertyMixin", null, {
    filters: [
        {
	        filterType: "FilterRadio",
	        name: "docStatus",
	        subject: Msg["kmCarmng.tree.car.information2"],
	        options: [
	           {name: Msg["mui.kmCarmngInformation.docStauts1"], value: "1"}
	          ,{name: Msg["mui.kmCarmngInformation.docStauts2"], value: "2"}
	          ,{name: Msg["mui.kmCarmngInformation.docStauts3"], value: "3"}
	        ]
	    }
    ]
  })
})
