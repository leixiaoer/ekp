<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do">
<div id="optBarDiv">
	<input type=button value="<bean:message key="button.update"/>"
		onclick="Com_Submit(document.sysAppConfigForm, 'update');">
</div>
<p class="txttitle"><bean:message bundle="geesun-leave" key="geesunLeaveConfig.config" /></p>
<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width="20%">
			<bean:message bundle="geesun-leave" key="geesunLeaveConfig.fdTemplateIds" />
		</td>
		<td>
			<xform:text property="value(fdTemplateIds)" style="width:300px;"/>
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET" />
<input type="hidden" name="modelName" value="com.landray.kmss.geesun.leave.model.GeesunLeaveConfig" />
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>
