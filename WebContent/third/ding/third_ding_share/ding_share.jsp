<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="com.landray.kmss.third.ding.model.DingConfig"%>
<%@ page import="java.util.*,
	com.landray.kmss.util.*,
	com.landray.kmss.third.ding.action.DingJsapiAction,
	com.landray.kmss.third.ding.constant.*,
	com.landray.kmss.third.ding.oms.*
	" %>
	
<%
	String domainName = DingConfig.newInstance().getDingDomain();
    String dingEnable = DingConfig.newInstance().getDingEnabled();
	if (StringUtil.isNull(domainName)) {
		domainName = ResourceUtil
				.getKmssConfigString("kmss.urlPrefix");
	}
	if(domainName.trim().endsWith("/"))
		domainName = domainName.trim().substring(0, domainName.length()-1);
	 String reqUrl=request.getParameter("reqUrl");
	 reqUrl =  SecureUtil.BASE64Encoder(reqUrl);	 
	 String subject=request.getParameter("fdSubject");
%>

<%
   if(StringUtil.isNotNull(dingEnable)&& "true".equals(dingEnable)){
%>	
	<div data-dojo-type="mui/tabbar/TabBarButton"
	     data-dojo-props='label:"分享",align:"${param.align}",modelId:"${param.fdModelId}",subject:"${lfn:escapeJs(param.fdSubject)}",modelName:"${param.fdModelName }"' 
	     onclick="dingShare()">
	</div>
	<script>
	require([ 'dojo/ready', 'mui/device/adapter', 'dojo/query', "dojo/request","mui/dialog/Tip"],
			function(ready,adapter,query, request, Tip){
		
		window.dingShare = function(){
			
			dd.biz.chat.pickConversation({
			    corpId: '<%=DingConfig.newInstance().getDingCorpid()%>', //企业id
			    isConfirm:'true', //是否弹出确认窗口，默认为true
			    onSuccess : function(rs) {
			        //onSuccess将在选择结束之后调用
			        // 该cid和服务端开发文档-普通会话消息接口配合使用，而且只能使用一次，之后将失效
			        /*{
			            cid: 'xxxx',
			            title:'xxx'
			        }*/
			        
			        $.post('${LUI_ContextPath}/third/ding/ThirdDingShare.do?method=share',{
			        	'cid':rs.cid,
			        	'title':rs.title,
			        	'reqUrl':'<%=reqUrl%>',
			        	'fdSubject':'<%=subject%>',
			        	'fdContent':'${param.fdContent}',
			        	'fdContentPro':'${param.fdContentPro}',
			        	'fdModelName':'${param.fdModelName}',
			        	'fdModelId':'${param.fdModelId}'
			        },function(result){
			        	var data = $.parseJSON(result);
						if(data.error == 0){
							Tip.success({
								text : '分享成功'
							});
						}else{
							Tip.fail({
								text : '分享失败'
							});
						}
			        	
			        });
			        
			},
			    onFail : function(err) {
			    	//alert("error:"+err.errorMessage);
			    	}
			})
		}
		
	})
	
	
	
	</script>
<%   
   }
%>