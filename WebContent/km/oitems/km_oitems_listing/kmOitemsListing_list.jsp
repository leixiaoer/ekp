<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/oitems/km_oitems_listing/kmOitemsListing.do">
	<!--<c:import url="/resource/jsp/search_bar.jsp" charEncoding="UTF-8">
	<c:param name="fdModelName" value="com.landray.kmss.km.oitems.model.KmOitemsListing" />
    </c:import>-->
	<div id="optBarDiv">
		
		<kmss:auth requestURL="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=add" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do" />?method=add&categoryId=${JsParam.categoryId }');">
		</kmss:auth>
		<c:if test="${param.type != 'stock' }">
		<kmss:auth requestURL="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmOitemsListingForm, 'deleteall');">
		</kmss:auth>
		</c:if>
		<!--<input  type="button" value="<bean:message key="button.search"/>" onclick="Search_Show();">-->
	</div>
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="10pt"><input type="checkbox" name="List_Tongle"></td>
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
				<sunbor:column property="kmOitemsListing.fdUnit">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdReferencePrice">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdAmount">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmOitemsListing" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do" />?method=view&fdId=${kmOitemsListing.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmOitemsListing.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td kmss_wordlength="20">
					<c:out value="${kmOitemsListing.fdNo}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${kmOitemsListing.fdName}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${kmOitemsListing.fdCategory.fdName}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${kmOitemsListing.fdSpecification}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${kmOitemsListing.fdBrand}" />
				</td>
				<td>
					<c:out value="${kmOitemsListing.fdUnit}" />
				</td>
				<td>
					<kmss:showNumber value="${kmOitemsListing.fdReferencePrice}" pattern="#.##"></kmss:showNumber>
				</td>
				<td>
					<c:out value="${kmOitemsListing.fdAmount}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>