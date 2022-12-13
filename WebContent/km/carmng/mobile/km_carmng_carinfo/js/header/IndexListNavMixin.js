define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/i18n/i18n!km-carmng:kmCarmng.tree.car.information"]
		, function(declare, Memory, Msg1) {
  return declare("km.Carmng.mobile.carInfoCarmng.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/carmng/km_carmng_infomation/kmCarmngInfomationIndex.do?method=list", 
	        		text : Msg1["kmCarmng.tree.car.information"]
	        	}
        ]
    })
  })
})