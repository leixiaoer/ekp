/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare", "mui/i18n/i18n!km-carmng:*"], function(declare, Msg) {
  return declare("km.carmng.CarDispatchPropertyMixin", null, {
    filters: [
    	//按车队
    	//按类型
		{
		    filterType: "FilterDatetime",
		    type: "date",
		    name: "fdStartTime",
		    subject: Msg["kmCarmngUserFeeInfo.fdUseStartTime"]
		},
		{
		    filterType: "FilterDatetime",
		    type: "date",
		    name: "fdEndTime",
		    subject: Msg["kmCarmngUserFeeInfo.fdUseEndTime"]
		}
    ]
  })
})
