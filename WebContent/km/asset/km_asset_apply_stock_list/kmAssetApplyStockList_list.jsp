<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/asset/km_asset_apply_stock_list/kmAssetApplyStockList.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_stock_list/kmAssetApplyStockList.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_stock_list/kmAssetApplyStockList.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_stock_list/kmAssetApplyStockList.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyStockListForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyStockList.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdStandard">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStandard"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdMeasure">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdMeasure"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdStockAmount">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdPrice">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdPrice"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdSubTotal">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdSubTotal"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdStockDate">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockDate"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdRemark">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdRemark"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdOrder">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdOrder"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdReceiveAmount">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdReceiveAmount"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdAssetApplyStock.fdId">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdAssetApplyStock"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdProvider.fdId">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdProvider"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyStockList.fdStocker.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStocker"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyStockList" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_stock_list/kmAssetApplyStockList.do" />?method=view&fdId=${kmAssetApplyStockList.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyStockList.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdStandard}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdMeasure}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdStockAmount}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdPrice}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdSubTotal}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyStockList.fdStockDate}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdRemark}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdOrder}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdReceiveAmount}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdAssetApplyStock.fdId}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdProvider.fdId}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyStockList.fdStocker.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>