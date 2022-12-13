<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=add" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do" />?method=add&categoryId=${JsParam.categoryId}&motorcadeId=${JsParam.motorcadeId}');">
		</kmss:auth>
		<kmss:auth requestURL="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmCarmngInfomationForm, 'deleteall');">
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
				<td width="10pt"><input type="checkbox" name="List_Tongle"></td>
				<td width="40pt"><bean:message key="page.serial"/></td>
				<sunbor:column property="kmCarmngInfomation.fdNo">
					<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdNo"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngInfomation.docSubject">
					<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docSubject"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngInfomation.fdVehichesType.fdName">
					<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdVehichesType"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngInfomation.fdSeatNumber">
					<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdSeatNumber"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngInfomation.fdMotorcade.fdName">
					<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdMotorcadeId"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngInfomation.fdDriverName">
					<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdDriverName"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngInfomation.docStatus">
					<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docStatus"/>
				</sunbor:column>
				
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmCarmngInfomation" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do" />?method=view&fdId=${kmCarmngInfomation.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmCarmngInfomation.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${kmCarmngInfomation.fdNo}" />
				</td>
				<td>
					<c:out value="${kmCarmngInfomation.docSubject}" />
				</td>
				<td>
					<c:out value="${kmCarmngInfomation.fdVehichesType.fdName}" />
				</td>
				<td>
					<c:out value="${kmCarmngInfomation.fdSeatNumber}" />
				</td>
				<td>
					<c:out value="${kmCarmngInfomation.fdMotorcade.fdName}" />
				</td>				
				<td>
					<c:out value="${kmCarmngInfomation.fdDriverName}" />
				</td>
				<td>
					<sunbor:enumsShow value="${kmCarmngInfomation.docStatus}"  enumsType="kmCarmngInformation_status"/>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>