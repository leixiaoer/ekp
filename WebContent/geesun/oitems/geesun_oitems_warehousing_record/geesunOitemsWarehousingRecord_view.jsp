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
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('geesunOitemsWarehousingRecord.do?method=edit&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('geesunOitemsWarehousingRecord.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="geesun-oitems" key="table.geesunOitemsWarehousingRecord"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="geesunOitemsWarehousingRecordForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="table.geesunOitemsListing"/>.<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdId"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsWarehousingRecordForm.geesunOitemsListing.fdId}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdNumber"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsWarehousingRecordForm.fdNumber}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdPrice"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsWarehousingRecordForm.fdPrice}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdAccountPrice"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsWarehousingRecordForm.fdAccountPrice}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdCreateTime"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsWarehousingRecordForm.fdCreateTime}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="table.sysOrgElement3"/>.<bean:message  bundle="geesun-oitems" key="sysOrgElement3.fdId"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsWarehousingRecordForm.sysOrgElement3.fdId}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
