<%-- 公文模板 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/supervise/fieldlayout/common/param_parser.jsp"%>
<span class="xform_fieldlayout" style="<%=parse.getStyle()%>">
<input type="hidden" name="docTemplateId" value="${kmSuperviseMainForm.docTemplateId}">
	<c:out value="${kmSuperviseMainForm.docTemplateName}"/>
</span>
