<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=add" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmCarmngUserFeeInfoForm, 'deleteall');">
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
				<sunbor:column property="kmCarmngUserFeeInfo.fdUserId">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUserId"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngUserFeeInfo.fdFee">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngUserFeeInfo.fdVehiclesId">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdVehiclesId"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngUserFeeInfo.fdMileageNumber">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdMileageNumber"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngUserFeeInfo.fdStopFee">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdStopFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngUserFeeInfo.fdTurnpikeFee">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdTurnpikeFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngUserFeeInfo.fdFuelFee">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdFuelFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngUserFeeInfo.fdOtherFee">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdOtherFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngUserFeeInfo.fdCarwashFee">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdCarwashFee"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngUserFeeInfo.fdUseStartTime">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseStartTime"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngUserFeeInfo.fdUseEndTime">
					<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseEndTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmCarmngUserFeeInfo" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do" />?method=view&fdId=${kmCarmngUserFeeInfo.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmCarmngUserFeeInfo.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdUserId}" />
				</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdVehiclesId}" />
				</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdMileageNumber}" />
				</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdStopFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdTurnpikeFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdFuelFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdOtherFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdCarwashFee}" />
				</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdUseStartTime}" />
				</td>
				<td>
					<c:out value="${kmCarmngUserFeeInfo.fdUseEndTime}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>