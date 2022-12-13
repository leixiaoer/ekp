<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.common.forms.IExtendForm" %>
<%@page import="org.apache.commons.beanutils.PropertyUtils"%>
<c:set var="sysWfBusinessForm" value="${requestScope[param.formName]}" />
<c:set var="lbpmProcessForm" value="${sysWfBusinessForm.sysWfBusinessForm.internalForm}" />

<%
String formBeanName = request.getParameter("formName");
String mainFormName = null;
String xformFormName = null;
int indexOf = formBeanName.indexOf('.');
if (indexOf > -1) {
	mainFormName = formBeanName.substring(0, indexOf);
	xformFormName = formBeanName.substring(indexOf + 1);
	pageContext.setAttribute("_formName", xformFormName);
} else {
	mainFormName = formBeanName;
	pageContext.setAttribute("_formName", null);
}

Object mainForm = request.getAttribute(mainFormName);
Object xform = xformFormName == null ? mainForm : PropertyUtils.getProperty(mainForm, xformFormName);
if(xform instanceof IExtendForm){
	IExtendForm extendForm = (IExtendForm)xform;
	String mainModelName = extendForm.getModelClass().getName();
	request.setAttribute("_mainForm", mainForm);
	request.setAttribute("_mainModelName", mainModelName);
}
%>

<!-- 多表单模式下，显示切换表单按钮 -->
<c:if test="${sysWfBusinessForm.docStatus!='10' && sysWfBusinessForm.docStatus!='11' && sysWfBusinessForm.method_GET=='view' && lbpmProcessForm.showSubBut}">
	<ui:button id="switchForm" parentId="toolbar" text="${ lfn:message('sys-lbpmservice:lbpmNode.subForm.switchForm') }" order="1" onclick="Subform_switchForm();"></ui:button>
</c:if>

<script type="text/javascript">
//切换表单
function Subform_switchForm(){
	var subFormInfoObj = lbpm.subFormInfoObj;
	if(subFormInfoObj && subFormInfoObj.length>0){
		var msg = '<div style="text-align:left;">'
		var isExit = false;
		for(var i = 0;i<subFormInfoObj.length;i++){
			if(subFormInfoObj[i]["id"]=="default"){
				isExit = true;
			}
			msg += '<label><input type="radio" name="subform_other" value="'+subFormInfoObj[i]["id"] + '"'; 
			if (subFormInfoObj[i]["id"] == lbpm.nowSubFormId) {
				msg += ' checked="checked">' + subFormInfoObj[i]["name"]+'(${ lfn:message("sys-lbpmservice:lbpmNode.subform.curSubForm") })';
			} else if (subFormInfoObj[i]["task"] == "1") {
				msg += ' task="1">' + subFormInfoObj[i]["name"] + '(${ lfn:message("sys-lbpmservice:lbpmNode.subform.taskToDo") })';
			} else {
				msg += ' task="0">' + subFormInfoObj[i]["name"];
			}
			msg += '</input></label><br><br>';
		}
		if(!isExit){
			if(lbpm.nowSubFormId=="default"){
				msg += '<label><input type="radio" name="subform_other" value="default" checked="checked">${ lfn:message("sys-lbpmservice:lbpmNode.subform.defaut_form") }(${ lfn:message("sys-lbpmservice:lbpmNode.subform.curSubForm") })</input></label><br><br>';
			}else{
				msg += '<label><input type="radio" name="subform_other" value="default">${ lfn:message("sys-lbpmservice:lbpmNode.subform.defaut_form") }</input></label><br><br>';
			}
		}
		msg += '</div>';
		seajs.use( [ 'lui/jquery', 'lui/dialog' ], function($, dialog) {
			dialog.build({
				config : {
					width : 420,
					cahce : false,
					title : "${ lfn:message('sys-lbpmservice:lbpmNode.subForm.switchForm') }",
					content : {
						type : "common",
						html : msg,
						iconType : 'question',
						buttons : [ {
							name : "${lfn:message('button.ok')}",
							value : true,
							focus : true,
							fn : function(value, dialog) {
								Subform_switchForm_ok();
								dialog.hide(value);
							}
						}, {
							name : "${lfn:message('button.cancel')}",
							value : false,
							styleClass : 'lui_toolbar_btn_gray',
							fn : function(value, dialog) {
								dialog.hide(value);
							}
						} ]
					}
				}
			}).show();
		});
	}
}

function Subform_switchForm_ok(){
	var subFormCheckObj = $("input[name='subform_other']:checked");
	var subFormId = subFormCheckObj.val();
	if(lbpm.nowSubFormId == subFormId){
		return
	}
	var url = window.location.href;
	url = Com_SetUrlParameter(url, "s_xform", subFormId);
	if (lbpm.nowSubFormId == subFormId || subFormCheckObj.attr("task") == "1") {
		setTimeout(function(){
			window.location.href = url;
		},200);
	} else {
		setTimeout(function(){
			window.open(url);
		},200);
	}
}

