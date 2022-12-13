<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ page import="com.landray.kmss.sys.profile.model.PasswordSecurityConfig"%>
<%@ page import="com.landray.kmss.sys.profile.util.ThirdLoginPluginUtil"%>
<%@ page import="com.landray.kmss.framework.plugin.core.config.IExtension"%>
<%@ page import="com.landray.kmss.framework.service.plugin.Plugin"%>
<%@ page import="com.landray.kmss.sys.profile.interfaces.IThirdLogin"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%
	IExtension[] extensions = ThirdLoginPluginUtil.getExtensions();
	List<Map<String,String>> collection = new ArrayList<Map<String,String>>();
	PasswordSecurityConfig passwordSecurityConfig = PasswordSecurityConfig.newInstance();
	String thirdLoginType = passwordSecurityConfig.getThirdLoginType();
	for(IExtension extension : extensions){
		IThirdLogin bean = (IThirdLogin)Plugin.getParamValue(extension, "bean");
		String[] key = bean.key().split("\\|");
		//兼容多企业微信
		for(int i=0; i<key.length; i++){
			if((bean.loginEnable() && thirdLoginType.indexOf(key[i]) > -1 && bean.isDefault() == false) ||
					(bean.cfgEnable() && thirdLoginType.indexOf(key[i]) > -1 && bean.isDefault())){
				Map<String,String> map = new HashMap<String,String>();
				map.put("name", bean.name(key[i]));
				map.put("iconKey", key[i]);
				map.put("iconUrl", bean.iconUrl());
				if(bean.isDefaultLang()){
					map.put("url", bean.loginUrl(key[i]));
				}else{
					map.put("url", bean.loginUrl(request));
				}
				collection.add(map);
			}
		}
	}
	request.setAttribute("thirdLoginCollection", collection);
%>
<c:if test="${fn:length(thirdLoginCollection) > 0 }">
	<div id="third_login_form" class="third_login_form">
		<div class="third_login_header">
		    <!-- 其他登录方式 -->
			<span>${lfn:message('sys-profile:sys.profile.org.passwordSecurityConfig.other.login')}</span>
		</div>
		<ul class='third_login_list'>
		<c:forEach items="${thirdLoginCollection}" var="thirdLogin" >
			<li class="third_login_item">
				<a href="${thirdLogin.url}" title="${thirdLogin.name}">
				  <div class="third_login_item_icon third_login_icon_${thirdLogin.iconKey}"></div>
			      <div class="third_login_item_desc">${fn:substring(thirdLogin.name, 0, 3)}</div>
				</a>
			</li>
		</c:forEach>
		</ul>
	</div>
</c:if>