<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript">
window.onload =function (){
	setTimeout(dyniFrameSize,100);
}; 
	function dyniFrameSize() {
	try {
		// 调整高度
		var arguObj = document.getElementsByTagName("table")[0];
		if (arguObj != null && window.frameElement != null && window.frameElement.tagName == "IFRAME") {
			window.frameElement.style.height = (arguObj.offsetHeight + 40) + "px";
		}
	} catch (e) {}
};
</script>
<html:form action="/km/oitems/km_oitems_report_listing/kmOitemsReportListing.do">
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table class="tb_normal" width="100%">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="10pt">
					<input type="checkbox" name="List_Tongle">
				</td>
				<td width="40pt">
					<bean:message key="page.serial"/>
				</td>
				<sunbor:column property="kmOitemsShoppingTrolley.fdApplicationNumber">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.number"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsShoppingTrolley.kmOitemsBudgerApplication.docSubject">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.subject"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsShoppingTrolley.kmOitemsBudgerApplication.docCreator.fdName">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.creater"/>
				</sunbor:column >
				<sunbor:column property="kmOitemsShoppingTrolley.kmOitemsBudgerApplication.docCreateTime">
					<bean:message bundle="km-oitems" key="kmOitemsReportListing.creatTime"/>
				</sunbor:column>
			
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmOitemsShoppingTrolley" varStatus="vstatus">
			<tr>
				<td>
					<input type="checkbox" name="List_Selected" value="${kmOitemsShoppingTrolley.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmOitemsShoppingTrolley.fdApplicationNumber}" />
				</td>
				<td>
					<a onclick="Com_OpenNewWindow(this)" data-href="<c:url value="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do" />?method=view&fdId=${kmOitemsShoppingTrolley.kmOitemsBudgerApplication.fdId}" target="_bank"><c:out value="${kmOitemsShoppingTrolley.kmOitemsBudgerApplication.docSubject}" /></a>
				</td>
				<td>
					<c:out value="${kmOitemsShoppingTrolley.kmOitemsBudgerApplication.fdApplyor.fdName}" />
				</td>
				<td>
					<c:out value="${kmOitemsShoppingTrolley.kmOitemsBudgerApplication.docCreateTime}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>