<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/oitems/km_oitems_report_listing/kmOitemsReportListing.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/oitems/km_oitems_report_listing/kmOitemsReportListing.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/oitems/km_oitems_report_listing/kmOitemsReportListing.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/oitems/km_oitems_report_listing/kmOitemsReportListing.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmOitemsReportListingForm, 'deleteall');">
		</kmss:auth>
	</div>
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="10pt">
					<input type="checkbox" name="List_Tongle">
				</td>
				<td width="40pt">
					<bean:message key="page.serial"/>
				</td>
				<sunbor:column property="kmOitemsReportListing.fdCount">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdCount"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsReportListing.fdCategory">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdCategory"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsReportListing.fdName">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsReportListing.fdReferencePrice">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdReferencePrice"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsReportListing.fdUnit">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdUnit"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsReportListing.fdAmount">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdAmount"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsReportListing.docCreator.fdName">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.docCreator"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsReportListing.fdMonthReport.docSubject">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.fdMonthReport"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmOitemsReportListing" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/oitems/km_oitems_report_listing/kmOitemsReportListing.do" />?method=view&fdId=${kmOitemsReportListing.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmOitemsReportListing.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmOitemsReportListing.fdCount}" />
				</td>
				<td>
					<c:out value="${kmOitemsReportListing.fdCategory}" />
				</td>
				<td>
					<c:out value="${kmOitemsReportListing.fdName}" />
				</td>
				<td>
					<c:out value="${kmOitemsReportListing.fdReferencePrice}" />
				</td>
				<td>
					<c:out value="${kmOitemsReportListing.fdUnit}" />
				</td>
				<td>
					<c:out value="${kmOitemsReportListing.fdAmount}" />
				</td>
				<td>
					<c:out value="${kmOitemsReportListing.docCreator.fdName}" />
				</td>
				<td>
					<c:out value="${kmOitemsReportListing.fdMonthReport.docSubject}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>