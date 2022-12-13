<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		moveTo : "contentView", 
		text : "${lfn:message('sys-task:mui.sysTaskMain.detail')}",
		selected : ${param.feedbackcount>0?false:true}
	}
	,
	{   
		moveTo : "feedbackView", 
		text : "${lfn:message('sys-task:mui.sysTaskMain.feedback.evaluate')}",
		selected : ${param.feedbackcount>0?true:false}
	},
	
	{ 
		moveTo : "childTaskView", 
		text : "${lfn:message('sys-task:tag.childtasks')}"
	},
	{
		moveTo:"picView",
		text:"${lfn:message('sys-task:mui.sysTaskMain.diagram')}"
	}
]
