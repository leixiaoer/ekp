<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
[ 
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUndertakeAndSupDatas&fdType=${JsParam.fdType}", 
		text : "全部",
		selected : true 
	},
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUndertakeAndSupDatas&fdStatus=notBack&fdType=${JsParam.fdType}&isDelay=true", 
		text : "未反馈"
	},
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUndertakeAndSupDatas&fdStatus=delayNotBack&fdType=${JsParam.fdType}&isDelay=true", 
		text : "超期未反馈"
	}
]