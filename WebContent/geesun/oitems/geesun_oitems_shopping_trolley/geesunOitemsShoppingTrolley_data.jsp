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
<html:form action="/geesun/oitems/geesun_oitems_report_listing/geesunOitemsReportListing.do">
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
				<sunbor:column property="geesunOitemsShoppingTrolley.fdApplicationNumber">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.number"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docSubject">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.subject"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docCreator.fdName">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.creater"/>
				</sunbor:column >
				<sunbor:column property="geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docCreateTime">
					<bean:message bundle="geesun-oitems" key="geesunOitemsReportListing.creatTime"/>
				</sunbor:column>
			
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOitemsShoppingTrolley" varStatus="vstatus">
			<tr>
				<td>
					<input type="checkbox" name="List_Selected" value="${geesunOitemsShoppingTrolley.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.fdApplicationNumber}" />
				</td>
				<td>
					<a href="<c:url value="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do" />?method=view&fdId=${geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdId}" target="_bank"><c:out value="${geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docSubject}" /></a>
				</td>
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdApplyor.fdName}" />
				</td>
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docCreateTime}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>
