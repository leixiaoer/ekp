<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/supervise/fieldlayout/common/param_parser.jsp"%>
<%
	parse.addStyle("width", "control_width", "95%"); 
%>
<div id="_fdApprovalTime" xform_type="datetime">
<xform:datetime property="fdApprovalTime"
				required="<%=required %>"
                showStatus="edit" 
                dateTimeType="datetime" 
                mobile="${param.mobile eq 'true'? 'true':'false'}"
                subject="${lfn:message('km-supervise:kmSuperviseMainForm.fdApprovalTime')}"
                style="<%=parse.getStyle()%>"/>
</div>	