<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit">
	<template:replace name="title">
		<c:choose>
			<c:when test="${geesunOrgEkpForm.method_GET == 'add' }">
				<c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-org:module.geesun.org') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${geesunOrgEkpForm.docSubject} - ${ lfn:message('geesun-org:module.geesun.org') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3"> 
			<c:choose>
				<c:when test="${ geesunOrgEkpForm.method_GET == 'edit' }">
					<ui:button text="${ lfn:message('button.update') }" onclick="Com_Submit(document.geesunOrgEkpForm, 'update');"></ui:button>
				</c:when>
				<c:when test="${ geesunOrgEkpForm.method_GET == 'add' }">	
					<ui:button text="${ lfn:message('button.save') }" onclick="Com_Submit(document.geesunOrgEkpForm, 'save');"></ui:button>
					<ui:button text="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.geesunOrgEkpForm, 'saveadd');"></ui:button>
				</c:when>
			</c:choose>	
			<ui:button text="${ lfn:message('button.close') }" onclick="Com_CloseWindow();"></ui:button>	
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">			
		<ui:menu layout="sys.ui.menu.nav"> 
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>	
			<ui:menu-item text="${ lfn:message('geesun-org:module.geesun.org') }">
			</ui:menu-item>
		</ui:menu>
	</template:replace>	
	<template:replace name="content">
		<html:form action="/geesun/org/geesun_org_ekp/geesunOrgEkp.do">
			<c:if test="${!empty geesunOrgEkpForm.docSubject}">
				<p class="txttitle" style="display: none;">${geesunOrgEkpForm.docSubject }</p>
			</c:if> 
			<div class="lui_form_content_frame" style="padding-top:20px">
				<table class="tb_simple" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="geesunOrgEkp.docCreateTime"/>
						</td>
						<td width="35%">
							<xform:datetime property="docCreateTime" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="geesunOrgEkp.fdResult"/>
						</td>
						<td width="35%">
							<xform:select property="fdResult">
								<xform:enumsDataSource enumsType="geesunOrgEkp_fdResult" />
							</xform:select>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="geesunOrgEkp.fdType"/>
						</td>
						<td width="35%">
							<xform:select property="fdType">
								<xform:enumsDataSource enumsType="geesunOrgEkp_fdType" />
							</xform:select>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="geesunOrgEkp.fdMessage"/>
						</td>
						<td width="35%">
							<xform:rtf property="fdMessage" />
						</td>
					</tr>
				</table>
			</div>
			<ui:tabpage expand="false">
			</ui:tabpage>
		<html:hidden property="fdId" />
		<html:hidden property="method_GET" />
		</html:form>
		<script>
			$KMSSValidation(document.forms['geesunOrgEkpForm']);
		</script>
	</template:replace>
	<%--
	<template:replace name="nav">
		<div style="min-width:200px;"></div>
		<ui:accordionpanel style="min-width:200px;"> 
			<ui:content title="${ lfn:message('sys-doc:kmDoc.kmDocKnowledge.docInfo') }" toggle="false">
				<c:import url="/sys/evaluation/import/sysEvaluationMain_view_star.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="geesunOrgEkpForm" />
				</c:import>
				<ul class='lui_form_info'>
					<li><bean:message bundle="geesun-org" key="geesunOrgEkp.docCreator" />：
					<ui:person personId="${geesunOrgEkpForm.docCreatorId}" personName="${geesunOrgEkpForm.docCreatorName}"></ui:person></li>
					<li><bean:message bundle="geesun-org" key="geesunOrgEkp.docDept" />：${geesunOrgEkpForm.docDeptName}</li>
					<li><bean:message bundle="geesun-org" key="geesunOrgEkp.docStatus" />：<sunbor:enumsShow value="${geesunOrgEkpForm.docStatus}" enumsType="common_status" /></li>
					<li><bean:message bundle="geesun-org" key="geesunOrgEkp.docCreateTime" />：${geesunOrgEkpForm.docCreateTime }</li>				
				</ul>
			</ui:content>
		</ui:accordionpanel>
	</template:replace>
	--%>
</template:include>
