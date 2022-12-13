<%@page import="com.landray.kmss.common.actions.RequestContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/sys/xform/include/sysForm_lang.jsp"%>
<%@ page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting" %>

<script language="JavaScript">
	Com_IncludeFile('fSelect_script.js','../sys/xform/designer/fSelect/');
</script>
<%  pageContext.setAttribute("isRefuseSelectPeople",(new LbpmSetting()).getIsRefuseSelectPeople());%>

<script language="JavaScript">
	/*******************************************************************************
	 * 功能：处理人“驳回”操作的审批所用JSP，此JSP路径在处理人“驳回”操作扩展点定义的reviewJs参数匹配
	  使用：
	  作者：罗荣飞
	 创建时间：2012-06-06
	 ******************************************************************************/
	( function(operations) {
		operations['handler_superRefuse'] = {
			click:OperationClick,
			check:OperationCheck,
			blur:OperationBlur,
			setOperationParam:setOperationParam
		};

		function OperationBlur() {
			lbpm.globals.clearDefaultUsageContent('handler_superRefuse');
		}
		
		//处理人操作：驳回
		function OperationClick(operationName){
			lbpm.globals.setDefaultUsageContent('handler_superRefuse');
			var operationsRow = document.getElementById("operationsRow");
			var operationsTDTitle = document.getElementById("operationsTDTitle");
			var operationsTDContent = document.getElementById("operationsTDContent");
			//var operatorInfo = lbpm.globals.getOperationParameterJson("refusePassedToThisNode:isRecoverPassedSubprocess:jumpToNodeId");
			operationsTDTitle.innerHTML = '<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationTypeRefuse" />'.replace("{refuse}", operationName);
			var html = '<select name="jumpToNodeIdSelectObj" alertText="" key="jumpToNodeId" onchange="lbpm.globals.superJumpToNodeItemsChanged(this);"></select>';
			//在驳回时，增加选择节点通知方式 add by wubing date:2015-05-06
			html+="<label id='refuseSuperNotifyTypeDivId' style='display:none'></label></br>";
			html+="<div id='_triageHandler' style='margin-top:4px;'></div>";
			lbpm.rejectOptionsEnabled = true; // 驳回选项开关是否开启标识
			if (Lbpm_SettingInfo && (Lbpm_SettingInfo["isShowRefuseOptonal"] === "false")) {
				lbpm.rejectOptionsEnabled = false;
			}
			// 驳回选项开关开启时才生成驳回选项html
			if (lbpm.rejectOptionsEnabled) {
				html += lbpm.globals._superRefusePassedToThisNodeLabel(operationName);
			}
			// 驳回后流经的子流程重新流转选项html
			var isPassedSubprocessNode = lbpm.globals.isPassedSubprocessNode();
			if (isPassedSubprocessNode) {
				html += '<br><label id="isRecoverPassedSubprocessLabel" class="lui-lbpm-checkbox" style="';
				// if (operatorInfo.refusePassedToThisNode == "true") {
				// 	html += 'display:none;';
				// }
				html += '"><input type="checkbox" id="isRecoverPassedSubprocess" value="true" alertText="" key="isRecoverPassedSubprocess">';
				html += '<span class="checkbox-label"><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationTypeRefuse.abandonSubprocess" /></span>'.replace("{refuse}", operationName);
				html += '</label>';
			}
			
			operationsTDContent.innerHTML = html;
			lbpm.globals.hiddenObject(operationsRow, false);

			// 获取可驳回到的节点集合（带节点重复过滤）
			var currNodeInfo = lbpm.globals.getCurrentNodeObj();
			var currNodeId = currNodeInfo.id;
			var url = Com_Parameter.ContextPath+"sys/lbpm/engine/jsonp.jsp";
			var pjson = {"s_bean": "lbpmRefuseRuleDataBean", "processId": $("[name='sysWfBusinessForm.fdProcessId']").val(), "nodeId": currNodeId, "_d": new Date().toString(),"refuseType":"superRefuse"};
			var passNodeArray = [];
			$.ajaxSettings.async = false;
			$.getJSON(url, pjson, function(json) {
				passNodeArray = json;
			});
			// 获取分之内节点
			var check_pjson = {"s_bean": "lbpmRefuseRuleDataBean", "processId": $("[name='sysWfBusinessForm.fdProcessId']").val(), "nodeId": currNodeId, "_d": new Date().toString()};
			$.getJSON(url, check_pjson, function(json) {
				check_passNodeArray = json;
			});
			var newPassNodeArray = [];
			var indexNode = 0;
			var hasDefaultRefuse = false;
			$.each(passNodeArray, function(index, nodeId) {
				if(nodeId.indexOf("#") > -1)
				{
					var nodeIdIndex = nodeId.split("#");
					nodeId = nodeIdIndex[0];
					indexNode = nodeIdIndex[1];
					hasDefaultRefuse = true;
				}
				newPassNodeArray.push(nodeId);
			});
			passNodeArray = newPassNodeArray;
			var nodeHandlerNameArray = []; // 可驳回到的节点的处理人名称信息集合
			nodeHandlerNameArray = _getPassNodeHandlerName(passNodeArray, true);
			// 构建可驳回节点下拉列表选项
			var jumpToNodeIdSelectObj = $("select[name='jumpToNodeIdSelectObj']")[0];
			for(var i = 0; i < passNodeArray.length; i++){
				var nodeInfo = lbpm.nodes[passNodeArray[i]];
				
				var	option = document.createElement("option");
				var langNodeName = WorkFlow_getLangLabel(nodeInfo.name,nodeInfo["langs"],"nodeName");
				var itemShowStr = lbpm.globals.lbpmIsRemoveNodeIdentifier() ? langNodeName : (nodeInfo.id + "." + langNodeName);
				itemShowStr += nodeHandlerNameArray[nodeInfo.id];
				option.title = itemShowStr;
				var optTextLength = 65;
				itemShowStr = itemShowStr.length > optTextLength ? itemShowStr
						.substr(0, optTextLength) + '...'
						: itemShowStr;
				option.appendChild(document.createTextNode(itemShowStr));
				option.value=passNodeArray[i];
				jumpToNodeIdSelectObj.appendChild(option);
			}
			if(jumpToNodeIdSelectObj.options.length > 0){
				if (!hasDefaultRefuse && Lbpm_SettingInfo && Lbpm_SettingInfo["isRefuseToPrevNodeDefault"] == "true") {
					jumpToNodeIdSelectObj.selectedIndex = jumpToNodeIdSelectObj.options.length - 1;
				} else {
					jumpToNodeIdSelectObj.selectedIndex = indexNode;
				}
				// 在驳回时，增加默认的选择节点通知方式 add by wubing date:2015-05-06
				var defaultToNodeId = jumpToNodeIdSelectObj.value;
				lbpm.globals.setRefuseSuperNodeNotifyType(defaultToNodeId);

				// <----------以下为驳回返回选项相关的逻辑处理，只有在驳回选项开关开启的情况下才会执行---------->
				if (lbpm.rejectOptionsEnabled) {
					// 驳回返回本人
					var refusePassedToThisNode = document.getElementById("refusePassedToThisNode");
					var refusePassedToThisNodeLabel = document.getElementById("refusePassedToThisNodeLabel");
					// 驳回返回本节点，add by wubing date:2016-07-29
					var refusePassedToThisNodeOnNode = document.getElementById("refusePassedToThisNodeOnNode");
					var refusePassedToThisNodeOnNodeLabel = document.getElementById("refusePassedToThisNodeOnNodeLabel");
					// 驳回返回指定节点
					var refusePassedToTheNode = document.getElementById("refusePassedToTheNode");
					var refusePassedToTheNodeLabel = document.getElementById("refusePassedToTheNodeLabel");

					//驳回的节点是否在分支内
					lbpm.globals._isJumpNodeInJoin = false;
					//默认判断是否在分之内
					var isInJoin = false;
					for(var i=0;i<check_passNodeArray.length;i++){
						if(check_passNodeArray[i]==jumpToNodeIdSelectObj.options[jumpToNodeIdSelectObj.selectedIndex].value){
							isInJoin = true;
							break;
						}     
					}
					lbpm.globals._isJumpNodeInJoin = isInJoin;

					/** 驳回选项的显示规则：1、一旦勾中了其中一个，则隐藏掉其它的选项；2、驳回返回本人和驳回返回本节点只能在分支内显示 */
					if(isInJoin == false){
						// 分支外，则隐藏驳回本人和驳回本节点的开关
						refusePassedToThisNode.checked = false;
						refusePassedToThisNodeLabel.style.display = "none";
						$(refusePassedToThisNodeLabel).next().css("display","none");
						refusePassedToThisNodeOnNode.checked = false;
						refusePassedToThisNodeOnNodeLabel.style.display = "none";
						$(refusePassedToThisNodeOnNodeLabel).next().css("display","none");
						refusePassedToTheNodeLabel.style.display = "";
					}
					// 构建超级驳回后可返回到的节点选项（For驳回返回指定节点）
					lbpm.globals.buildSuperReturnBackToNodeIdSelectOption(jumpToNodeIdSelectObj);

					// 监听切换驳回节点
					Com_AddEventListener(jumpToNodeIdSelectObj, "change", function(){
						//默认判断是否在分之内
						var isInJoin = false;
						for(var i=0;i<check_passNodeArray.length;i++){
							if(check_passNodeArray[i]==jumpToNodeIdSelectObj.options[jumpToNodeIdSelectObj.selectedIndex].value){
								isInJoin = true;
								break;
							}     
						}
						lbpm.globals._isJumpNodeInJoin = isInJoin;
						/** 切换时驳回选项的相关规则：
						 *  1、若切换之前勾选了驳回返回指定节点，则切换的时候自动去掉勾选；
						 *  2、若切换之前勾选了是驳回返回本人和驳回放回本节点，则在切换后的节点（分支内）有驳回返回本人和驳回放回本节点选项时，继承切换前的勾选；
						 */
						if(isInJoin == false){
							// 分支外，则去掉勾选且隐藏驳回本人和驳回本节点的开关
							refusePassedToThisNode.checked = false;
							refusePassedToThisNodeLabel.style.display = "none";
							$(refusePassedToThisNodeLabel).next().css("display","none");
							refusePassedToThisNodeOnNode.checked = false;
							refusePassedToThisNodeOnNodeLabel.style.display = "none";
							$(refusePassedToThisNodeOnNodeLabel).next().css("display","none");
							refusePassedToTheNodeLabel.style.display = "";
						}else{
							// 分支内，则根据情况控制返回本人和返回本节点的开关显示
							if (refusePassedToThisNodeOnNode.checked != true) {
								refusePassedToThisNodeLabel.style.display = "";
								$(refusePassedToThisNodeLabel).next().css("display","block");
							}
							if (refusePassedToThisNode.checked != true) {
								refusePassedToThisNodeOnNodeLabel.style.display = "";
								$(refusePassedToThisNodeOnNodeLabel).next().css("display","block");
							}
						}
						// 切换驳回节点的时候，自动取消驳回返回指定节点的勾选
						if (refusePassedToTheNode.checked == true) {
							refusePassedToTheNode.checked = false;
							lbpm.globals.hiddenObject($("select[name='returnBackToNodeIdSelectObj']")[0], true);
						}

						if (isPassedSubprocessNode) {
							if (!(refusePassedToThisNode.checked || refusePassedToThisNodeOnNode.checked || refusePassedToTheNode.checked)) {
								// 没有驳回返回选项被勾选时，驳回后流经的子流程重新流转选项可以显示出来
								document.getElementById("isRecoverPassedSubprocessLabel").style.display = "";
							}
						}
					});

					// 驳回后流经的子流程重新流转选项
					if (isPassedSubprocessNode) {
						var isRecoverPassedSubprocess = document.getElementById("isRecoverPassedSubprocess");
						var isRecoverPassedSubprocessLabel = document.getElementById("isRecoverPassedSubprocessLabel");
						if (refusePassedToThisNode.checked || refusePassedToThisNodeOnNode.checked || refusePassedToTheNode.checked) {
							isRecoverPassedSubprocessLabel.style.display = "none";
						}
						Com_AddEventListener(refusePassedToThisNode, "click", function(){
							if (refusePassedToThisNode.checked) {
								isRecoverPassedSubprocess.checked = false;
							}
							isRecoverPassedSubprocessLabel.style.display = (refusePassedToThisNode.checked) ? "none" : "";
						});
						Com_AddEventListener(refusePassedToThisNodeOnNode, "click", function(){
							if (refusePassedToThisNodeOnNode.checked) {
								isRecoverPassedSubprocess.checked = false;
							}
							isRecoverPassedSubprocessLabel.style.display = (refusePassedToThisNodeOnNode.checked) ? "none" : "";
						});
						Com_AddEventListener(refusePassedToTheNode, "click", function(){
							if (refusePassedToTheNode.checked) {
								isRecoverPassedSubprocess.checked = false;
							}
							isRecoverPassedSubprocessLabel.style.display = (refusePassedToTheNode.checked) ? "none" : "";
						});
					}
				}
				// <----------END---------->
			}
			
				var processDefine=WorkFlow_LoadXMLData(lbpm.globals.getProcessXmlString());
				//开关开启才会去执行驳回具体审批人
				<c:if test='${isRefuseSelectPeople=="true"}'>
					if(processDefine&&processDefine.refuseSelectPeople&&processDefine.refuseSelectPeople=="true"){
						if(jumpToNodeIdSelectObj.selectedIndex!==undefined&&jumpToNodeIdSelectObj.selectedIndex>-1){
					    	 var nodeData = lbpm.nodes[jumpToNodeIdSelectObj.options[jumpToNodeIdSelectObj.selectedIndex].value];
					    		//会审才会显示具体人员
								if(nodeData.processType&&nodeData.processType=="2"){
									var selectTrialHtml=buildSelectTrialStaff(jumpToNodeIdSelectObj.options[jumpToNodeIdSelectObj.selectedIndex].value);
									$("#_triageHandler").html(selectTrialHtml);	
								}else{
									$("#_triageHandler").html("");
								}
					     }
					}
				</c:if>
			

			if (jumpToNodeIdSelectObj.options.length == 0) {
				operationsTDContent.innerHTML = '<bean:message bundle="sys-lbpmservice" key="lbpmNode.flowContent.noRefuseNode" /><input type="hidden" alertText="<bean:message bundle="sys-lbpmservice" key="lbpmNode.flowContent.noRefuseNode" />" key="jumpToNodeId">'.replace("{refuse}", operationName);
			}
		};
		
		//“驳回”操作的检查
		function OperationCheck(){
			var jumpToNodeIdOptionObj = $("select[name='jumpToNodeIdSelectObj']").find("option:selected");
			if (jumpToNodeIdOptionObj.length == 0) {
				alert('<bean:message bundle="sys-lbpmservice" key="lbpmNode.flowContent.noRefuseNode" />'.replace("{refuse}", lbpm.currentOperationName));
				return false;
			}
			if(lbpm.globals.isUsageContenRequired(lbpm.currentOperationType)){
				return lbpm.globals.validateMustSignYourSuggestion();
			}
			return true;
		};

		//"驳回"操作的获取参数
		function setOperationParam()
		{		
			var jumpStr=$("[key='jumpToNodeId']")[0].value;
			var jumpArr=jumpStr.split(":");	
			lbpm.globals.setOperationParameterJson(jumpArr[0],"jumpToNodeId", "param");
			if(jumpArr.length>1){
				lbpm.globals.setOperationParameterJson(jumpArr[1],"jumpToNodeInstanceId", "param");
			}else{
				lbpm.globals.setOperationParameterJson("","jumpToNodeInstanceId", "param");
			}	
			
			if (lbpm.rejectOptionsEnabled) {
				lbpm.globals.setOperationParameterJson($("[key='refusePassedToThisNode']")[0],"refusePassedToThisNode", "param");
				//增加驳回返回本节点，add by wubing date:2016-07-29
				lbpm.globals.setOperationParameterJson($("[key='refusePassedToThisNodeOnNode']")[0],"refusePassedToThisNodeOnNode", "param");
				//增加驳回返回指定节点，add by linbb
				lbpm.globals.setOperationParameterJson($("[key='refusePassedToTheNode']")[0],"refusePassedToTheNode", "param");
				if ($("[key='refusePassedToTheNode']")[0].checked) {
					lbpm.globals.setOperationParameterJson($("[key='returnBackToNodeId']")[0],"returnBackToNodeId", "param");
				}
			} else {
				lbpm.globals.setOperationParameterJson(false, "refusePassedToThisNode", "param");
				lbpm.globals.setOperationParameterJson(false, "refusePassedToThisNodeOnNode", "param");
				lbpm.globals.setOperationParameterJson(false, "refusePassedToTheNode", "param");
			}
			
			//会审驳回到具体人
			if($("[key='lbpmHandlerTriage']").length>0&&$("[key='lbpmHandlerTriage']")[0]){
				var lbpmHandlerTriageStr=$("[key='lbpmHandlerTriage']")[0].value;
				lbpm.globals.setOperationParameterJson(lbpmHandlerTriageStr,"lbpmHandlerTriage", "param");
			}
			
			// 驳回后流经的子流程重新流转
			lbpm.globals.setOperationParameterJson($("[key='isRecoverPassedSubprocess']")[0],"isRecoverPassedSubprocess", "param");
		};	
	})(lbpm.operations);
	
