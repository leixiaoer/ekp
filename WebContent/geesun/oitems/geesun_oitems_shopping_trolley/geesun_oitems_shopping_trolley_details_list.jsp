<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<br/>
<p><b><center><font size=4>
<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.out.details.count"/></font></center></b>
</p>
<html:form action="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do">
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="40pt"><bean:message key="page.serial"/></td>
				<sunbor:column property="geesunOitemsListing.fdNo">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdName">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdCategory.fdName">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdSpecification">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdBrand">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsShoppingTrolley.fdApplicationNumber">
				<bean:message  bundle="geesun-oitems" key="geesunOitemsShoppingTrolley.fdApplicationNumber"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdUnit">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdReferencePrice">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdAmount.money">
				<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount.money"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsBudgerApplication.fdOutTime">
				<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdOutTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOitemsShoppingTrolley" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do" />?method=view&fdId=${geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdId}">
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.fdNo}" />
				</td>
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.fdName}" />
				</td>
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.fdCategoryName}" />
				</td>
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.fdSpecification}" />
				</td>
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.fdBrand}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${geesunOitemsShoppingTrolley.fdApplicationNumber}" />
				</td>
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.fdUnit}" />
				</td>
				<td>
					<kmss:showNumber value="${geesunOitemsShoppingTrolley.fdReferencePrice}" pattern="#.##"></kmss:showNumber>
				</td>
				<td>
					<kmss:showNumber value="${geesunOitemsShoppingTrolley.fdApplicationNumber*geesunOitemsShoppingTrolley.fdReferencePrice}" pattern="#.##"/>
				</td>
				<td><kmss:showDate value="${geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdOutTime}"
					type="datetime" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>
