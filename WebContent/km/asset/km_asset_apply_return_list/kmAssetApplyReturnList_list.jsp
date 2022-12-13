<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/asset/km_asset_apply_return_list/kmAssetApplyReturnList.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_return_list/kmAssetApplyReturnList.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_return_list/kmAssetApplyReturnList.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_return_list/kmAssetApplyReturnList.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyReturnListForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyReturnList.fdAddress">
					<bean:message bundle="km-asset" key="kmAssetApplyReturnList.fdAddress"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyReturnList.fdDate">
					<bean:message bundle="km-asset" key="kmAssetApplyReturnList.fdDate"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyReturnList.fdApplyReturn.fdId">
					<bean:message bundle="km-asset" key="kmAssetApplyReturnList.fdApplyReturn"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyReturnList.fdAssetCard.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyReturnList.fdAssetCard"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyReturnList" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_return_list/kmAssetApplyReturnList.do" />?method=view&fdId=${kmAssetApplyReturnList.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyReturnList.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyReturnList.fdAddress}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyReturnList.fdDate}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyReturnList.fdApplyReturn.fdId}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyReturnList.fdAssetCard.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>