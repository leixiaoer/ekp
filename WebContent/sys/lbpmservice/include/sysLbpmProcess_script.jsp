<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.lbpm.engine.manager.node.NodeDescTypeManager" %>
<%@ page import="com.landray.kmss.sys.lbpm.engine.manager.node.NodeTypeManager" %>
<%@ page import="com.landray.kmss.sys.lbpm.engine.manager.node.NodeType" %>
<%@ page import="com.landray.kmss.sys.lbpm.engine.manager.node.NodeDescType" %>
<%@ page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@ page import="java.util.*" %>
<c:set var="modelClassName" value="${sysWfBusinessForm.sysWfBusinessForm.fdModelName}" />
<c:set var="modeId" value="${sysWfBusinessForm.fdId}" />
<script type="text/javascript">	
Com_IncludeFile("jquery.js|json2.js");
Com_IncludeFile("docutil.js|optbar.js|validator.jsp|validation.js|plugin.js|validation.jsp|xform.js|data.js", null, "js");
Com_IncludeFile("dialog.js");
</script>
<link rel="stylesheet" type="text/css" href="<c:url value="/sys/lbpmservice/resource/jNotify.jquery.css?s_cache=${LUI_Cache}"/>" media="screen" />
<script type="text/javascript" src="<c:url value="/sys/lbpmservice/resource/jNotify.jquery.js?s_cache=${LUI_Cache}"/>"></script>
<%@ include file="/sys/lbpmservice/include/sysLbpmProcessConstant.jsp"%>
<script type="text/javascript">
var Lbpm_SettingInfo = lbpm.settingInfo = new KMSSData().AddBeanData("lbpmSettingInfoService").GetHashMapArray()[0]; //统一在此获取流程默认值与功能开关等配置
</script>
<script src="<c:url value="/sys/lbpm/flowchart/js/workflow.js?s_cache=${LUI_Cache}"/>"></script>
<script src="<c:url value="/sys/lbpmservice/include/syslbpmprocess.js?s_cache=${LUI_Cache}"/>"></script>
<script src="<c:url value="/sys/lbpmservice/resource/address_builder.js?s_cache=${LUI_Cache}"/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/sys/lbpmservice/resource/review.css?s_cache=${LUI_Cache}"/>" />
<c:forEach items="${lbpmProcessForm.curNodesReviewJs}" var="reviewJs"
			varStatus="vstatus">
	<c:import url="${reviewJs}" charEncoding="UTF-8" />
</c:forEach>
<c:forEach items="${lbpmProcessForm.curTasksReviewJs}" var="reviewJs"
			varStatus="vstatus">
	<c:import url="${reviewJs}" charEncoding="UTF-8" />
</c:forEach>
<script type="text/javascript">	
	lbpm.drafterOperationsReviewJs=new Array();
	lbpm.adminOperationsReviewJs=new Array();
	lbpm.historyhandlerOperationsReviewJs=new Array();
	<c:forEach items="${lbpmProcessForm.curDrafterOperationsReviewJs}" var="reviewJs" varStatus="vstatus">
		lbpm.drafterOperationsReviewJs.push("${reviewJs}");
	</c:forEach>
	<c:forEach items="${lbpmProcessForm.curAdminOperationsReviewJs}" var="reviewJs" varStatus="vstatus">
		lbpm.adminOperationsReviewJs.push("${reviewJs}");
	</c:forEach>
	<c:forEach items="${lbpmProcessForm.curHistoryhandlerOperationsReviewJs}" var="reviewJs" varStatus="vstatus">
		lbpm.historyhandlerOperationsReviewJs.push("${reviewJs}");
	</c:forEach>
	lbpm.myAddedNodes=new Array();
</script>

<link rel="stylesheet" type="text/css" href="<c:url value="/component/locker/resource/jNotify.jquery.css"/>" media="screen" />
<script type="text/javascript" src="<c:url value="/component/locker/resource/jNotify.jquery.js"/>"></script>

