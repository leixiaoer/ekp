<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
		<script>Com_IncludeFile("jquery.js");</script>
		<script>Com_IncludeFile("polyfill.js","${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/wps/js/","js",true);</script>
		<script>Com_IncludeFile("web-office-sdk-1.1.1.umd.js","${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/wps/js/","js",true);</script>
		<script>Com_IncludeFile("wps_attachment.js","${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/wps/js/","js",true);</script>
		<div>
			<div id="WPSWebOffice_${sysAttMainForm.fdKey}">
			</div>
		</div>
		<script>
			var status;
			var wps 
			$(document).ready(function(){
				//loadAttWps("${fdAttMainId}","write");
				var fdAttMainId ='${sysAttMainForm.fdId}';
		  		var fdKey = '${sysAttMainForm.fdKey}';
		  		var fdModelId = '${sysAttMainForm.fdModelId}';
		  		var fdModelName = '${sysAttMainForm.fdModelName}';
				var wpsObj = new WPS_AttachmentObject(fdAttMainId,fdKey,fdModelId,fdModelName,"write");
				wpsObj.load();
				$("#office-iframe").height(window.innerHeight);
			});
		    
		</script>
	</template:replace>	
</template:include>	