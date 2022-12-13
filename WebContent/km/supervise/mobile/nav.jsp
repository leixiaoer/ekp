<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.docStatus=30&q.mydoc=${JsParam.mydoc}", 
		text : "${lfn:message('km-supervise:enums.doc_status.30')}",
		selected : true 
	},
	{
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.status=unstart&q.mydoc=${JsParam.mydoc}",
		text: "${lfn:message('km-supervise:enums.doc_status.20')}"
	},
	{
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.docStatus=40&q.mydoc=${JsParam.mydoc}",
		text: "${lfn:message('km-supervise:enums.doc_status.40')}"
	},
	{
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.docStatus=50&q.mydoc=${JsParam.mydoc}",
		text: "${lfn:message('km-supervise:enums.doc_status.50')}"
	}
]