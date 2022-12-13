<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content">
		<style>
			.lui_dialog_content {
				padding: 10px;
			}
			.lui_dialog_copyTips {
				width: 100%;
				padding-bottom: 10px;
			}
			.lui_dialog_copyTips .description {
				text-align: left;
				margin-left: 10px;
			}
			.lui_dialog_copyTips .radioUl {
				text-align: left;
				margin-left: 10px;
			}
			.lui_dialog_copyTips .radioUl label {
				display: block;
				margin:10px 0;
				cursor: pointer;
			}
			.lui_dialog_copyTips .radioUl span {
				margin-left: 5px;
			}
		</style>
		
		<center>
			<script  type="text/javascript">
				seajs.use([ 'lui/jquery','lui/dialog'],function($, dialog) {
					$(function() {
						
					});
					
					//确认
					window.clickOK = function() {
						var copyTaskUrl = $dialog.content.params.copyTaskUrl;
						var copyChildTaskUrl = $dialog.content.params.copyChildTaskUrl;
						var parentId = $dialog.content.params.data;
						var dialogRoot = $dialog.content.params.dialog;
						
						if(!copyTaskUrl || !copyChildTaskUrl || !parentId) {
							$dialog.hide();
							dialogRoot.alert('<bean:message key="return.optFailure"/>');
							return;
						}
						
						var copyType = $("input[name='copyType']:checked").val();
						if (copyType == 'copyNew') {
							copyNewTask(copyTaskUrl, dialogRoot);
						} else if (copyType == 'copyChild') {
							copyChildTask(copyChildTaskUrl, parentId, dialogRoot);
						}
					};
					
					// 复制为新建任务
					window.copyNewTask = function(url, dialogRoot) {
						$.post('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=checkAuth',
							function(checkAuth){
								if (checkAuth != null && checkAuth.haveAuth == "true") {
									$dialog.hide();
									Com_OpenWindow(url,'_blank');
								} else {
									$dialog.hide();
									dialogRoot.alert("${lfn:message('sys-task:button.copy.confirm.message3')}");
								}
						},'json');
					};
					
					// 复制为当前任务子任务
					window.copyChildTask = function(url, id, dialogRoot) {
						$.post('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=isParentClose&fdTaskId='+id,
							function(data){
								if(data!=null && data.isParentClose =="false"){
									$.post('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=checkAuth&isCheckUrl=true&checkParam='+id,
										function(checkAuth){
											if (checkAuth != null && checkAuth.haveAuth == "true") {
												$dialog.hide();
												Com_OpenWindow(url,'_blank');
											} else {
												$dialog.hide();
												dialogRoot.alert("${lfn:message('sys-task:button.copy.confirm.message3')}");
											}
									},'json');
								} else {
									$dialog.hide();
									dialogRoot.alert("${lfn:message('sys-task:button.copy.confirm.message2')}");
								}
						},'json');
					};
				});
			</script>
			<div class="lui_dialog_content">
				<!-- 复制任务提示框 Starts -->
				<div class="lui_dialog_copyTips">
					<div class="description"><bean:message key="button.copy.confirm.message" bundle="sys-task"/></div>
					<div class="radioUl">
						<label><input type="radio" name="copyType" value="copyNew" checked/><span id="copyNew_span"><bean:message key="button.copy.confirm.radio.copyNewTask" bundle="sys-task"/></span></label>
						<label><input type="radio" name="copyType" value="copyChild"/><span id="copyChild_span"><bean:message key="button.copy.confirm.radio.copyChildTask" bundle="sys-task"/></span></label>
					</div>
				</div>
				<!-- 复制任务提示框 Ends -->
	
				<ui:button text="${lfn:message('button.ok') }" onclick="clickOK();"></ui:button>
				<ui:button style="padding-left:10px"  text="${lfn:message('button.cancel') }" styleClass="lui_toolbar_btn_gray" onclick="Com_CloseWindow();"></ui:button>
			</div>
		</center>
	</template:replace>
</template:include>
