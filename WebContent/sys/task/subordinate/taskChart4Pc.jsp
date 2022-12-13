<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
<template:replace name="body">
<link rel="stylesheet" type="text/css" href="${ KMSS_Parameter_ContextPath}sys/task/css/orgChart.css?s_cache=${LUI_Cache}">

<script type="text/javascript">
	window.openTaskUrl = "${LUI_ContextPath}/sys/subordinate/sysSubordinate.do?method=view&modelName=com.landray.kmss.sys.task.model.SysTaskMain&orgId=${JsParam.orgId}&modelId=";
	window.authCheck = function(taskId, callback) {
		seajs.use(['lui/jquery','lui/dialog'], function($, dialog) {
			// 校验权限
			$.ajax({
		    	type: "post",
		        url: "${LUI_ContextPath}/sys/subordinate/sysSubordinate.do?method=checkAuth",
		        dataType: "json",
		        data: { modelId: taskId, modelName: "com.landray.kmss.sys.task.model.SysTaskMain" },
		        success: function (data) {
		        	if(data.check) {
		        		callback(true);
					} else {
						dialog.alert('<bean:message key="global.accessDenied"/>');
						callback(false);
					}
		        },
		        error: function(res) {
		        	dialog.alert(res.responseJSON.message[0].msg);
		        	callback(false);
		        }
		    });
		});
	}
</script>
<%@ include file="/sys/task/import/taskChart.jsp"%>
<table width=100% style="table-layout: fixed" >
	<tr>
		<td>
			<%--任务分解图/责任分解图选项--%>
			<div style="float: left;margin: 10px;" class="scaleDiv">
				 <img src="${LUI_ContextPath}/sys/task/images/showBig.png" style=" cursor:pointer;  " onclick="ShowBig()">
	             <img src="${LUI_ContextPath}/sys/task/images/showSmall.png" style=" cursor:pointer; " onclick="ShowSmall()">
	             <div style="display: inline-block;vertical-align: top">	
	            	展开层级：
	             	<select id="select_Arrow" onchange="selectChange(this)"  style="width:100px;"></select>
	             </div>	
			</div>
			<div style="float: right;margin: 10px;" class="statusDiv">
				<img src="../images/STATUS_INACTIVE.png" title="<bean:message bundle="sys-task" key = "sysTaskMain.status.inactive"/>"/><bean:message bundle="sys-task" key = "sysTaskMain.status.inactive"/>
				<img src="../images/STATUS_PROGRESS.png" title="<bean:message bundle="sys-task" key = "sysTaskMain.status.progress"/>"/><bean:message bundle="sys-task" key = "sysTaskMain.status.progress"/>
				<img src="../images/STATUS_COMPLETE.png" title="<bean:message bundle="sys-task" key = "sysTaskMain.status.complete"/>"/><bean:message bundle="sys-task" key = "sysTaskMain.status.complete"/>
				<img src="../images/STATUS_OVERRULE.png" title="<bean:message bundle="sys-task" key = "sysTaskMain.status.overrule"/>"/><bean:message bundle="sys-task" key = "sysTaskMain.status.overrule"/>
				<img src="../images/STATUS_TERMINATE.png" title="<bean:message bundle="sys-task" key = "sysTaskMain.status.terminate"/>"/><bean:message bundle="sys-task" key = "sysTaskMain.status.terminate"/>
				<img src="../images/STATUS_CLOSE.png" title="<bean:message bundle="sys-task" key = "sysTaskMain.status.close"/>"/><bean:message bundle="sys-task" key = "sysTaskMain.status.close"/>
				<select id="select_type" onchange="swapProcess(this)">
					<option value="task" selected><bean:message bundle="sys-task" key = "sysTaskMain.processIco.task"/></option>
					<option value="person"><bean:message bundle="sys-task" key = "sysTaskMain.processIco.person"/></option>
				</select>
			</div>
		</td>	
	</tr>
	<tr>
		<td>
			<center>
				<div id="worldMap">
					<div id="lefttask" style="display: none;"><ul id="task"></ul></div>
					<div id="leftperson" style="display: none;"><ul id="person"></ul></div>
					<div id="leftweights" style="display: none;"><ul id="weights"></ul></div>
					<div id="main"></div>
				</div>
			</center>
		</td>
		<script>
			seajs.use(['lui/jquery','${LUI_ContextPath}/sys/task/js/jquery.orgchart.js'],function($,orgchart){
				orgchart($);
				
				$(document).ready(function(){
					var fdId = '${param.fdId}';
					var ajaxUrl = '<c:url value="/sys/subordinate/sysSubordinate.do?method=data&modelName=${JsParam.modelName}&orgId=${JsParam.orgId}&operType=taskChart"/>';
					GetOrgChartAjax(fdId, ajaxUrl,0.9);
				});
			});
		</script>
	</tr>
</table>	
</template:replace> 
</template:include>
