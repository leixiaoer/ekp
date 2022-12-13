<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/asset/km_asset_apply_buy_list/kmAssetApplyBuyList.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_buy_list/kmAssetApplyBuyList.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_buy_list/kmAssetApplyBuyList.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_buy_list/kmAssetApplyBuyList.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyBuyListForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyBuyList.fdOrder">
					<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdOrder"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuyList.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuyList.fdStandard">
					<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdStandard"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuyList.fdMeasure">
					<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdMeasure"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuyList.fdApplyAmount">
					<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdApplyAmount"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuyList.fdPrice">
					<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdPrice"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuyList.fdSubTotal">
					<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdSubTotal"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuyList.fdReceiveDate">
					<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdReceiveDate"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyBuyList" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_buy_list/kmAssetApplyBuyList.do" />?method=view&fdId=${kmAssetApplyBuyList.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyBuyList.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyBuyList.fdOrder}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyBuyList.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyBuyList.fdStandard}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyBuyList.fdMeasure}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyBuyList.fdApplyAmount}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyBuyList.fdPrice}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyBuyList.fdSubTotal}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyBuyList.fdReceiveDate}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>