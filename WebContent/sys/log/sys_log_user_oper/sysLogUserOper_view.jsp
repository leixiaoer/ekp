<%@page import="org.springframework.web.util.HtmlUtils"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.landray.kmss.sys.log.model.SysLogUserOper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<%@ include file="/sys/log/resource/import/jshead.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	//获取操作content
	SysLogUserOper model = (SysLogUserOper)request.getAttribute("sysLogUserOper");
	Map content = model.getFdContent();
	String json = "";
	if(content!=null){
		//转换为json格式
		json = JSONObject.fromObject(content).toString();
		json = HtmlUtils.htmlEscape(json);
	}
	request.setAttribute("contentJson", json);
%>
<div id="optBarDiv">
	<!-- 审计 -->
	<kmss:auth requestURL="/sys/log/sys_log_user_oper/sysLogUserOper.do?method=audit&List_Selected=${JsParam.fdId}" requestMethod="POST">
		<c:if test="${sysLogUserOper.fdStatus == 0}">
			<input type="button" value="<bean:message bundle="sys-log" key="sysLogUserOper.button.audit"/>" onclick="audit('${JsParam.fdId}')"/>
		</c:if>
	</kmss:auth>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>
<div class="txttitle"><bean:message bundle="sys-log" key="table.sysLogUserOper"/></div>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="sysLogUserOper" property="fdId"/>
	<!-- 操作时间	上报时间 -->
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdCreateTime"/>
		</td><td width=35%>
			<fmt:formatDate value="${sysLogUserOper.fdCreateTime }"  type="both" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdReportTime"/>
		</td><td width=35%>
			<fmt:formatDate value="${sysLogUserOper.fdReportTime }"  type="both" />
		</td>
	</tr>
	<!-- 事件类型	事件结果 -->
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdEventType"/>
		</td><td width=35%>
			<bean:write name="sysLogUserOper" property="fdEventType"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdSuccess"/>
		</td><td width=35%>
			<sunbor:enumsShow value="${sysLogUserOper.fdSuccess}" enumsType="sysLogUserOper_enum_fdSuccess" />
		</td>
	</tr>
	<c:if test="${!isAudit && !isLogin && !isLogout}">
		<!-- 模块中文名	请求目标方法 -->
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="sys-log" key="sysLogUserOper.fdModelDesc"/>
			</td><td width=35%>
				<bean:write name="sysLogUserOper" property="fdModelDesc"/>
			</td>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="sys-log" key="sysLogUserOper.fdParaMethod"/>
			</td><td width=35%>
				<bean:write name="sysLogUserOper" property="fdParaMethod"/>
			</td>
		</tr>
		<!-- 模块名称-->
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="sys-log" key="sysLogUserOper.fdModelName"/>
			</td><td colspan=3>
				<bean:write name="sysLogUserOper" property="fdModelName"/>
			</td>
		</tr>
	</c:if>
	<!-- 日志状态 审计意见-->
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdStatus"/>
		</td><td colspan=3>
			<sunbor:enumsShow value="${sysLogUserOper.fdStatus}" enumsType="sysLogUserOper_enum_fdStatus" />
		</td>
	</tr>
	<c:if test="${sysLogUserOper.fdStatus == 1 }">
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="sys-log" key="page.audit.fdDesc"/>
			</td><td colspan=3>
				<a target="_blank" href="${KMSS_Parameter_ContextPath}sys/log/sys_log_user_oper/sysLogUserOper.do?method=view&fdId=<bean:write name="sysLogUserOper" property="fdAuditId"/>">
					<bean:write name="sysLogUserOper" property="fdAuditDesc"/>
				</a>
			</td>
		</tr>
	</c:if>
	<!-- 用户姓名	操作人标识 -->
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdOperator"/>
		</td><td width=35%>
			<bean:write name="sysLogUserOper" property="fdOperator"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdOperatorId"/>
		</td><td width=35%>
			<bean:write name="sysLogUserOper" property="fdOperatorId"/>
		</td>
	</tr>
	<!-- 登录名	用户分类 -->
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdOperLoginName"/>
		</td><td width=35%>
			<bean:write name="sysLogUserOper" property="fdOperLoginName"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdUserGrade"/>
		</td><td width=35%>
			<sunbor:enumsShow value="${sysLogUserOper.fdUserGrade}" enumsType="sysLogUserOper_enum_fdUserGrade" />
		</td>
	</tr>
	<!-- URL Method -->
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdUrl"/>
		</td><td class="break_all">
			<c:out value="${sysLogUserOper.fdRequest.fdUrl }" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdMethod"/>
		</td><td width=35%>
			<c:out value="${sysLogUserOper.fdRequest.fdMethod }" />
		</td>
	</tr>
	<!-- 终端	ip地址 -->
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdEquipment"/>
		</td><td width=35%>
			<bean:write name="sysLogUserOper" property="fdEquipment"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdIp"/>
		</td><td width=35%>
			<bean:write name="sysLogUserOper" property="fdIp"/>
		</td>
	</tr>
	<!-- UserAgent -->
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdUserAgent"/>
		</td><td colspan=3 width=35% class="break_all">
			<c:out value="${sysLogUserOper.fdRequest.fdUserAgent }" />
		</td>
	</tr>
	<!-- 操作内容 -->
	<tr>
		<td colspan="4" class="txttitle" align="center" width=15%>
			<bean:message bundle="sys-log" key="sysLogUserOper.fdContent"/>
		</td>
	</tr>
	<tr>
		<td colspan="4" class="break_all">
			<div id="contentShow" style="display:none">
				${contentJson }
			</div>
		</td>
	</tr>
