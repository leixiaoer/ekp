<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 	
	{ 
		moveTo : "dateView", 
		text : '<span class="icon"><i class="mui mui-meeting_date"></i></span><span class="txt">${lfn:message('sys-task:sysTaskAnalyze.time')}</span>',
		selected : true 
	},
	{ 
		moveTo : 'personView', 
		text : '<span class="icon"><i class="mui mui-address"></i></span><span class="txt">${lfn:message('sys-task:sysTaskAnalyze.org')}</span>'
	},
	{   
		moveTo : "syncView", 
		text : '<span class="icon"><i class="mui mui-syn"></i></span><span class="txt">${lfn:message('sys-task:mui.sysTaskMain.synchronous')}</span>'
	}
]
