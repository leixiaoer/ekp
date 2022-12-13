<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/km/oitems/km_oitems_report_listing/kmOitemsReportListing.do">
<div id="optBarDiv">
	<c:if test="${kmOitemsReportListingForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmOitemsReportListingForm, 'update');">
	</c:if>
	<c:if test="${kmOitemsReportListingForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmOitemsReportListingForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmOitemsReportListingForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-oitems" key="table.kmOitemsReportListing"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdCount"/>
		</td><td width="35%">
			<xform:text property="fdCount" style="width:95%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdCategory"/>
		</td>
		<td width="35%">
			<xform:text property="fdCategory" style="width:95%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdName"/>
		</td><td width="35%">
			<xform:text property="fdName" style="width:95%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdReferencePrice"/>
		</td><td width="35%">
			<xform:text property="fdReferencePrice" style="width:95%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdUnit"/>
		</td><td width="35%">
			<xform:text property="fdUnit" style="width:95%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdAmount"/>
		</td><td width="35%">
			<xform:text property="fdAmount" style="width:95%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.docCreator"/>
		</td><td width="35%">
			<xform:address propertyId="docCreatorId" propertyName="docCreatorName" orgType="ORG_TYPE_PERSON" showStatus="readOnly" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdMonthReport"/>
		</td><td width="35%">
			<xform:select property="fdMonthReportId">
				<xform:beanDataSource serviceBean="kmOitemsMonthReportService" selectBlock="fdId,docSubject" orderBy="" />
			</xform:select>
		</td>
	</tr>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>