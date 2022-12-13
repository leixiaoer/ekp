<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
[ 
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&isLeadConcern=true&categoryId=${JsParam.categoryId }", 
		text : "全部",
		selected : true 
	},
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=30&isLeadConcern=true&categoryId=${JsParam.categoryId }", 
		text : "${lfn:message('km-supervise:enums.status.delay')}"
	},
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=20&isLeadConcern=true&categoryId=${JsParam.categoryId }", 
		text : "${lfn:message('km-supervise:enums.status.soon.delay')}"
	},
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=00&isLeadConcern=true&categoryId=${JsParam.categoryId }", 
		text : "${lfn:message('km-supervise:enums.status.soon.start')}"
	},
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=10&isLeadConcern=true&categoryId=${JsParam.categoryId }", 
		text : "${lfn:message('km-supervise:enums.status.normal')}"
	},
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=50&isLeadConcern=true&categoryId=${JsParam.categoryId }", 
		text : "${lfn:message('km-supervise:enums.status.stop')}"
	},
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=40&isLeadConcern=true&categoryId=${JsParam.categoryId }", 
		text : "${lfn:message('km-supervise:enums.status.finish')}"
	},
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=60&isLeadConcern=true&categoryId=${JsParam.categoryId }", 
		text : "${lfn:message('km-supervise:enums.status.change')}"
	}
]