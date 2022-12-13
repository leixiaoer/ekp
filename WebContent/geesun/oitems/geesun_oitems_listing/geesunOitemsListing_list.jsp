<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do">
	<!--<c:import url="/resource/jsp/search_bar.jsp" charEncoding="UTF-8">
	<c:param name="fdModelName" value="com.landray.kmss.geesun.oitems.model.GeesunOitemsListing" />
    </c:import>-->
	<div id="optBarDiv">
		
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=add" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do" />?method=add&categoryId=${JsParam.categoryId }');">
		</kmss:auth>
		<c:if test="${param.type != 'stock' }">
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.geesunOitemsListingForm, 'deleteall');">
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
				<sunbor:column property="geesunOitemsListing.fdUnit">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdReferencePrice">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdAmount">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOitemsListing" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do" />?method=view&fdId=${geesunOitemsListing.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${geesunOitemsListing.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td kmss_wordlength="20">
					<c:out value="${geesunOitemsListing.fdNo}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${geesunOitemsListing.fdName}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${geesunOitemsListing.fdCategory.fdName}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${geesunOitemsListing.fdSpecification}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${geesunOitemsListing.fdBrand}" />
				</td>
				<td>
					<c:out value="${geesunOitemsListing.fdUnit}" />
				</td>
				<td>
					<kmss:showNumber value="${geesunOitemsListing.fdReferencePrice}" pattern="#.##"></kmss:showNumber>
				</td>
				<td>
					<c:out value="${geesunOitemsListing.fdAmount}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>
