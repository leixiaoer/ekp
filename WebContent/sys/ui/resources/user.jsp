<%@ page language="java" pageEncoding="UTF-8" contentType="text/plain; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/ui.tld" prefix="ui"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.landray.kmss.util.UserUtil"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);

	String returnMsg = UserUtil.getUser(request).getFdLoginName();

	// 这里要将参数取出来，不然不会对参数作“非法值”校验处理
	Enumeration<String> names = request.getParameterNames();
	while (names.hasMoreElements()) {
		String name = names.nextElement();
		try {
			request.getParameter(name);
		} catch (Exception e) {
			returnMsg = "invalid_value" + e.getMessage();
			break;
		}
	}
%>
<ui:ajaxtext>
<%= returnMsg %>
</ui:ajaxtext>