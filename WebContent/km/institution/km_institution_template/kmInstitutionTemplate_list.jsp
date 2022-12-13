<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<c:import
	url="/sys/right/tmp_right_batch_change_button.jsp"
	charEncoding="UTF-8">
	<c:param
		name="modelName"
		value="com.landray.kmss.km.institution.model.KmInstitutionTemplate" />
</c:import>
<html:form action="/km/institution/km_institution_template/kmInstitutionTemplate.do">
	<div id="optBarDiv"><kmss:auth
		requestURL="/km/institution/km_institution_template/kmInstitutionTemplate.do?method=add"
		requestMethod="GET">
		<input
			type="button"
			value="<bean:message key="button.add"/>"
			onclick="Com_OpenWindow('<c:url value="/km/institution/km_institution_template/kmInstitutionTemplate.do?method=add&parentId=${JsParam.parentId}" />');">
	</kmss:auth> <kmss:auth
		requestURL="/km/institution/km_institution_template/kmInstitutionTemplate.do?method=deleteall&parentId=${param.parentId}"
		requestMethod="GET">
		<input
			type="button"
			value="<bean:message key="button.deleteall"/>"
			onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmInstitutionTemplateForm, 'deleteall');">
	</kmss:auth></div>
	<%
	if (((Page) request.getAttribute("queryPage")).getTotalrows() == 0) {
	%>
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
	<%
	} else {
	%>
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="10pt"><input
					type="checkbox"
					name="List_Tongle"></td>
				<td width="40pt"><bean:message key="page.serial" /></td>
				<sunbor:column property="kmInstitutionTemplate.fdName">
					<bean:message
						bundle="km-institution"
						key="kmInstitutionTemplate.fdName" />
				</sunbor:column>
				<sunbor:column property="kmInstitutionTemplate.docCategory.fdName">
					<bean:message
						bundle="km-institution"
						key="kmInstitutionTemplate.docCategoryName" />
				</sunbor:column>
				<sunbor:column property="kmInstitutionTemplate.fdOrder">
					<bean:message
						bundle="km-institution"
						key="kmInstitutionTemplate.fdOrder" />
				</sunbor:column>
				<sunbor:column property="kmInstitutionTemplate.docCreator.fdName">
					<bean:message
						bundle="km-institution"
						key="kmInstitutionTemplate.docCreatorName" />
				</sunbor:column>
				<sunbor:column property="kmInstitutionTemplate.docCreateTime">
					<bean:message
						bundle="km-institution"
						key="kmInstitutionTemplate.docCreateTime" />
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach
			items="${queryPage.list}"
			var="kmInstitutionTemplate"
			varStatus="vstatus">
			<tr kmss_href="<c:url value="/km/institution/km_institution_template/kmInstitutionTemplate.do" />?method=view&fdId=${kmInstitutionTemplate.fdId}">
				<td><input
					type="checkbox"
					name="List_Selected"
					value="${kmInstitutionTemplate.fdId}"></td>
				<td>${vstatus.index+1}</td>
				<td><c:out value="${kmInstitutionTemplate.fdName}" /></td>
				<td><c:out value="${kmInstitutionTemplate.docCategory.fdName}" /></td>
				<td><c:out value="${kmInstitutionTemplate.fdOrder}" /></td>
				<td><c:out value="${kmInstitutionTemplate.docCreator.fdName}" /></td>
				<td><kmss:showDate
					value="${kmInstitutionTemplate.docCreateTime}"
					type="datetime" /></td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp"%>
	<%
	}
	%>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>