<script type="text/javascript">	
	lbpm.load_Frame=function(){
		// 审批日志
		lbpm.globals.load_Frame('historyInfoTableTD', '<c:url value="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote.do?method=listNote" />'
			+'&fdModelId=${sysWfBusinessForm.fdId}&fdModelName=${modelClassName}&formBeanName=${(not empty JsParam.formName) ? (JsParam.formName) : formName}'
			+'&showPersonal=true&approveType=${param.approveType}');
	};
	lbpm.flow_chart_load_Frame=function(){
		
		if (lbpm.isFreeFlow) {//自由流
			
			//IE8浏览器自由流有问题，提示警告，
		    var DEFAULT_VERSION = 8.0;  
		    var ua = navigator.userAgent.toLowerCase();  
		    var isIE = ua.indexOf("msie")>-1;  
		    var safariVersion;  
		    if(isIE){  
		   	 safariVersion =  ua.match(/msie ([\d.]+)/)[1];  
		    }  
		    if(safariVersion <= DEFAULT_VERSION ){  
		    	jNotify("${ lfn:message('sys-lbpmservice:sysProcess.freeFlow.flowChart.warning') }", {
					TimeShown: 50000,
					autoHide:false,
					VerticalPosition: 'top',
					HorizontalPosition:'right',
					ShowOverlay: false
				});
		    }; 
		    
		    
			if(!($("#workflowInfoTD").closest("div").hasClass("process_body_checked_false")||
					$("#workflowInfoTD").closest("div").hasClass("process_body_checked_true"))){
				$("#workflowInfoTD").closest("div").addClass("process_body_checked_false");
			}
		
			if (lbpm.nowProcessorInfoObj) {
				if (!$("#WF_IFrame").attr('src')) {
					var fdIsModify=$("input[name='sysWfBusinessForm.fdIsModify']")[0];
					if(fdIsModify==null || fdIsModify.value!="1"){
						var processXml = lbpm.globals.getProcessXmlString();
						document.getElementsByName("sysWfBusinessForm.fdFlowContent")[0].value = processXml;
					}
				}
			}
			var url = '<c:url value="/sys/lbpm/flowchart/page/freeflowPanel.jsp">'
						+'<c:param name="edit" value="true" />'
						+'<c:param name="extend" value="oa" />'
						+'<c:param name="template" value="false" />'
						+'<c:param name="contentField" value="sysWfBusinessForm.fdFlowContent" />'
						+'<c:param name="statusField" value="sysWfBusinessForm.fdTranProcessXML" />'
						+'<c:param name="modelName" value="${modelClassName}" />'
						+'<c:param name="modelId" value="${sysWfBusinessForm.fdId}" />'
						+'<c:param name="hasParentProcess" value="${lbpmProcessForm.hasParentProcess}" />'
						+'<c:param name="hasSubProcesses" value="${lbpmProcessForm.hasSubProcesses}" />'
						+'<c:param name="showBar" value="true" />'
						+'<c:param name="isNotShowBar" value="true" />' //去掉保存按钮
						+'<c:param name="freeflowPanelImg" value="true" />' //显示自由流流程图，add 2020-3-1
						+'<c:param name="flowType" value="1" />'
						+'<c:param name="deployApproval" value="0" />'
					+'</c:url>';
			url+="&flowPopedom="+lbpm.nowNodeFlowPopedom;
			lbpm.globals.load_Frame('workflowInfoTD', url);
			$('#flowGraphicTemp').hide();
			$('#flowNodeDIV').show();
		} else {
			lbpm.globals.load_Frame('workflowInfoTD', '<c:url value="/sys/lbpm/flowchart/page/panel.html">'
					+'<c:param name="edit" value="false" />'
					+'<c:param name="extend" value="oa" />'
					+'<c:param name="template" value="false" />'
					+'<c:param name="contentField" value="sysWfBusinessForm.fdFlowContent" />'
					+'<c:param name="statusField" value="sysWfBusinessForm.fdTranProcessXML" />'
					+'<c:param name="modelName" value="${modelClassName}" />'
					+'<c:param name="modelId" value="${sysWfBusinessForm.fdId}" />'
					+'<c:param name="hasParentProcess" value="${lbpmProcessForm.hasParentProcess}" />'
					+'<c:param name="hasSubProcesses" value="${lbpmProcessForm.hasSubProcesses}" />'
					+'<c:param name="modelingModelId" value="${modelingAppModelMainForm.fdModelId}" />'
				+'</c:url>');
		}
		lbpm.globals.flowChartLoaded = true;
	};
	lbpm.flow_table_load_Frame=function(){
		lbpm.globals.load_Frame('workflowTableTD', '<c:url value="/sys/lbpmservice/include/sysLbpmTable_view.jsp" />'
			+'?edit=false&extend=oa&template=false&contentField=sysWfBusinessForm.fdFlowContent&statusField=sysWfBusinessForm.fdTranProcessXML'
			+'&modelName=${modelClassName}&modelId=${sysWfBusinessForm.fdId}&IdPre=${sysWfBusinessFormPrefix}&fdKey=${JsParam.fdKey}');
	};
	lbpm.flow_log_load_Frame=function(){
		lbpm.globals.load_Frame('flowLogTableTD', '<c:url value="/sys/lbpmservice/support/lbpm_audit_note_ui/lbpmAuditNote_flowLog_index.jsp" />'
			+'?fdModelId=${sysWfBusinessForm.fdId}&fdModelName=${modelClassName}');
	};	
	
	lbpm.process_status_load_Frame=function(){
		lbpm.globals.load_Frame('processStatusTD', '<c:url value="/sys/lbpmservice/support/lbpm_process_status/index.jsp" />'
			+'?fdModelId=${sysWfBusinessForm.fdId}&fdModelName=${modelClassName}');
	};
	lbpm.process_restart_Log_Frame=function(){
		lbpm.globals.load_Frame('lbpmProcessRestartLogTD', '<c:url value="/sys/lbpmservice/support/lbpm_process_restart_log/lbpmProcessRestartLog_index.jsp" />'
			+'?fdModelId=${sysWfBusinessForm.fdId}&fdModelName=${modelClassName}');
	};
	
	if(window.seajs){
		seajs.use(['lui/imageP/preview'], function(preview) {
			window.previewImage = preview;
		});
	};
	
	var lbpmPinArray = [];
	
	//判断是否给元素绑定了卡片弹出框
	___hasLbpmPin = function(curObj){
		var isBind = false;
		for(var i=0; i<lbpmPinArray.length; i++){
			if(lbpmPinArray[i] && lbpmPinArray[i].obj == curObj){
				isBind = true;
				break;
			}
		}
		return isBind;
	};
	
	lbpm.person = function(event, element, type){
		seajs.use(['lui/jquery','lui/parser','lui/pinwheel'],function($,parser,p){
			p($,parser);
			if(!___hasLbpmPin(element)){
				lbpmPinArray.push({obj:element});
				if(type=="historyInfoTableIframe"){
					if($(element).parents("div#auditNoteTable").length>0){
						type="auditNoteRight";
					}
					//审批记录内的个人卡片弹出框
					$(element).pinwheel({"top":$(element).offset().top + $("#"+type).offset().top, "left":$(element).offset().left + $("#"+type).offset().left});
				}else if(type=="flowNodeUL"){
					//自由流个人卡片弹出框
					$(element).pinwheel({"top":$(element).offset().top, "left":$(element).offset().left});
				}
			}
		});
	};
	
</script>
<c:if test="${lbpmProcessForm.fdTemplateType=='4'}">
<script src="<c:url value="/sys/lbpmservice/include/syslbpmprocess_freeflow.js?s_cache=${LUI_Cache}"/>"></script>
</c:if>
<c:if test="${lbpmProcessForm.fdIsError == 'true'}">
<%
com.landray.kmss.sys.lbpmservice.support.service.spring.ErrorQueueDataBean errorDataBean = 
	(com.landray.kmss.sys.lbpmservice.support.service.spring.ErrorQueueDataBean) SpringBeanUtil.getBean("lbpmErrorQueueDataBean");
