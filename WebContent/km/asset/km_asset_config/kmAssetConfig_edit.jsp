<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.profile.edit" sidebar="no">
<template:replace name="content">
<html:form action="/km/asset/km_asset_config/kmAssetConfig.do">
<div style="margin-top:25px">
<p class="configtitle"><bean:message bundle="km-asset" key="table.kmAssetConfig"/></p>
<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetConfig.codeRule"/>
		</td><td colspan="3">
			<xform:radio property="codeRule">
				<xform:enumsDataSource enumsType="km_asset_config_code_rule" />
			</xform:radio>
		</td>
	</tr>
</table>
<div style="margin-bottom: 10px;margin-top:25px">
	   <ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="Com_Submit(document.kmAssetConfigForm, 'update');" order="1" ></ui:button>
</div>
</center>
</div>
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();
</script>
</html:form>
</template:replace>
</template:include>