<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/asset/km_asset_apply_change_list/kmAssetApplyChangeList.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_change_list/kmAssetApplyChangeList.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_change_list/kmAssetApplyChangeList.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_change_list/kmAssetApplyChangeList.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyChangeListForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyChangeList.fdApplyChange.fdId">
					<bean:message bundle="km-asset" key="kmAssetApplyChangeList.fdApplyChange"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyChangeList.fdNewAddress.fdId">
					<bean:message bundle="km-asset" key="kmAssetApplyChangeList.fdNewAddress"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyChangeList.fdNewDept.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyChangeList.fdNewDept"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyChangeList.fdAssetCard.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyChangeList.fdAssetCard"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyChangeList.fdResponsiblePerson.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyChangeList.fdResponsiblePerson"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyChangeList" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_change_list/kmAssetApplyChangeList.do" />?method=view&fdId=${kmAssetApplyChangeList.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyChangeList.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyChangeList.fdApplyChange.fdId}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyChangeList.fdNewAddress.fdId}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyChangeList.fdNewDept.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyChangeList.fdAssetCard.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyChangeList.fdResponsiblePerson.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>