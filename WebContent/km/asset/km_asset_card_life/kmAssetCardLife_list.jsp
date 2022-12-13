<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/asset/km_asset_card_life/kmAssetCardLife.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_card_life/kmAssetCardLife.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_card_life/kmAssetCardLife.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_card_life/kmAssetCardLife.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetCardLifeForm, 'deleteall');">
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
				<sunbor:column property="kmAssetCardLife.fdOperType">
					<bean:message bundle="km-asset" key="kmAssetCardLife.fdOperType"/>
				</sunbor:column>
				<sunbor:column property="kmAssetCardLife.fdApplyDate">
					<bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyDate"/>
				</sunbor:column>
				<sunbor:column property="kmAssetCardLife.fdApplyModelid">
					<bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid"/>
				</sunbor:column>
				<sunbor:column property="kmAssetCardLife.fdApplyModelname">
					<bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelname"/>
				</sunbor:column>
				<sunbor:column property="kmAssetCardLife.fdApplyPerson.fdName">
					<bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyPerson"/>
				</sunbor:column>
				<sunbor:column property="kmAssetCardLife.fdAssetCardFdid.fdName">
					<bean:message bundle="km-asset" key="kmAssetCardLife.fdAssetCardFdid"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetCardLife" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_card_life/kmAssetCardLife.do" />?method=view&fdId=${kmAssetCardLife.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetCardLife.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetCardLife.fdOperType}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetCardLife.fdApplyDate}" type="date"/>
				</td>
				<td>
					<c:out value="${kmAssetCardLife.fdApplyModelid}" />
				</td>
				<td>
					<c:out value="${kmAssetCardLife.fdApplyModelname}" />
				</td>
				<td>
					<c:out value="${kmAssetCardLife.fdApplyPerson.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetCardLife.fdAssetCardFdid.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>