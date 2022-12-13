<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/geesun/oitems/geesun_oitems_report_listing/geesunOitemsReportListing.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_report_listing/geesunOitemsReportListing.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_report_listing/geesunOitemsReportListing.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_report_listing/geesunOitemsReportListing.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.geesunOitemsReportListingForm, 'deleteall');">
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
				<sunbor:column property="geesunOitemsReportListing.fdCount">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdCount"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsReportListing.fdCategory">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdCategory"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsReportListing.fdName">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdName"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsReportListing.fdReferencePrice">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdReferencePrice"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsReportListing.fdUnit">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdUnit"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsReportListing.fdAmount">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdAmount"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsReportListing.docCreator.fdName">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.docCreator"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsReportListing.fdMonthReport.docSubject">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.fdMonthReport"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOitemsReportListing" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/geesun/oitems/geesun_oitems_report_listing/geesunOitemsReportListing.do" />?method=view&fdId=${geesunOitemsReportListing.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${geesunOitemsReportListing.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${geesunOitemsReportListing.fdCount}" />
				</td>
				<td>
					<c:out value="${geesunOitemsReportListing.fdCategory}" />
				</td>
				<td>
					<c:out value="${geesunOitemsReportListing.fdName}" />
				</td>
				<td>
					<c:out value="${geesunOitemsReportListing.fdReferencePrice}" />
				</td>
				<td>
					<c:out value="${geesunOitemsReportListing.fdUnit}" />
				</td>
				<td>
					<c:out value="${geesunOitemsReportListing.fdAmount}" />
				</td>
				<td>
					<c:out value="${geesunOitemsReportListing.docCreator.fdName}" />
				</td>
				<td>
					<c:out value="${geesunOitemsReportListing.fdMonthReport.docSubject}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>
