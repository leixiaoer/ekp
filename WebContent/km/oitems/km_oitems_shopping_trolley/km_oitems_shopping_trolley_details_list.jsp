<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<br/>
<p><b><center><font size=4>
<bean:message  bundle="km-oitems" key="kmOitemsListing.out.details.count"/></font></center></b>
</p>
<html:form action="/km/oitems/km_oitems_listing/kmOitemsListing.do">
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="40pt"><bean:message key="page.serial"/></td>
				<sunbor:column property="kmOitemsListing.fdNo">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdName">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdCategory.fdName">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdSpecification">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdBrand">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsShoppingTrolley.fdApplicationNumber">
				<bean:message  bundle="km-oitems" key="kmOitemsShoppingTrolley.fdApplicationNumber"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdUnit">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdReferencePrice">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdAmount.money">
				<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount.money"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsBudgerApplication.fdOutTime">
				<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdOutTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmOitemsShoppingTrolley" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do" />?method=view&fdId=${kmOitemsShoppingTrolley.kmOitemsBudgerApplication.fdId}">
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${kmOitemsShoppingTrolley.fdNo}" />
				</td>
				<td>
					<c:out value="${kmOitemsShoppingTrolley.fdName}" />
				</td>
				<td>
					<c:out value="${kmOitemsShoppingTrolley.fdCategoryName}" />
				</td>
				<td>
					<c:out value="${kmOitemsShoppingTrolley.fdSpecification}" />
				</td>
				<td>
					<c:out value="${kmOitemsShoppingTrolley.fdBrand}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${kmOitemsShoppingTrolley.fdApplicationNumber}" />
				</td>
				<td>
					<c:out value="${kmOitemsShoppingTrolley.fdUnit}" />
				</td>
				<td>
					<kmss:showNumber value="${kmOitemsShoppingTrolley.fdReferencePrice}" pattern="#.##"></kmss:showNumber>
				</td>
				<td>
					<kmss:showNumber value="${kmOitemsShoppingTrolley.fdApplicationNumber*kmOitemsShoppingTrolley.fdReferencePrice}" pattern="#.##"/>
				</td>
				<td><kmss:showDate value="${kmOitemsShoppingTrolley.kmOitemsBudgerApplication.fdOutTime}"
					type="datetime" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>