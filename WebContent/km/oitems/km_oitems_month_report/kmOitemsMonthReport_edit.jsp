<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/km/oitems/km_oitems_month_report/kmOitemsMonthReport.do">
<div id="optBarDiv">
	<c:if test="${kmOitemsMonthReportForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmOitemsMonthReportForm, 'update');">
	</c:if>
	<c:if test="${kmOitemsMonthReportForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmOitemsMonthReportForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmOitemsMonthReportForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-oitems" key="table.kmOitemsMonthReport"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsMonthReport.docSubject"/>
		</td><td width="35%">
			<xform:text property="docSubject" style="width:95%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsMonthReport.docCreateTime"/>
		</td><td width="35%">
			<xform:datetime property="docCreateTime" showStatus="readOnly" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsMonthReport.docAlterTime"/>
		</td><td width="35%">
			<xform:datetime property="docAlterTime" showStatus="readOnly" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsMonthReport.fdLastModifiedTime"/>
		</td><td width="35%">
			<xform:datetime property="fdLastModifiedTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsMonthReport.fdType"/>
		</td><td width="35%">
			<xform:text property="fdType" style="width:95%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsMonthReport.fdAmount"/>
		</td><td width="35%">
			<xform:text property="fdAmount" style="width:95%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsMonthReport.docDept"/>
		</td><td width="35%">
			<xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_ALL" style="width:95%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsMonthReport.docCreator"/>
		</td><td width="35%">
			<xform:address propertyId="docCreatorId" propertyName="docCreatorName" orgType="ORG_TYPE_PERSON" showStatus="readOnly" />
		</td>
	</tr>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	Com_IncludeFile("calendar.js");
	Com_IncludeFile("dialog.js");
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>