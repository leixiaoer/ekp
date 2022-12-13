<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
<html:form action="/km/asset/km_asset_address_cate/kmAssetAddressCate.do">
<div id="optBarDiv">
	<c:if test="${kmAssetAddressCateForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmAssetAddressCateForm, 'update');">
	</c:if>
	<c:if test="${kmAssetAddressCateForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmAssetAddressCateForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmAssetAddressCateForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message  bundle="km-asset" key="table.kmAssetAddressCate"/></p>

<center>
<table class="tb_normal" width=95%>
   <c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_edit_body.jsp"
			charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetAddressCateForm" />
		<c:param name="requestURL" value="km/asset/km_asset_address_cate/kmAssetAddressCate.do?method=add" />
		<c:param name="fdModelName" value="${param.fdModelName}" />
	</c:import> 
</table>
</center>
<html:hidden property="fdId"/>
<html:hidden property="method_GET"/>
<script>
	$KMSSValidation();
	$('input[name="fdName"]').attr("subject","<bean:message bundle='sys-simplecategory' key='sysSimpleCategory.fdName' />");
	$('input[name="fdName"]').attr("validate","required");
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>