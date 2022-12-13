<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="java.util.Date, com.landray.kmss.util.*"%>
<template:include ref="default.dialog">
	<template:replace name="content" >
		<script>
			Com_IncludeFile("calendar.js");
			seajs.use(['lui/dialog', 'lui/jquery'],function(dialog,$) {
				//确认
				window.clickOk=function(){
					var fdDescription = document.getElementsByName("fdDescription")[0];
					if(window.validationDesc(fdDescription)) {
						window.$dialog.hide({rejectReason: fdDescription.value});
					}
				};

				window.validationDesc = function(textarea) {
					var validateMsgId = "validate_desc";
					$("#" + validateMsgId).remove();
					if(textarea.value.replace(/(^\s*)|(\s*$)/g, '').length < 1) {
						var msg = '<bean:message key="errors.required"/>'.replace("{0}", '<span class="validation-advice-title"><bean:message bundle="sys-task" key="button.rejectTask.fdReason" /></span>');
						window.showErrorMsg(validateMsgId, textarea, msg);
						return false;
					} else {
						var newvalue = textarea.value.replace(/[^\x00-\xff]/g, "***");
						if(newvalue.length > 2000) {
							var msg = '<bean:message key="errors.maxLength"/>'.replace("{0}", '<span class="validation-advice-title"><bean:message bundle="sys-task" key="button.rejectTask.fdReason" /></span>').replace("{1}", 2000);
							window.showErrorMsg(validateMsgId, textarea, msg);
							return false;
						} else {
							return true;
						}
					}
				};
				window.showErrorMsg = function(validateMsgId, element, message) {
					if($("#" + validateMsgId).length == 0) {
						$(element).parent().append('<div class="validation-advice" id="'+validateMsgId+'" _reminder="true"><table class="validation-table"><tbody><tr><td><div class="lui_icon_s lui_icon_s_icon_validator"></div></td><td class="validation-advice-msg">'+message+'</td></tr></tbody></table></div>');
					}
				};

			});
		</script>
		<div style="margin:10px auto;text-align: center;">
			<div class="txttitle">
				<bean:message key="button.rejectTask" bundle="sys-task"/>
			</div>
			<br/>
			<table id="Table_Main" class="tb_normal" width="90%" align="center">
				<tr>
					<td class="td_normal_title">
						<bean:message key="button.rejectTask.message" bundle="sys-task"/>
					</td>
					<td width="75%">
						<bean:message key="button.rejectTask.message2" bundle="sys-task"/>
					</td> 
				</tr>
				<tr>
					<td class="td_normal_title">
						<bean:message key="button.rejectTask.fdReason" bundle="sys-task"/>
					</td>
					<td width="75%">
						<textarea name="fdDescription" style="width:95%;height:100px" onblur="validationDesc(this)"></textarea>
						<span class="txtstrong">*</span>
					</td> 
				</tr>
				<tr>
					<td colspan="2" align="center" >
						<ui:button text="${lfn:message('button.ok') }" onclick="clickOk();" >
						</ui:button>&nbsp;
						<ui:button  text="${lfn:message('button.cancel') }" onclick="window.$dialog.hide(null);" styleClass="lui_toolbar_btn_gray">
						</ui:button>
					</td>
				</tr>
			</table>
		</div>
	</template:replace>
</template:include>