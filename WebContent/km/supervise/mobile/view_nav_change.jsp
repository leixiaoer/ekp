<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		moveTo : "contentView", 
		text : "${lfn:message('km-supervise:kmSuperviseMain.change.fdContent')}",
		selected : true 
	},
	{ 
		moveTo : "baseView", 
		text : "${lfn:message('km-supervise:py.JiBenXinXi')}"
	},
	{ 
		moveTo : "planView", 
		text : "${lfn:message('km-supervise:py.JieDuanJiHua')}"
	},
	{
		moveTo:"folwView",
		text : "${lfn:message('km-supervise:mobile.flow.record')}",
	}
]
