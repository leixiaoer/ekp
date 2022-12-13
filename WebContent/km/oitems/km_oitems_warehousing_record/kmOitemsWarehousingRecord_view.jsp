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
		<kmss:auth requestURL="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmOitemsWarehousingRecord.do?method=edit&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmOitemsWarehousingRecord.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-oitems" key="table.kmOitemsWarehousingRecord"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="kmOitemsWarehousingRecordForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="table.kmOitemsListing"/>.<bean:message  bundle="km-oitems" key="kmOitemsListing.fdId"/>
		</td><td width=35%>
			<c:out value="${kmOitemsWarehousingRecordForm.kmOitemsListing.fdId}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdNumber"/>
		</td><td width=35%>
			<c:out value="${kmOitemsWarehousingRecordForm.fdNumber}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdPrice"/>
		</td><td width=35%>
			<c:out value="${kmOitemsWarehousingRecordForm.fdPrice}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdAccountPrice"/>
		</td><td width=35%>
			<c:out value="${kmOitemsWarehousingRecordForm.fdAccountPrice}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdCreateTime"/>
		</td><td width=35%>
			<c:out value="${kmOitemsWarehousingRecordForm.fdCreateTime}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="table.sysOrgElement3"/>.<bean:message  bundle="km-oitems" key="sysOrgElement3.fdId"/>
		</td><td width=35%>
			<c:out value="${kmOitemsWarehousingRecordForm.sysOrgElement3.fdId}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>