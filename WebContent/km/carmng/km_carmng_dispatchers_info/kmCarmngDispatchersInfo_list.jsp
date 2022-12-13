<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript">
	function List_ConfirmDel(checkName){
		return List_CheckSelect(checkName) && confirm('<bean:message key="kmCarmngDispatchersInfo.delete.confirm" bundle="km-carmng"/>');
	}
</script>
<html:form action="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmCarmngDispatchersInfoForm, 'deleteall');">
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
				<sunbor:column property="kmCarmngDispatchersInfo.fdCarInfo.fdNo">
					<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngDispatchersInfo.fdCarInfo.fdMotorcade.fdName">
					<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdMotorcadeId"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngDispatchersInfo.fdDestination">
					<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdDestination"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngDispatchersInfo.fdTravelPath">
					<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdTravelPath"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngDispatchersInfo.fdStartTime">
					<bean:message  bundle="km-carmng" key="kmCarmng.fdUseTime"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngDispatchersInfo.fdFlag">
					<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdFlag"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmCarmngDispatchersInfo" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do" />?method=view&fdId=${kmCarmngDispatchersInfo.fdId}">				
				<td>
					<input type="checkbox" name="List_Selected" value="${kmCarmngDispatchersInfo.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${kmCarmngDispatchersInfo.fdCarInfo.fdNo}" />
				</td>
				<td>
					<c:out value="${kmCarmngDispatchersInfo.fdCarInfo.fdMotorcade.fdName}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${kmCarmngDispatchersInfo.fdDestination}" />
				</td>
				<td kmss_wordlength="30">
					<c:out value="${kmCarmngDispatchersInfo.fdTravelPath}" />
				</td>
				<td kmss_wordlength="40">
					<kmss:showDate value="${kmCarmngDispatchersInfo.fdStartTime}" />
					
				<bean:message  bundle="km-carmng" key="kmCarmng.message.title0"/>
				
					<kmss:showDate value="${kmCarmngDispatchersInfo.fdEndTime}" />
				</td>
				<td >				
					<sunbor:enumsShow value="${kmCarmngDispatchersInfo.fdFlag}"  enumsType="kmCarmngDispatchersInfo_fdFlag"/>			
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>