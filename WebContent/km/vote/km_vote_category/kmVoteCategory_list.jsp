<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/vote/km_vote_category/kmVoteCategory.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/vote/km_vote_category/kmVoteCategory.do?method=add" requestMethod="GET">
			<!-- 新建 -->
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_category/kmVoteCategory.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/vote/km_vote_category/kmVoteCategory.do?method=deleteall" requestMethod="GET">
			<!-- 删除 -->
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmVoteCategoryForm, 'deleteall');">
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
				<!-- 类别名称 -->
				<sunbor:column property="kmVoteCategory.fdName">
					<bean:message  bundle="km-vote" key="kmVoteCategory.fdName"/>
				</sunbor:column>
				<!-- 是否有效 -->
				<sunbor:column property="kmVoteCategory.fdIsAvailable">
					<bean:message  bundle="km-vote" key="kmVoteCategory.fdIsAvailable"/>
				</sunbor:column>
				<!-- 创建者 -->
				<sunbor:column property="kmVoteCategory.docCreator.fdName">
					<bean:message  bundle="km-vote" key="kmVoteCategory.docCreatorName"/>
				</sunbor:column>
				<!-- 创建时间 -->
				<sunbor:column property="kmVoteCategory.docCreateTime">
					<bean:message  bundle="km-vote" key="kmVoteCategory.docCreateTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmVoteCategory" varStatus="vstatus">
			<tr kmss_href="<c:url value="/km/vote/km_vote_category/kmVoteCategory.do" />?method=view&fdId=${kmVoteCategory.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmVoteCategory.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${kmVoteCategory.fdName}" />
				</td>
				<td>
					<center><sunbor:enumsShow value="${kmVoteCategory.fdIsAvailable}" enumsType="common_yesno" /></center>
				</td>
				<td>
					<center><c:out value="${kmVoteCategory.docCreator.fdName}" /></center>
				</td>
				<td>
					<center><kmss:showDate value="${kmVoteCategory.docCreateTime}" /></center>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>