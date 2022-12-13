<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="config.profile.edit" sidebar="no">
	<template:replace name="title"><bean:message bundle="sys-organization" key="sysOrgConfig" /></template:replace>
	<template:replace name="head">
		<script>
			Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp", null, "js");
		</script>
		<script>$KMSSValidation();</script>
		<script type="text/javascript">
			function submitConfig() {
				var taskFieldEnable = document.getElementById("taskFieldEnable");
				if(taskFieldEnable.checked) {
					document.getElementsByName("value(taskFieldEnable)")[0].value="true";
				} else {
					document.getElementsByName("value(taskFieldEnable)")[0].value="false";
				}
				
				var feedbackEnable = document.getElementById("feedbackEnable");
				if(feedbackEnable.checked) {
					document.getElementsByName("value(feedbackEnable)")[0].value="true";
				} else {
					document.getElementsByName("value(feedbackEnable)")[0].value="false";
				}
				
				var sysUnitEnable = document.getElementById("sysUnitEnable");
				if(sysUnitEnable.checked) {
					document.getElementsByName("value(sysUnitEnable)")[0].value="true";
				} else {
					document.getElementsByName("value(sysUnitEnable)")[0].value="false";
				}
				Com_Submit(document.sysAppConfigForm, 'update');
			}
			seajs.use(['lui/jquery'],function($) {
				$(document).ready(function(){
					var taskFieldEnable = document.getElementsByName("value(taskFieldEnable)")[0].value;
					if(taskFieldEnable){
						if(taskFieldEnable === 'true') {
							$("#taskFieldEnable").prop("checked",true);
						}
					}else{
						$("#taskFieldEnable").prop("checked",true);
					}
					
					var feedbackEnable = document.getElementsByName("value(feedbackEnable)")[0].value;
					if(feedbackEnable){
						if(feedbackEnable === 'true') {
							$("#feedbackEnable").prop("checked",true);
						}
					}else{
						$("#feedbackEnable").prop("checked",true);
					}
					
					var sysUnitEnable = document.getElementsByName("value(sysUnitEnable)")[0].value;
					if(sysUnitEnable){
						if(sysUnitEnable === 'true') {
							$("#sysUnitEnable").prop("checked",true);
						}
					}else{
						$("#sysUnitEnable").prop("checked",true);
					}
					
				});
			});
		</script>
	</template:replace>
	<template:replace name="content">
		<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do" >
			<div style="margin-top:25px">
			<p class="configtitle">
				<kmss:message bundle="km-supervise" key="kmSuperviseParamConfig.setting" />
			</p>
			<center>
			<table class="tb_normal" width=90%>
			
				<tr>
					<td class="td_normal_title" width=15%>
						<kmss:message bundle="km-supervise" key="kmSuperviseParamConfig.setting" />
					</td><td colspan=3>
					<p><label>
					<html:hidden property="value(taskFieldEnable)"/>
					<input type="checkbox" id="taskFieldEnable"/>
					<kmss:message bundle="km-supervise" key="kmSuperviseParamConfig.task.field.enable.tip" /></label></p>
					
					<p><label>
					<html:hidden property="value(feedbackEnable)"/>
					<input type="checkbox" id="feedbackEnable"/>
					<kmss:message bundle="km-supervise" key="kmSuperviseParamConfig.feedback.enable.tip" /></label></p>
					
					<p><label>
					<html:hidden property="value(sysUnitEnable)"/>
					<input type="checkbox" id="sysUnitEnable"/>
					<kmss:message bundle="km-supervise" key="kmSuperviseParamConfig.sysunit.enable.tip" /></label></p>
					</td>
				</tr>
			</table>
			<div style="margin-bottom: 10px;margin-top:25px">
				   <ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="submitConfig();" order="1" ></ui:button>
			</div>
			</center>
			</div>
			<html:hidden property="method_GET"/>
			<html:hidden property="modelName" value="com.landray.kmss.km.supervise.model.KmSuperviseParamConfig"/>
		</html:form>
	</template:replace>
</template:include>
