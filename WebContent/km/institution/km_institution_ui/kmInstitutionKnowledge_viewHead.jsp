<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.institution.forms.KmInstitutionKnowledgeForm"%>
<%@ page import="com.landray.kmss.km.institution.util.AbolishUtil"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>	
<%@ include file="/sys/ui/jsp/common.jsp"%>

<%-- 标签页标题--%>
<template:replace name="title">
	<c:out value="${kmInstitutionKnowledgeForm.docSubject} - ${ lfn:message('km-institution:table.kmInstitutionKnowledge') }"></c:out>
</template:replace>
<%--操作按钮--%>
<template:replace name="toolbar">
	<link href="${LUI_ContextPath}/km/institution/resource/style/default/expire.css" rel="stylesheet" type="text/css"/>
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="5">
		<%--编辑--%>
		<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit > '0' }">
			<kmss:auth
				requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=edit&fdId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('button.edit')}" 
					onclick="Com_OpenWindow('kmInstitutionKnowledge.do?method=edit&fdId=${param.fdId}','_self');" order="2">
				</ui:button>
			</kmss:auth> 
		</c:if>
		<c:if test="${kmInstitutionKnowledgeForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSign =='true' && yqqFlag=='true' && kmInstitutionKnowledgeForm.fdSignEnable == 'true'}">
	     	 <%-- 集成了易企签、勾选了附件选项 --%>
	      	 <ui:button text="${lfn:message('km-institution:kmInstitutionKnowledge.executionSignature')}" onclick="yqq()" order="2" />
			</c:if>
		<%--失效--%>
		<c:if test="${kmInstitutionKnowledgeForm.docStatus == '30' && kmInstitutionKnowledgeForm.docIsNewVersion == true}">
			<kmss:auth
				requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=abolish&fdId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('km-institution:kmInstitution.button.abolish')}" order="4"
					onclick="abolishDoc('${LUI_ContextPath }/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=abolish&fdAbolishDocId=${param.fdId}');">
				</ui:button>
			</kmss:auth>
		</c:if>
		<%--删除--%>
		<kmss:auth
			requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=delete&fdId=${param.fdId}"
			requestMethod="GET">
			<ui:button text="${lfn:message('button.delete')}" order="4"
					onclick="deleteDoc('kmInstitutionKnowledge.do?method=delete&fdId=${param.fdId}');">
			</ui:button>
		</kmss:auth>
		<ui:button text="${lfn:message('km-institution:kmInstitution.button.copyLink')}" order="4" onclick="copyLink();">
		</ui:button>
		<%--关闭--%>
		<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
		</ui:button>
	</ui:toolbar>
</template:replace>
<%--导航路径--%>
<template:replace name="path">
	<ui:combin ref="menu.path.simplecategory">
		<ui:varParams 
			moduleTitle="${ lfn:message('km-institution:table.kmInstitutionKnowledge') }" 
			modulePath="/km/institution/" 
			modelName="com.landray.kmss.km.institution.model.KmInstitutionTemplate" 
			autoFetch="false"
			href="/km/institution/"
			categoryId="${kmInstitutionKnowledgeForm.fdDocTemplateId}" />
	</ui:combin>
</template:replace>