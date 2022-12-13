<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/pindagate/km_pindagate_response/kmPindagateResponse.do">
	<div id="optBarDiv">
		
		<kmss:auth requestURL="/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=deleteall">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmPindagateResponseForm, 'deleteall');">
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
				<sunbor:column property="kmPindagateResponse.fdCreateTime">
					<bean:message bundle="km-pindagate" key="kmPindagateResponse.fdCreateTime"/>
				</sunbor:column>
				<sunbor:column property="kmPindagateResponse.docCreator.fdName">
					<bean:message bundle="km-pindagate" key="kmPindagateResponse.docCreator"/>
				</sunbor:column>
				<sunbor:column property="kmPindagateResponse.fdQuetionair.docSubject">
					<bean:message bundle="km-pindagate" key="kmPindagateResponse.fdQuetionair"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmPindagateResponse" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/pindagate/km_pindagate_response/kmPindagateResponse.do" />?method=edit&fdId=${kmPindagateResponse.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmPindagateResponse.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<kmss:showDate value="${kmPindagateResponse.fdCreateTime}" />
				</td>
				<td>
					<c:out value="${kmPindagateResponse.docCreator.fdName}" />
				</td>
				<td>
					<c:out value="${kmPindagateResponse.fdQuetionair.docSubject}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>