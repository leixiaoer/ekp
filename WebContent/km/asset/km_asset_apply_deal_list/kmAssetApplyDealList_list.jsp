<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/asset/km_asset_apply_deal_list/kmAssetApplyDealList.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_deal_list/kmAssetApplyDealList.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_deal_list/kmAssetApplyDealList.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_deal_list/kmAssetApplyDealList.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyDealListForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyDealList.fdNetValue">
					<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdNetValue"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyDealList.fdRemainValue">
					<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdRemainValue"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyDealList.fdDealMoney">
					<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdDealMoney"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyDealList.fdRemark">
					<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdRemark"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyDealList.fdApplyDeal.fdId">
					<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdApplyDeal"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyDealList.fdAssetCard.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdAssetCard"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyDealList" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_deal_list/kmAssetApplyDealList.do" />?method=view&fdId=${kmAssetApplyDealList.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyDealList.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyDealList.fdNetValue}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyDealList.fdRemainValue}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyDealList.fdDealMoney}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyDealList.fdRemark}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyDealList.fdApplyDeal.fdId}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyDealList.fdAssetCard.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>