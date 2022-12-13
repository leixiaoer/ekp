define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/i18n/i18n!km-supervise:mobile"]
		, function(declare, Memory, Msg) {
  return declare("km.supervise.mobile.ListAudit.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/supervise/km_supervise_dynamic/kmSuperviseDynamic.do?method=data&mydoc=approval&type=review",
	        		text : Msg["mobile.approval.my"]
	        	},
	            {
	         		url : "/km/supervise/km_supervise_dynamic/kmSuperviseDynamic.do?method=data&mydoc=approved&type=review",
	         		text:  Msg["mobile.approved.my"]
	         	}
     	   ]
    })
  })
})