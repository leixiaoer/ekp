<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		moveTo : "contentView", 
		text : "${lfn:message('km-supervise:kmSuperviseMain.fdContent')}",
		selected : true 
	},
	<c:if test="${param.docStatus >= '30' }">
	<kmss:authShow roles="ROLE_SYSTASK_DEFAULT">
	{ 
		moveTo : "planView", 
		text : "${lfn:message('km-supervise:kmSuperviseMain.task.title')}",
	}
	,
	</kmss:authShow>
	{   
		moveTo : "feedbackView", 
		text : "${lfn:message('km-supervise:table.kmSuperviseBack')}",
	},
	</c:if>
	{
		moveTo:"folwView",
		text : "${lfn:message('km-supervise:mobile.flow.record')}",
	}
]
