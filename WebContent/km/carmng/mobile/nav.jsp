<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
   <kmss:authShow roles="ROLE_KMCARMNG_CARMANAGE">
   {
		url : "/km/carmng/km_carmng_infomation/kmCarmngInfomationIndex.do?method=list",
		text : "${ lfn:message('km-carmng:kmCarmng.tree.car.information') }",
		selected : true,
		getcount:true
	},
	</kmss:authShow>
	<kmss:authShow roles="ROLE_KMCARMNG_MOTORCADE_ATTEMPER">
	{
		url : "/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=listByDispatchers&docStatus=30&fdIsDispatcher=1&mobile=true&orderby=docCreateTime&ordertype=down",
		text : "${ lfn:message('km-carmng:kmCarmng.tree.dispatcher1') }",
		getcount:true
	},
	{
		url : "/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfoIndex.do?method=list&orderby=kmCarmngDispatchersInfo.docCreateTime&ordertype=down",
		text : "${ lfn:message('km-carmng:kmCarmng.tree.dispatcher2') }",	
		getcount:true
	},
	</kmss:authShow>
	<kmss:authShow roles="ROLE_KMCARMNG_EVALUATION">
	{
		url : "/km/carmng/km_carmng_evaluation/kmCarmngEvaluation.do?method=list&orderby=fdEvaluationTime&ordertype=down",
		text : "${ lfn:message('km-carmng:kmCarmng.tree.evaluate') }",
		getcount:true		
	},
	</kmss:authShow>
	{ 
		url : "/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=create&orderby=docCreateTime&ordertype=down", 
		text : "${ lfn:message('km-carmng:kmCarmng.tree.my.submit') }",
		getcount:true
	},
	{ 
		url : "/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=approval&orderby=docCreateTime&ordertype=down", 
		text : "${ lfn:message('list.approval') }",
		getcount:true
	},
	{
		url : "/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list&q.mydoc=approved&orderby=docCreateTime&ordertype=down",
		text : "${ lfn:message('list.approved') }",
		getcount:true
	}
]
