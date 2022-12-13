<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ include file="/km/asset/resource/assetcommon.jsp"%>
<script language="JavaScript">
		Com_IncludeFile("dialog.js");
</script>
<html:form action="/km/asset/km_asset_apply_repair/kmAssetApplyRepair.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_repair/kmAssetApplyRepair.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="addByApplyTemplate();">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_repair/kmAssetApplyRepair.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyRepairForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyRepair.docSubject">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
				</sunbor:column>
			
				<sunbor:column property="kmAssetApplyRepair.fdNo">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyRepair.fdCreateDate">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyRepair.fdCreator.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyRepair.fdDept.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyRepair.fdApplyTemplate.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyTemplate"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyRepair" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_repair/kmAssetApplyRepair.do" />?method=view&fdId=${kmAssetApplyRepair.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyRepair.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyRepair.docSubject}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyRepair.fdNo}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyRepair.fdCreateDate}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyRepair.fdCreator.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyRepair.fdDept.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyRepair.fdApplyTemplate.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>