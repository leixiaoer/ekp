<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/supervise/fieldlayout/common/param_parser.jsp"%>
<%
	parse.addStyle("width", "control_width", "45%");
%>
<div id="_fdUrgency" valField="fdUrgencyId" xform_type="select">
<xform:select 
	property="fdUrgencyId" 
	showStatus="edit"
	required="<%=required%>" 
	mobile="${param.mobile eq 'true'? 'true':'false'}"
	style="<%=parse.getStyle()%>">
    <xform:beanDataSource serviceBean="kmSuperviseUrgencyService" selectBlock="fdId,fdName" whereBlock="fdIsAvailable=true" orderBy="fdOrder" />
</xform:select>
</div>
