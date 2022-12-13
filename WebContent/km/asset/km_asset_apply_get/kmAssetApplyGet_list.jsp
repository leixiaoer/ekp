<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ include file="/km/asset/resource/assetcommon.jsp"%>
<script language="JavaScript">
		Com_IncludeFile("dialog.js");
</script>
<html:form action="/km/asset/km_asset_apply_get/kmAssetApplyGet.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_get/kmAssetApplyGet.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="addByApplyTemplate();">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_get/kmAssetApplyGet.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyGetForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyGet.docSubject">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
				</sunbor:column>
			
				<sunbor:column property="kmAssetApplyGet.fdNo">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyGet.fdCreateDate">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyGet.fdCreator.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyGet.fdDept.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyGet.fdApplyTemplate.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyTemplate"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyGet" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_get/kmAssetApplyGet.do" />?method=view&fdId=${kmAssetApplyGet.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyGet.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyGet.docSubject}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyGet.fdNo}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyGet.fdCreateDate}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyGet.fdCreator.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyGet.fdDept.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyGet.fdApplyTemplate.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>