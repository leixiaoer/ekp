<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/oitems/km_oitems_month_report/kmOitemsMonthReport.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/oitems/km_oitems_month_report/kmOitemsMonthReport.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmOitemsMonthReportForm, 'deleteall');">
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
				<sunbor:column property="kmOitemsMonthReport.docSubject">
					<bean:message bundle="km-oitems" key="kmOitemsMonthReport.docSubject"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsMonthReport.docCreateTime">
					<bean:message bundle="km-oitems" key="kmOitemsMonthReport.docCreateTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmOitemsMonthReport" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/oitems/km_oitems_month_report/kmOitemsMonthReport.do" />?method=view&fdId=${kmOitemsMonthReport.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmOitemsMonthReport.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmOitemsMonthReport.docSubject}" />
				</td>
				<td>
					<kmss:showDate value="${kmOitemsMonthReport.docCreateTime}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>