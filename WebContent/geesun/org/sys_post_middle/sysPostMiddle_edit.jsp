<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit">
	<template:replace name="title">
		<c:choose>
			<c:when test="${sysPostMiddleForm.method_GET == 'add' }">
				<c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-org:module.geesun.org') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${sysPostMiddleForm.docSubject} - ${ lfn:message('geesun-org:module.geesun.org') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3"> 
			<c:choose>
				<c:when test="${ sysPostMiddleForm.method_GET == 'edit' }">
					<ui:button text="${ lfn:message('button.update') }" onclick="Com_Submit(document.sysPostMiddleForm, 'update');"></ui:button>
				</c:when>
				<c:when test="${ sysPostMiddleForm.method_GET == 'add' }">	
					<ui:button text="${ lfn:message('button.save') }" onclick="Com_Submit(document.sysPostMiddleForm, 'save');"></ui:button>
					<ui:button text="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.sysPostMiddleForm, 'saveadd');"></ui:button>
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
		<html:form action="/geesun/org/sys_post_middle/sysPostMiddle.do">
			<c:if test="${!empty sysPostMiddleForm.docSubject}">
				<p class="txttitle" style="display: none;">${sysPostMiddleForm.docSubject }</p>
			</c:if> 
			<div class="lui_form_content_frame" style="padding-top:20px">
				<table class="tb_simple" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPostMiddle.objid"/>
						</td>
						<td width="35%">
							<xform:text property="objid" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPostMiddle.stext"/>
						</td>
						<td width="35%">
							<xform:text property="stext" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPostMiddle.objidUp"/>
						</td>
						<td width="35%">
							<xform:text property="objidUp" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPostMiddle.objidSUp"/>
						</td>
						<td width="35%">
							<xform:text property="objidSUp" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPostMiddle.zsfyx"/>
						</td>
						<td width="35%">
							<xform:radio property="zsfyx">
								<xform:enumsDataSource enumsType="common_yesno" />
							</xform:radio>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPostMiddle.priox"/>
						</td>
						<td width="35%">
							<xform:text property="priox" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPostMiddle.zzDatum"/>
						</td>
						<td width="35%">
							<xform:text property="zzDatum" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
					</tr>
				</table>
			</div>
			<ui:tabpage expand="false">
			</ui:tabpage>
		<html:hidden property="fdId" />
		<html:hidden property="method_GET" />
		</html:form>
		<script>
			$KMSSValidation(document.forms['sysPostMiddleForm']);
		</script>
	</template:replace>
	<%--
	<template:replace name="nav">
		<div style="min-width:200px;"></div>
		<ui:accordionpanel style="min-width:200px;"> 
			<ui:content title="${ lfn:message('sys-doc:kmDoc.kmDocKnowledge.docInfo') }" toggle="false">
				<c:import url="/sys/evaluation/import/sysEvaluationMain_view_star.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="sysPostMiddleForm" />
				</c:import>
				<ul class='lui_form_info'>
					<li><bean:message bundle="geesun-org" key="sysPostMiddle.docCreator" />：
					<ui:person personId="${sysPostMiddleForm.docCreatorId}" personName="${sysPostMiddleForm.docCreatorName}"></ui:person></li>
					<li><bean:message bundle="geesun-org" key="sysPostMiddle.docDept" />：${sysPostMiddleForm.docDeptName}</li>
					<li><bean:message bundle="geesun-org" key="sysPostMiddle.docStatus" />：<sunbor:enumsShow value="${sysPostMiddleForm.docStatus}" enumsType="common_status" /></li>
					<li><bean:message bundle="geesun-org" key="sysPostMiddle.docCreateTime" />：${sysPostMiddleForm.docCreateTime }</li>				
				</ul>
			</ui:content>
		</ui:accordionpanel>
	</template:replace>
	--%>
</template:include>
