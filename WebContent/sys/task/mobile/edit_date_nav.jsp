<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 	
	{ 
		text : "${lfn:message('sys-task:mui.sysTaskMain.custom')}",
		datetype:0,
		selected : true
	},
	{ 
		text : "${lfn:message('sys-task:sysTaskMain.DateTime.today')}",
		datetype:1
	},
	{ 
		text : "${lfn:message('sys-task:sysTaskMain.DateTime.tomorrow')}",
		datetype:2
	}
	,
	{   
		text : "${lfn:message('sys-task:sysTaskMain.DateTime.after.tomorrow')}",
		datetype:3
	},
	{
		text:"${lfn:message('sys-task:sysTaskMain.DateTime.next.week')}", 
		datetype:4
	},
	{
		text:"${lfn:message('sys-task:sysTaskMain.DateTime.next.month')}",
		datetype:5
	}
]
