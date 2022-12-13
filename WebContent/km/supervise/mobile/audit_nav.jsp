<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.mydoc=approval", 
		text : "${lfn:message('km-supervise:mobile.approval.my')}"
	},
	{
		url : "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.mydoc=approved",
		text: "${lfn:message('km-supervise:mobile.approved.my')}"
	}
]