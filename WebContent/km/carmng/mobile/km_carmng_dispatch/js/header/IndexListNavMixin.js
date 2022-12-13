define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/i18n/i18n!km-carmng:kmCarmng.mobile.header.dispatch"]
		, function(declare, Memory, Msg1) {
  return declare("km.Carmng.mobile.dispatchCarmng.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=listByDispatchers&orderby=docCreateTime&ordertype=down", 
	        		text : Msg1["kmCarmng.mobile.header.dispatch"]
	        	}
        ]
    })
  })
})