define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/util",
        "mui/i18n/i18n!km-supervise:*"]
		, function(declare, Memory, util, Msg) {
	var fdType = util.getUrlParameter(window.location.href,"mydoc") || '';
  return declare("km.supervise.mobile.Stage.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUndertakeAndSupDatas&fdType=" + fdType,
	        		text : Msg["py.quanBu"]
	        	},
	            {
	        		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUndertakeAndSupDatas&fdStatus=notBack&fdType=" + fdType + "&isDelay=true",
	         		text:  Msg["task.status.not.back"]
	         	},
			 	{ 
			 		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUndertakeAndSupDatas&fdStatus=delayNotBack&fdType=" + fdType + "&isDelay=true", 
			 		text : Msg["task.status.delay"]
			 	}
     	   ]
    })
  })
})