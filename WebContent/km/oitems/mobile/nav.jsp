<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : '/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplicationIndex.do?method=list', 
		text : "${ lfn:message('km-oitems:kmOitems.tree.my.all') }"
	},
	{
		url : '/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplicationIndex.do?method=list&q.mydoc=create',
		text: "${ lfn:message('km-oitems:kmOitems.tree.my.submit') }"
	},
	{
		url : '/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplicationIndex.do?method=list&q.mydoc=approval',
		text: "${ lfn:message('km-oitems:kmOitems.tree.my.approval') }"
	},
	{
		url : '/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplicationIndex.do?method=list&q.mydoc=approved',
		text: "${ lfn:message('km-oitems:kmOitems.tree.my.approved') }"
	}
]