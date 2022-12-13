<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
[ 
	<c:choose>
		<c:when test="${JsParam.status eq '30' }">
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "全部"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=30&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.delay')}",
				selected : true 
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=20&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.soon.delay')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=00&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.soon.start')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=10&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.normal')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=50&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.stop')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=40&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.finish')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=60&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.change')}"
			}
		</c:when>
		<c:when test="${JsParam.status eq '20' }">
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "全部"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=30&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.delay')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=20&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.soon.delay')}",
				selected : true 
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=00&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.soon.start')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=10&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.normal')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=50&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.stop')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=40&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.finish')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=60&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.change')}"
			}
		</c:when>
		<c:when test="${JsParam.status eq '10' }">
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "全部"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=30&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.delay')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=20&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.soon.delay')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=00&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.soon.start')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=10&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.normal')}",
				selected : true 
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=50&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.stop')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=40&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.finish')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=60&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.change')}"
			}
		</c:when>
		<c:otherwise>
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "全部",
				selected : true 
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=30&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.delay')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=20&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.soon.delay')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=00&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.soon.start')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=10&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.normal')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=50&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.stop')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=40&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.finish')}"
			},
			{ 
				url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.fdStatus=60&q.mydoc=${JsParam.mydoc}&cateId=${JsParam.categoryId }", 
				text : "${lfn:message('km-supervise:enums.status.change')}"
			}
		</c:otherwise>
	</c:choose>
]