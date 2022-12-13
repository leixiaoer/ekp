<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.cogroup.util.CogroupUtil" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.profile.edit" sidebar="no">
	<template:replace name="title"><bean:message key="cogroup.cogroupConfig" bundle="km-cogroup"/></template:replace>
	<template:block name="path" >
		<span class=txtlistpath><bean:message key="cogroupConfig.currurl" bundle="km-cogroup"/>：<bean:message key="cogroup.config.setting" bundle="km-cogroup"/></span>
	</template:block>
	<template:replace name="content">
		<h2 align="center" style="margin:10px 0">
			<span class="profile_config_title"><bean:message key="cogroup.cogroupConfig" bundle="km-cogroup"/></span>
		</h2>
		<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do?autoclose=false" onsubmit="return validateAppConfigForm(this);">
			<center>
				<table id="cogroupBaseTable" class="tb_normal" width="95%">
					<tr id="cogroupEnableTR">
						<td class="td_normal_title" width="15%"><bean:message key="cogroup.cogroupEnabled" bundle="km-cogroup"/></td>
						<td>
							<ui:switch property="value(cogroupEnabled)" onValueChange="window.wx_display_change();" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
							<br/>
							<font><bean:message key="group.tips" bundle="km-cogroup"/></font>
						</td>
					</tr>
					<%
					boolean dingExist = CogroupUtil.moduleExist("/third/ding/");
					boolean lDingExist = CogroupUtil.moduleExist("/third/lding/");
					if(dingExist || lDingExist){
					%>
					<%-- <kmss:ifModuleExist  path = "/third/ding/"> --%>
						<tr id="dingCogroupEnableTR">
							<td class="td_normal_title" width="15%"><bean:message key="cogroup.dingCogroupEnabled" bundle="km-cogroup"/></td>
							<td>
								<ui:switch property="value(dingCogroupEnable)" onValueChange="window.wx_display_change();" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
								<br/>
								<font><bean:message key="group.tips.ding" bundle="km-cogroup"/></font>
							</td>
						</tr>
					<% } %>	
					<!-- 企业微信群聊 -->
					<%
					boolean weixinExist = CogroupUtil.moduleExist("/third/weixin/");
					if(weixinExist){
					%>
						<tr id="wxWorkCogroupEnableTR" style="display:none;">
							<td class="td_normal_title" width="15%"><bean:message key="cogroup.wxWorkCogroupEnable" bundle="km-cogroup"/></td>
							<td>
								<ui:switch property="value(wxWorkCogroupEnable)" onValueChange="window.wx_display_change();" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
								<br/>
								<font><bean:message key="group.tips.weixinWork" bundle="km-cogroup"/>23</font>
							</td>
						</tr>
					<% } %>	
					<%-- </kmss:ifModuleExist> --%>
					<tr>
						<td colspan="2">
							<img src="${KMSS_Parameter_ContextPath}km/cogroup/resource/images/demo.png" style="width: 100%;">
						</td>
					</tr>
				</table>
			</center>
			<html:hidden property="method_GET" />
			<input type="hidden" name="modelName" value="com.landray.kmss.km.cogroup.model.GroupConfig" />
			<center style="margin:20px 0;">
				<!-- 保存 -->
				<ui:button text="${lfn:message('button.save')}" suspend="bottom" onclick="window.itSubmit();" width="120" height="35"></ui:button>
			</center>
		</html:form>
		<script type="text/javascript">
			var validation = $KMSSValidation();
			seajs.use(['lui/jquery'],function($){
					function wx_display_change(){
						/* var value = $('[name="value(cogroupEnabled)"]').val();
						if(value == 'true'){
							$('#cogroupBaseTable tr[id!="cogroupEnableTR"]').show();
						}else{
							$('#cogroupBaseTable tr[id!="cogroupEnableTR"]').hide();
						} */
					}
					
					window.validateAppConfigForm = function(){
						return true;
					};
					
					window.itSubmit = function(){
						Com_Submit(document.sysAppConfigForm, 'update');
					};
					
					LUI.ready(function(){
						//wx_display_change();
					});
					
					window.wx_display_change = wx_display_change;
				});
		</script>
	</template:replace>	
</template:include>