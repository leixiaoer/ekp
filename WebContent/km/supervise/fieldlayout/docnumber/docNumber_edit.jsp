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
<c:choose>
	<c:when test='${kmSuperviseMainForm.docNumber!=null}'>
	    <xform:text property="docNumber" showStatus="view" style="width:95%;" />
	</c:when>
	<c:otherwise>
		<bean:message bundle="km-supervise" key="kmSuperviseMain.auto.number" />
	</c:otherwise>
</c:choose>