</script>

<script>
//取得有效的上一历史节点对象
lbpm.globals.getHistoryPreviousNodeInfo=function(){
	var passNodeString = lbpm.globals.getAvailableHistoryRoute();
	var passNodeArray = passNodeString.split(";");
	for(var i = passNodeArray.length - 1; i >= 0; i--){
		var passNodeInfo = passNodeArray[i].split(":");
		var nodeInfo = lbpm.nodes[passNodeInfo[0]];
		if (lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_START, nodeInfo)
				|| lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_END, nodeInfo)
				|| lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_AUTOBRANCH, nodeInfo)
				|| lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_MANUALBRANCH, nodeInfo)
				|| lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SEND, nodeInfo)) {
			continue;
		}
		if(nodeInfo.id == lbpm.nowNodeId){
			continue;
		}
		return passNodeArray[i];
	}
};

//取得有效的上一历史路径
lbpm.globals.getAvailableHistoryRoute=function(){
	var fdTranProcessObj = document.getElementById("sysWfBusinessForm.fdTranProcessXML");
	var statusData = WorkFlow_GetStatusObjectByXML(fdTranProcessObj.value);
	for(var i=0; i<statusData.runningNodes.length; i++){
		var nodeInfo = statusData.runningNodes[i];
		if(nodeInfo.id == lbpm.nowNodeId){
			return nodeInfo.routePath;
		}
	}
	return "";
}

