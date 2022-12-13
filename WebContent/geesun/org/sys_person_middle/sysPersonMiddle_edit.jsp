<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit">
	<template:replace name="title">
		<c:choose>
			<c:when test="${sysPersonMiddleForm.method_GET == 'add' }">
				<c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-org:module.geesun.org') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${sysPersonMiddleForm.docSubject} - ${ lfn:message('geesun-org:module.geesun.org') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3"> 
			<c:choose>
				<c:when test="${ sysPersonMiddleForm.method_GET == 'edit' }">
					<ui:button text="${ lfn:message('button.update') }" onclick="Com_Submit(document.sysPersonMiddleForm, 'update');"></ui:button>
				</c:when>
				<c:when test="${ sysPersonMiddleForm.method_GET == 'add' }">	
					<ui:button text="${ lfn:message('button.save') }" onclick="Com_Submit(document.sysPersonMiddleForm, 'save');"></ui:button>
					<ui:button text="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.sysPersonMiddleForm, 'saveadd');"></ui:button>
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
		<html:form action="/geesun/org/sys_person_middle/sysPersonMiddle.do">
			<c:if test="${!empty sysPersonMiddleForm.docSubject}">
				<p class="txttitle" style="display: none;">${sysPersonMiddleForm.docSubject }</p>
			</c:if> 
			<div class="lui_form_content_frame" style="padding-top:20px">
				<table class="tb_simple" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.pernr"/>
						</td>
						<td width="35%">
							<xform:text property="pernr" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.nachn"/>
						</td>
						<td width="35%">
							<xform:text property="nachn" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.vnamc"/>
						</td>
						<td width="35%">
							<xform:text property="vnamc" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.orger"/>
						</td>
						<td width="35%">
							<xform:text property="orger" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.plans01"/>
						</td>
						<td width="35%">
							<xform:text property="plans01" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.plans02"/>
						</td>
						<td width="35%">
							<xform:text property="plans02" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.phone"/>
						</td>
						<td width="35%">
							<xform:text property="phone" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.email"/>
						</td>
						<td width="35%">
							<xform:text property="email" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.ccall"/>
						</td>
						<td width="35%">
							<xform:text property="ccall" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.wxid"/>
						</td>
						<td width="35%">
							<xform:text property="wxid" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.zhrOmGwzj"/>
						</td>
						<td width="35%">
							<xform:text property="zhrOmGwzj" style="width:85%" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.zhrOmGwzd"/>
						</td>
						<td width="35%">
							<xform:text property="zhrOmGwzd" style="width:85%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.zsfyx"/>
						</td>
						<td width="35%">
							<xform:radio property="zsfyx">
								<xform:enumsDataSource enumsType="common_yesno" />
							</xform:radio>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="geesun-org" key="sysPersonMiddle.zzDatum"/>
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
			$KMSSValidation(document.forms['sysPersonMiddleForm']);
		</script>
	</template:replace>
	<%--
	<template:replace name="nav">
		<div style="min-width:200px;"></div>
		<ui:accordionpanel style="min-width:200px;"> 
			<ui:content title="${ lfn:message('sys-doc:kmDoc.kmDocKnowledge.docInfo') }" toggle="false">
				<c:import url="/sys/evaluation/import/sysEvaluationMain_view_star.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="sysPersonMiddleForm" />
				</c:import>
				<ul class='lui_form_info'>
					<li><bean:message bundle="geesun-org" key="sysPersonMiddle.docCreator" />：
					<ui:person personId="${sysPersonMiddleForm.docCreatorId}" personName="${sysPersonMiddleForm.docCreatorName}"></ui:person></li>
					<li><bean:message bundle="geesun-org" key="sysPersonMiddle.docDept" />：${sysPersonMiddleForm.docDeptName}</li>
					<li><bean:message bundle="geesun-org" key="sysPersonMiddle.docStatus" />：<sunbor:enumsShow value="${sysPersonMiddleForm.docStatus}" enumsType="common_status" /></li>
					<li><bean:message bundle="geesun-org" key="sysPersonMiddle.docCreateTime" />：${sysPersonMiddleForm.docCreateTime }</li>				
				</ul>
			</ui:content>
		</ui:accordionpanel>
	</template:replace>
	--%>
</template:include>
