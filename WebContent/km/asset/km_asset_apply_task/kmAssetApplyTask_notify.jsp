<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content">
	<br><br>
	<script type="text/javascript">
			seajs.use([ 'lui/jquery','lui/parser','lui/dialog'],function($,parser,dialog) {
				window.submitForm = function(form){
					var selected = $("input[name='fdNotifyType']:checked");
					if(selected.length <= 0){
						dialog.alert("${lfn:message('km-asset:kmAssetApplyTask.notify.notnull')}");
						return false;
					}
					$dialog.hide($(form).serialize());
					return true;
				}
			});
	</script>
	<html:form action="/km/asset/km_asset_apply_task/kmAssetApplyTask.do" method="post">
	<center>
		<table class="tb_noborder" width=95%>
			<tr>
				<td><bean:message bundle="km-asset" key="kmAssetApplyTask.startNotifyType" /></td>			
				<td>
					<label><input name="fdNotifyType" type="checkbox" value="todo" checked onclick=""/>${lfn:message('km-asset:kmAssetApplyTask.notify.todo')} </label> &nbsp;
					<label><input name="fdNotifyType" type="checkbox" value="email" />${lfn:message('km-asset:kmAssetApplyTask.notify.email')} </label> &nbsp;
					<label><input name="fdNotifyType" type="checkbox" value="mobile"/>${lfn:message('km-asset:kmAssetApplyTask.notify.mobile')} </label> &nbsp;
				</td>			
			</tr>
		</table>
		<div style="padding-top:17px">
			<ui:button text="${lfn:message('km-asset:kmAssetApplyTask.button.ok')}" onclick="submitForm(document.kmAssetApplyTaskForm);"></ui:button>
			<ui:button text="${lfn:message('km-asset:kmAssetApplyTask.button.cancel') }" styleClass="lui_toolbar_btn_gray" onclick="Com_CloseWindow();"></ui:button>
		</div>
	</center>
	<html:hidden property="fdId" value="${HtmlParam.fdId}"/>
	<html:hidden property="method" value="notify"/>
	<html:hidden property="method_GET"/>
	</html:form>
</template:replace>
</template:include>
