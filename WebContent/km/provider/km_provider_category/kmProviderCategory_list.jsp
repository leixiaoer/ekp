<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/provider/km_provider_category/kmProviderCategory.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/provider/km_provider_category/kmProviderCategory.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/provider/km_provider_category/kmProviderCategory.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/provider/km_provider_category/kmProviderCategory.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmProviderCategoryForm, 'deleteall');">
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
				<sunbor:column property="kmProviderCategory.fdName">
					<bean:message bundle="km-provider" key="kmProviderCategory.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.fdOrder">
					<bean:message bundle="km-provider" key="kmProviderCategory.fdOrder"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.fdHierarchyId">
					<bean:message bundle="km-provider" key="kmProviderCategory.fdHierarchyId"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.docCreateTime">
					<bean:message bundle="km-provider" key="kmProviderCategory.docCreateTime"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.docAlterTime">
					<bean:message bundle="km-provider" key="kmProviderCategory.docAlterTime"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.docStatus">
					<bean:message bundle="km-provider" key="kmProviderCategory.docStatus"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.authReaderFlag">
					<bean:message bundle="km-provider" key="kmProviderCategory.authReaderFlag"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.authAttNocopy">
					<bean:message bundle="km-provider" key="kmProviderCategory.authAttNocopy"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.authAttNodownload">
					<bean:message bundle="km-provider" key="kmProviderCategory.authAttNodownload"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.authAttNoprint">
					<bean:message bundle="km-provider" key="kmProviderCategory.authAttNoprint"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.fdParent.fdName">
					<bean:message bundle="km-provider" key="kmProviderCategory.fdParent"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.docCreator.fdName">
					<bean:message bundle="km-provider" key="kmProviderCategory.docCreator"/>
				</sunbor:column>
				<sunbor:column property="kmProviderCategory.docAlteror.fdName">
					<bean:message bundle="km-provider" key="kmProviderCategory.docAlteror"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmProviderCategory" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/provider/km_provider_category/kmProviderCategory.do" />?method=view&fdId=${kmProviderCategory.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmProviderCategory.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmProviderCategory.fdName}" />
				</td>
				<td>
					<c:out value="${kmProviderCategory.fdOrder}" />
				</td>
				<td>
					<c:out value="${kmProviderCategory.fdHierarchyId}" />
				</td>
				<td>
					<kmss:showDate value="${kmProviderCategory.docCreateTime}" />
				</td>
				<td>
					<kmss:showDate value="${kmProviderCategory.docAlterTime}" />
				</td>
				<td>
					<c:out value="${kmProviderCategory.docStatus}" />
				</td>
				<td>
					<xform:radio value="${kmProviderCategory.authReaderFlag}" property="authReaderFlag" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<xform:radio value="${kmProviderCategory.authAttNocopy}" property="authAttNocopy" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<xform:radio value="${kmProviderCategory.authAttNodownload}" property="authAttNodownload" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<xform:radio value="${kmProviderCategory.authAttNoprint}" property="authAttNoprint" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<c:out value="${kmProviderCategory.fdParent.fdName}" />
				</td>
				<td>
					<c:out value="${kmProviderCategory.docCreator.fdName}" />
				</td>
				<td>
					<c:out value="${kmProviderCategory.docAlteror.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>