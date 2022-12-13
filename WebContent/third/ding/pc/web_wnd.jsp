<%@page import="java.net.URLEncoder"%>
<%@ page import="com.landray.kmss.third.ding.model.DingConfig"%>
<%@ page import="com.landray.kmss.third.ding.util.DingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ page import="java.util.*,
	java.net.URLDecoder,
	com.landray.kmss.util.*,
	com.landray.kmss.sys.mobile.util.*,
	com.landray.kmss.third.ding.action.DingJsapiAction,
	com.landray.kmss.third.ding.constant.*,
	com.landray.kmss.third.ding.oms.*
	" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />
<title><bean:message bundle="third-ding" key="third.ding.ding.loading" /></title>
</head>
<%
String url = request.getParameter("url");
url=StringUtil.formatUrl(url);
out.println("跳转中...");
if(MobileUtil.DING_ANDRIOD == MobileUtil.getClientType(request) || MobileUtil.DING_IPHONE == MobileUtil.getClientType(request)){
	response.sendRedirect(url);
	return;
}
url=URLEncoder.encode(StringUtil.formatUrl(url));
DingApiService dingApiService = new DingApiServiceImpl();
String corpId =DingConfig.newInstance().getDingCorpid();
String appId= request.getParameter("appId");
if(StringUtil.isNull(appId)){
	appId=DingConfig.newInstance().getDingAgentid(); 
}
//第三方应用和企业自建模式的app_id参数不同
if(StringUtil.isNotNull(ResourceUtil.getKmssConfigString("kmss.ding.proxy"))){
	url="dingtalk://dingtalkclient/action/openapp?corpid="+corpId+"&container_type=work_platform&app_id="+appId+"&redirect_type=jump&redirect_url="+url;
}else{
	url="dingtalk://dingtalkclient/action/openapp?corpid="+corpId+"&container_type=work_platform&app_id=0_"+appId+"&redirect_type=jump&redirect_url="+url;
}
out.print(url);
%>
<body>
<script type="text/javascript" src="<%= request.getContextPath() %>/resource/js/jquery.js"></script>
<script type="text/javascript" src="//g.alicdn.com/dingding/dingtalk-pc-api/2.3.1/index.js"></script>
<script type="text/javascript" src="js/zepto.min.js"></script>
<script type="text/javascript" src="js/logger.js"></script>
<script type="text/javascript" src="js/apps.js"></script>
<script type="text/javascript">
var _ctx = "<%= request.getContextPath() %>";
var _appId="<%=org.apache.commons.lang.StringEscapeUtils.escapeHtml(appId)%>";
var _scode="";
function dingOpen(){
	var url = "<%=url%>";
	console.log("url:"+url);
	Com_OpenWindow(url, '_self');
    close();
}
function close(){
    dd.biz.navigation.close();
    DingTalkPC.biz.navigation.quit({
	    message: "quit message",//退出信息，传递给openModal或者openSlidePanel的onSuccess函数的result参数
	    onSuccess : function(result) {
	    },
	    onFail : function() {}
	});
};
$(function(){
	dingOpen();
});

</script>
</body>

</html>