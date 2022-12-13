<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ include file="/km/asset/resource/assetcommon.jsp"%>
<script>
	Com_IncludeFile("dialog.js|calendar.js");
	Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
</script>
<html:form action="/km/asset/km_asset_apply_in/kmAssetApplyIn.do">
	<div id="optBarDiv">
		<!-- 存在分类ID -->
		<c:if test="${not empty param.fdTemplateId}">
				<kmss:auth
					requestURL="/km/asset/km_asset_apply_in/kmAssetApplyIn.do?method=add&fdTemplateId=${param.fdTemplateId}"
					requestMethod="GET">
					<input type="button" value="<bean:message key="button.add"/>"
						onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_in/kmAssetApplyIn.do" />?method=add&fdTemplateId=${JsParam.fdTemplateId}');">
				</kmss:auth>
		</c:if>
		
		<!-- 不存在分类ID，弹出选择框 -->
		<c:if test="${empty param.fdTemplateId}">
			<kmss:auth requestURL="/km/asset/km_asset_apply_in/kmAssetApplyIn.do?method=add">
				<input type="button" value="<bean:message key="button.add"/>"
						onclick="Dialog_Template('com.landray.kmss.km.asset.model.KmAssetApplyTemplate',
						'<c:url value="/km/asset/km_asset_apply_in/kmAssetApplyIn.do" />?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}');">
			</kmss:auth>
		</c:if>
		
		<kmss:auth requestURL="/km/asset/km_asset_apply_in/kmAssetApplyIn.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyInForm, 'deleteall');">
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
				<sunbor:column property="kmAssetApplyBuy.docSubject">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuy.fdNo">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuy.fdCreator.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuy.fdCreateDate">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
				</sunbor:column>
				<sunbor:column property="kmAssetApplyBuy.docStatus">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.docStatus"/>
				</sunbor:column>
				<td>
					<bean:message bundle="km-asset" key="sysWfNode.processingNode.currentProcess" />
				</td>
				<td>
					<bean:message bundle="km-asset" key="sysWfNode.processingNode.currentProcessor" />
				</td>
				<sunbor:column property="kmAssetApplyBuy.fdApplyTemplate.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyTemplate"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyIn" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_in/kmAssetApplyIn.do" />?method=view&fdId=${kmAssetApplyIn.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyIn.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetApplyIn.docSubject}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyIn.fdNo}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyIn.fdCreator.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${kmAssetApplyIn.fdCreateDate}" type="date" />
				</td>
				<td>
					<sunbor:enumsShow value="${kmAssetApplyIn.docStatus}" enumsType="common_status"/>
				</td>
				<td>
					<kmss:showWfPropertyValues idValue="${kmAssetApplyIn.fdId}" propertyName="nodeName" />
				</td>
				<td>
					<kmss:showWfPropertyValues idValue="${kmAssetApplyIn.fdId}" propertyName="handlerName" />
				</td>
				<td>
					<c:out value="${kmAssetApplyIn.fdApplyTemplate.fdName}" />
				</td>
	
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>