<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/oitems/km_oitems_report_listing/kmOitemsReportListing.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmOitemsReportListing.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/oitems/km_oitems_report_listing/kmOitemsReportListing.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmOitemsReportListing.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-oitems" key="table.kmOitemsReportListing"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdCount"/>
		</td><td width="35%">
			<xform:text property="fdCount" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdCategory"/>
		</td><td width="35%">
			<xform:text property="fdCategory" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdName"/>
		</td><td width="35%">
			<xform:text property="fdName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdReferencePrice"/>
		</td><td width="35%">
			<xform:text property="fdReferencePrice" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdUnit"/>
		</td><td width="35%">
			<xform:text property="fdUnit" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdAmount"/>
		</td><td width="35%">
			<xform:text property="fdAmount" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.docCreator"/>
		</td><td width="35%">
			<c:out value="${kmOitemsReportListingForm.docCreatorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdMonthReport"/>
		</td><td width="35%">
			<c:out value="${kmOitemsReportListingForm.fdMonthReportName}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>