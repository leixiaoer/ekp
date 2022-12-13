<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%
	String[] param = new String[]{"url"};
	for(String p : param){
		String v = request.getParameter(p);
		if(StringUtil.isNotNull(v)){
			v = v.trim();
			if(v.startsWith("//") || v.indexOf("\"")>-1 || !v.startsWith("/")){
				throw new RuntimeException("参数"+p+"包含非法字符");
			}
		}
	}
%>
<%@ include file="/resource/jsp/common.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="Pragma" content="No-Cache">
		<meta http-equiv="x-ua-compatible" content="IE=6"/>
	</head>
	<frameset frameborder=0 border=0>
  		<frame src="${HtmlParam.url}">
	</frameset>
</html>