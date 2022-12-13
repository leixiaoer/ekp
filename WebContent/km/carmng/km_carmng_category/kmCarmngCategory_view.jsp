<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
		<kmss:auth requestURL="/km/carmng/km_carmng_category/kmCarmngCategory.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmCarmngCategory.do?method=edit&fdId=${param.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/carmng/km_carmng_category/kmCarmngCategory.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmCarmngCategory.do?method=delete&fdId=${param.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngCategory"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="kmCarmngCategoryForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngCategory.fdName"/>
		</td><td width=35%>
			<c:out value="${kmCarmngCategoryForm.fdName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngCategory.fdParentId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngCategoryForm.fdParentName}" />
		</td>
	</tr>
	<tr>		
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngCategory.fdOrder"/>
		</td><td width=35%>
			<c:out value="${kmCarmngCategoryForm.fdOrder}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngCategory.docCreateTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngCategoryForm.docCreateTime}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngCategory.docCreatorId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngCategoryForm.docCreatorName}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>