lbpm.globals._superRefusePassedToThisNodeLabel = function(operationName){
	var html = '';
	if(lbpm.approveType == "right"){
		html += '<br/><label style="" ';
	}else{
		html += '<label ';
	}
	
	// zl
	html += 'id="refusePassedToSequenceFlowNodeLabel" class="lui-lbpm-checkbox" onclick="lbpm.globals.handleSuperRefuseOption(this)" title="' + '<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationTypeRefuse.sequenceFlow" />'.replace("{refuse}", operationName) + '"><input type="checkbox" id="refusePassedToSequenceFlowNode" value="true" alertText="" key="refusePassedToSequenceFlowNode"';
	if(lbpm.flowcharts["rejectReturn"] != "true"){
		html += " checked='true'";
	}
	html += '>';
	html += '<span class="checkbox-label"><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationTypeRefuse.sequenceFlow.title" /></span></label></br>';

	html += '<label id="refusePassedToThisNodeLabel" class="lui-lbpm-checkbox" onclick="lbpm.globals.handleSuperRefuseOption(this)" title="' + '<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationTypeRefuse.returnBackMe" />'.replace("{refuse}", operationName) +'"><input type="checkbox" id="refusePassedToThisNode" value="true" alertText="" key="refusePassedToThisNode"';
	if(lbpm.flowcharts["rejectReturn"] == "true"){
		html += " checked='true'";
	}
	html += '>';
	html += '<span class="checkbox-label"><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationTypeRefuse.returnBackMe.title" /></span></label></br>';

	//增加驳回返回本节点，add by wubing date:2016-07-29
	html += '<label id="refusePassedToThisNodeOnNodeLabel" class="lui-lbpm-checkbox" onclick="lbpm.globals.handleSuperRefuseOption(this)" title="' + '<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationTypeRefuse.returnBack" />'.replace("{refuse}", operationName) + '"';
	html += '><input type="checkbox" id="refusePassedToThisNodeOnNode" value="true" alertText="" key="refusePassedToThisNodeOnNode">';
	html += '<span class="checkbox-label"><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationTypeRefuse.returnBack.title" /></span></label></br>';
	
	//增加驳回返回指定节点 add by linbb
	html += '<label id="refusePassedToTheNodeLabel" class="lui-lbpm-checkbox" onclick="lbpm.globals.handleSuperRefuseOption(this)" title="' + '<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationTypeRefuse.returnBackTheNode" />'.replace("{refuse}", operationName) + '"';
	html += '><input type="checkbox" id="refusePassedToTheNode" value="true" alertText="" key="refusePassedToTheNode">';
	html += '<span class="checkbox-label"><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationTypeRefuse.returnBackTheNode.title" /></span></label>';
	html += '<select name="returnBackToNodeIdSelectObj" alertText="" key="returnBackToNodeId" style="display:none;max-width:200px;margin-left:4px;"></select>';
	
	return html;
}

