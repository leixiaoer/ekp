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
		<kmss:auth requestURL="/km/oitems/km_oitems_budger_listing/kmOitemsBudgerListing.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmOitemsBudgerListing.do?method=edit&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/oitems/km_oitems_budger_listing/kmOitemsBudgerListing.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmOitemsBudgerListing.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-oitems" key="table.kmOitemsBudgerListing"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="kmOitemsBudgerListingForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="table.kmOitemsBudgerApplication"/>.<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdId"/>
		</td><td width=35%>
			<c:out value="${kmOitemsBudgerListingForm.kmOitemsBudgerApplication.fdId}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-oitems" key="kmOitemsBudgerListing.fdApplicationNumber"/>
		</td><td width=35%>
			<c:out value="${kmOitemsBudgerListingForm.fdApplicationNumber}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="table.kmOitemsListing"/>.<bean:message  bundle="km-oitems" key="kmOitemsListing.fdId"/>
		</td><td width=35%>
			<c:out value="${kmOitemsBudgerListingForm.kmOitemsListing.fdId}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>