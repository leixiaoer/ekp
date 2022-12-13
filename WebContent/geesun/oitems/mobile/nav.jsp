<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : '/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplicationIndex.do?method=list', 
		text : "${ lfn:message('geesun-oitems:geesunOitems.tree.my.all') }"
	},
	{
		url : '/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplicationIndex.do?method=list&q.mydoc=create',
		text: "${ lfn:message('geesun-oitems:geesunOitems.tree.my.submit') }"
	},
	{
		url : '/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplicationIndex.do?method=list&q.mydoc=approval',
		text: "${ lfn:message('geesun-oitems:geesunOitems.tree.my.approval') }"
	},
	{
		url : '/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplicationIndex.do?method=list&q.mydoc=approved',
		text: "${ lfn:message('geesun-oitems:geesunOitems.tree.my.approved') }"
	}
]
