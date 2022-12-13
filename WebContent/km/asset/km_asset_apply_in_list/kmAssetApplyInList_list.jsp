<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/asset/km_asset_apply_in_list/kmAssetApplyInList.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_in_list/kmAssetApplyInList.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_in_list/kmAssetApplyInList.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_in_list/kmAssetApplyInList.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyInListForm, 'deleteall');">
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
				<td width="10pt">
					<input type="checkbox" name="List_Tongle">
				</td>
				<td width="40pt">
					<bean:message key="page.serial"/>
				</td>
				<sunbor:column property="kmAssetApplyInList.fdOrder">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdOrder"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdStockNo">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdStockNo"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdStockAmount">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdStockAmount"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdStockDate">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdStockDate"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdNo">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdNo"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdCode">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdCode"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdDeptCode">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdDeptCode"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdInNum">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdInNum"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdAssetApplyIn.fdId">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdAssetApplyIn"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdStockList.fdId">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdStockList"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyInList.fdAssetCategory.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdAssetCategory"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyInList" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_in_list/kmAssetApplyInList.do" />?method=view&fdId=${kmAssetApplyInList.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyInList.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdOrder}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdStockNo}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdStockAmount}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyInList.fdStockDate}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdNo}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdCode}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdDeptCode}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdInNum}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdAssetApplyIn.fdId}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdStockList.fdId}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyInList.fdAssetCategory.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>