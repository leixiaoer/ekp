<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.framework.plugin.core.config.IExtension"%>
<%@page import="com.landray.kmss.sys.task.util.SysTaskAnalyzeExecutorPlugin"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%
	String fdType=(String)request.getParameter("type");
	IExtension ext=SysTaskAnalyzeExecutorPlugin.getExtensionForStat(fdType);
	if(ext!=null){
		if(StringUtil.isNotNull(SysTaskAnalyzeExecutorPlugin.getConditionJsp(ext))){
			request.setAttribute("conditionUrl", SysTaskAnalyzeExecutorPlugin.getConditionJsp(ext));
		}
		if(StringUtil.isNotNull(SysTaskAnalyzeExecutorPlugin.getExtJs(ext))){
			request.setAttribute("extJs", SysTaskAnalyzeExecutorPlugin.getExtJs(ext));
		}
	}
%>
<template:include ref="default.edit" showQrcode="false" sidebar="no">
	<%--标签页标题--%>
	<template:replace name="title">
		<c:choose>
			<c:when test="${ sysTaskAnalyzeForm.method_GET == 'add' }">
				<c:out value="新建分析 - ${ lfn:message('sys-task:module.sys.task') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${sysTaskAnalyzeForm.docSubject} - ${ lfn:message('sys-task:module.sys.task') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="head">
		<script language="JavaScript">
			Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp|xform.js|jquery.js|dialog.js|calendar.js", null, "js");
			seajs.use("${LUI_ContextPath}/sys/task/sys_task_analyze/resource/css/stat.css");
			seajs.use(["${LUI_ContextPath}/sys/task/sys_task_analyze/resource/js/stat.js"],function(stat){
				window.stat = stat;
			});
			LUI.ready(function(){
				$("#div_condtionSection").attr("isShow","0");
				window.stat.expandDiv($("#div_condtionArea .div_titleArea"),'div_condtionSection');
			});
		</script>
	</template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
				<ui:button text="${lfn:message('sys-task:sysTaskAnalyze.opt.saveAndView')}" 
					onclick="submitMethod(document.sysTaskAnalyzeForm, 'save');">
				</ui:button>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	<%--导航路径--%>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('sys-task:module.sys.task') }" >
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('sys-task:table.sysTaskAnalyze') }" >
			</ui:menu-item>
		</ui:menu>
	</template:replace>	
	
	<%--任务分析表单--%>
	<template:replace name="content"> 
		<script type="text/javascript">
			Com_IncludeFile("dialog.js");
			seajs.use(['lui/jquery','lui/dialog'], function($,dialog) {
				$(function(){
					//切换
					$('[name="fdAnalyzeObjType"]').change(function(){
						/* var addressContainer = $('[name="fdBoundIds"]').parent();
							fdAnalyzeObjType=$('[name="fdAnalyzeObjType"]:checked');
						var type ="${JsParam.type}";
						if(addressContainer.length > 0){
							addressContainer.unbind('click');
							addressContainer.removeAttr('onclick');
							if(fdAnalyzeObjType.val() == '1'){
								addressContainer.click(function(e){
									e.stopPropagation();
									if(type == '5'){
										Dialog_Address(false,'fdBoundIds','fdBoundNames',';',ORG_TYPE_DEPT|ORG_TYPE_ORG);
									}else{
										Dialog_Address(true,'fdBoundIds','fdBoundNames',';',ORG_TYPE_DEPT|ORG_TYPE_ORG);
									}
								});
								$('#childrow').show();
								
							}else if(fdAnalyzeObjType.val() == '2'){
								addressContainer.click(function(e){
									e.stopPropagation();
									if(type == '5'){
										Dialog_Address(false,'fdBoundIds','fdBoundNames',';',ORG_TYPE_PERSON);
									}else{
										Dialog_Address(true,'fdBoundIds','fdBoundNames',';',ORG_TYPE_PERSON);
									}
									
								});
								
								$('#childrow').hide();
							}
							$('[name="fdBoundIds"]').val('');
							$('[name="fdBoundNames"]').val('');
						} */
						var addressContainer = $('[name="fdBoundIds"]').parent();
						fdAnalyzeObjType=$('[name="fdAnalyzeObjType"]:checked');
						var type ="${JsParam.type}";
						var isMulti=false,propertyId='fdBoundIds',propertyName='fdBoundNames',splitStr=';',orgType=ORG_TYPE_PERSON;
						if(addressContainer.length > 0){
							addressContainer.find('.orgelement').attr('onclick','');
							if(fdAnalyzeObjType.val() == '1'){
								isMulti = !(type == '5');
								orgType = ORG_TYPE_DEPT|ORG_TYPE_ORG;
								$('#childrow').show();
								
							}else if(fdAnalyzeObjType.val() == '2'){
								isMulti = !(type == '5');
								orgType = ORG_TYPE_PERSON;
								$('#childrow').hide();
							}
							var clickEvt = "Dialog_Address("+isMulti+",'"+propertyId+"','"+propertyName+"','"+splitStr+"',"+orgType+")";
							addressContainer.find('.orgelement').attr('onclick',clickEvt);
							var address = Address_GetAddressObj(propertyName);
							address.reset(splitStr,orgType,isMulti,[]);
						}
					});
					
				});
				
				window.validateFormData = function(){
					var flag = true;
					var analyzeStartDate = document.getElementsByName("fdStartDate")[0].value;
					var analyzeEndDate = document.getElementsByName("fdEndDate")[0].value;
					var dateQueryTypeList = document.getElementsByName("fdDateQueryType");
					var timeType = $("input[name='fdDateType']:checked").val();
					if (timeType == '7') {
						if(Com_GetDate(analyzeStartDate).getTime() > Com_GetDate(analyzeEndDate).getTime()){
							dialog.alert('${lfn:message("sys-task:sysTaskAnalyze.compareTime.tip")}');
							flag = false;
						}
					} else {
						if(analyzeStartDate > analyzeEndDate){
							dialog.alert('${lfn:message("sys-task:sysTaskAnalyze.compareTime.tip")}');
							flag = false;
						}
					}
					if(analyzeStartDate != undefined || analyzeEndDate != undefined) {
						if(dateQueryTypeList[0].value == ""){
							dialog.alert("<bean:message bundle='sys-task' key='sysTaskAnalyze.dateQueryType.message'/>");
							flag = false;
						}
					}
					return flag;
				};
				
				window.previewFn =  function(){
					if(validateFormData()){
						window.stat.statExecutor();
					}
				};
				
				window.submitMethod = function(form,method){
					if(validateFormData()){
						Com_Submit(form, method);
					}
				};
			});
		</script>
		<html:form action="/sys/task/sys_task_analyze/sysTaskAnalyze.do">
			<html:hidden property="fdId"/>
			<html:hidden property="method_GET"/>
			<p class="lui_form_subject">
				<bean:message key="sys-task:sysTaskAnalyze.type.${JsParam.type}"/>
			</p>
			<div class="lui_form_content_frame" style="padding-top:20px">
				<%--条件筛选--%>	
				<div id="div_condtionArea">
					<div class="div_section">
						<div class="div_line"></div>
						<div class="div_titleArea"  onclick="window.stat.expandDiv(this,'div_condtionSection');">
							${lfn:message('sys-task:sysTaskAnalyze.title.condition') }
							<span class="div_icon_coll"></span>
						</div>
					</div>	
					<c:import url="${conditionUrl}" charEncoding="UTF-8">
						<c:param name="fdType" value="${JsParam.type}"/>
						<c:param name="formName" value="sysTaskAnalyzeForm"/>
						<c:param name="mode" value="edit"></c:param>
					</c:import>
				</div>
				<div id="div_previewArea">
					<ui:button text="${lfn:message('sys-task:sysTaskAnalyze.stat.section.preview')}" onclick="previewFn();"></ui:button>
				</div>
				<div id="div_chartArea">
					<div class="div_section">
						<div class="div_line"></div>
						<div class="div_titleArea" onclick="window.stat.expandDiv(this,'div_reportSection');">
							${lfn:message('sys-task:sysTaskAnalyze.stat.section.result')}
							<span class="div_icon_exp"></span>
						</div>
					</div>
					<div id="div_reportSection">
						<div id="div_chartSection">
							<%--echart图表--%>
							<ui:chart height="500px" width="1100px;" id="sysTaskStatChart">
			  					<ui:source type="AjaxJson">
									{"url":""}
			  					</ui:source>
							</ui:chart>
						</div>
						<div id="div_listSection">
							<div id="div_list" class="div_list"></div>
						</div>
					</div>
				</div>
			</div>
		</html:form>
		<script type="text/javascript">
			Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp|eventbus.js|xform.js",null,"js");
		</script>
		<script type="text/javascript">
		var statValidation  = $KMSSValidation();//加载校验框架
		</script>
	</template:replace>
	
</template:include>