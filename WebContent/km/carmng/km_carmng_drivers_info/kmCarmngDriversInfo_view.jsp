<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="title">
		<c:out value="${kmCarmngDriversInfoForm.fdName} - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<kmss:auth requestURL="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do?method=edit&motorcadeId=${kmCarmngDriversInfoForm.fdMotorcadeId}&fdId=${param.fdId}" requestMethod="GET">
			   <ui:button text="${lfn:message('button.edit') }" order="2" onclick="Com_OpenWindow('kmCarmngDriversInfo.do?method=edit&motorcadeId=${kmCarmngDriversInfoForm.fdMotorcadeId}&fdId=${param.fdId}','_self');">
			   </ui:button>
			</kmss:auth>
			<kmss:auth requestURL="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do?method=delete&motorcadeId=${kmCarmngDriversInfoForm.fdMotorcadeId}&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.delete') }" order="2" onclick="if(!confirmDelete())return;Com_OpenWindow('kmCarmngDriversInfo.do?method=delete&motorcadeId=${kmCarmngDriversInfoForm.fdMotorcadeId}&fdId=${param.fdId}','_self');">
			    </ui:button>
			</kmss:auth>
			<ui:button text="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
<template:replace name="content"> 
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngDriversInfo"/></p>
<div class="lui_form_content_frame" style="padding-top:20px">
<table class="tb_normal" width=95%>
		<html:hidden name="kmCarmngDriversInfoForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdName"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdName}" />
			   &nbsp;&nbsp;&nbsp;<sunbor:enumsShow value="${kmCarmngDriversInfoForm.fdType}"  enumsType="kmCarmngDriversInfo_fdType"/>			
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdOrder"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdOrder}" />
		</td>
		<td rowspan="6">
		<c:if test="${empty kmCarmngDriversInfoForm.attachmentForms['kmCarmngDriverPic'].attachments}">
		<img src="head.jpg" border="0" width="120" height="120">
		</c:if>
		<c:if test="${not empty kmCarmngDriversInfoForm.attachmentForms['kmCarmngDriverPic'].attachments}">
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="kmCarmngDriverPic" />
			<c:param name="formBeanName" value="kmCarmngDriversInfoForm" />
			<c:param name="fdAttType" value="pic"/>
		</c:import> 
		</c:if>	
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdMotorcadeId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdMotorcadeName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdDriverNumber"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdDriverNumber}" />
		</td>
	</tr>
	<tr>
		
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdCredentialsType"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdCredentialsType}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdCredentialsNumber"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdCredentialsNumber}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdRelationPhone"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdRelationPhone}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdDriveYear"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdDriveYear}" />
		</td>	
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdCredentialsTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdCredentialsTime}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdValidTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdValidTime}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdAnnualAuditingTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdAnnualAuditingTime}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdAnnualExamFrequency"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.fdAnnualExamFrequency}" />
		</td>
	</tr>
	
	
	<!--<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdNotifyType"/>
		</td><td width=35% colspan="3">
			<kmss:showNotifyType value="${kmCarmngDriversInfoForm.fdNotifyType}"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdNotifyPersons"/>
		</td><td width=35% colspan="3">
			<c:out value="${kmCarmngDriversInfoForm.fdNotifyPersonNames}" />
		</td>
	</tr>-->
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdRemark"/>
		</td><td width=35% colspan="4">
			<kmss:showText value="${kmCarmngDriversInfoForm.fdRemark}" />
		</td>
		
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.docCreatorId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngDriversInfoForm.docCreatorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.docCreateTime"/>
		</td><td width=35% colspan="3">
			<c:out value="${kmCarmngDriversInfoForm.docCreateTime}" />
		</td>
	</tr>
</table>
</div>
</template:replace>
</template:include>