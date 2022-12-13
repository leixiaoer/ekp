<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : "/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&q.docStatus=30&orderby=fdIsTop%3BfdTopTime%3BdocPublishTime%3BdocAlterTime%3BdocCreateTime&ordertype=down", 
		text : "${ lfn:message('km-institution:module.km.institution') }", 
		selected : true 
	}
]
