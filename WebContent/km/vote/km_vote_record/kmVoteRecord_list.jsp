<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/vote/km_vote_record/kmVoteRecord.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/vote/km_vote_record/kmVoteRecord.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_record/kmVoteRecord.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/km/vote/km_vote_record/kmVoteRecord.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmVoteRecordForm, 'deleteall');">
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
				<sunbor:column property="kmVoteRecord.docCreateTime">
					<bean:message bundle="km-vote" key="kmVoteRecord.docCreateTime"/>
				</sunbor:column>
				<sunbor:column property="kmVoteRecord.fdMainItemIds">
					<bean:message bundle="km-vote" key="kmVoteRecord.fdMainItemIds"/>
				</sunbor:column>
				<sunbor:column property="kmVoteRecord.docCreator.fdName">
					<bean:message bundle="km-vote" key="kmVoteRecord.docCreator"/>
				</sunbor:column>
				<sunbor:column property="kmVoteRecord.kmVoteMain.docSubject">
					<bean:message bundle="km-vote" key="kmVoteRecord.kmVoteMain"/>
				</sunbor:column>
				<sunbor:column property="kmVoteRecord.kmVoteComment.fdId">
					<bean:message bundle="km-vote" key="kmVoteRecord.kmVoteComment"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmVoteRecord" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/vote/km_vote_record/kmVoteRecord.do" />?method=view&fdId=${kmVoteRecord.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmVoteRecord.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<kmss:showDate value="${kmVoteRecord.docCreateTime}" />
				</td>
				<td>
					<c:out value="${kmVoteRecord.fdMainItemIds}" />
				</td>
				<td>
					<c:out value="${kmVoteRecord.docCreator.fdName}" />
				</td>
				<td>
					<c:out value="${kmVoteRecord.kmVoteMain.docSubject}" />
				</td>
				<td>
					<c:out value="${kmVoteRecord.kmVoteComment.fdId}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>