Object msg = errorDataBean.getErrorJsonData((String) pageContext.getAttribute("modeId"));
Object nameInfo = errorDataBean.getAdminNameJsonData((String) pageContext.getAttribute("modeId"));
%>
<script>
$(document).ready(function() {
	var get_node_txt = function(nodeId) {
		var n = lbpm.nodes[nodeId];
		return (n ? (n.id + "." + n.name) : "");
	};
	lbpm.globals.isError = true;
	var nameInfo = <%=nameInfo%>;
	var tmpNotify = '<kmss:message key="sys-lbpm-engine:lbpm.process.exception.notify.all" />';
	var notifyText = tmpNotify.replace("{admin}", nameInfo[0].adminName);
	jError(notifyText, {
		TimeShown: 8000,
		VerticalPosition: 'top',
		HorizontalPosition: 'right',
		ShowOverlay: false
	});
	var tmpFull = '<kmss:message key="sys-lbpm-engine:lbpm.process.exception.notify.full" />';
	var tmpMsg = '<kmss:message key="sys-lbpm-engine:lbpm.process.exception.notify.msg" />';
	var tmpDef = '<kmss:message key="sys-lbpm-engine:lbpm.process.exception.notify.def" />';
	var msg = <%=msg%>;
	var text = [];
	$.each(msg, function(index, row) {
		var errorNode = get_node_txt(row['errorId']);
		var errorType = row['errorType'];
		var errorMsg = row['errorMessage'];
		var errorText = null;
		if (errorType != null && errorType != '' && errorMsg != null && errorMsg != '') {
			errorText = tmpFull.replace("{node}", errorNode).replace("{type}", errorType).replace("{msg}", errorMsg);
		}
		else if (errorMsg != null && errorMsg != '') {
			errorText = (tmpMsg.replace("{node}", errorNode).replace("{msg}", errorMsg));
		}
		else {
			errorText = (tmpDef.replace("{node}", errorNode));
		}
		row['errorText'] = errorText;
		row['errorNodeName'] = errorNode;
		row['sourceNodeName'] = get_node_txt(row['sourceId']);

		var tmp = '<kmss:message key="sys-lbpmservice-operation-admin:lbpmOperations.fdOperType.processor.retry.queueTemp" />';
		tmp = tmp.replace('{user}', row['user']).replace('{node}', row['sourceNodeName']).replace('{opr}', row['operationName']);
		//text.push(tmp + ", " + errorText);
		row['errorOperText'] = tmp;
		text.push(errorText);
	});
	$("#currentHandlersLabel").after("<div class='lbpm_error_info_div'><div class='lbpm_error_detail_div'></div><div style='text-align: right;color:#2f84fb'><span class='lui-lbpm-more lookMore'><bean:message bundle='sys-lbpmservice' key='lbpmRight.lookmore' /></span><span class='lui-lbpm-moreFold'><bean:message bundle='sys-lbpmservice' key='lbpmRight.close' /></span></div></div>");
	$(".lbpm_error_info_div .lbpm_error_detail_div").text(text.join(""));
	
	// 流程出错提示
	$('.lbpm_error_info_div .lui-lbpm-more').click(function(){
		$('.lbpm_error_info_div .lbpm_error_detail_div').css({
			"max-height":"none",
		})
		$(this).removeClass('lookMore').next().addClass('lookMore')
	})
	$('.lbpm_error_info_div .lui-lbpm-moreFold').click(function(){
		$('.lbpm_error_info_div .lbpm_error_detail_div').css({
			"max-height":"42px",
		})
		$(this).removeClass('lookMore').prev().addClass('lookMore')
	})
	lbpm.globals.errorMessages = msg;
	LUI.ready(function(){
		 setTimeout(function(){
				//流程出错的提示
				 if($('.lbpm_error_info_div .lbpm_error_detail_div').height()<42){ 
			    	$('.lbpm_error_info_div .lui-lbpm-more').removeClass('lookMore');
				 }
			},0)  
	})
	 
	
});
</script>
</c:if>
<c:if test="${sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30'}">
<%
com.landray.kmss.sys.lbpmservice.node.checknode.CheckNodeMsgDataBean msgDataBean = 
(com.landray.kmss.sys.lbpmservice.node.checknode.CheckNodeMsgDataBean) SpringBeanUtil.getBean("lbpmcheckNodeMsgDataBean");
Object msgCheckNode=msgDataBean.getMsgJsonData((String) pageContext.getAttribute("modeId"));
%>
<script>
$(document).ready(function() {
	var checkNodeMsg=<%=msgCheckNode%>;
	if(checkNodeMsg["msg"]){
		var html = '<div class="lbpm_msg_info_div"></div>';
		if(lbpm.approveType){
			html = '<div class="lui-lbpm-warning-tips">';
			html +='  <div class="lui-lbpm-warning-tips-iocn"></div>';
			html +='  <label class="lui-lbpm-warning-tips-text"></label>';
			html +='</div>';
		}
		$("#currentHandlersLabel").after(html);
		if(lbpm.approveType){
			$(".lui-lbpm-warning-tips-text").text(checkNodeMsg["msg"]);
		}else{
			$(".lbpm_msg_info_div").text(checkNodeMsg["msg"]);
		}
	}
});
</script>
</c:if>
<c:if test="${(sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30') || sysWfBusinessForm.docStatus == '11'}">
<script>
$(document).ready(function() {
	new KMSSData().SendToBean("flowQueueLock&processId=" + lbpm.globals.getWfBusinessFormModelId(), function(rtnData){
		if(!rtnData){
			return;
		}
		if(rtnData.GetHashMapArray()[0] && rtnData.GetHashMapArray()[0].key0 == "true") {
			jNotify('<kmss:message key="sys-lbpm-engine:lbpm.process.running.notify.all" />', {
				TimeShown: 5000,
				VerticalPosition: 'top',
				HorizontalPosition: 'right',
				ShowOverlay: false,
				MinWidth: 300
			});
		}
	});
});
</script>
<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdIsHander == 'true'}">
<script>
$(document).ready(function() {
	if (!window.LUI) {
		return;
	}
	if ("true" != "${lbpmProcessForm.fdIsHander}") {
		return;
	}
	if ("true" == "${JsParam.isSimpleWorkflow}") {
		//return;
	}
	//简单弹出框模式和 操作按钮平铺模式不需要出现快速审批
	if(Lbpm_SettingInfo && Lbpm_SettingInfo['approveModel'] && (Lbpm_SettingInfo['approveModel']=='dialog' 
			|| Lbpm_SettingInfo['approveModel']=='tiled')){
		return;
	}
	var isRight = ${param.approveType eq 'right'};
	//右侧审批模式不需要出现快速审批
	if(isRight){
		return;
	}
	if (lbpm.nowProcessorInfoObj) {
		lbpm.globals.initShortReview('<kmss:message key="sys-lbpmservice:lbpm.operation.shortcut" />');
	}
});

