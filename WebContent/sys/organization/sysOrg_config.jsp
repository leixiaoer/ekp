<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="config.profile.edit" sidebar="no">
	<template:replace name="title"><bean:message bundle="sys-organization" key="sysOrgConfig" /></template:replace>
	<template:replace name="content">
		<h2 align="center" style="margin: 10px 0">
			<span class="profile_config_title"><bean:message bundle="sys-organization" key="sysOrgPerson.config.title" /></span>
			<% if(!new com.landray.kmss.sys.organization.transfer.SysOrganizationConfigChecker().isRuned()) { %>
			<span style="color: red;"><bean:message bundle="sys-organization" key="organization.config.transfer" /></span>
			<% } %>
		</h2>
		
		<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do" onsubmit="return validateAppConfigForm(this);">
			<center>
				<table class="tb_normal" width=95%>
					<tr>
					  <td class="td_normal_title" width=15%>
						 <bean:message bundle="sys-organization" key="sysOrganizationSearch.config.realTimeSeach"/>
						 <br>
						 <font color="red"><bean:message bundle="sys-organization" key="sysOrgPerson.config.realTimeSeach.alert"/></font>
					  </td><td colspan="3">
							<ui:switch property="value(realTimeSearch)" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
					  </td>
					</tr>
					<tr>
					  <td class="td_normal_title" width=35%>
						 <bean:message  bundle="sys-organization" key="sysOrganizationRelation.config.isRelation"/>
						  <br>
						 <font color="red"><bean:message bundle="sys-organization" key="sysOrgPerson.config.isRelation.alert"/></font>
					  </td><td colspan="3">
							<ui:switch property="value(isRelation)" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
					  </td>
					</tr>
					<tr>
					  <td class="td_normal_title" width=35%>
						 <bean:message  bundle="sys-organization" key="organization.keepGroupUnique" />
					  </td><td colspan="3">
							<ui:switch property="value(keepGroupUnique)" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
					  </td>
					</tr>
					<tr>
					  <td class="td_normal_title" width=35%>
						 <bean:message  bundle="sys-organization" key="sysOrgElement.deptLevelNames"/>
					  </td><td colspan="3">
						<xform:radio alignment="V" property="value(kmssOrgDeptLevelDisplay)" value="${passwordSecurityConfig.kmssOrgDeptLevelDisplay}" showStatus="edit" onValueChange="kmssOrgDeptLevelDisplayChange();">
						 	<xform:simpleDataSource value="1"><bean:message  bundle="sys-organization" key="sysOrgElement.deptLevelNames.type1"/></xform:simpleDataSource>
						 	<xform:simpleDataSource value="2"><bean:message  bundle="sys-organization" key="sysOrgElement.deptLevelNames.type2"/></xform:simpleDataSource>
						 	<xform:simpleDataSource value="3"><bean:message  bundle="sys-organization" key="sysOrgElement.deptLevelNames.type3.part1"/><xform:text property="value(kmssOrgDeptLevelDisplayLength)" value="${passwordSecurityConfig.kmssOrgDeptLevelDisplayLength}" style="width:50px;" showStatus="edit" required="true" validators="digits min(0)"/><bean:message  bundle="sys-organization" key="sysOrgElement.deptLevelNames.type3.part2"/></xform:simpleDataSource>
						 </xform:radio>
					  </td>
					</tr>
					<tr>
					  <td class="td_normal_title" width=35%>
						 <bean:message  bundle="sys-organization" key="sysOrgElement.addressDeptLevelNames"/>
					  </td><td colspan="3">
						<xform:radio alignment="V" property="value(kmssOrgAddressDeptLevelDisplay)" value="${passwordSecurityConfig.kmssOrgAddressDeptLevelDisplay}" showStatus="edit" onValueChange="kmssOrgAddressDeptLevelDisplayChange();">
						 	<xform:simpleDataSource value="1"><bean:message  bundle="sys-organization" key="sysOrgElement.deptLevelNames.type1"/></xform:simpleDataSource>
						 	<xform:simpleDataSource value="2"><bean:message  bundle="sys-organization" key="sysOrgElement.deptLevelNames.type2"/></xform:simpleDataSource>
						 	<xform:simpleDataSource value="3"><bean:message  bundle="sys-organization" key="sysOrgElement.deptLevelNames.type3.part1"/><xform:text property="value(kmssOrgAddressDeptLevelDisplayLength)" value="${passwordSecurityConfig.kmssOrgAddressDeptLevelDisplayLength}" style="width:50px;" showStatus="edit" required="true" validators="digits min(0)"/><bean:message  bundle="sys-organization" key="sysOrgElement.deptLevelNames.type3.part2"/></xform:simpleDataSource>
						 </xform:radio>
					  </td>
					</tr>
					<tr>
					  <td class="td_normal_title" width=35%>
						 <bean:message  bundle="sys-organization" key="organization.showStaffingLevel" />
					  </td><td colspan="3">
							<ui:switch property="value(showStaffingLevel)" checked="true" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
					  </td>
					</tr>
					<tr>
					  <td class="td_normal_title" width=35%>
					  	<bean:message bundle="sys-organization" key="sysOrgPersonConfig.special.char.pass" />
					  </td><td colspan="3">
							<ui:switch property="value(isLoginSpecialChar)" checked="false" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
					  </td>
					</tr>											
					<tr>
					  <td class="td_normal_title" width=35%>
						 <bean:message  bundle="sys-organization" key="organization.isNoRequired" />
						 <br>
						 <font color="red"><bean:message bundle="sys-organization" key="organization.isNoRequired.desc"/></font>
					  </td><td colspan="3">
							<ui:switch property="value(isNoRequired)" checked="true" onValueChange="kmssNoRequiredChange()" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
					  </td>
					</tr>
					
					<tr>
					  <td class="td_normal_title" width=35%>
						 <bean:message  bundle="sys-organization" key="sysOrganizationRelation.config.orderGroupPerson"/> 
					  </td><td colspan="3">
							<ui:switch property="value(orderGroupPerson)" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
					  </td>
					</tr>
					
											
				</table>
			</center>
			<html:hidden property="method_GET" />
			<input type="hidden" name="modelName" value="com.landray.kmss.sys.organization.model.SysOrganizationConfig" />
			
			<center style="margin-top: 10px;">
			<!-- 保存 -->
			<ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="Com_Submit(document.sysAppConfigForm, 'update');"></ui:button>
			</center>
		</html:form>
		
	 	<script type="text/javascript">
	 		$KMSSValidation();
		 	function validateAppConfigForm(thisObj){
		 		return true;
		 	}
		 	
		 	function kmssOrgDeptLevelDisplayChange() {
		 		var displayVal = $("input[name='value\\\(kmssOrgDeptLevelDisplay\\\)']:checked").val();
		 		var displayLength = $("input[name='value\\\(kmssOrgDeptLevelDisplayLength\\\)']");
		 		if(displayVal == '3') {
		 			displayLength.attr("disabled", false);
		 		} else {
		 			displayLength.attr("disabled", true);
		 		}
		 	}
		 	
		 	function kmssOrgAddressDeptLevelDisplayChange() {
		 		var displayVal = $("input[name='value\\\(kmssOrgAddressDeptLevelDisplay\\\)']:checked").val();
		 		var displayLength = $("input[name='value\\\(kmssOrgAddressDeptLevelDisplayLength\\\)']");
		 		if(displayVal == '3') {
		 			displayLength.attr("disabled", false);
		 		} else {
		 			displayLength.attr("disabled", true);
		 		}
		 	}
		 	
		 	function kmssNoRequiredChange() {
		 		var displayVal = $("input[name='value\\\(isNoRequired\\\)']").val();
		 		if('true'== displayVal){
		 			alert('<bean:message bundle="sys-organization" key="organization.isNoRequired.alert"/>');
		 		}
		 	}
		 	
		 	LUI.ready(function() {
		 		kmssOrgDeptLevelDisplayChange();
			});
	 	</script>
	</template:replace>
</template:include>
