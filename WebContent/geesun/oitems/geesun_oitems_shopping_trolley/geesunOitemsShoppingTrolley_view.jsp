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
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_listing/geesunOitemsBudgerListing.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('geesunOitemsBudgerListing.do?method=edit&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_listing/geesunOitemsBudgerListing.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('geesunOitemsBudgerListing.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="geesun-oitems" key="table.geesunOitemsBudgerListing"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="geesunOitemsBudgerListingForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="table.geesunOitemsBudgerApplication"/>.<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdId"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsBudgerListingForm.geesunOitemsBudgerApplication.fdId}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerListing.fdApplicationNumber"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsBudgerListingForm.fdApplicationNumber}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="table.geesunOitemsListing"/>.<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdId"/>
		</td><td width=35%>
			<c:out value="${geesunOitemsBudgerListingForm.geesunOitemsListing.fdId}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
