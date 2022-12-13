<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.profile.edit" sidebar="no">
<template:replace name="head">
	<script>
			Com_IncludeFile("dialog.js|jquery.js");
		</script>
</template:replace>
<template:replace name="content">
<style type="text/css">
</style>
<html:form action="/geesun/annual/geesun_annual_main/geesunAnnualMain.do">
<html:hidden property="fdId"/>
<div style="margin-top:25px">
<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			单据ID
		</td><td colspan=3>
			<xform:text property="reviewId" required="true" showStatus="edit" style="width:85%;"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			字段ID
		</td><td colspan=3>
			<xform:text property="fieldId" required="true" showStatus="edit" style="width:85%;"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			字段值
		</td><td colspan=3>
			<xform:text property="fieldValue" required="true" showStatus="edit" style="width:85%;"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			类型
		</td><td colspan=3>
			<xform:select property="type" required="true" showStatus="edit">
				<xform:enumsDataSource enumsType="geesun_annual_type"/>
			</xform:select>
		</td>
	</tr>
</table>
<div style="margin-bottom: 10px;margin-top:25px">
	   <ui:button text="${lfn:message('geesun-annual:geesunAnnualMain.save')}" height="35" width="120" onclick="onSave();" order="1" ></ui:button>
</div>
</center>
</div>
<html:hidden property="method_GET"/>
</html:form>
<script type="text/javascript">
	var onsubmit = false;
	seajs.use(['lui/jquery','lui/dialog'], function($,dialog){
		var validation = $KMSSValidation();
		window.onSave = function() {
			if(onsubmit){
				return;
			}
			if(!validation.validate()){
				return;
			}
			onsubmit = true;
			window.syn_loading = dialog.loading();
			Com_Submit(document.geesunAnnualMainForm, 'updateReviewInfo');
		};
	});
</script>
</template:replace>
</template:include>