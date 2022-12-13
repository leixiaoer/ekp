<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/supervise/fieldlayout/common/param_parser.jsp"%>
    <%
	   // String docSubject = parse.getParamValue("defaultValue");
	   // String defaultDocSubject = parse.acquireValue("docSubject",docSubject);
		parse.addStyle("width", "control_width", "95%");
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
	%>
<input type="hidden" name="docTemplateId" value="${kmSuperviseMainForm.docTemplateId}"/>
<input type="hidden" name="fdSysUnitEnable" value="${kmSuperviseMainForm.fdSysUnitEnable}"/>
<html:hidden property="fdModelId" />
<html:hidden property="fdModelName" />
<div id="_docSubject" xform_type="xtext">
<xform:xtext property="docSubject" mobile="${param.mobile eq 'true'? 'true':'false'}"  validators="maxLength(500)" required="<%=required%>" style="<%=parse.getStyle()%>" htmlElementProperties="id='docSubject'"/>
</div>	