lbpm.globals.setRefuseSuperNodeNotifyType=function(nodeId){
	var refuseNotifyTypeDivIdEl = document.getElementById("refuseSuperNotifyTypeDivId");
	refuseNotifyTypeDivIdEl.innerHTML=lbpm.globals.getNotifyType4NodeHTML(nodeId);
	refuseNotifyTypeDivIdEl.style.display="";
}

lbpm.globals.handleSuperRefuseOption=function(el){
	 var refusePassedToSequenceFlowNode = document.getElementById("refusePassedToSequenceFlowNode");
	 var refusePassedToThisNodeOnNode = document.getElementById("refusePassedToThisNodeOnNode");
	 var refusePassedToTheNode = document.getElementById("refusePassedToTheNode");
	 var refusePassedToThisNode = document.getElementById("refusePassedToThisNode");
	 
	 if(el.id=="refusePassedToSequenceFlowNodeLabel"){
			var thisCheck = refusePassedToSequenceFlowNode;
			var othersNoSelect = !refusePassedToThisNodeOnNode.checked && !refusePassedToTheNode.checked && !refusePassedToThisNode.checked;
			
			if(thisCheck) {
				refusePassedToThisNodeOnNode.checked = false;
				refusePassedToTheNode.checked = false;
				refusePassedToThisNode.checked = false;
			} 
			if(othersNoSelect && !thisCheck.checked) {
				thisCheck.checked = true;
			} 
			var isPassedSubprocessNode = lbpm.globals.isPassedSubprocessNode();
			if(isPassedSubprocessNode){
				var isRecoverPassedSubprocessLabel = document.getElementById("isRecoverPassedSubprocessLabel");
				isRecoverPassedSubprocessLabel.style.display = (refusePassedToThisNode.checked) ? "none" : "";
			}
		}
	 
	 if(el.id=="refusePassedToThisNodeLabel"){
		 var thisCheck = refusePassedToThisNode;
			var othersNoSelect = !refusePassedToThisNodeOnNode.checked && !refusePassedToTheNode.checked && !refusePassedToSequenceFlowNode.checked;
			
			if(thisCheck) {
				refusePassedToThisNodeOnNode.checked = false;
				refusePassedToTheNode.checked = false;
				refusePassedToSequenceFlowNode.checked = false;
			} 
			if(othersNoSelect && !thisCheck.checked) {
				thisCheck.checked = true;
			} 		
	}
	if(el.id=="refusePassedToThisNodeOnNodeLabel"){
		var thisCheck = refusePassedToThisNodeOnNode;
		var othersNoSelect = !refusePassedToSequenceFlowNode.checked && !refusePassedToTheNode.checked && !refusePassedToThisNode.checked;
		
		if(thisCheck) {
			refusePassedToThisNode.checked = false;
			refusePassedToTheNode.checked = false;
			refusePassedToSequenceFlowNode.checked = false;
		} 
		if(othersNoSelect && !thisCheck.checked) {
			thisCheck.checked = true;
		} 
	}
	if(el.id=="refusePassedToTheNodeLabel"){
		var thisCheck = refusePassedToTheNode;
		var othersNoSelect = !refusePassedToSequenceFlowNode.checked && !refusePassedToThisNodeOnNode.checked && !refusePassedToThisNode.checked;
		
		if(thisCheck) {
			refusePassedToThisNode.checked = false;
			refusePassedToThisNodeOnNode.checked = false;
			refusePassedToSequenceFlowNode.checked = false;
		} 
		if(othersNoSelect && !thisCheck.checked) {
			thisCheck.checked = true;
		} 
	
		if (thisCheck.checked) {
			lbpm.globals.buildSuperReturnBackToNodeIdSelectOption();
			lbpm.globals.hiddenObject($("select[name='returnBackToNodeIdSelectObj']")[0], false);
		} else {
			lbpm.globals.hiddenObject($("select[name='returnBackToNodeIdSelectObj']")[0], true);
			lbpm.events.fireListener("clickRefusePassedToTheNodeLabel", null);
		}
	} else {
		lbpm.globals.hiddenObject($("select[name='returnBackToNodeIdSelectObj']")[0], true);
	}
}

