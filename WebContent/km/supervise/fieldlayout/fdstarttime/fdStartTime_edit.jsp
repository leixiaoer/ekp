<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/supervise/fieldlayout/common/param_parser.jsp"%>
<%
	parse.addStyle("width", "control_width", "95%"); 
	required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
%>
<div id="_fdStartTime" xform_type="datetime">
<c:choose>
	<c:when test="${kmSuperviseMainForm.canEditStartTime eq 'false' }">
		<xform:datetime property="fdStartTime"
				required="<%=required %>"
                showStatus="readOnly" 
                dateTimeType="datetime"
                mobile="${param.mobile eq 'true'? 'true':'false'}"
                subject="${lfn:message('km-supervise:kmSuperviseMainForm.fdStartTime')}"
                style="<%=parse.getStyle()%>"/>
	</c:when>
	<c:otherwise>
		<xform:datetime property="fdStartTime"
				required="<%=required %>"
                showStatus="edit" 
                dateTimeType="datetime"
                mobile="${param.mobile eq 'true'? 'true':'false'}"
                subject="${lfn:message('km-supervise:kmSuperviseMainForm.fdStartTime')}"
                style="<%=parse.getStyle()%>"
                 validators="validateStartTime"/>
	</c:otherwise>
</c:choose>
</div>                
