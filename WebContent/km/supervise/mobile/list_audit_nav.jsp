<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : "/km/supervise/km_supervise_dynamic/kmSuperviseDynamic.do?method=data&mydoc=approval&type=review", 
		text : "${lfn:message('km-supervise:mobile.approval.my')}"
	},
	{
		url : "/km/supervise/km_supervise_dynamic/kmSuperviseDynamic.do?method=data&mydoc=approved&type=review",
		text: "${lfn:message('km-supervise:mobile.approved.my')}"
	}
]