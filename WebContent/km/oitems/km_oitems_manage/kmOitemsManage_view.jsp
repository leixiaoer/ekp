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
		<kmss:auth requestURL="/km/oitems/km_oitems_manage/kmOitemsManage.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmOitemsManage.do?method=edit&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/oitems/km_oitems_manage/kmOitemsManage.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmOitemsManage.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-oitems" key="table.kmOitemsManage"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="kmOitemsManageForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-oitems" key="kmOitemsManage.fdName"/>
		</td><td width=35%>
			<c:out value="${kmOitemsManageForm.fdName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-oitems" key="kmOitemsManage.fdParentCategory"/>
		</td><td width=35%>
			<c:out value="${kmOitemsManageForm.fdParentName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title">
			<bean:message  bundle="km-oitems" key="kmOitemsManage.fdOrder"/>
		</td>
		<td colspan="3">
			<c:out value="${kmOitemsManageForm.fdOrder}"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsManage.fdCreatorId"/>
		</td><td width=35%>
			<c:out value="${kmOitemsManageForm.docCreatorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-oitems" key="kmOitemsManage.fdCreateTime"/>
		</td><td width=35%>
			<c:out value="${kmOitemsManageForm.docCreateTime}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>