//多表单模式下是否开启打印模板，缓存到页面，以免每次点击打印按钮都调用后台去查
var subform_isCanPrint = '';

//打印
function subform_print_BySubformId(url){
	var subFormInfoObj = lbpm.subFormInfoObj;
	if(subFormInfoObj && subFormInfoObj.length>0){
		var printIds = [];
		var printNames = [];
		var nodes = [];
		for(var i = 0;i<subFormInfoObj.length;i++){
			if(subFormInfoObj[i]["id"]==lbpm.nowSubFormId){
				nodes = subFormInfoObj[i]["nodes"];
			}
		}
		if(nodes.length>0){
			for(var j = 0;j<nodes.length;j++){
				if(printIds.join(",").indexOf(nodes[j]["subFormPrintId"])<0){
					printIds.push(nodes[j]["subFormPrintId"]);
					printNames.push(nodes[j]["subFormPrintName"]);
				}
			}
		}
		var isExit = false;
		if(printIds.length==0 || (printIds.length==1 && printIds[0]=="default")){
			subform_print_default(url);
		}else{
			if(!subform_isCanPrint){
				var checkUrl = Com_Parameter.ContextPath + "sys/lbpmservice/support/lbpmSubFormAction.do?method=checkIsCanPrint";
				var data = {"modelId":"${_mainForm.fdId}","modelName":"${_mainModelName}"};
				$.ajax({
					type : "POST",
					data : data,
					url : checkUrl,
					async : false,
					success : function(json){
						if(json){
							subform_isCanPrint = json;
						}
					}
				});
			}
			if(subform_isCanPrint == "true"){
				var msg = '<div style="text-align:left;">';
				for(var k=0;k<printIds.length;k++){
					if(printIds[k]=="default"){
						isExit = true;
					}
					msg += '<label><input type="radio" name="switch_print" value="'+printIds[k] + '"';
					if(k==0){
						msg += ' checked="checked">';
					}else{
						msg += '>';
					}
					msg += printNames[k]+'</input></label><br><br>';
				}
				if(!isExit){
					msg += '<label><input type="radio" name="switch_print" value="default">${ lfn:message("sys-lbpmservice:lbpmNode.subform.default_print_form") }</input></label><br><br>';
				}
				msg += '</div>';
				seajs.use( [ 'lui/jquery', 'lui/dialog' ], function($, dialog) {
					dialog.build({
						config : {
							width : 420,
							cahce : false,
							title : "${ lfn:message('sys-lbpmservice:lbpmNode.subForm.switchPrint') }",
							content : {
								type : "common",
								html : msg,
								iconType : 'question',
								buttons : [ {
									name : "${lfn:message('button.ok')}",
									value : true,
									focus : true,
									fn : function(value, dialog) {
										subform_switchPrint_ok(url);
										dialog.hide(value);
									}
								}, {
									name : "${lfn:message('button.cancel')}",
									value : false,
									styleClass : 'lui_toolbar_btn_gray',
									fn : function(value, dialog) {
										dialog.hide(value);
									}
								} ]
							}
						}
					}).show();
				});
			}else{
				subform_print_default(url);
			}
		}
	}else{
		subform_print_default(url);
	}
}

function subform_print_default(url){
	if(lbpm.subFormInfoObj && lbpm.subFormInfoObj.length>0 && lbpm.nowSubFormId){
		if(!(lbpm.subFormInfoObj.length==1 && lbpm.subFormInfoObj[0]["id"]=="default")){
			url = Com_SetUrlParameter(url, "s_xform", lbpm.nowSubFormId);
		}
	}
	Com_OpenWindow(url);
}

function subform_switchPrint_ok(url){
	var subPrintCheckObj = $("input[name='switch_print']:checked");
	url = Com_SetUrlParameter(url, "s_print", subPrintCheckObj.val());
	url = Com_SetUrlParameter(url, "s_xform", lbpm.nowSubFormId);
	Com_OpenWindow(url);
}

//编辑
function subform_edit_BySubformId(url,target){
	if(!target){
		target = "_self";
	}
	if(lbpm.subFormInfoObj && lbpm.subFormInfoObj.length>0 && lbpm.nowSubFormId){
		if(!(lbpm.subFormInfoObj.length==1 && lbpm.subFormInfoObj[0]["id"]=="default")){
			url = Com_SetUrlParameter(url, "s_xform", lbpm.nowSubFormId);
		}
	}
	Com_OpenWindow(url,target);
}
</script>

<%
pageContext.removeAttribute("_formName");
if(xform instanceof IExtendForm){
	request.removeAttribute("_mainForm");
	request.removeAttribute("_mainModelName");
}
%>