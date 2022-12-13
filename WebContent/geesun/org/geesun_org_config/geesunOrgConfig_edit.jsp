<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="config.profile.edit" sidebar="no">
	<template:replace name="title">${lfn:message('geesun-org:geesunOrgConfig.setting')}</template:replace>
		<template:replace name="head">
		<script type="text/javascript" src="${KMSS_Parameter_ResPath}js/common.js?s_cache=${LUI_Cache}"></script>
		<script type="text/javascript">
		Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp|xform.js", null, "js");
		</script>
		<style type="text/css"> 
			.tb_normal td {
    //padding: 5px;
    //border: 1px #d2d2d2 solid;
    //word-break: break-all;
}
		</style> 
	</template:replace>
	<template:replace name="content">
		<h2 align="center" style="margin: 10px 0">
			<span class="profile_config_title">${lfn:message('geesun-org:geesunOrgConfig.setting')}</span>
		</h2>
		
<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do">
	<center>
		<table class="tb_normal" width=95%  cellpadding="20" cellspacing="20" style="width: 95%;">
			<tr>
				<td class="td_normal_title" width="15%">${lfn:message('geesun-org:geesunOrgConfig.new.person.initialPassword')}</td>
				<td>
					<html:text property="value(kmss.ehr.new.person.init.password)" style="width:85%"/>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">${lfn:message('geesun-org:geesunOrgConfig.batch.size')}</td>
				<td>
					<html:text property="value(kmss.ehr.in.batch.size)" style="width:85%"/>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">${lfn:message('geesun-org:geesunOrgConfig.in.delete.size')}</td>
				<td>
					<html:text property="value(kmss.ehr.in.delete.size)" style="width:10%"/>
					<span class="message">${lfn:message('geesun-org:geesunOrgConfig.in.delete.size.tip')}</span>
				</td>
			</tr>
		</table>
	</center>
	<html:hidden property="method_GET" />
	<input type="hidden" name="modelName" value="com.landray.kmss.geesun.org.model.GeesunOrgConfig" />
	<input type="hidden" name="autoclose" value="false" />
	<center style="margin-top: 10px;">
	<!-- 保存 -->
	<ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="Com_Submit(document.sysAppConfigForm, 'update');"></ui:button>
	</center>
</html:form>
		
	 	<script type="text/javascript">
			$KMSSValidation();
			function validateAppConfigForm(thisObj) {
				return true;
			}

		</script>
	</template:replace>
</template:include>
