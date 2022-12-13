<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		moveTo : "contentView", 
		text : "${lfn:message('km-supervise:kmSuperviseMainFinish.fdContent')}",
		selected : true 
	},
	{
		moveTo:"folwView",
		text : "${lfn:message('km-supervise:mobile.flow.record')}",
	}
]
