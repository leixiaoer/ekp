<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do">
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				
				<td width="40pt"><bean:message key="page.serial"/></td>
				<sunbor:column property="kmCarmngDispatchersInfo.fdApplicationNames">
					<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdApplicationIds"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngDispatchersInfo.fdCarInfoNames">
					<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngDispatchersInfo.fdStartTime">
					<bean:message  bundle="km-carmng" key="kmCarmngDispatchersLog.fdDispatchersTime"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngDispatchersInfo.fdFlag">
					<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docStatus"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmCarmngDispatchersInfo" varStatus="vstatus">
			<tr kmss_href="<c:url value="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do" />?method=view&fdId=${kmCarmngDispatchersInfo.fdId}" >				
				
				<td>${vstatus.index+1}</td>
				<td> <c:out value="${kmCarmngDispatchersInfo.fdApplicationNames}"></c:out></td>
				<td> <c:out value="${kmCarmngDispatchersInfo.fdCarInfoNames}"></c:out></td>
				<td> <kmss:showDate value="${kmCarmngDispatchersInfo.fdStartTime}" /> <bean:message  bundle="km-carmng" key="kmCarmng.message.title0"/> <kmss:showDate value="${kmCarmngDispatchersInfo.fdEndTime}" /></td>
				<td>				
					<sunbor:enumsShow value="${kmCarmngDispatchersInfo.fdFlag}"  enumsType="kmCarmngDispatchersInfo_fdFlag"/>			
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>