lbpm.globals.buildSuperReturnBackToNodeIdSelectOption=function(jumpToNodeIdSelectObj){
	if (jumpToNodeIdSelectObj == null) {
		jumpToNodeIdSelectObj = $("select[name='jumpToNodeIdSelectObj']")[0];
	}
	
	var jumpToNodeIdSelectOptions = jumpToNodeIdSelectObj.options;
	var jumpToNodeId = jumpToNodeIdSelectOptions[jumpToNodeIdSelectObj.selectedIndex].value;
	var returnNodes = getReturnNodes(lbpm.globals.getNodeObj(jumpToNodeId));
	
	$("select[name='returnBackToNodeIdSelectObj']").empty();
	var returnBackToNodeIdSelectObj = $("select[name='returnBackToNodeIdSelectObj']")[0];
	
	for(var j = 0; j < jumpToNodeIdSelectOptions.length; j++){
		var nodeInfo = lbpm.globals.getNodeObj(jumpToNodeIdSelectOptions[j].value);
		if (!containNode(returnNodes, nodeInfo)){
			continue;
		}
		var	option = document.createElement("option");
		option.title = jumpToNodeIdSelectOptions[j].title;
		var itemShowStr = option.title.length > 65 ? option.title.substr(0, 65) + '...' : option.title;
		option.appendChild(document.createTextNode(itemShowStr));
		option.value=jumpToNodeIdSelectOptions[j].value;
		returnBackToNodeIdSelectObj.appendChild(option);
	}
	if (containNode(returnNodes, lbpm.globals.getNodeObj(lbpm.nowNodeId))) {
		var	option = document.createElement("option");
		option.title = '<bean:message bundle="sys-lbpmservice" key="lbpmNode.flowContent.thisNode" />';
		option.appendChild(document.createTextNode(option.title));
		option.value=lbpm.nowNodeId;
		returnBackToNodeIdSelectObj.appendChild(option);
	}
	
	if (returnBackToNodeIdSelectObj.options.length == 0) {
		var	option = document.createElement("option");
		option.appendChild(document.createTextNode('<bean:message bundle="sys-lbpmservice" key="lbpmNode.flowContent.noReturnBackNode" />'));
		option.value=null;
		returnBackToNodeIdSelectObj.appendChild(option);
	}
}

