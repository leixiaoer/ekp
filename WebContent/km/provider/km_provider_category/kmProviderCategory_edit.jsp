<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>
	Com_IncludeFile("dialog.js|jquery.js");
</script>
<html:form action="/km/provider/km_provider_category/kmProviderCategory.do">
<div id="optBarDiv">
	<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_edit_button.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmProviderCategoryForm" />
	</c:import>
</div>

<p class="txttitle"><bean:message bundle="km-provider" key="table.kmProviderCategory"/></p>

<center>
<table class="tb_normal" width=95%>
	
	<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_edit_body.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmProviderCategoryForm" />
			<c:param name="requestURL" value="/km/provider/km_provider_category/kmProviderCategory.do?method=add" />
			<c:param name="fdModelName" value="com.landray.kmss.km.provider.model.KmProviderCategory" />
	</c:import>

</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();
	$('input[name="fdName"]').attr("subject","<bean:message bundle='sys-simplecategory' key='sysSimpleCategory.fdName' />");
	$('input[name="fdName"]').attr("validate","required");
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>