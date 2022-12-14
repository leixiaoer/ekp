<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.FileUtil,com.landray.kmss.sys.config.loader.ConfigLocationsUtil,java.io.File"%>

<% 

	File lic16 = new File(ConfigLocationsUtil.getWebContentPath() + "/WEB-INF/KmssConfig/LandrayV16.license");
	
	File lic15 = new File(ConfigLocationsUtil.getWebContentPath() + "/WEB-INF/KmssConfig/LandrayV15.license");
	
	File lic14 = new File(ConfigLocationsUtil.getWebContentPath() + "/WEB-INF/KmssConfig/LandrayV14.license");
	
	File lic13 = new File(ConfigLocationsUtil.getWebContentPath() + "/WEB-INF/KmssConfig/LandrayV13.license");
	
	String[] v16 = new String[] {
			"120826;CNVD-2021-43475;/WEB-INF/KmssConfig/version/version.xml",
			"123482;CNVD-2021-01363;/WEB-INF/KmssConfig/version/version.xml",
			"136843;CNVD-2021-43475;/WEB-INF/KmssConfig/sys/organization/version/version.xml",
			"143107;;/WEB-INF/KmssConfig/sys/ui/version/version.xml",
			"120450;;/WEB-INF/KmssConfig/sys/attachment/version/version.xml",
			"125830;;/WEB-INF/KmssConfig/version/version.xml"};
	
	String[] v15 = new String[] {
			"142413;CNVD-2021-43475;/WEB-INF/KmssConfig/version/version.xml",
			"137543;;/WEB-INF/KmssConfig/version/version.xml",
			"123482;CNVD-2021-01363;/WEB-INF/KmssConfig/version/version.xml",
			"136843;CNVD-2021-43475;/WEB-INF/KmssConfig/sys/organization/version/version.xml",
			"143107;;/WEB-INF/KmssConfig/sys/ui/version/version.xml",
			"138133;;/WEB-INF/KmssConfig/sys/profile/version/version.xml",
			"139458;;/WEB-INF/KmssConfig/version/version.xml",
			"120450;;/WEB-INF/KmssConfig/sys/attachment/version/version.xml",
			"125830;;/WEB-INF/KmssConfig/version/version.xml"};
	
	String[] v14 = new String[] {
			"142413;CNVD-2021-43475;/WEB-INF/KmssConfig/version/version.xml",
			"137543;;/WEB-INF/KmssConfig/version/version.xml",
			"137663;CNVD-2021-01363;/WEB-INF/KmssConfig/version/version.xml",
			"136843;CNVD-2021-43475;/WEB-INF/KmssConfig/sys/organization/version/version.xml",
			"143107;;/WEB-INF/KmssConfig/sys/ui/version/version.xml",
			"138133;;/WEB-INF/KmssConfig/sys/profile/version/version.xml",
			"139458;;/WEB-INF/KmssConfig/version/version.xml",
			"120450;;/WEB-INF/KmssConfig/sys/attachment/version/version.xml",
			"143829;;/WEB-INF/KmssConfig/version/version.xml"};
	
	//13.5???13??????????????????????????????license
	
/* 	String[] v13_5 = new String[] {
			"142413;CNVD-2021-43475;/WEB-INF/KmssConfig/version/version.xml",
			"137663;CNVD-2021-01363;/WEB-INF/KmssConfig/version/version.xml",
			"136843;CNVD-2021-43475;/WEB-INF/KmssConfig/sys/organization/version/version.xml",
			"143107;;/WEB-INF/KmssConfig/sys/ui/version/version.xml",
			"139458;;/WEB-INF/KmssConfig/version/version.xml",
			"120450;;/WEB-INF/KmssConfig/sys/attachment/version/version.xml",
			"143829;;/WEB-INF/KmssConfig/version/version.xml"}; */
	
	String[] v13 = new String[] {
			"142413;CNVD-2021-43475;/WEB-INF/KmssConfig/version/version.xml",
			"137663;CNVD-2021-01363;/WEB-INF/KmssConfig/version/version.xml",
			"136843;CNVD-2021-43475;/WEB-INF/KmssConfig/sys/organization/version/version.xml",
			"143107;;/WEB-INF/KmssConfig/sys/ui/version/version.xml",
			"139458;;/WEB-INF/KmssConfig/version/version.xml",
			"120450;;/WEB-INF/KmssConfig/sys/attachment/version/version.xml",
			"143829;;/WEB-INF/KmssConfig/version/version.xml"};

	String[] vs = new String[0];
	
	boolean hasLic = true;
	
	if(lic16.exists())
		vs = v16;
	else if(lic15.exists())
		vs = v15;
	else if(lic14.exists())
		vs = v14;
	else if(lic13.exists())
		vs = v13;
	else{
		hasLic = false;
		out.print("ekp??????????????????license?????????????????????");
	}

	if(hasLic){
		try {
	
			StringBuffer content = new StringBuffer();
			
			content.append("<table class='tb_normal' align='center' style='width: 95%'>");
			content.append("<tr><td class='td_normal_title' width='25%' align='center'>????????????????????????????????????</td><td class='td_normal_title' width='25%' align='center'>??????????????????</td><td class='td_normal_title' width='25%' align='center'>????????????</td><td class='td_normal_title' width='25%' align='center'>??????</td></tr>");
	
			for(String v : vs) {
				String[] s = v.split(";");
				
				String versionPath = ConfigLocationsUtil.getWebContentPath() + s[2];
				
				String version= FileUtil.getFileString(versionPath, "UTF-8");
				
				if(version.contains("#"+s[0])) {
					content.append("<tr><td class='td_normal_title' width='25%' align='center'>"+ s[1] +"</td><td class='td_normal_title' width='25%' align='center'>#"+ s[0] +"</td><td width='25%' align='center' style='color:#00cc00'>?????????</td><td width='25%' align='center'></td></tr>");
				}else{
					content.append("<tr><td class='td_normal_title' width='25%' align='center'>"+ s[1] +"</td><td class='td_normal_title' width='25%' align='center'>#"+ s[0] +"</td><td width='25%' align='center' style='color:#ff0000'>?????????</td><td width='25%' align='center'>???????????????????????????????????????????????????????????????</td></tr>");
				}
			}
					
			content.append("<tr><td colspan='4'><div style='display:inline-block;float:left'>?????????????????????<br>1???<font color='#00cc00'>?????????</font>????????????????????????????????????version????????????	<br>2???<font color='#ff0000'>?????????</font>???????????????version???????????????????????????????????????<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a?????????????????????????????????<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b????????????????????????????????????????????????????????????????????????????????????????????????version????????????????????? <br>3???????????????????????????????????????????????????????????????</div></td><tr>");
			
			content.append("<tr><td colspan='4'><div style='display:inline-block;float:left'>???????????????????????????????????????<a href='https://www.cnvd.org.cn/' target='_blank'>https://www.cnvd.org.cn/</a></div><div style='display:inline-block;;float:right'>????????????v0.1 &nbsp;&nbsp; ??????????????????:2022-01-18</div></td><tr>");
			
			content.append("</table>");
			
			out.print(content.toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
%>

