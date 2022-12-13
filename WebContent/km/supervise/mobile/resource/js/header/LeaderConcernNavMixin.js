define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/util",
        "mui/i18n/i18n!km-supervise:*"]
		, function(declare, Memory, util, Msg) {
	var cateId = util.getUrlParameter(window.location.href,"cateId") || '';
  return declare("km.supervise.mobile.LeaderConcern.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&isLeadConcern=true&categoryId=" + cateId,
	        		text : Msg["py.quanBu"],
	        		key:"a"
	        	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=30&isLeadConcern=true&categoryId=" + cateId,
	         		text:  Msg["enums.status.delay"],
	        		key:"b"
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=20&isLeadConcern=true&categoryId=" + cateId,
	         		text:  Msg["enums.status.soon.delay"],
	        		key:"n"
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=00&isLeadConcern=true&categoryId=" + cateId,
	         		text:  Msg["enums.status.soon.start"],
	        		key:"m"
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=10&isLeadConcern=true&categoryId=" + cateId,
	         		text:  Msg["enums.status.normal"],
	        		key:"k"
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=50&isLeadConcern=true&categoryId=" + cateId,
	         		text:  Msg["enums.status.stop"],
	        		key:"h"
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=40&isLeadConcern=true&categoryId=" + cateId,
	         		text:  Msg["enums.status.finish"],
	        		key:"g"
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=60&isLeadConcern=true&categoryId=" + cateId,
	         		text:  Msg["enums.status.change"],
	        		key:"s"
	         	}
     	   ]
    })
  })
})