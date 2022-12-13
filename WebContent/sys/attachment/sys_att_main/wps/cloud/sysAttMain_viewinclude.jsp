<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.web.taglib.TagUtils,com.landray.kmss.sys.attachment.forms.*,java.util.*"%>
<%@ page import="com.landray.kmss.sys.attachment.service.*"%>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%
	pageContext.setAttribute("wpsPreviewIsLinux", SysAttWpsCloudUtil.checkWpsPreviewIsLinux());
	String agreementUseWpsOnline = "";
	if (pageContext.getAttribute("_pIsUseWpsOnlineView") != null) {
		agreementUseWpsOnline = (String)pageContext.getAttribute("_pIsUseWpsOnlineView");
	}
	if ("true".equals(agreementUseWpsOnline)) {
		//合同模块使用linux预览，但是编辑器不是通过附件机制控制，所以还是使用以前逻辑
		if (pageContext.getAttribute("attachmentId") != null) {
			String pAttachmentId = (String)pageContext.getAttribute("attachmentId");
			if (!SysAttWpsCloudUtil.isAttHadSyncByAttMainId(pAttachmentId)) {
				SysAttWpsCloudUtil.syncAttToAddByMainId(pAttachmentId);
			}
		}
		pageContext.setAttribute("wpsPreviewIsLinux", "false");
	}
%>
<style>
#office-iframe{
	width:100%;
	min-height:556px;
}
</style>
<script>Com_IncludeFile("jquery.js");</script>
<script>Com_IncludeFile("polyfill.js","${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/wps/js/","js",true);</script>
<script>Com_IncludeFile("web-office-sdk-1.1.1.umd.js","${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/wps/js/","js",true);</script>
<script>Com_IncludeFile("wps_cloud_attachment.js","${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/wps/cloud/js/","js",true);</script>
<div id="WPSCloudOffice_${param.fdKey}" class="wps-container">
</div>
<script>
	var wps_cloud_${param.fdKey};
	function loadWpsAtt(fdAttMainId, previewCode){
		if(fdAttMainId != ""){
			wps_cloud_${param.fdKey} = new WPSCloudOffice_AttachmentObject(fdAttMainId,"${param.fdKey}","${param.fdModelId}","${param.fdModelName}","read",false, "${wpsPreviewIsLinux}",previewCode);
			if("${param.contentFlag}" != "" && "${param.contentFlag}" == "true" && "${_docStatus}" == "30"){
				wps_cloud_${param.fdKey}.contentFlag = true;
			}
			wps_cloud_${param.fdKey}.load();
		}
	}
	// 显示审批意见、留言等
	function showWpsCloudApprove(){
		loadWpsAtt("${attachmentId}", '1110110');
	}
	// 隐藏审批意见、留言等
	function hideWpsCloudApprove(){
		loadWpsAtt("${attachmentId}");
	}
	/*
		自定义是否显示审批意见、留言等
		默认 1110110。取值由 0 和 1 组成 7 位字符串表示 svg 预览，从低位到高位（从右到左），每位取值 0 或者 1，依次代表如下：
		第 0 位：默认 1，0-最终状态，1- 原始状态；
		第 1 位：默认 1（显示），是否显示标记；
		第 2 位和第 3 位组合使用：00 是批注框显示修订者，10 是嵌入方式显示，01 及 11 为批注框方式；
		第 4 位：默认 1（显示），是否显示评论；
		第 5 位：默认 1（显示），是否显示插入和删除；
		第 6 位：默认 1（显示），是否显示格式修订。
 	*/
	function customizeWpsCloudApprove(previewCode){
		loadWpsAtt("${attachmentId}",previewCode);
	}
</script>
<%
    boolean isExpand = "true".equals(request.getParameter("isExpand"));
	if(isExpand){
%>
<script>
	$(document).ready(function(){
		loadWpsAtt("${attachmentId}");
	});
</script>
<%}else{%>
<ui:event event="show">
	loadWpsAtt("${attachmentId}");
</ui:event>
<%}%>


