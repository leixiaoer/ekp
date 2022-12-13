<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.sys.authentication.user.KMSSUser"%>
<%@page import="com.landray.kmss.sys.authentication.user.UserAuthInfo"%>
<%@page import="com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.json.*"%>
<%@page import="com.landray.kmss.sys.authentication.filter.HQLFragment"%>
<%@page import="com.landray.kmss.common.dao.HQLParameter"%>
<%@page import="com.landray.kmss.sys.authorization.util.TripartiteAdminUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>当前用户信息</title>
<style>
table { border-collapse: collapse;border-spacing: 0;}
td {padding:2px 8px;border: 1px #d2d2d2 solid;word-break:break-all;}
</style>
</head>
<body style="margin:20px; line-height:24px; font-size:12px;">
<%
KMSSUser user = UserUtil.getKMSSUser(request);
pageContext.setAttribute("user", user);
UserAuthInfo auth = user.getUserAuthInfo();
pageContext.setAttribute("auth", auth);
if(!user.isAnonymous()){
	ISysOrgCoreService service = (ISysOrgCoreService)SpringBeanUtil.getBean("sysOrgCoreService");
	List<Object[]> results = service.getNamesByIds(auth.getAuthOrgIds());
	List<Object> names = new ArrayList<Object>();
	for(Object[] result:results){
		names.add(result[0]);
	}
	pageContext.setAttribute("authNames", names);
}
List hqlInfos = new ArrayList();
for(Object o: auth.getHqlInfoModelMap().entrySet()){
	Map.Entry entry = (Map.Entry) o;
	HQLFragment fragment = (HQLFragment) entry.getValue();
	Map item = new HashMap();
	item.put("key", entry.getKey());
	item.put("join", fragment.getJoinBlock());
	item.put("where", fragment.getWhereBlock());
	JSONArray array = new JSONArray();
	for(HQLParameter param : fragment.getParameterList()){
		JSONObject json = new JSONObject();
		json.put("name", param.getName());
		json.put("value", param.getValue());
		array.add(json);
	}
	item.put("param", array);
	hqlInfos.add(item);
}
pageContext.setAttribute("hqlInfos", hqlInfos);
%>
<b>基本信息</b><br>
当前用户：${user.userName}（${user.userId}）<br>
登录名：${user.username}<br>
语言：${user.locale}<br>
<br>
<b>权限信息<c:if test="${user.admin}">：超级管理员</c:if></b><br>
角色：${auth.authRoleAliases}<br>
身份：${authNames}（${auth.authOrgIds}）<br>
<%
if (TripartiteAdminUtil.IS_ENABLED_TRIPARTITE_ADMIN) {
	int type = TripartiteAdminUtil.getUserType(null);
	String typeName = null;
	switch(type) {
	case 2:{
		typeName = "系统管理员";
		break;
	}
	case 4:{
		typeName = "安全保密管理员";
		break;
	}
	case 8:{
		typeName = "安全审计管理员";
		break;
	}
	default:{
		typeName = "普通用户";
	}
	}
%>
三员管理用户类型：<%= typeName %>
<% } %>
<br>
<b>查询缓存</b>
<table>
	<tr style="text-align: center;">
		<td>Key</td>
		<td>Join</td>
		<td>Where</td>
		<td>Param</td>
	</tr>
<c:forEach items="${hqlInfos}" var="hqlInfo">
	<tr>
		<td><c:out value="${hqlInfo.key}" /></td>
		<td><c:out value="${hqlInfo.join}" /></td>
		<td><c:out value="${hqlInfo.where}" /></td>
		<td><c:out value="${hqlInfo.param}" /></td>
	</tr>
</c:forEach>
</table>
</body>
</html>