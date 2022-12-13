define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/i18n/i18n!km-carmng:kmCarmng.tree.my.submit",
        "mui/i18n/i18n!km-carmng:kmCarmng.tree.my.approval",
        "mui/i18n/i18n!km-carmng:kmCarmng.tree.my.approved"]
		, function(declare, Memory, Msg1, Msg2, Msg3) {
  return declare("km.Carmng.mobile.applyCarmng.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=create&orderby=docCreateTime&ordertype=down", 
	        		text : Msg1["kmCarmng.tree.my.submit"],
	        		isNavCount:true
	        	},
	        	{ 
	        		url : "/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=approval&orderby=docCreateTime&ordertype=down", 
	        		text : Msg2["kmCarmng.tree.my.approval"],
	        		isNavCount:true
	        	},
	        	{
	        		url : "/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=approved&orderby=docCreateTime&ordertype=down",
	        		text : Msg3["kmCarmng.tree.my.approved"],
	        		isNavCount:true
	        	}
        ]
    })
  })
})