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
	
	//13.5和13一样，并且用的同一个license
	
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
		out.print("ekp未部署正确的license，无法自动检测");
	}

	if(hasLic){
		try {
	
			StringBuffer content = new StringBuffer();
			
			content.append("<table class='tb_normal' align='center' style='width: 95%'>");
			content.append("<tr><td class='td_normal_title' width='25%' align='center'>国家信息安全漏洞共享平台</td><td class='td_normal_title' width='25%' align='center'>蓝凌安全编号</td><td class='td_normal_title' width='25%' align='center'>检测结果</td><td class='td_normal_title' width='25%' align='center'>说明</td></tr>");
	
			for(String v : vs) {
				String[] s = v.split(";");
				
				String versionPath = ConfigLocationsUtil.getWebContentPath() + s[2];
				
				String version= FileUtil.getFileString(versionPath, "UTF-8");
				
				if(version.contains("#"+s[0])) {
					content.append("<tr><td class='td_normal_title' width='25%' align='center'>"+ s[1] +"</td><td class='td_normal_title' width='25%' align='center'>#"+ s[0] +"</td><td width='25%' align='center' style='color:#00cc00'>已修复</td><td width='25%' align='center'></td></tr>");
				}else{
					content.append("<tr><td class='td_normal_title' width='25%' align='center'>"+ s[1] +"</td><td class='td_normal_title' width='25%' align='center'>#"+ s[0] +"</td><td width='25%' align='center' style='color:#ff0000'>未修复</td><td width='25%' align='center'>必须修复，请联系项目经理或您的客服专员确认</td></tr>");
				}
			}
					
			content.append("<tr><td colspan='4'><div style='display:inline-block;float:left'>检测结果说明：<br>1、<font color='#00cc00'>已修复</font>，表示通过正常的补丁升级version有记录。	<br>2、<font color='#ff0000'>未修复</font>，表示根据version记录扫描发现未修复，原因：<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a）该安全补丁没有修复；<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b）有可能通过独立补丁修复，若确认通过该方法已修复过，可补充单号到version中再进行检测。 <br>3、如有疑问，请咨询项目经理或您的客服专员。</div></td><tr>");
			
			content.append("<tr><td colspan='4'><div style='display:inline-block;float:left'>国家信息安全漏洞共享平台：<a href='https://www.cnvd.org.cn/' target='_blank'>https://www.cnvd.org.cn/</a></div><div style='display:inline-block;;float:right'>检测工具v0.1 &nbsp;&nbsp; 最后更新时间:2022-01-18</div></td><tr>");
			
			content.append("</table>");
			
			out.print(content.toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
%>

