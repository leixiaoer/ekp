<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/geesun/oitems/geesun_oitems_month_report/geesunOitemsMonthReport.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_month_report/geesunOitemsMonthReport.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.geesunOitemsMonthReportForm, 'deleteall');">
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
				<sunbor:column property="geesunOitemsMonthReport.docSubject">
					<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.docSubject"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsMonthReport.docCreateTime">
					<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.docCreateTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOitemsMonthReport" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/geesun/oitems/geesun_oitems_month_report/geesunOitemsMonthReport.do" />?method=view&fdId=${geesunOitemsMonthReport.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${geesunOitemsMonthReport.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${geesunOitemsMonthReport.docSubject}" />
				</td>
				<td>
					<kmss:showDate value="${geesunOitemsMonthReport.docCreateTime}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>
