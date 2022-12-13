define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/util",
        "mui/i18n/i18n!km-supervise:*"]
		, function(declare, Memory, util, Msg) {
	var cateId = util.getUrlParameter(window.location.href,"cateId") || '';
	var mydoc = util.getUrlParameter(window.location.href,"mydoc") || '';
  return declare("km.supervise.mobile.SuperviseNavStatus.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.mydoc=" + mydoc + "&cateId=" + cateId,
	        		text : Msg["py.quanBu"]
	        	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=30&q.mydoc=" + mydoc + "&cateId=" + cateId, 
	         		text:  Msg["enums.status.delay"]
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=20&q.mydoc=" + mydoc + "&cateId=" + cateId, 
	         		text:  Msg["enums.status.soon.delay"]
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=00&q.mydoc=" + mydoc + "&cateId=" + cateId, 
	         		text:  Msg["enums.status.soon.start"]
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=10&q.mydoc=" + mydoc + "&cateId=" + cateId, 
	         		text:  Msg["enums.status.normal"]
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=50&q.mydoc=" + mydoc + "&cateId=" + cateId, 
	         		text:  Msg["enums.status.stop"]
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=40&q.mydoc=" + mydoc + "&cateId=" + cateId, 
	         		text:  Msg["enums.status.finish"]
	         	},
	            {
	         		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=60&q.mydoc=" + mydoc + "&cateId=" + cateId, 
	         		text:  Msg["enums.status.change"]
	         	}
     	   ]
    })
  })
})