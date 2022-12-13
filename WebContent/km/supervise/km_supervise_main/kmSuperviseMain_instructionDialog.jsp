<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content" >
		<script type="text/javascript">Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js", null, "js");</script>
		<script>
			$KMSSValidation();//校验框架
			seajs.use(['lui/dialog', 'lui/jquery'],function(dialog,$) {
				//确认
				window.clickOk=function(){
					var _validation = $KMSSValidation(document.forms['kmSuperviseInstructionForm']);
					var formObj = document.kmSuperviseInstructionForm;
					Com_Submit(formObj, "save");
				};
			});
		</script>
		<div style="margin:10px auto;text-align: center;">
			<html:form action="/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do">
			<html:hidden property="fdMainId"/>
			<table id="Table_Main" class="tb_normal"width="80%"align="center">
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-supervise" key="kmSuperviseInstruction.fdMessage"/>
					</td>
					<td width="85%" colspan="3">
						<xform:textarea property="docContent" style="width:95%;" 
								required="true" showStatus="edit" validators="maxLength(1500)" placeholder="请输入您的批示意见"></xform:textarea>
					</td>
				</tr>
			</table>
			<div style="width:50px;margin: 10px auto;">
				<ui:button text="${lfn:message('button.ok') }" onclick="clickOk();" />
			</div>
			</html:form>
		</div>
		<div style="height: 60px;"></div>
	</template:replace>
</template:include>