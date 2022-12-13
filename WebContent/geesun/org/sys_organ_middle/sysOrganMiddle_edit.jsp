<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit">
	<template:replace name="title">
		<c:choose>
			<c:when test="${sysOrganMiddleForm.method_GET == 'add' }">
				<c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-org:module.geesun.org') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${sysOrganMiddleForm.docSubject} - ${ lfn:message('geesun-org:module.geesun.org') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3"> 
			<c:choose>
				<c:when test="${ sysOrganMiddleForm.method_GET == 'edit' }">
					<ui:button text="${ lfn:message('button.update') }" onclick="Com_Submit(document.sysOrganMiddleForm, 'update');"></ui:button>
				</c:when>
				<c:when test="${ sysOrganMiddleForm.method_GET == 'add' }">	
					<ui:button text="${ lfn:message('button.save') }" onclick="Com_Submit(document.sysOrganMiddleForm, 'save');"></ui:button>
					<ui:button text="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.sysOrganMiddleForm, 'saveadd');"></ui:button>
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
		<html:form action="/geesun/org/sys_organ_middle/sysOrganMiddle.do">
			<c:if test="${!empty sysOrganMiddleForm.docSubject}">
				<p class="txttitle" style="display: none;">${sysOrganMiddleForm.docSubject }</p>
			</c:if> 
			<div class="lui_form_content_frame" style="padding-top:20px">
				<table class="tb_simple" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysOrganMiddle.objid"/>
						</td>
						<td width="35%">
							<xform:text property="objid" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysOrganMiddle.stext"/>
						</td>
						<td width="35%">
							<xform:text property="stext" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysOrganMiddle.objidUp"/>
						</td>
						<td width="35%">
							<xform:text property="objidUp" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysOrganMiddle.objidSUp"/>
						</td>
						<td width="35%">
							<xform:text property="objidSUp" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysOrganMiddle.zsfyx"/>
						</td>
						<td width="35%">
							<xform:radio property="zsfyx">
								<xform:enumsDataSource enumsType="common_yesno" />
							</xform:radio>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysOrganMiddle.zhrOmJglx"/>
						</td>
						<td width="35%">
							<xform:text property="zhrOmJglx" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysOrganMiddle.priox"/>
						</td>
						<td width="35%">
							<xform:text property="priox" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysOrganMiddle.zzDatum"/>
						</td>
						<td width="35%">
							<xform:text property="zzDatum" style="width:85%" />
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
			$KMSSValidation(document.forms['sysOrganMiddleForm']);
		</script>
	</template:replace>
	<%--
	<template:replace name="nav">
		<div style="min-width:200px;"></div>
		<ui:accordionpanel style="min-width:200px;"> 
			<ui:content title="${ lfn:message('sys-doc:kmDoc.kmDocKnowledge.docInfo') }" toggle="false">
				<c:import url="/sys/evaluation/import/sysEvaluationMain_view_star.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="sysOrganMiddleForm" />
				</c:import>
				<ul class='lui_form_info'>
					<li><bean:message bundle="geesun-org" key="sysOrganMiddle.docCreator" />：
					<ui:person personId="${sysOrganMiddleForm.docCreatorId}" personName="${sysOrganMiddleForm.docCreatorName}"></ui:person></li>
					<li><bean:message bundle="geesun-org" key="sysOrganMiddle.docDept" />：${sysOrganMiddleForm.docDeptName}</li>
					<li><bean:message bundle="geesun-org" key="sysOrganMiddle.docStatus" />：<sunbor:enumsShow value="${sysOrganMiddleForm.docStatus}" enumsType="common_status" /></li>
					<li><bean:message bundle="geesun-org" key="sysOrganMiddle.docCreateTime" />：${sysOrganMiddleForm.docCreateTime }</li>				
				</ul>
			</ui:content>
		</ui:accordionpanel>
	</template:replace>
	--%>
</template:include>
