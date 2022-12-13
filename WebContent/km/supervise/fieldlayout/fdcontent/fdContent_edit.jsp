<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/supervise/fieldlayout/common/param_parser.jsp"%>
    <%
		parse.addStyle("width", "control_width", "95%");
    	required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
	%>
<div id="_fdContent" xform_type="textarea">
<xform:textarea property="fdContent"  mobile="${param.mobile eq 'true'? 'true':'false'}" required="<%=required%>" style="<%=parse.getStyle()%>" />
</div>	