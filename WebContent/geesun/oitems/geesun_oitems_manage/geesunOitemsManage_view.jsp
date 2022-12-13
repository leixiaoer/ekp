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
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('geesunOitemsManage.do?method=edit&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('geesunOitemsManage.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="geesun-oitems" key="table.geesunOitemsManage"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="geesunOitemsManageForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsManage.fdName"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsManageForm.fdName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsManage.fdParentCategory"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsManageForm.fdParentName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title">
			<bean:message  bundle="geesun-oitems" key="geesunOitemsManage.fdOrder"/>
		</td>
		<td colspan="3">
			<c:out value="${geesunOitemsManageForm.fdOrder}"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsManage.fdCreatorId"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsManageForm.docCreatorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsManage.fdCreateTime"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsManageForm.docCreateTime}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
