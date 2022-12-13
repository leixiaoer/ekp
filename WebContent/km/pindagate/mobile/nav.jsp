<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : "/km/pindagate/km_pindagate_main/kmPindagateData.do?method=listChildren&treeNode=participate&nodeType=&orderby=docCreateTime&ordertype=down", 
		text : "${ lfn:message('km-pindagate:kmPindagate.tree.all') }", 
		selected : true 
	},
	{ 
		url : "/km/pindagate/km_pindagate_main/kmPindagateData.do?method=listChildren&treeNode=participate&nodeType=&q.join=mine&orderby=docCreateTime&ordertype=down", 
		text : "${ lfn:message('km-pindagate:kmPindagate.tree.join.mine') }"
	},
	{
		url:"/km/pindagate/km_pindagate_main/kmPindagateData.do?method=listChildren&treeNode=result",
		text:"${ lfn:message('km-pindagate:kmPindagate.tree.result') }"
	}
	
]
