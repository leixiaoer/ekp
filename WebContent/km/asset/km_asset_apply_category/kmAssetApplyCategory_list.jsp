<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/asset/km_asset_apply_category/kmAssetApplyCategory.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_category/kmAssetApplyCategory.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_category/kmAssetApplyCategory.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_category/kmAssetApplyCategory.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyCategoryForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyCategory.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyCategory.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyCategory.fdOrder">
					<bean:message bundle="km-asset" key="kmAssetApplyCategory.fdOrder"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyCategory.fdHierarchyId">
					<bean:message bundle="km-asset" key="kmAssetApplyCategory.fdHierarchyId"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyCategory.docCreateTime">
					<bean:message bundle="km-asset" key="kmAssetApplyCategory.docCreateTime"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyCategory.docAlterTime">
					<bean:message bundle="km-asset" key="kmAssetApplyCategory.docAlterTime"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyCategory.docStatus">
					<bean:message bundle="km-asset" key="kmAssetApplyCategory.docStatus"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyCategory.docPublishTime">
					<bean:message bundle="km-asset" key="kmAssetApplyCategory.docPublishTime"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyCategory.docCreator.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyCategory.docCreator"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyCategory.docAlteror.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyCategory.docAlteror"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyCategory.fdParent.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyCategory.fdParent"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyCategory" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_category/kmAssetApplyCategory.do" />?method=view&fdId=${kmAssetApplyCategory.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyCategory.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyCategory.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyCategory.fdOrder}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyCategory.fdHierarchyId}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyCategory.docCreateTime}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyCategory.docAlterTime}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyCategory.docStatus}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyCategory.docPublishTime}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyCategory.docCreator.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyCategory.docAlteror.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyCategory.fdParent.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>