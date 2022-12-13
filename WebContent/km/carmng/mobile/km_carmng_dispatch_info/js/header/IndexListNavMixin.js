define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/i18n/i18n!km-carmng:kmCarmng.tree.dispatcher2"]
		, function(declare, Memory, Msg1) {
  return declare("km.Carmng.mobile.dispatchCarmng.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfoIndex.do?method=list&orderby=kmCarmngDispatchersInfo.docCreateTime&ordertype=down", 
	        		text : Msg1["kmCarmng.tree.dispatcher2"]
	        	}
        ]
    })
  })
})