<%@page import="com.landray.kmss.sys.appconfig.service.ISysAppConfigService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.landray.kmss.sys.appconfig.service.ISysAppConfigService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="java.util.Map"%>

<%
ISysAppConfigService sysAppConfigService = (ISysAppConfigService) SpringBeanUtil.getBean("sysAppConfigService");
Map dataMap = sysAppConfigService.findByKey(
		"com.landray.kmss.third.esa.model.EsaConfig");
boolean esaEnable = false;
if ("true".equals(dataMap.get("kmss.integrate.esa.enabled"))) {
	esaEnable = true;
	request.setAttribute("lbpmNote_Id", request.getParameter("auditNoteFdId"));
	request.setAttribute("lbpmHandler_Id", request.getParameter("curHanderId"));
	
	String ESASerSystemSq = (String)dataMap.get("kmss.esa.ESASerSystemSq");
	request.setAttribute("ESASerSystemSq", ESASerSystemSq);
}
request.setAttribute("esaEnable", esaEnable);
%>
<c:import url="/sys/lbpmservice/signature/sysAttMain_view.jsp" charEncoding="UTF-8">
		<c:param name="fdKey" value="${param.auditNoteFdId}_qz" />
		<c:param name="formBeanName" value="${param.formName}"/>
</c:import>
<c:if test="${esaEnable == true}">
<c:import url="/sys/lbpmservice/signature/sysLbpmProcess_signatureList_esa.jsp" charEncoding="UTF-8">
		<c:param name="fdKey" value="${param.auditNoteFdId}_qz" />
		<c:param name="formBeanName" value="${param.formName}"/>
</c:import>
</c:if>