lbpm.globals.superJumpToNodeItemsChanged=function(){
	if (lbpm.rejectOptionsEnabled && $("[key='refusePassedToTheNode']")[0].checked) {
		lbpm.globals.buildSuperReturnBackToNodeIdSelectOption();
	}
	

	var processDefine=WorkFlow_LoadXMLData(lbpm.globals.getProcessXmlString());
	
	//开关开启才会去执行驳回具体审批人
	<c:if test='${isRefuseSelectPeople=="true"}'>
	     if(processDefine&&processDefine.refuseSelectPeople&&processDefine.refuseSelectPeople=="true"){
	    	 if(arguments.length>0){
	 			var op=arguments[0];
	 			var nodeData = lbpm.nodes[op.value];
	 			//会审才会显示具体人员
	 			if(nodeData.processType&&nodeData.processType=="2"){
	 				var selectTrialHtml=_buildSelectTrialStaff(op.value);
	 				var operationsTDContent = document.getElementById("operationsTDContent");
	 				$("#_triageHandler").html(selectTrialHtml);	
	 				
	 				$("xformflag[flagtype='xform_fSelect']").fSelect();
	 			}else{
	 				$("#_triageHandler").html("");
	 			}
	 		}
	     }
	</c:if>
	
}

function getReturnNodes(jumpToNode) {
	var nodes = [];
	nodes = _findReturnNodes(jumpToNode, nodes);
	return nodes;
}

