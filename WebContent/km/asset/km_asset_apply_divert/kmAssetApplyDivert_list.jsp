<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ include file="/km/asset/resource/assetcommon.jsp"%>
<script language="JavaScript">
		Com_IncludeFile("dialog.js");
</script>
<html:form action="/km/asset/km_asset_apply_divert/kmAssetApplyDivert.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_divert/kmAssetApplyDivert.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="addByApplyTemplate();">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_divert/kmAssetApplyDivert.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyDivertForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyDivert.docSubject">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyDivert.fdNo">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyDivert.fdCreateDate">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyDivert.fdCreator.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyDivert.fdDept.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyDivert.fdApplyTemplate.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyTemplate"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyDivert" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_divert/kmAssetApplyDivert.do" />?method=view&fdId=${kmAssetApplyDivert.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyDivert.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyDivert.docSubject}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyDivert.fdNo}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyDivert.fdCreateDate}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyDivert.fdCreator.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyDivert.fdDept.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyDivert.fdApplyTemplate.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>