$(document).ready(function() {
	function autoSaveDraftAction() {
		var oldValue = "", timer = null;
		var doSave = function() {
			try {
				$("[name='fdUsageContent']").each(function(i, fdUsageContent) {
					if (oldValue != fdUsageContent.value) {
						var defalutUsage = "";
						defalutUsage = lbpm.globals.getOperationDefaultUsage(lbpm.currentOperationType);
						if(defalutUsage != fdUsageContent.value){
							oldValue = fdUsageContent.value;
							lbpm.globals.saveDraftAction();
						}
					}
				});
			} catch (e) {}
			timer = setTimeout(doSave, 8000);
		};
		timer = setTimeout(doSave, 8000);
	}
	autoSaveDraftAction();
});

$(document).ready(function() {
	// 若当前节点的下一个节点是结束节点，流程提交后马上就要结束了，则不再加载分发操作信息行
	if (lbpm.nowNodeId && (lbpm.nodes[lbpm.nowNodeId]["canAssign"] != "true" || lbpm.nodes[lbpm.nowNodeId].endLines[0].endNode.id == "N3")) {
		return;
	}
	function loadAssignInfo() {
		// 构建分发操作信息行
		var options = {
				mulSelect : true,
				idField : 'toAssigneeIds',
				nameField : 'toAssigneeNames', 
				splitStr : ';',
				selectType : ORG_TYPE_PERSON|ORG_TYPE_POST,
				notNull : false,
				exceptValue : document.getElementById("sysWfBusinessForm.fdHandlerRoleInfoIds").value.split(';'),
				text : lbpm.constant.SELECTORG
		};
		if (lbpm.approveType == "right") {
			options["width"] = "99%";
		}
		var rowContentHtml = "";
		rowContentHtml += lbpm.address.html_build(options);
		rowContentHtml += "<label class='lui-lbpm-checkbox' style='margin-left: 5px;'>";
		rowContentHtml += "<input id='canMultiAssign' type='checkbox' key='canMultiAssign'>";
		rowContentHtml += '<span class="checkbox-label"><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle_Scope.allow.muti" />' + '<bean:message bundle="sys-lbpmservice-support" key="lbpmAssign.fdOperType.assign" /></span>';
		rowContentHtml += "</label>";
		if (lbpm.approveType == "right") {
			var oprRowHtml = '<div id="assignOprRow" lbpmmark="operation">';
			oprRowHtml += '<div class="lui-lbpm-titleNode" id="operationsTDTitle">'+'<bean:message bundle="sys-lbpmservice-support" key="lbpmAssign.fdOperType.assign" />' + '</div>';
			oprRowHtml += '<div class="lui-lbpm-detailNode" id="operationsTDContent">';
			oprRowHtml += rowContentHtml;
			oprRowHtml += '</div></div>';
			$("#operationsRow_Scope").after(oprRowHtml);
		} else {
			var oprRow = $('<tr id="assignOprRow" lbpmMark="operation"></tr>');
			var rowTitle = $('<td class="td_normal_title" width="15%">'+'<bean:message bundle="sys-lbpmservice-support" key="lbpmAssign.fdOperType.assign" />'+'</td>');
			var rowContent = $('<td>' +rowContentHtml+ '</td>');
			oprRow.append(rowTitle);
			oprRow.append(rowContent);
			$("#operationsRow_Scope").after(oprRow);
		}
	}
	if (lbpm.currentOperationType == "handler_pass") {
		loadAssignInfo();
	}
	lbpm.events.addListener(lbpm.constant.EVENT_CHANGEOPERATION, function() {
		// 当前选中的操作是通过操作时，加载分发操作信息行
		if (lbpm.currentOperationType == "handler_pass") {
			loadAssignInfo();
		}
	});
	lbpm.events.addListener(lbpm.constant.EVENT_SETOPERATIONPARAM, function() {
		// 通过操作提交时，填充分发操作信息到流程操作参数里面
		if (lbpm.currentOperationType == "handler_pass") {
			if ($("#toAssigneeIds")[0].value != "") {
				var assignParam = {};
				assignParam["toAssigneeIds"] = $("#toAssigneeIds")[0].value;
				assignParam["canMultiAssign"] = $("input[key='canMultiAssign']")[0].checked;
				lbpm.globals.setOperationParameterJson(JSON.stringify(assignParam), "assignParam", "param");
			}
		}
	});
	
});
//附件控件设置了审批人必填，仅通过操作做提示即可，转办和驳回等操作不提示必填
Com_Submit.ajaxBeforeSubmit = function modAttRequired(){
	if(typeof(Attachment_ObjectInfo) == "undefined"){
		return;
	}
	if (lbpm && lbpm.currentOperationType != "handler_pass" && lbpm.currentOperationType != "drafter_submit" && lbpm.currentOperationType != "handler_sign"){
		for(var attachment_ObjectInfo in Attachment_ObjectInfo){
			Attachment_ObjectInfo[attachment_ObjectInfo]._required = Attachment_ObjectInfo[attachment_ObjectInfo].required;
			Attachment_ObjectInfo[attachment_ObjectInfo].required = false;
		}
	}
};
//(未提交成功)还原附件控件必填属性
Com_Submit.ajaxCancelSubmit = function restoreAttRequired(){
	if(typeof(Attachment_ObjectInfo) == "undefined"){
		return;
	}
	if (lbpm && lbpm.currentOperationType != "handler_pass" && lbpm.currentOperationType != "drafter_submit" && lbpm.currentOperationType != "handler_sign"){
		for(var attachment_ObjectInfo in Attachment_ObjectInfo){
			if(Attachment_ObjectInfo[attachment_ObjectInfo]._required)
			Attachment_ObjectInfo[attachment_ObjectInfo].required = Attachment_ObjectInfo[attachment_ObjectInfo]._required;
		}
	}
};
</script>
</c:if>
<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdIsHander != 'true'}">
<%
com.landray.kmss.sys.lbpmservice.support.service.spring.LbpmAssignServiceImp assignService = 
	(com.landray.kmss.sys.lbpmservice.support.service.spring.LbpmAssignServiceImp) SpringBeanUtil.getBean("lbpmAssignService");
