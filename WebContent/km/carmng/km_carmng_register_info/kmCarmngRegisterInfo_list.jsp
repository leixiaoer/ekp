<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmCarmngRegisterInfoForm, 'deleteall');">
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
				<sunbor:column property="kmCarmngRegisterInfo.fdDispatchersId">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdDispatchersId"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdEndTime">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdEndTime"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdMileageBeforeNumber">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdMileageBeforeNumber"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdMileageAfterNumber">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdMileageAfterNumber"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdRealPath">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRealPath"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdStopFee">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStopFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdTurnpikeFee">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdTurnpikeFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdFuelFee">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdFuelFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdOtherFee">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdOtherFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdCarwashFee">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdCarwashFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdRemark">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRemark"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdRegisterId">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRegisterId"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngRegisterInfo.fdRegisterTime">
					<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRegisterTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmCarmngRegisterInfo" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do" />?method=view&fdId=${kmCarmngRegisterInfo.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmCarmngRegisterInfo.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdDispatchersId}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdEndTime}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdMileageBeforeNumber}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdMileageAfterNumber}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdRealPath}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdStopFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdTurnpikeFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdFuelFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdOtherFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdCarwashFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdRemark}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdRegisterId}" />
				</td>
				<td>
					<c:out value="${kmCarmngRegisterInfo.fdRegisterTime}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>