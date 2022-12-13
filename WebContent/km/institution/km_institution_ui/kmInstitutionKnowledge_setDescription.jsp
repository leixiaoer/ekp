<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="java.util.Date, com.landray.kmss.util.*"%>

<% 
	String abolishTime = DateUtil.convertDateToString(new Date(), DateUtil.TYPE_DATE, request.getLocale());
%>
<template:include ref="default.dialog">
	<template:replace name="content" >
		<script>
			Com_IncludeFile("calendar.js");
			seajs.use(['lui/dialog', 'lui/jquery'],function(dialog,$) {
				//确认
				window.clickOk=function(){
					var fdAbolishDescription = document.getElementsByName("fdAbolishDescription")[0];
					var abolishTime = document.getElementsByName("abolishTime")[0];
					if(window.validationDesc(fdAbolishDescription) && window.validationTime(abolishTime)) {
						window.$dialog.hide({abolishDescription:fdAbolishDescription.value, abolishTime:abolishTime.value});
					}
				};

				window.validationTime = function(abolishTime) {
					var validateMsgId = "validate_time";
					$("#" + validateMsgId).remove();
					// 判断失效时间是否为空
					if(abolishTime.value == "") {
						var msg = '<bean:message key="errors.required"/>'.replace("{0}", '<span class="validation-advice-title"><bean:message bundle="km-institution" key="kmInstitution.fdAbolishTime" /></span>');
						window.showErrorMsg(validateMsgId, $(abolishTime).parent().parent(), msg);
						return false;
					}
					// 判断失效时间是否在生效时间之前
					var publishTime = "${JsParam.docPublishTime}";
					if(publishTime && publishTime.length > 0) {
						if(getDate(abolishTime.value).getTime() < getDate(publishTime).getTime()) {
							var msg = '<bean:message key="errors.min"/>'.replace("{0}", '<span class="validation-advice-title"><bean:message bundle="km-institution" key="kmInstitution.fdAbolishTime" /></span>').replace("{1}", '<span class="validation-advice-title"><bean:message bundle="km-institution" key="kmInstitution.docPublishTime" /></span>');
							window.showErrorMsg(validateMsgId, $(abolishTime).parent().parent(), msg);
							return false;
						}
					}
					return true;
				};

				window.validationDesc = function(textarea) {
					var validateMsgId = "validate_desc";
					$("#" + validateMsgId).remove();
					if(textarea.value.replace(/(^\s*)|(\s*$)/g, '').length < 1) {
						var msg = '<bean:message key="errors.required"/>'.replace("{0}", '<span class="validation-advice-title"><bean:message bundle="km-institution" key="kmInstitution.fdAbolishDescription" /></span>');
						window.showErrorMsg(validateMsgId, textarea, msg);
						return false;
					} else {
						var newvalue = textarea.value.replace(/[^\x00-\xff]/g, "***");
						if(newvalue.length > 2000) {
							var msg = '<bean:message key="errors.maxLength"/>'.replace("{0}", '<span class="validation-advice-title"><bean:message bundle="km-institution" key="kmInstitution.fdAbolishDescription" /></span>').replace("{1}", 2000);
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

				window.getDate = function(str) {
					return new Date(Date.parse(str));
				};
			});
		</script>
		<div style="margin:10px auto;text-align: center;">
			<div class="txttitle">
				<bean:message bundle="km-institution" key="kmInstitutionMain.abolishTitle" />
			</div>
			<br/>
			<table id="Table_Main" class="tb_normal" width="90%" align="center">
				<tr>
					<td class="td_normal_title">
						<bean:message bundle="km-institution" key="kmInstitution.fdAbolishDescription" />
					</td>
					<td width="75%">
						<textarea name="fdAbolishDescription" style="width:95%;height:100px" onblur="validationDesc(this)"></textarea>
						<span class="txtstrong">*</span>
					</td> 
				</tr>
				<tr>
					<td class="td_normal_title">
						<bean:message bundle="km-institution" key="kmInstitution.fdAbolishTime" />
					</td>
					<td width="75%">
						<div class="inputselectsgl" onclick="selectDate('abolishTime')" style="width: 98%">
							<div class="input"><input type="text" name="abolishTime" value="<%=abolishTime %>" ></div>
							<div class="inputdatetime"><span class="txtstrong" style="margin-left:20px;">*</span></div>
						</div>
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