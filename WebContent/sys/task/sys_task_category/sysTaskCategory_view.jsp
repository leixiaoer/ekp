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
		<kmss:auth requestURL="/sys/task/sys_task_category/sysTaskCategory.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('sysTaskCategory.do?method=edit&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/sys/task/sys_task_category/sysTaskCategory.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('sysTaskCategory.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="sys-task" key="table.sysTaskCategory"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="sysTaskCategoryForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="sys-task" key="sysTaskCategory.fdName"/>
		</td><td width=35% colspan=3>
			<c:out value="${sysTaskCategoryForm.fdName}" />
		</td>
		
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="sys-task" key="sysTaskCategory.fdOrder"/>
		</td><td width=35%>
			<c:out value="${sysTaskCategoryForm.fdOrder}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="sys-task" key="sysTaskCategory.fdIsAvailable"/>
		</td><td width=35%>
			<sunbor:enumsShow value="${sysTaskCategoryForm.fdIsAvailable}" enumsType="common_yesno" />
		</td>
		
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>