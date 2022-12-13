<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/geesun/oitems/geesun_oitems_report_listing/geesunOitemsReportListing.do">
<div id="optBarDiv">
	<c:if test="${geesunOitemsReportListingForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.geesunOitemsReportListingForm, 'update');">
	</c:if>
	<c:if test="${geesunOitemsReportListingForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.geesunOitemsReportListingForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.geesunOitemsReportListingForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="geesun-oitems" key="table.geesunOitemsReportListing"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdCount"/>
		</td><td width="35%">
			<xform:text property="fdCount" style="width:95%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdCategory"/>
		</td>
		<td width="35%">
			<xform:text property="fdCategory" style="width:95%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdName"/>
		</td><td width="35%">
			<xform:text property="fdName" style="width:95%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdReferencePrice"/>
		</td><td width="35%">
			<xform:text property="fdReferencePrice" style="width:95%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdUnit"/>
		</td><td width="35%">
			<xform:text property="fdUnit" style="width:95%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdAmount"/>
		</td><td width="35%">
			<xform:text property="fdAmount" style="width:95%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.docCreator"/>
		</td><td width="35%">
			<xform:address propertyId="docCreatorId" propertyName="docCreatorName" orgType="ORG_TYPE_PERSON" showStatus="readOnly" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdMonthReport"/>
		</td><td width="35%">
			<xform:select property="fdMonthReportId">
				<xform:beanDataSource serviceBean="geesunOitemsMonthReportService" selectBlock="fdId,docSubject" orderBy="" />
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
