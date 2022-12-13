<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.km.supervise.service.IKmSuperviseMainService"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%
	String fdModelId = request.getParameter("fdModelId");
	String fdModelName = request.getParameter("fdModelName");
	int superviseCount = ((IKmSuperviseMainService)SpringBeanUtil.getBean("kmSuperviseMainService")).getSuperviseCount(fdModelId,fdModelName);
	if(superviseCount > 0){
		pageContext.setAttribute("superviseCount", "("+superviseCount+")");
	}
%>
<c:set var="communicateUrl" value="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&modelName=${JsParam.fdModelName}&modelId=${JsParam.fdModelId}" />
<kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
	<c:if test="${empty param.commuTitle}">
		<c:set var="_contentBtnTitle" value="${lfn:message('km-supervise:table.kmSuperviseMain.title')}"/>
	</c:if>
	<c:if test="${not empty param.commuTitle}">
		<c:set var="_contentBtnTitle" value="${param.commuTitle}"/>
	</c:if>
	<ui:button parentId="toolbar" text="${_contentBtnTitle}" 
		onclick="Com_OpenWindow('${communicateUrl}','_blank');" order="3">
	</ui:button>
</kmss:authShow>


<c:set var="_contentTitle" value="${lfn:message('km-supervise:kmSuperviseMain.content.title')}"/>
<c:set var="order" value="${empty param.order ? '25' : param.order}"/>
<c:set var="disable" value="${empty param.disable ? 'false' : param.disable}"/>
<ui:content title="${_contentTitle}${superviseCount}" titleicon="${not empty param.titleicon?param.titleicon:''}" cfg-order="${order}" cfg-disable="${disable}">
	<ui:event event="show">
		document.getElementById('superviseContent').src = '<c:url value="/km/supervise/import/kmSuperviseMain_list.jsp"/>?fdModelId=${JsParam.fdId}&fdModelName=${JsParam.fdModelName}&norecodeLayout=${param.norecodeLayout}';
	</ui:event>
	<table width="100%" ${HtmlParam.styleValue}>
		<tr>
			<td>
				<iframe src="" width=100% height="1000" frameborder=0 scrolling="no" id="superviseContent">
				</iframe>
			</td>
		</tr>
	</table>
</ui:content>