// 从指定的驳回的节点往下遍历（遇到启动并行分支需直接跳到对应的结束并行分支节点再往下遍历）
function _findReturnNodes(curr, nodes) {
	var nexts = lbpm.globals.getNextNodeObjs(curr.id);
	for (var i = 0; i < nexts.length; i ++) {
		var nNode = nexts[i];
		if (lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_END,nNode)) {
			continue;
		}
		if (containNode(nodes, nNode)) {
			continue;
		}
		nodes.push(nNode);
		if (nNode.id == lbpm.nowNodeId) {
			continue;
		}
		if (lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SPLIT,nNode)) {
			nNode = lbpm.globals.getNodeObj(nNode.relatedNodeIds);
			nodes.push(nNode);
		}
		_findReturnNodes(nNode, nodes);
	}
	return nodes;
}

function containNode(nodes, node) {
	for (var n = 0; n < nodes.length; n ++) {
		if (node.id == nodes[n].id) {
			return true;
		}
	}
	return false;
}

//isParse为true时，计算出节点处理人
function _getPassNodeHandlerName(passNodeArray, isParse) {
	var nodeHandlerNameArray = [];
	if (isParse) {
		var nodeHandlerForParse = [];
		$.each(passNodeArray, function(index, nodeId) {
			var nodeData = lbpm.nodes[nodeId];
			if(nodeData.handlerIds){
				nodeHandlerForParse.push({"nodeId": nodeData.id, "handlerIds": nodeData.handlerIds, "handlerSelectType": nodeData.handlerSelectType, "distinct": false});
			}
		});
		nodeHandlerNameArray = _parsePassNodesHandler(nodeHandlerForParse);
	}
	
	for(var i = 0; i < passNodeArray.length; i++){
		var nodeHandlerName = nodeHandlerNameArray[passNodeArray[i]];
		if (nodeHandlerName == null || nodeHandlerName == "") {
			var nodeInfo = lbpm.nodes[passNodeArray[i]];
			if(nodeInfo.handlerNames != null && nodeInfo.handlerSelectType == 'org'){
				nodeHandlerNameArray[passNodeArray[i]] = "(" + nodeInfo.handlerNames + ")";
			} else if (nodeInfo.handlerSelectType != null)  {
				nodeHandlerNameArray[passNodeArray[i]] = "(" + lbpm.workitem.constant.COMMONLABELFORMULASHOW + ")";
			} else {
				nodeHandlerNameArray[passNodeArray[i]] = "";
			}
		} else {
			nodeHandlerNameArray[passNodeArray[i]] = "(" +nodeHandlerName + ")";
		}
	}
	return nodeHandlerNameArray;
}

