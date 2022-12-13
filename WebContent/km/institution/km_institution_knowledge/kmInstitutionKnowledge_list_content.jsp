
<%
if (((Page) request.getAttribute("queryPage")).getTotalrows() == 0) {
%>
<%@ include file="/resource/jsp/list_norecord.jsp"%>
<%
} else {
%>
<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
<%@page import="com.sunbor.web.tag.Page"%>
	<input type="hidden" name="fdTemplateId" />
	<input type="hidden" name="fdTemplateName" />
	<input type="hidden" name="fdAbolishTime" />
	<input type="hidden" name="docStatus" />
<table id="List_ViewTable">
	<tr>
		<sunbor:columnHead htmlTag="td">
			<td width="10pt"><input
				type="checkbox"
				name="List_Tongle"></td>
			<td width="40pt"><bean:message key="page.serial" /></td>
			<sunbor:column property="kmInstitutionKnowledge.fdNumber">
				<bean:message
					bundle="km-institution"
					key="kmInstitution.fdNumber" />
			</sunbor:column>
			<sunbor:column property="kmInstitutionKnowledge.docSubject">
				<bean:message
					bundle="km-institution"
					key="kmInstitution.docSubject" />
			</sunbor:column>
			<sunbor:column property="kmInstitutionKnowledge.docCreator">
				<bean:message
					bundle="sys-doc"
					key="sysDocBaseInfo.docCreator" />
			</sunbor:column>
			<sunbor:column property="kmInstitutionKnowledge.docDept">
				<bean:message
					bundle="sys-doc"
					key="sysDocBaseInfo.docDept" />
			</sunbor:column>
			<sunbor:column property="kmInstitutionKnowledge.docStatus">
				<bean:message
					bundle="km-institution"
					key="kmInstitution.kmInstitutionKnowledge.docStatus" />
			</sunbor:column>
			<sunbor:column property="kmInstitutionKnowledge.docPublishTime">
				<bean:message
					bundle="km-institution"
					key="kmInstitution.docPublishTime" />
			</sunbor:column>
		</sunbor:columnHead>
	</tr>

	<c:forEach
		items="${queryPage.list}"
		var="kmInstitutionKnowledge"
		varStatus="vstatus">
		<tr kmss_href="<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do" />?method=view&fdId=${kmInstitutionKnowledge.fdId}"
			kmss_target="_blank">
			<td><input
				type="checkbox"
				name="List_Selected"
				value="${kmInstitutionKnowledge.fdId}"></td>
			<td>${vstatus.index+1}</td>
			<td><c:out value="${kmInstitutionKnowledge.fdNumber}" /></td>
			<td style="text-align: left;"><c:out value="${kmInstitutionKnowledge.docSubject}" /></td>
			<td><c:out value="${kmInstitutionKnowledge.docCreator.fdName}" /></td>
			<td><c:out value="${kmInstitutionKnowledge.docDept.fdName}" /></td>
			<td><sunbor:enumsShow
				value="${kmInstitutionKnowledge.docStatus}"
				enumsType="kmInstitutionKnowledge_docStaus"/></td>
			<td><kmss:showDate
				value="${kmInstitutionKnowledge.docPublishTime}"
				type="date" /></td>
		</tr>
	</c:forEach>
</table>
<%@ include file="/resource/jsp/list_pagenav_down.jsp"%>
<%
}
%>