Object assignData = assignService.getAssignJsonData((String) pageContext.getAttribute("modeId"));
%>
	<script type="text/javascript">
	$(document).ready(function() {
		var isAssignee = false; // 是否为被分发人
		var assignData = <%=assignData%>;
		if (assignData != null && assignData.length > 0) {
			isAssignee = true;
			lbpm.nowAssignItem = assignData[0];
		} else {
			return;
		}
		// 当前用户非当前审批人且是被分发人时加载分发信息, 构建分发操作信息行
		var canAssign = (lbpm.nowAssignItem.isCanAssign == "true");
		var options = {
				mulSelect : true,
				idField : 'toAssigneeIds',
				nameField : 'toAssigneeNames', 
				splitStr : ';',
				selectType : ORG_TYPE_PERSON|ORG_TYPE_POST,
				notNull : false,
				exceptValue : document.getElementById("sysWfBusinessForm.fdHandlerRoleInfoIds").value.split(';'),
				text : lbpm.constant.SELECTORG
		};
		if (lbpm.approveType == "right") {
			options["width"] = "99%";
		}
		var rowContentHtml = "";
		rowContentHtml += '<div id="assignTypeDIV">';
		rowContentHtml += "<label style='padding-right:10px' class='lui-lbpm-radio'><input type='radio' name='assignType' value='0' onclick='document.getElementById(\"assignSelectDIV\").style.display=\"none\";' checked>"+'<span class="radio-label"><bean:message key="lbpmAssign.fdOperType.replyAssign" bundle="sys-lbpmservice-support" />'+"</span></label>";
		rowContentHtml += "<label class='lui-lbpm-radio'><input type='radio' name='assignType' value='1' onclick='document.getElementById(\"assignSelectDIV\").style.display=\"\";'>"+'<span class="radio-label"><bean:message key="lbpmAssign.fdOperType.assign" bundle="sys-lbpmservice-support" />'+"</span></label><br/>";
		rowContentHtml += '</div>';
		rowContentHtml += '<div id="assignSelectDIV" style="margin-top:3px;display:none;">';
		rowContentHtml += lbpm.address.html_build(options);
		rowContentHtml += "<label class='lui-lbpm-checkbox' style='margin-left: 5px;'>";
		rowContentHtml += "<input id='canMultiAssign' type='checkbox' key='canMultiAssign'>";
		rowContentHtml += '<span class="checkbox-label"><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle_Scope.allow.muti" />' + '<bean:message bundle="sys-lbpmservice-support" key="lbpmAssign.fdOperType.assign" /></span>';
		rowContentHtml += "</label>";
		rowContentHtml += '</div>';
		
		if (lbpm.approveType == "right") {
			var oprRowHtml = '<div id="assignOprRow"  style="'+(canAssign?'':'display:none')+'">';
			oprRowHtml += '<div class="lui-lbpm-titleNode" id="operationsTDTitle">'+'<bean:message bundle="sys-lbpmservice-support" key="lbpmAssign.fdOperType.assign" />' + '</div>';
			oprRowHtml += '<div class="lui-lbpm-detailNode" id="operationsTDContent">';
			oprRowHtml += rowContentHtml;
			oprRowHtml += '</div></div>';
			$("#operationsRow_Scope").after(oprRowHtml);
			
			// 构建分发意见行
			var opinionRowHtml = '<div id="assignOpinionRow" >';
			opinionRowHtml += '<div class="lui-lbpm-titleNode" id="operationsTDTitle">'+'<bean:message key="lbpmAssign.assignOpinion" bundle="sys-lbpmservice-support" />' + '</div>';
			opinionRowHtml += '<div class="lui-lbpm-detailNode" id="operationsTDContent">';
			rowContentHtml = '<table width=100% border=0 class="tb_noborder"><tr><td width="85%">'
	               + '<textarea name="fdAssignOpinion" class="inputMul" style="width:100%;" validate="maxLength(4000)"></textarea></td>'
	               + '<td width="15%"><input id="process_assign_button" class="process_review_button" style="margin-left: 8px;" type=button value="'+'<bean:message key="button.submit"/>'+'" onclick="lbpm.globals.assignOprOnSubmit();"/>'
	               + '</td></tr></table>';
	        opinionRowHtml += rowContentHtml;
	        opinionRowHtml += '</div></div>';
			$("#assignOprRow").after(opinionRowHtml);
			
		} else {
			var oprRow = $('<tr id="assignOprRow" style="'+(canAssign?'':'display:none')+'" lbpmMark="operation"></tr>');
			var rowTitle = $('<td class="td_normal_title" width="15%">'+'<bean:message key="lbpmAssign.assignOption" bundle="sys-lbpmservice-support" />'+'</td>');
			var rowContent = $('<td>' +rowContentHtml+ '</td>');
			oprRow.append(rowTitle);
			oprRow.append(rowContent);
			if (Lbpm_SettingInfo && (Lbpm_SettingInfo.approveModel == "dialog" || Lbpm_SettingInfo.approveModel == "tiled")) {
				$("#historyTableTR").after(oprRow);
			} else {
				$("#operationsRow_Scope").after(oprRow);
			}
			if ($("#descriptionRow")[0].style.display == "none") {
				// 构建分发意见行
				var opinionRow = $('<tr id="assignOpinionRow" lbpmMark="operation"></tr>');
				rowTitle = $('<td class="td_normal_title" width="15%">' +'<bean:message key="lbpmAssign.assignOpinion" bundle="sys-lbpmservice-support" />'+ '</td>');
				rowContentHtml = '<table width=100% border=0 class="tb_noborder"><tr><td width="85%">'
	               + '<textarea name="fdAssignOpinion" class="inputMul" style="width:100%;" validate="maxLength(4000)"></textarea></td>'
	               + '<td width="15%"><input id="process_assign_button" class="process_review_button" style="margin-left: 8px;" type=button value="'+'<bean:message key="button.submit"/>'+'" onclick="lbpm.globals.assignOprOnSubmit();"/>'
	               + '</td></tr></table>';
				rowContent = $('<td>' +rowContentHtml+ '</td>');
				opinionRow.append(rowTitle);
				opinionRow.append(rowContent);
				$("#assignOprRow").after(opinionRow);
			}
		}
	});
	
	lbpm.globals.assignOprOnSubmit = function() {
		var kmssData = new KMSSData();
		var assignFormData = [];
		assignFormData.push({"fdAssignItemId":lbpm.nowAssignItem.id});
		assignFormData.push({"fdAssignOpinion":$("textarea[name='fdAssignOpinion']")[0].value});
		if ($('input[name="assignType"]:checked').val() == "1") {
			assignFormData.push({"toAssigneeIds":$("#toAssigneeIds")[0].value});
			assignFormData.push({"fdIsCanAssign":$("input[key='canMultiAssign']")[0].checked});
		}
		kmssData.AddHashMapArray(assignFormData);
		kmssData.SendToUrl(Com_Parameter.ContextPath
				+ 'sys/lbpmservice/support/lbpm_assign/lbpmAssign.do?method=doAssign', function(request) {
			var responseText = request.responseText;
			var successOrFailure = Com_GetUrlParameter(responseText, "operationKey");
			if(successOrFailure != lbpm.constant.SUCCESS && successOrFailure != lbpm.constant.FAILURE){
				return;
			}
			var url= Com_Parameter.ContextPath+'sys/lbpmservice/support/lbpm_assign/lbpmAssign.do?method=' + successOrFailure;
			document.forms[0].action=url;
			document.forms[0].submit();
		}, true);
	};
	</script>