</table>
</center>
<script type="text/javascript">
	var viewOption = {
        contextPath: '${LUI_ContextPath}',
        modelName: 'com.landray.kmss.sys.log.model.SysLogUserOper',
        templateName: '',
        basePath: '/sys/log/sys_log_user_oper/SysLogUserOper.do',
        canDelete: '${canDelete}',
        auditConfirm : '${lfn:message("sys-log:page.comfirmAudit")}',
        mode: '',
        customOpts: {
            ____fork__: 0
        },
        lang: {
            serial : '${lfn:message("page.serial")}',
            fdId : '${lfn:message("model.fdId")}',
            propertyName : '${lfn:message("model.fdName")}',
            serial : '${lfn:message("page.serial")}',
            fdEventType : '${lfn:message("sys-log:sysLogUserOper.fdEventType")}',
            param : '${lfn:message("sys-log:sysLogUserOper.view.content.param")}',
            find : '${lfn:message("sys-log:sysLogUserOper.view.content.find")}',
            deletes : '${lfn:message("sys-log:sysLogUserOper.view.content.delete")}',
            add : '${lfn:message("sys-log:sysLogUserOper.view.content.add")}',
            update : '${lfn:message("sys-log:sysLogUserOper.view.content.update")}',
            audit : '${lfn:message("sys-log:sysLogUserOper.view.content.audit")}',
            message : '${lfn:message("sys-log:sysLogUserOper.view.content.message")}',
            errorMessage : '${lfn:message("sys-log:sysLogUserOper.view.content.errorMessage")}',
            mechs : '${lfn:message("sys-log:sysLogUserOper.view.content.mechs")}',
            mechsName : '${lfn:message("sys-log:sysLogUserOper.view.content.mechs.name")}',
            fields : '${lfn:message("sys-log:sysLogUserOper.view.content.fields")}',
            fieldsName : '${lfn:message("sys-log:sysLogUserOper.view.content.fields.name")}',
            fieldsValue : '${lfn:message("sys-log:sysLogUserOper.view.content.fields.value")}',
            auditLog : '${lfn:message("sys-log:sysLogUserOper.view.content.auditLog")}',
            auditId : '${lfn:message("sys-log:sysLogUserOper.view.content.auditId")}',
            auditDisplay : '${lfn:message("sys-log:page.audit.fdDesc")}',
            fieldsOld : '${lfn:message("sys-log:sysLogUserOper.view.content.fields.old")}',
            fieldsNew : '${lfn:message("sys-log:sysLogUserOper.view.content.fields.new")}',
            paramName : '${lfn:message("sys-log:sysLogUserOper.view.content.param.name")}',
            paramValue : '${lfn:message("sys-log:sysLogUserOper.view.content.param.value")}',
            detail : '${lfn:message("sys-log:sysLogUserOper.view.content.detail")}',
            noone : '${lfn:message("sys-log:sysLogUserOper.view.content.null")}',
            logType : '${lfn:message("sys-log:sysLogUserOper.view.content.logType")}',
            description : '${lfn:message("sys-log:sysLogUserOper.view.content.description")}',
            attachment : '${lfn:message("sys-log:sysLogUserOper.view.content.attachment")}',
            attachmentUpdate : '${lfn:message("sys-log:sysLogUserOper.view.content.attachment.update")}',
            attachmentDelete : '${lfn:message("sys-log:sysLogUserOper.view.content.attachment.delete")}',
            attachmentType : '${lfn:message("sys-log:sysLogUserOper.view.content.attachment.type")}',
            attachmentNum : '${lfn:message("sys-log:sysLogUserOper.view.content.attachment.num")}',
            remove : '${lfn:message("sys-log:sysLogUserOper.view.content.remove")}',
            noChanged : '${lfn:message("sys-log:sysLogUserOper.view.content.noChanged")}',
            noAtt : '${lfn:message("sys-log:sysLogUserOper.view.content.noAtt")}',
            show : '${lfn:message("sys-log:sysLogUserOper.view.content.show")}',
            hide : '${lfn:message("sys-log:sysLogUserOper.view.content.hide")}',
            attUnit : '${lfn:message("sys-log:sysLogUserOper.view.content.attUnit")}'
        }
    };
</script>
<!-- 引入CSS -->
<link type="text/css" rel="styleSheet"  href="${LUI_ContextPath}/sys/log/resource/css/useroper_view.css" />
<!-- 引入JS -->
<script type="text/javascript" src="${LUI_ContextPath}/sys/log/resource/js/useroper_view.js"></script>	 
<%@ include file="/resource/jsp/view_down.jsp"%>