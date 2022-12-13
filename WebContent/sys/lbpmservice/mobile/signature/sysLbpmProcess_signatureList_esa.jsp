<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.landray.kmss.sys.appconfig.service.ISysAppConfigService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="java.util.Map"%>
<%
	request.setAttribute("lbpmNote_Id", request.getParameter("auditNoteFdId"));
	request.setAttribute("lbpmHandler_Id", request.getParameter("curHanderId"));
	
	ISysAppConfigService sysAppConfigService = (ISysAppConfigService) SpringBeanUtil.getBean("sysAppConfigService");
	Map dataMap = sysAppConfigService.findByKey(
			"com.landray.kmss.third.esa.model.EsaConfig");
String signWidth = "80";
String width = (String)dataMap.get("kmss.esa.sign.width");
if(width!=null && !"".equals(width)){
	signWidth = width;
}
request.setAttribute("signWidth", signWidth);

String signHeight = "30";
String height = (String)dataMap.get("kmss.esa.sign.height");
if(height!=null && !"".equals(height)){
	signHeight = height;
}
request.setAttribute("signHeight", signHeight);
%>
<%
	if(request.getHeader("user-agent").indexOf("Windows")>=0){
%>
<OBJECT style="Z-INDEX: 1; POSITION: relative; WIDTH: 120px; HEIGHT: 80px" id="privateSignLoad_${lbpmNote_Id}" classid=clsid:07121F49-A0DC-4EBD-A2A2-A0A71DC6FDB9></OBJECT>
<script type="text/javascript">

$(document).ready(function () {
	function load_signature(data){
		//加载个人签章信息
		if(data.privategndata){
			var privateSignLoad = document.getElementById("privateSignLoad_${lbpmNote_Id}");
			try{
				privateSignLoad.ESASetDataisEncrypt(1);      //设置载入的数据是否加密的
				if(data.fdIsOriginal && data.fdIsOriginal=="1"){
					//传入加密数据，对应移动端的info，不传入会显示印章被篡改验证不通过。注传入数据是经过base64过的数据
					privateSignLoad.ESASetSignData(1,data.fdModelId);
				}
				privateSignLoad.ESALoadSignData(data.privategndata);//加载个人签章信息数据
			}catch(e){
				
			}
		}
		//加载公章信息
		/* if(data.publicgndata){
			var publicSignLoad = document.getElementById("publicSignLoad_${lbpmNote_Id}");
			publicSignLoad.ESASetDataisEncrypt(1);      //设置载入的数据是否加密的
			publicSignLoad.ESALoadSignData(data.publicgndata);//加载公章信息数据
		} */
	}
	var autoSignPicUrl = "${KMSS_Parameter_ContextPath}third/esa/third_esa_signature_lbpm_info/esaSignatureLbpmInfo.do?method=getSignature";
	var fdModelId = "${JsParam.modelId}";
	var fdPersonId = "${lbpmHandler_Id}";
	var lbpmNote_Id = "${param.auditNoteFdId}";
	var signWidth_value = "<%=signWidth%>";
	var signHeight_value = "<%=signHeight%>";
	
	$.ajax({
	     type:"post",
	     url:autoSignPicUrl,
	     data:{"fdModelId":fdModelId,"fdPersonId":fdPersonId,"lbpmNote_Id":lbpmNote_Id},
	     async:true,
	     success:function(data){
	    	 if(data!=null){
	    		 load_signature(data);
	    		 var privateSignLoadn = document.getElementById("privateSignLoad_${lbpmNote_Id}");
    			 privateSignLoadn.style.height=signHeight_value+"px";
    			 privateSignLoadn.style.width=signWidth_value+"px";
	    	 }
		}
	   });
});
</script>
<% 
	}
%>
