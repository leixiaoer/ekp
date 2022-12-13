<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		moveTo : "baseView", 
		text : "${lfn:message('km-supervise:py.JiBenXinXi')}",
		selected : true 
	},
	{ 
		moveTo : "planView", 
		text : "${lfn:message('km-supervise:py.JieDuanJiHua')}",
	},
	{
		moveTo:"folwView",
		text : "${lfn:message('km-supervise:mobile.flow.record')}",
	}
]
