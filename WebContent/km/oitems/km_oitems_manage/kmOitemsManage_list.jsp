<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/oitems/km_oitems_manage/kmOitemsManage.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/oitems/km_oitems_manage/kmOitemsManage.do?method=add" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/oitems/km_oitems_manage/kmOitemsManage.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/oitems/km_oitems_manage/kmOitemsManage.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmOitemsManageForm, 'deleteall');">
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
				<td width="10pt"><input type="checkbox" name="List_Tongle"></td>
				<td width="40pt"><bean:message key="page.serial"/></td>
				<sunbor:column property="kmOitemsManage.fdOrder">
					<bean:message  bundle="km-oitems" key="kmOitemsManage.fdOrder"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsManage.fdName">
					<bean:message  bundle="km-oitems" key="kmOitemsManage.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsManage.hbmParent.fdName">
					<bean:message  bundle="km-oitems" key="kmOitemsManage.fdParentCategory"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsManage.docCreator.fdName">
					<bean:message  bundle="km-oitems" key="kmOitemsManage.fdCreatorId"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsManage.docCreateTime">
					<bean:message  bundle="km-oitems" key="kmOitemsManage.fdCreateTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmOitemsManage" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/oitems/km_oitems_manage/kmOitemsManage.do" />?method=view&fdId=${kmOitemsManage.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmOitemsManage.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${kmOitemsManage.fdOrder}" />
				</td>
				<td kmss_wordlength="30">
					<c:out value="${kmOitemsManage.fdName}" />
				</td>
				<td kmss_wordlength="30">
					<c:out value="${kmOitemsManage.fdParent.fdName}" />
				</td>
				<td>
					<c:out value="${kmOitemsManage.docCreator.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${kmOitemsManage.docCreateTime}"
					type="datetime" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>