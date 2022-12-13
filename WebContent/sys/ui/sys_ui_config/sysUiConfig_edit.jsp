<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>	
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="config.profile.edit" sidebar="no">
	<template:replace name="title"><bean:message bundle="sys-ui" key="sys.ui.config" /></template:replace>
	<template:replace name="head">
		<link charset="utf-8" rel="stylesheet" 
		href="${LUI_ContextPath}/sys/ui/sys_ui_config/config.css">
	</template:replace>
	
	<template:replace name="content">
		<h2 align="center" style="margin: 10px 0;color: #35a1d0;">
			<bean:message bundle="sys-ui" key="sys.ui.config" />
			<% if(!new com.landray.kmss.sys.ui.transfer.SysUiConfigChecker().isRuned()) { %>
			<span style="color: red;"><bean:message bundle="sys-ui" key="sys.ui.config.transfer" /></span>
			<% } %>
		</h2>
		
		<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do">
			<center>
				<table  class="tb_normal" width=80%>
					<tr>
						<td class="td_normal_title" width="22%">
							<bean:message bundle="sys-person" key="sysPerson.config.fdWidth"/>
						</td>
						<td>
							<div>
								<xform:text property="value(fdWidth)" style="width:50px" required="true" onValueChange="validateWidth();"/>
							</div>
							<div>
								<bean:message bundle="sys-person" key="sysPerson.config.fdWidth.tip"/>
							</div>				
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width="22%">
							<bean:message bundle="sys-ui" key="sys.ui.config.fdMaxWidth"/>
						</td>
						<td>
							<div>
								<bean:message bundle="sys-ui" key="sys.ui.config.page.minWidth"/> 980 px , <bean:message bundle="sys-ui" key="sys.ui.config.page.maxWidth"/> <xform:text property="value(fdMaxWidth)" style="width:60px" required="true" validators="min(980)"/> px
							</div>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width="22%">
							<bean:message bundle="sys-ui" key="sys.ui.config.fdPersonLeftSide"/>
						</td>
						<td>
							<div>
								<xform:text property="value(fdPersonLeftSide)" style="width:60px" validators="min(150) leftSide"/> px
							</div>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width="22%">
							<bean:message bundle="sys-ui" key="sys.ui.config.mourning"/>
						</td>
						<td>
							<span  class="lui_mourning_switch">
								<ui:switch property="value(fdIsSysMourning)"
                                           enabledText="${lfn:message('sys-ui:ui.switch.enabled')}"
                                           disabledText="${lfn:message('sys-ui:ui.switch.disabled')}">
                                </ui:switch>
							</span>
							<span class="lui_mourning_help">
								<span class="lui_icon_s lui_icon_s_icon_help"></span><div>${lfn:message('sys-ui:sys.ui.config.mourning.help')}</div>
							</span>
						</td>
					</tr>
					<!-- 如果系统启用了集团分级，则显示 “用户登录门户设置”（用户进行登录时，是否直接登录到用户设置的默认场所下的门户） 配置行 -->
					<% if(ISysAuthConstant.IS_AREA_ENABLED) { %> 
						<tr>
							<td class="td_normal_title" width="22%">
								<bean:message bundle="sys-ui" key="sys.ui.config.loginDefaultAreaPortal"/>
							</td>
							<td>
							    <div style="display: table;">
									<div style="display: table-cell;vertical-align: middle;white-space: nowrap;">
										<ui:switch property="value(loginDefaultAreaPortal)" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
									</div>
									<div style="display: table-cell;padding-left: 12px;">
									    <bean:message bundle="sys-ui" key="sys.ui.config.loginDefaultAreaPortal.desc"/>
									</div>
								</div>
							</td>
						</tr>	
					<% } %>						
					<!-- 如果系统启用了集团分级，则显示 “用户漫游到其它场所的同时切换到该场所下的门户” 配置行 -->
					<% if(ISysAuthConstant.IS_AREA_ENABLED) { %> 
						<tr>
							<td class="td_normal_title" width="22%">
								<bean:message bundle="sys-ui" key="sys.ui.config.roamSwitchPortal"/>
							</td>
							<td>
							    <div style="display: table;">
									<div style="display: table-cell;vertical-align: middle;white-space: nowrap;">
										<ui:switch property="value(roamSwitchPortal)" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
									</div>
									<div style="display: table-cell;padding-left: 12px;">
									    <bean:message bundle="sys-ui" key="sys.ui.config.roamSwitchPortal.desc"/>
									</div>
								</div>
							</td>
						</tr>	
					<% } %>				
					<tr>
						<td colspan="2">
							<bean:message bundle="sys-ui" key="sys.ui.config.msg0"/><br>
							<bean:message bundle="sys-ui" key="sys.ui.config.msg1"/><br>
							 &nbsp;<bean:message bundle="sys-ui" key="sys.ui.config.msg2"/><br>
							<bean:message bundle="sys-ui" key="sys.ui.config.msg4"/>
						</td>
					</tr>
				</table>
			</center>
			<html:hidden property="method_GET" />
			
			<center style="margin-top: 10px;">
			<!-- 提交 -->
			<ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="commitMethod();"></ui:button>
			</center>
		</html:form>
		
	 	<script type="text/javascript">
	 		var _validation = $KMSSValidation();
	 		_validation.addValidator('leftSide','<bean:message bundle="sys-ui" key="sys.ui.config.fdPersonLeftSide.error"/>',function(v, e, o) {
	 			if(v==""){
	 				return true;
	 			}
	 			// 不能大于“全系统页面宽度”的3/1
	 			var maxWidth = parseInt($("input[name=value\\\(fdMaxWidth\\\)]").val());
	 			if(parseInt(v) <= (maxWidth/3)) {
	 				return true;
	 			}
	 			
	 			return false;
	 		});

		 	function validateWidth() {
			 	var fdWidth = $("input[name=value\\\(fdWidth\\\)]");
			 	fdWidth.parent().find(".validation-advice").remove();
	 			if(/^\d+(px|%)$/.test(fdWidth.val())) {
	 				if(/^\d+(px)$/.test(fdWidth.val())) {
		 				var width = parseInt(fdWidth.val().replace("px", ""));
		 				var maxWidth = parseInt($("input[name=value\\\(fdMaxWidth\\\)]").val());
		 				if(maxWidth > 980 && (width < 980 || width > maxWidth)) {
		 					showError(fdWidth, '<bean:message bundle="sys-person" key="sysPerson.config.error2"/>'.replace("{0}", maxWidth));
		 					return false;
			 			}
		 				return true;
	 				}
	 				return true;
	 			}
 				showError(fdWidth, '<bean:message bundle="sys-person" key="sysPerson.config.error"/>');
		 		return false;
		 	}

		 	function showError(input, msg) {
		 		input.parent().append('<div class="validation-advice" _reminder="true"><table class="validation-table"><tbody><tr><td><div class="lui_icon_s lui_icon_s_icon_validator"></div></td><td class="validation-advice-msg"><span class="validation-advice-title"></span> ' + msg + '</td></tr></tbody></table></div>');
			}
	
		 	function commitMethod(){
		 		if(validateWidth()){
		 			Com_Submit(document.sysAppConfigForm, 'update');
		 		}
		 	}
	 	</script>
	</template:replace>
</template:include>