</c:if>
</c:if>
<script>
if (window.LUI) {
	LUI.ready(initLbpmFollow);
}else{
	$(document).ready(initLbpmFollow);
}

//判断obj是否为json对象
function isJson(obj){
	var isjson = typeof(obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !obj.length; 
	return isjson;
}

function initLbpmFollow() {
	var followOptButton = document.getElementById("followOptButton");
	var cancelFollowOptButton = document.getElementById("cancelFollowOptButton");
	
	if(followOptButton == null && cancelFollowOptButton == null){
		return;
	}
	
	/* if (lbpm.nowProcessorInfoObj) {
		return;
	} */
	
	var url = Com_Parameter.ContextPath + 'sys/lbpmservice/support/lbpm_follow/lbpmFollow.do?method=getIsFollowed';
	url += "&processId=" + $("[name='sysWfBusinessForm.fdProcessId']")[0].value;
	var kmssData = new KMSSData();
	var followInfo = {};
		
	window.lbpmFollowRecordTypeFun = function(src){
		var val = src.value;
		var nodeObjs = $("[name='node']",$(".lbpmFollow"));
		if (val === "1"){
			nodeObjs.prop("checked", false);
			nodeObjs.prop("disabled", true);
		}else{
			nodeObjs.prop("disabled", false);
		}
	};
		
	//构建跟踪节点html
	var buildReocrdHtml = function(){
		var html = [];
		var isAll = followInfo.nodeIds ? false : true;
		html.push("<div class='lbpmFollow'>");
		html.push("<div class='recordType'><label><input type='radio' onclick='lbpmFollowRecordTypeFun(this);' name='recordType' " + (isAll ? "checked='true'" : "") + " value='1'/><bean:message key='lbpmFollow.allNodes' bundle='sys-lbpmservice-support' /></label><br/>");
		html.push("<label><input type='radio'  onclick='lbpmFollowRecordTypeFun(this);' name='recordType'" + (isAll ? "" : "checked='true'") +" value='0'/><bean:message key='lbpmFollow.specifiedNode' bundle='sys-lbpmservice-support' /></label></div>");
		var nodes = lbpm.nodes;
		html.push("<div class='nodeIds'>")
		for (var key in nodes){
			
			var nodeObj = nodes[key];
			if('signNode' == nodeObj.XMLNODENAME 
					|| 'reviewNode' == nodeObj.XMLNODENAME ){
				
				html.push("<label><input type='checkBox' name='node' value='" + nodeObj.id + "'");
				if (!isAll){
					var followIdArr = followInfo.nodeIds.split(";");
					for (var i = 0; i < followIdArr.length; i++){
						var nodeId = followIdArr[i];
						if (key === nodeId){
							html.push(" checked='true'");
							break;
						}
					}
				}else{
					html.push(" disabled ");
				}
				
				var nodeLangs="";
				try{
					nodeLangs=JSON.parse(nodeObj.langs);
				}catch(e){}
				
				var nodeNameTemp="";
				if(isJson(nodeLangs)){
					try{
						var nodeNames= nodeLangs.nodeName;
						for(var z=0;z<nodeNames.length;z++){
							if(nodeNames[z].lang.toLowerCase()==Com_Parameter.Lang){
								nodeNameTemp=nodeNames[z].value;
							}
						}
					}catch(e){}
				}
				
				if(nodeNameTemp==""){
						html.push("/>" + nodeObj.name  + "</label><br/>");
				}else{
					html.push("/>" + nodeNameTemp + "</label><br/>");
				}
			}
		}
		html.push("</div>");
		html.push("</div>");
		return html.join("");
	};
	//取消跟踪
	var cancelText = '<bean:message key="lbpmFollow.button.cancelFollow" bundle="sys-lbpmservice-support" />';
	//跟踪流程
	var followText = '<bean:message key="lbpmFollow.button.follow" bundle="sys-lbpmservice-support" />';
	//取消/跟踪流程
	var followCancelText = '<bean:message key="lbpmFollow.button.followCancel" bundle="sys-lbpmservice-support" />';
	
	var followUrl = Com_Parameter.ContextPath + "sys/lbpmservice/support/lbpm_follow/lbpmFollowConfirm.jsp?isFollow=true";
	var cancelUrl = Com_Parameter.ContextPath + "sys/lbpmservice/support/lbpm_follow/lbpmFollowConfirm.jsp?isFollow=false";
	//跟踪函数
	var followFun = function(){
		if (typeof(seajs) != 'undefined'){
			seajs.use([ 'lui/dialog' ], function(dialog) {
				var config = { config : {
					width : 400,
					cahce : false,
					title : followText,
					height : 600,
					content : {
						type : "common",
						html : buildReocrdHtml(),
						iconType : '',
						buttons : [ {
							name : "${lfn:message('button.ok')}",
							value : true,
							focus : true,
							fn : function(value, dialog) {
								followCallback();
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
				}};
				
				dialog.build(config).on('show', function() {
					this.element.find(".lui_dialog_common_content_right").css("max-width","100%");
					this.element.find(".lui_dialog_common_content_right").css("margin-left","0px");
				}).show();
			});
		}else{
			var lbpmInfo = {"lbpm":lbpm,"followInfo":followInfo,"newFollow":true};
			LbpmFollow_PopupWindow(followUrl,lbpmInfo,followCallback);
		}
	};
	
	//跟踪回调
	var followCallback = function(rtnData){
		//跟踪类型 1:全部节点;0:指定节点
		var recordType = $("[name='recordType']:checked").val();
		//有返回值,说明用的是旧UI
		var oldUINodeIds;
		if (rtnData){
			var value = rtnData.GetHashMapArray()[0];
			recordType = value.recordType;
			if (!value.follow){
				return;
			}
			if (value.nodeIds){
				oldUINodeIds = value.nodeIds;
			}
		}
		//新UI可以从 $("[name='recordType']:checked").val()获取值,如果获取不到,又没有rtnData,则说明使用旧UI直接关掉了窗口导致没有返回值
		if (!recordType){
			return;
		}
		var url = Com_Parameter.ContextPath + 'sys/lbpmservice/support/lbpm_follow/lbpmFollow.do?method=recordFollow';
		url += "&processId=" + $("[name='sysWfBusinessForm.fdProcessId']")[0].value + "&modelName=" + $("[name='sysWfBusinessForm.fdModelName']")[0].value;
		url += "&recordType=" + recordType ;
		//指定节点
		var nodeIds = [];
		if (recordType === "0"){
			var nodeObjs = $("[name='node']:checked");
			nodeObjs.each(function(index,obj){
				nodeIds.push(obj.value);
			});
			url += "&nodeIds=" + (nodeIds.join(";") || (oldUINodeIds ? oldUINodeIds : ""));
		}else{
			url += "&nodeIds=";
		}
		var kmssData = new KMSSData();
		kmssData.SendToUrl(url, function(http_request) {
			var responseText = http_request.responseText;
			var json = eval("(" + responseText + ")");
			followInfo.nodeIds = json.nodeIds;
			if (json.result == "true") {
				//cancel标识是跟踪还是取消
				//isAll标识跟踪类型是全部节点还是指定节点
				if (json.isCancel === "true"){
					//显示跟踪
					lbpm.globals.hiddenObject(followOptButton, false);
					//隐藏取消
					lbpm.globals.hiddenObject(cancelFollowOptButton, true);
				}else{
					//隐藏跟踪
					lbpm.globals.hiddenObject(followOptButton, true);
					//显示取消
					lbpm.globals.hiddenObject(cancelFollowOptButton, false);
					if(json.isAll === "true"){
						//如果全部节点或者流程结束则显示"取消跟踪",
						if($("#cancelFollowOptButton")[0].tagName.toLowerCase()=="a"){
							$("#cancelFollowOptButton").text(cancelText);
						}else{
							$("#cancelFollowOptButton").attr("title",cancelText);
							var cancelFollowLUI = LUI("cancelFollowOptButton");
							if(cancelFollowLUI!=null){
								cancelFollowLUI.textContent.text(cancelText);
							}
						}
						cancelFollowOptButton.onclick = cancelFollowFun;
					}else{
						//如果指定节点则显示"跟踪/取消跟踪"
						if($("#cancelFollowOptButton")[0].tagName.toLowerCase()=="a"){
							$("#cancelFollowOptButton").text(followCancelText);
						}else{
							$("#cancelFollowOptButton").attr("title",followCancelText);
							var cancelFollowLUI = LUI("cancelFollowOptButton");
							if(cancelFollowLUI!=null){
								cancelFollowLUI.textContent.text(followCancelText);
							}
						}
						cancelFollowOptButton.onclick = followFun;
					}
				}
			}
		});
	};
	
	//旧交互跟踪函数
	var oldFollowFun = function(){
		if (typeof(seajs) != 'undefined'){
			seajs.use([ 'lui/dialog' ], function(dialog) {
				dialog.confirm('<bean:message  bundle="sys-lbpmservice-support" key="lbpmFollow.button.follow.confirm"/>',oldFollowFunCallback);
			});
		}else{
			var lbpmInfo = {"lbpm":lbpm,"followInfo":followInfo,"oldFollow":true};
			var oldFollowUrl = followUrl + "&oldFollow=true";
			LbpmFollow_PopupWindow(followUrl,lbpmInfo,oldFollowFunCallback);
		}
	};
	
	//旧交互跟踪回调
	var oldFollowFunCallback = function(rtnData){
		if(!rtnData)return;
		var flag;
		if (jQuery.type(rtnData) === "boolean"){
			flag = rtnData;
		}else{
			var value = rtnData.GetHashMapArray()[0];
			flag = value.follow;
		}
		if(flag==true){
			var url = Com_Parameter.ContextPath + 'sys/lbpmservice/support/lbpm_follow/lbpmFollow.do?method=recordFollow';
			url += "&processId=" + $("[name='sysWfBusinessForm.fdProcessId']")[0].value + "&modelName=" + $("[name='sysWfBusinessForm.fdModelName']")[0].value;
			var kmssData = new KMSSData();
			kmssData.SendToUrl(url, function(http_request) {
				var responseText = http_request.responseText;
				var json = eval("(" + responseText + ")");
				if (json.result == "true") {
					lbpm.globals.hiddenObject(followOptButton, true);
					lbpm.globals.hiddenObject(cancelFollowOptButton, false);
				}
			});
	    }else{
	    	return;
		}
	};
		
	//取消跟踪函数
	var cancelFollowFun = function(){
		if (typeof(seajs) != 'undefined'){//
			seajs.use([ 'lui/dialog' ], function(dialog) {
				dialog.confirm('<bean:message  bundle="sys-lbpmservice-support" key="lbpmFollow.button.cancelFollow.confirm"/>',cancelFollowFunCallback);
			});
		}else{
			var lbpmInfo = {"lbpm":lbpm,"followInfo":followInfo,"cancel":true};
			var winOpen = LbpmFollow_PopupWindow(cancelUrl,lbpmInfo,cancelFollowFunCallback);
		}
	};
	//取消跟踪回调
	var cancelFollowFunCallback = function(rtnData){
		if(!rtnData)return;
		var flag;
		//新UI返回boolean类型的值
		if (jQuery.type(rtnData) === "boolean"){
			flag = rtnData;
		}else{//旧UI返回kmssdialog对象
			var value = rtnData.GetHashMapArray()[0];
			flag = value.cancel;
		}
		if(flag==true){
			var url = Com_Parameter.ContextPath + 'sys/lbpmservice/support/lbpm_follow/lbpmFollow.do?method=cancelFollow';
			url += "&processId=" + $("[name='sysWfBusinessForm.fdProcessId']")[0].value;
			var kmssData = new KMSSData();
			kmssData.SendToUrl(url, function(http_request) {
				var responseText = http_request.responseText;
				var json = eval("(" + responseText + ")");
				if (json.result == "true") {
					lbpm.globals.hiddenObject(cancelFollowOptButton, true);
					lbpm.globals.hiddenObject(followOptButton, false);
				}
			});
	    }else{
	    	return;
		}
	};
			
	if(followOptButton!=null){
		//设置流程跟踪按钮
		//'<bean:message  bundle="sys-lbpmservice-support" key="lbpmFollow.button.follow.confirm"/>'
		if(window!=window.top){
			followOptButton.onclick = oldFollowFun
		}else{
			followOptButton.onclick = followFun;
		}
	}
	
	if(cancelFollowOptButton!=null){
		//设置取消跟踪按钮
		cancelFollowOptButton.onclick = cancelFollowFun;
	}
	
	kmssData.SendToUrl(url, function(http_request) {
		var responseText = http_request.responseText;
		followInfo = eval("(" + responseText + ")");
		
		if (followInfo.isFollowed == "true") {
			if (followInfo.nodeIds){
				if($("#cancelFollowOptButton")[0].tagName.toLowerCase()=="a"){
					$("#cancelFollowOptButton").text(followCancelText);
				}else{
					$("#cancelFollowOptButton").attr("title",followCancelText);
					var cancelFollowLUI = LUI("cancelFollowOptButton");
					if(cancelFollowLUI!=null){
						cancelFollowLUI.textContent.text(followCancelText);
					}
				}
				cancelFollowOptButton.onclick = followFun;
			}
			//流程是否结束,若结束显示取消跟踪
			if (followInfo.isPassed){
				if($("#cancelFollowOptButton")[0].tagName.toLowerCase()=="a"){
					$("#cancelFollowOptButton").text(cancelText);
				}else{
					$("#cancelFollowOptButton").attr("title",cancelText);
					var cancelFollowLUI = LUI("cancelFollowOptButton");
					if(cancelFollowLUI!=null){
						cancelFollowLUI.textContent.text(cancelText);
					}
				}
				cancelFollowOptButton.onclick = cancelFollowFun;
			}
			lbpm.globals.hiddenObject(cancelFollowOptButton, false);
		} else {
			lbpm.globals.hiddenObject(followOptButton, false);
			if (followInfo.isPassed){
				followOptButton.onclick = oldFollowFun;
			}
		}
	});
}

//旧UI弹窗
function LbpmFollow_PopupWindow(url,lbpmInfo,action){
	var dialog = new KMSSDialog();
	var lbpmInfo = lbpmInfo;
	dialog.parameter = lbpmInfo;
	dialog.BindingField(null, null);
	dialog.SetAfterShow(function(value){
		action(value);
	});
	dialog.URL = url;
	dialog.Show(window.screen.width*400/1366,150);
} 
</script>
<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdIsHander == 'true'}">
	<script type="text/javascript">
		//更新查看状态
		$(function(){
			var result = null;
			$.ajax({
				url: Com_Parameter.ContextPath + "sys/lbpmservice/support/lbpmHistoryWorkitemAction.do?method=updateIsLook",
				async: false,
				data: {fdModelId:'${sysWfBusinessForm.fdId}'},
				type: "POST",
				dataType: 'json',
				success: function (data) {
					result = data;
				},
				error: function (er) {
	
				}
			});
			return result;
		});
	</script>
</c:if>
<script>
$(document).ready(function() {
	//判断当前流程是否重启过，重启过则显示重启日志标签
	var liProcess_restart_Log_Frame=$("#liProcess_restart_Log_Frame");
	if(liProcess_restart_Log_Frame){
		var lbpmProcessRestartLogData = new KMSSData().AddBeanData("lbpmProcessRestartLogService&processId=${sysWfBusinessForm.fdId}").GetHashMapArray();
		if(lbpmProcessRestartLogData.length>0){
			if(lbpmProcessRestartLogData[0].logType=="false"){
				liProcess_restart_Log_Frame.hide();
			}
			
		}	
	}
});
</script>

