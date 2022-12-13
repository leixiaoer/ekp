<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ include file="/km/asset/resource/assetcommon.jsp"%>
<script language="JavaScript">
	Com_IncludeFile("dialog.js");
</script>
<html:form action="/km/asset/km_asset_apply_return/kmAssetApplyReturn.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/asset/km_asset_apply_return/kmAssetApplyReturn.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="addByApplyTemplate();">
		</kmss:auth>
		<kmss:auth requestURL="/km/asset/km_asset_apply_return/kmAssetApplyReturn.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmAssetApplyReturnForm, 'deleteall');">
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
				<!--标题-->
				<sunbor:column property="kmAssetApplyReturn.docSubject">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
				</sunbor:column>
				<!--编号-->
				<sunbor:column property="kmAssetApplyReturn.fdNo">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</sunbor:column>
				<!--申请人-->
				<sunbor:column property="kmAssetApplyBuy.fdCreator.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
				</sunbor:column>
				<!--申请日期-->
				<sunbor:column property="kmAssetApplyBuy.fdCreateDate">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
				</sunbor:column>
		     	<!--文档状态-->
		     	<sunbor:column property="kmAssetApplyBuy.docStatus">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.docStatus"/>
				</sunbor:column>
		        <!--当前环节-->
		        <td>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.currentLink" />
				</td>
			    <!--当前处理人-->
			    <td>
					<bean:message bundle="km-asset" key="sysWfNode.processingNode.currentProcessor" />
				</td>
			    <!--类别-->
			    <sunbor:column property="kmAssetApplyBuy.fdApplyTemplate.fdName">
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
				</sunbor:column>
				
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetApplyReturn" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/asset/km_asset_apply_return/kmAssetApplyReturn.do" />?method=view&fdId=${kmAssetApplyReturn.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmAssetApplyReturn.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				
				<td>
					<c:out value="${kmAssetApplyReturn.docSubject}" />
				</td>
					<td>
					<c:out value="${kmAssetApplyReturn.fdNo}" />
				</td>
				<td>
					<c:out value="${kmAssetApplyReturn.fdCreator.fdName}" />
				</td>
					<td>
					<kmss:showDate value="${kmAssetApplyReturn.fdCreateDate}" type="date" />
				</td>
				<td>
					<sunbor:enumsShow value="${kmAssetApplyReturn.docStatus}" enumsType="common_status"/>
				</td>
				<td>
					<kmss:showWfPropertyValues idValue="${kmAssetApplyReturn.fdId}" propertyName="nodeName" />
				</td>
				<td>
					<kmss:showWfPropertyValues idValue="${kmAssetApplyReturn.fdId}" propertyName="handlerName" />
				</td>
				<td>
					<c:out value="${kmAssetApplyReturn.fdApplyTemplate.fdName}"/>
				</td>		
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>