define(["dojo/_base/declare","mui/util","dojo/request","mui/store/JsonRest", "mui/i18n/i18n!km-supervise:*"], function(declare,util,request,JsonRest, Msg) {
	function getCount(j,name){
		var desc = '';
		if(j){
			j.forEach(function(item,index){
			    if(item.name == name){
			    	desc = item.count;
			    }
			});
		}
		return desc;
	};
	var data = null;
	request('../km_supervise_main/kmSuperviseMain.do?method=getSuperviseMobileIndexNew',{sync:true}).then(function(d){
		var json = eval("("+d+")");
		data = [
			        [
				        {
				        	icon: "muis-supervise-management",
				        	text: Msg["py.DuBan.audit"], //督办管理
				        	href: "/km/supervise/mobile/list_audit.jsp",
				            desc: getCount(json,"audit") + Msg["mobile.tip14"]
				        },
				        
				        {
				        	icon: "muis-supervise-branch",
				        	text: Msg["py.WoFenGuande"], //我分管的
				        	href: "/km/supervise/mobile/list_manage.jsp?mydoc=fenguan",
				            desc: getCount(json,"myManage")
				        },
				        {
				        	icon: "muis-supervise-incharge",
				        	text: Msg["py.WoFuZeDe"], //我负责的
				        	href: "/km/supervise/mobile/list_charge.jsp?mydoc=duty",
				            desc: getCount(json,"myCharge")
				        },
				        {
				        	icon: "muis-case-authenticate",
				        	text: Msg["py.WoChengBanDe"], //我承办的 
				        	href: "/km/supervise/mobile/list_undertake.jsp?mydoc=myUndertake",
				            desc: getCount(json,"myUndertake")
				        },
				        {
				        	icon: "muis-supervise-jointly",
				        	text: Msg["py.WoXieBanDe"], //我协办的
				        	href: "/km/supervise/mobile/list_sup.jsp?mydoc=mySup",
				            desc: getCount(json,"mySup")
				        },

				        {
				        	icon: "muis-property-receive",
				        	text: Msg["py.myLiXiang"], //我立项的
				        	href: "/km/supervise/mobile/list_create.jsp?mydoc=create",
				            desc: getCount(json,"myLiXiang")
				        },
				        {
				        	icon: "muis-attention",
				        	text: Msg["py.WoGuanZhuDe"], //我关注的
				        	href: "/km/supervise/mobile/list_concern.jsp?mydoc=concern",
				            desc: getCount(json,"myConcern")
				        },
				    ]
			    ]
	},function(error){
	    
	});
	
	return declare("", null, {
		datas: data
	})
})