function _parsePassNodesHandler(nodeHandlers) {
	var nodeHandlerNameArray = [];
	if(nodeHandlers && nodeHandlers.length > 0){
		var url = "lbpmHandlerParseService&modelId=" + lbpm.globals.getWfBusinessFormModelId() + "&modelName=" + lbpm.globals.getWfBusinessFormModelName();
		for(var i = 0; i < nodeHandlers.length; i++) {
			var node = nodeHandlers[i];
			if(!node.handlerIds) {
				continue;
			}
			url += "&nodeId=" + node.nodeId;
			url += "&handlerIds=" + encodeURIComponent(node.handlerIds);
			url += "&isFormula=" + (node.handlerSelectType == "formula" ? "true" : "false");
			url += "&isMatrix=" + (node.handlerSelectType == "matrix" ? "true" : "false");
			url += "&isRule=" + (node.handlerSelectType == "rule" ? "true" : "false");
			url += "&distinct=" + (node.distinct ? "true" : "false");
		}
		var data = new KMSSData();
		var handlerArray = data.AddBeanData(url).GetHashMapArray();
		if (handlerArray && handlerArray.length > 0) {
			for ( var j = 0; j < handlerArray.length; j++) {
				nodeHandlerNameArray[handlerArray[j].nodeId] = lbpm.globals.htmlUnEscape(handlerArray[j].name);
			}
		}
	}
	return nodeHandlerNameArray;
}

//传入节点Id，得到驳回节点的已处理人集合
function getPassNodeHandlerObj(nodeId) {
	var url = "lbpmHandlerTriageService&modelId=" + lbpm.modelId + "&fdFactId=" + nodeId;
	var handlerArray=[];
	var data = new KMSSData();
	handlerArray = data.AddBeanData(url).GetHashMapArray();
    return handlerArray;
}

function _buildSelectTrialStaff(nodeId){
	var handlerArray=getPassNodeHandlerObj(nodeId);
	var nodeData = lbpm.nodes[nodeId];
	
	var trialStaffPeopleHtmlStart="<xformflag flagid='fd_trialStaffPeople' id='_xform_trialStaffPeople' property='trialStaffPeople' flagtype='xform_fSelect' _xform_type='fSelect'>"+
		"<div class='select_div_box xform_Select' fd_type='fSelect' style='display: inline-block; width: auto; text-align: left;'>"+
	"<div id='div_trialStaffPeople' style='display:none'>"+
		"<input name='trialStaffPeople' type='hidden' value='' key='lbpmHandlerTriage'>"+
	"</div>"+
	"<div class='fs-wrap multiple'>"+
		"<div class='fs-label-wrap'>"+
			"<div class='fs-label' >==${lfn:message('sys-lbpmservice:lbpmservice.select.refusePeople')}==</div>"+
			"<span class='fs-arrow'></span>"+
		"</div>"+
		"<div class='fs-dropdown'>"+
			"<div class='fs-search'>"+
				"<input type='text' autocomplete='off' placeholder='${lfn:message('sys-lbpmservice:lbpmservice.select.refusePeople.search')}'>"+
				"<i class='fs-search-icon-del'></i>"+
			"</div>";
			
			var optionHtml="";
	if(handlerArray.length>0){
		for(var i=0;i<handlerArray.length;i++){
			optionHtml+="<div class='fs-options'>"+
				"<div data-value='"+handlerArray[i].handlerId+"' class='fs-option' data-index='0'>"+
					"<span class='fs-checkbox'><i></i></span>"+
					"<div class='fs-option-label'>"+handlerArray[i].handlerName+"</div>"+
					"<input type='hidden' name='_trialStaffPeople' value='"+handlerArray[i].handlerId+"'>"+
				"</div>"+
			"</div>";
		}
	}
				
	var trialStaffPeopleHtmlEnd="</div>"+
		"</div>"+
	"</div></xformflag>";
	
	var selectHtml=trialStaffPeopleHtmlStart+optionHtml+trialStaffPeopleHtmlEnd;
	return selectHtml;
}

</script>
