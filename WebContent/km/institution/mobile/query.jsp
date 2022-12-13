<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div data-dojo-type="mui/query/QueryList" data-dojo-props="topHeight:!{topHeight}">
	<div data-dojo-type="mui/query/QueryListItem" 
		data-dojo-mixins="mui/simplecategory/SimpleCategoryDialogMixin" 
		data-dojo-props="authType:'03',label:'<bean:message key="portlet.cate" />',icon:'mui mui-Csort',
			modelName:'com.landray.kmss.km.institution.model.KmInstitutionTemplate',
			redirectURL:'/km/institution/mobile/index.jsp?moduleName=!{curNames}&filter=1',
			filterURL:'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&categoryId=!{curIds}&q.docStatus=30&orderby=docPublishTime&ordertype=down'">
	</div>
	<div data-dojo-type="mui/query/QueryListItem"
		data-dojo-mixins="mui/search/SearchBarDialogMixin" 
		data-dojo-props="label:'<bean:message key="button.search" />',icon:'mui mui-search', modelName:'com.landray.kmss.km.institution.model.KmInstitutionKnowledge'">
	</div>
	<div data-dojo-type="mui/query/QueryListItem"
		data-dojo-mixins="mui/query/CommonQueryDialogMixin" 
		data-dojo-props="label:'<bean:message key="list.search" />',icon:'mui mui-query',
			redirectURL:'/km/institution/mobile/index.jsp?moduleName=!{text}&filter=1',
			store:[{'text':'<bean:message key="kmInstitutionKnowledge.list.all" bundle="km-institution" />','dataURL':'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&q.docStatus=30&categoryId=&orderby=docPublishTime&ordertype=down'},
			{'text':'<bean:message key="kmInstitutionKnowledge.list.create"  bundle="km-institution" />','dataURL':'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&categoryId=&q.mydoc=create&orderby=docPublishTime&ordertype=down'},
			{'text':'<bean:message key="list.approval" />','dataURL':'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&categoryId=&q.mydoc=approval&orderby=docPublishTime&ordertype=down'},
			{'text':'<bean:message key="list.approved" />','dataURL':'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&categoryId=&q.mydoc=approved&orderby=docPublishTime&ordertype=down'}
			]">
	</div>
</div>
