<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/carmng/km_carmng_category/kmCarmngCategory.do">
<c:import url="/resource/jsp/search_bar.jsp" charEncoding="UTF-8">
	<c:param name="fdModelName" value="com.landray.kmss.km.carmng.model.KmCarmngCategory" />
    </c:import>
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/carmng/km_carmng_category/kmCarmngCategory.do?method=add" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/carmng/km_carmng_category/kmCarmngCategory.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/carmng/km_carmng_category/kmCarmngCategory.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmCarmngCategoryForm, 'deleteall');">
		</kmss:auth>
		<input  type="button" value="<bean:message key="button.search"/>" onclick="Search_Show();">
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
				<sunbor:column property="kmCarmngCategory.fdOrder">
					<bean:message  bundle="km-carmng" key="kmCarmngCategory.fdOrder"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngCategory.fdName">
					<bean:message  bundle="km-carmng" key="kmCarmngCategory.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngCategory.hbmParent.fdName">
					<bean:message  bundle="km-carmng" key="kmCarmngCategory.fdParentId"/>
				</sunbor:column>			
				<sunbor:column property="kmCarmngCategory.docCreator.fdName">
					<bean:message  bundle="km-carmng" key="kmCarmngCategory.docCreatorId"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngCategory.docCreateTime">
					<bean:message  bundle="km-carmng" key="kmCarmngCategory.docCreateTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmCarmngCategory" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/carmng/km_carmng_category/kmCarmngCategory.do" />?method=view&fdId=${kmCarmngCategory.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmCarmngCategory.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${kmCarmngCategory.fdOrder}" />
				</td>
				<td>
					<c:out value="${kmCarmngCategory.fdName}" />
				</td>
				<td>
					<c:out value="${kmCarmngCategory.fdParent.fdName}" />
				</td>							
				<td>
					<c:out value="${kmCarmngCategory.docCreator.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${kmCarmngCategory.docCreateTime}"></kmss:showDate>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>