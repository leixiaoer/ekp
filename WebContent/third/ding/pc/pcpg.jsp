<%@page import="java.net.URLEncoder"%>
<%@ page import="com.landray.kmss.third.ding.model.DingConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ page import="java.util.*,
	java.net.URLDecoder,
	com.landray.kmss.util.*,
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
DingApiService dingApiService = new DingApiServiceImpl();
String appId= request.getParameter("appId");
if(StringUtil.isNull(appId)){
	appId=DingConfig.newInstance().getDingAgentid();
}
String pg= request.getParameter("pg");
String toUrl= request.getParameter("toUrl");
String viewUrl="/third/ding/sso/pc_redirect.jsp?pg="+pg+"";
String mobilePg = "";
if(StringUtil.isNotNull(toUrl)&&"true".equals(toUrl)){
	viewUrl="/third/ding/sso/pc_redirect.jsp?url="+pg+"";
	mobilePg = SecureUtil.BASE64Decoder(pg);
}
if (StringUtil.isNotNull(DingConfig.newInstance().getDingDomain())) {
	viewUrl = DingConfig.newInstance().getDingDomain() + viewUrl;
} else {
	viewUrl = StringUtil.formatUrl(viewUrl);
}
String corpid = DingConfig.newInstance().getDingCorpid();
request.setAttribute("corpid", corpid);
String lang = request.getHeader("Accept-Language");
if (StringUtil.isNotNull(lang)&& lang.indexOf(",") > -1) {
	lang = lang.trim();
	lang = lang.substring(0, lang.indexOf(","));	
}
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

/* $(function(){
    var url = '<c:url value="/third/ding/jsapi.do?method=pcJsapiSignature&url=" />'+encodeURIComponent(window.location.href.split('#')[0]);
    $.ajax({
		   type: "POST",
		   url: url,
		   async:true,
		   dataType: "json",
		   success: function(data){
			   dingConfig(data);
		   },
		   error:function(err){
			   document.getElementById("_load").innerHTML = "load fail: "+JSON.stringify(err); 
		   }
		});
}); */

$(function(){
	 //平台、设备和操作系统
    var system = {
        win: false,
        mac: false,
        xll: false
    };
    //检测平台
    var p = navigator.platform;
    system.win = p.indexOf("Win") == 0;
    system.mac = p.indexOf("Mac") == 0;
    system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
    //跳转语句
    if (system.win || system.mac || system.xll) {//pc端 
    	
    } else {
      //window.location.href = "./outpg.jsp";//手机端页面
      mobileRedirect();
    }
    authCode();
});

//手机端页面
function mobileRedirect(){
	var toUrl = "<%= request.getContextPath()%><%=mobilePg%>";
	window.location.href = toUrl;
}

function authCode(){
	 DingTalkPC.runtime.permission.requestAuthCode({
        corpId: "${corpid}",
        onSuccess: function (info) {
            logger.i('authcode: ' + info.code);
			_scode=info.code;
			dingOpen();
			/*
            $.ajax({
                url: _ctx+'/third/ding/jsapi.do?method=userinfo&from=dingpc&code=' + info.code,
                type: 'GET',
                success: function (data, status, xhr) {
                    var info = $.parseJSON(data);
					if (info.errcode === 0) {
                        logger.i('user id: ' + info.userid);
 						dingOpen();
						//history.back();
                   }else {
                	   document.getElementById("_load").innerHTML = "user id parse fail:"+JSON.stringify(info);  
                        logger.e('auth error: ' + data);
						//history.back();
                    }
                },
                error: function (xhr, errorType, error) {
                	document.getElementById("_load").innerHTML = "user id get fail:"+JSON.stringify(error);  
                    logger.e(errorType + ', ' + error);
                }
            });
			*/
        },
        onFail: function (err) {
            logger.e('fail: ' + JSON.stringify(err));
            document.getElementById("_load").innerHTML = "ready err:"+JSON.stringify(err);  
        }

    });
}

function dingOpen(){
	document.getElementById("_load").innerHTML='<bean:message key="third.ding.pc.view" bundle="third-ding"/>';
	close();
	DingTalkPC.biz.util.openLink({
		url: "<%=viewUrl%>&formDing=1&code="+_scode+"&j_lang=<%=lang%>",
		onSuccess : function(info) {
            logger.i('biz.ding info: ' + $.parseJSON(info));
		},
		onFail : function(err) {
			document.getElementById("_load").innerHTML = $.parseJSON(err);  
            logger.e('biz.ding fail: ' + $.parseJSON(err));
		}
	})
	//timeInteval();

}

var time = 0;
function timeInteval(){
	var _timeArea = document.getElementById("_timeArea");
	if(time==3){
		close();
		return;
	}
	_timeArea.innerHTML = 3 - time;
	time ++;
	setTimeout("timeInteval()",1000);
}

function close(){
    Com_Parameter.CloseInfo = null;
    Com_CloseWindow();
}
//重写window.close方法
window.close = function(){
    dd.biz.navigation.close();
};
</script>

<div id="_load">
	<bean:message key="third.ding.pc.view.loading" bundle="third-ding"/>
</div>
<div>
    <span>
      <bean:message key="third.ding.pc.view.close.1" bundle="third-ding"/>
	</sapn>
	<span id="_timeArea" style="color:red">
    3
	</span>
	<span>
	  <bean:message key="third.ding.pc.view.close.2" bundle="third-ding"/>
	</sapn>
</div>
</body>

</html>