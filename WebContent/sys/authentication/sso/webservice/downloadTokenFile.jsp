<%@page import="java.io.* "%>
<%@page import="com.landray.kmss.sys.authentication.sso.GetTokenUserName"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 
try {
	
	String tokenPath = GetTokenUserName.getTokenConfigPath();
	//System.out.println();
	tokenPath = tokenPath.replace("lib", "KmssConfig");
	File downFile = new File(tokenPath);
	byte[] temp = org.apache.commons.io.FileUtils.readFileToByteArray(downFile);
	response.reset();
	response.addHeader("Content-Disposition",
			"attachment;filename=LRToken");
	response.addHeader("Content-Length", "" + temp.length);
	response.setContentType("application/octet-stream");
	OutputStream os = response.getOutputStream();
	BufferedOutputStream bos = new BufferedOutputStream(os);
	bos.write(temp);
	bos.flush();
	bos.close();
	os.close();

	response.flushBuffer();
} catch (Exception ex) {

	out.println("应用系统SSO配置downloadManual时发生错误,"+ ex.getMessage());
}

%>