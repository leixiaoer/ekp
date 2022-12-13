<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do?method=add" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.geesunOitemsManageForm, 'deleteall');">
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
				<sunbor:column property="geesunOitemsManage.fdOrder">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsManage.fdOrder"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsManage.fdName">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsManage.fdName"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsManage.hbmParent.fdName">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsManage.fdParentCategory"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsManage.docCreator.fdName">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsManage.fdCreatorId"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsManage.docCreateTime">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsManage.fdCreateTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOitemsManage" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do" />?method=view&fdId=${geesunOitemsManage.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${geesunOitemsManage.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${geesunOitemsManage.fdOrder}" />
				</td>
				<td kmss_wordlength="30">
					<c:out value="${geesunOitemsManage.fdName}" />
				</td>
				<td kmss_wordlength="30">
					<c:out value="${geesunOitemsManage.fdParent.fdName}" />
				</td>
				<td>
					<c:out value="${geesunOitemsManage.docCreator.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${geesunOitemsManage.docCreateTime}"
					type="datetime" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>
