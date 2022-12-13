<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>

<%--标签页标题--%>
<template:replace name="title">
	<c:choose>
		<c:when test="${ kmInstitutionKnowledgeForm.method_GET == 'add' }">
			<c:out value="${ lfn:message('km-institution:kmInstitution.create.title') } - ${ lfn:message('km-institution:table.kmInstitutionKnowledge') }"></c:out>	
		</c:when>
		<c:otherwise>
			<c:out value="${kmInstitutionKnowledgeForm.docSubject} - ${ lfn:message('km-institution:table.kmInstitutionKnowledge') }"></c:out>
		</c:otherwise>
	</c:choose>
</template:replace>
<%--操作按钮--%>
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
		<c:choose>
			<%--add页面的按钮--%>
			<c:when test="${ kmInstitutionKnowledgeForm.method_GET == 'add' }">
				<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('save','true');">
				</ui:button>
				<c:choose>
					<c:when test="${ param.approveModel eq 'right' }">
						<ui:button text="${lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true"
								onclick="commitMethod('save','false');">
						</ui:button>
					</c:when>
					<c:otherwise>
						<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('save','false');"></ui:button>
					</c:otherwise>
				</c:choose>
			</c:when>
			<%--edit页面的按钮--%>
			<c:when test="${ kmInstitutionKnowledgeForm.method_GET == 'edit' }">
				<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit=='1'}">
					<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('update','true');">
					</ui:button>
				</c:if>
				<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit<'3'}">
					<c:choose>
						<c:when test="${ param.approveModel eq 'right' }">
							<ui:button text="${lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true"
									onclick="commitMethod('update','false');">
							</ui:button>
						</c:when>
						<c:otherwise>
							<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('update','false');"></ui:button>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit>='3'}">
					<c:choose>
						<c:when test="${ param.approveModel eq 'right' }">
							<ui:button text="${lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true"
									onclick="Com_Submit(document.kmInstitutionKnowledgeForm, 'update');">
							</ui:button>
						</c:when>
						<c:otherwise>
							<ui:button text="${lfn:message('button.submit') }" order="2" onclick="Com_Submit(document.kmInstitutionKnowledgeForm, 'update');"></ui:button>
						</c:otherwise>
					</c:choose>
				</c:if>			
			</c:when>
		</c:choose>
		<%--关闭--%>
		<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
		</ui:button>
	</ui:toolbar>
</template:replace>
<%--路径导航栏--%>
<template:replace name="path">
	<ui:combin ref="menu.path.simplecategory">
		<ui:varParams 
			moduleTitle="${ lfn:message('km-institution:table.kmInstitutionKnowledge') }" 
			modulePath="/km/institution/" 
			modelName="com.landray.kmss.km.institution.model.KmInstitutionTemplate" 
			autoFetch="false"
			categoryId="${kmInstitutionKnowledgeForm.fdDocTemplateId}" />
	</ui:combin>
</template:replace>