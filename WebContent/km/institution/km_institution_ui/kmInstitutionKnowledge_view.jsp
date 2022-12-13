<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.institution.forms.KmInstitutionKnowledgeForm"%>
<%@ page import="com.landray.kmss.km.institution.util.AbolishUtil"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>	
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>

<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.institution.model.KmInstitutionKnowledge"></lbpm:lbpmApproveModel>

<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" showQrcode="true" formName="kmInstitutionKnowledgeForm" formUrl="${KMSS_Parameter_ContextPath}km/institution/km_institution_knowledge/kmInstitutionKnowledge.do">
			<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_viewHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
		 	</c:import>
		 	<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_viewTab.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
		 	</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.view" sidebar="auto">
		    <c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_viewHead.jsp" charEncoding="UTF-8"></c:import>
		 	<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_viewTab.jsp" charEncoding="UTF-8"></c:import>
		</template:include>
	</c:otherwise>
</c:choose>