<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/asset/km_asset_apply_repair_list/kmAssetApplyRepairList.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_repair_list/kmAssetApplyRepairList.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_repair_list/kmAssetApplyRepairList.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_repair_list/kmAssetApplyRepairList.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyRepairListForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyRepairList.fdRepairType">
					<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdRepairType"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyRepairList.fdMoney">
					<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdMoney"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyRepairList.fdDegree">
					<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdDegree"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyRepairList.fdForeignRepairAdd">
					<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdForeignRepairAdd"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyRepairList.fdApplyRepair.fdId">
					<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdApplyRepair"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyRepairList.fdAssetCard.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyRepairList" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_repair_list/kmAssetApplyRepairList.do" />?method=view&fdId=${kmAssetApplyRepairList.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyRepairList.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyRepairList.fdRepairType}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyRepairList.fdMoney}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyRepairList.fdDegree}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyRepairList.fdForeignRepairAdd}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyRepairList.fdApplyRepair.fdId}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyRepairList.fdAssetCard.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>