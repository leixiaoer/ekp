<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("dialog.js", null, "js");
</script>
<html:form action="/km/carmng/km_carmng_category/kmCarmngCategory.do" onsubmit="return validateKmCarmngCategoryForm(this);">
	<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_edit_button.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmCarmngCategoryForm" />
	</c:import>

<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngCategory"/></p>

<center>
<table class="tb_normal" width=95%>
<html:hidden property="fdId"/>
	<c:import url="/sys/simplecategory/include/sysCategoryMain_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmCarmngCategoryForm" />
			<c:param name="requestURL" value="km/carmng/km_carmng_category/kmCarmngCategory.do?method=add" />
			<c:param name="fdModelName" value="${param.fdModelName}" />
		</c:import>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="kmCarmngCategoryForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>