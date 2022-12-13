<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>

<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.institution.model.KmInstitutionKnowledge"></lbpm:lbpmApproveModel>

<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" isShowQrcode="false" isEdit="true" formName="kmInstitutionKnowledgeForm" formUrl="${KMSS_Parameter_ContextPath}km/institution/km_institution_knowledge/kmInstitutionKnowledge.do">
			<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_editHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
		 	</c:import>
		 	<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_editTab.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
		 	</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.edit" showQrcode="false">
		    <c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_editHead.jsp" charEncoding="UTF-8"></c:import>
		 	<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_editTab.jsp" charEncoding="UTF-8"></c:import>
		</template:include>
	</c:otherwise>
</c:choose>