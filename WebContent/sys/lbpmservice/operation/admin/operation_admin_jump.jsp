<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
	/*******************************************************************************
	 * 功能：处理人“前后跳转”操作的审批所用JSP，此JSP路径在处理人“驳回”操作扩展点定义的reviewJs参数匹配
	  使用：
	  作者：罗荣飞
	 创建时间：2012-06-06
	 ******************************************************************************/
	( function(operations) {
		operations['admin_jump'] = {
			click:OperationClick,
			check:OperationCheck,
			setOperationParam:setOperationParam
		};	

		function _getSubString(str, len) {  
			var strlen = 0;  
			var s = "";  
			for (var i = 0; i < str.length; i++) {  
				if (str.charCodeAt(i) > 128) {  
					strlen += 2;  
				} else {  
					strlen++;  
				}  
				s += str.charAt(i);  
				if (strlen >= len) {  
					return s+"...";  
				}  
			}  
			return s;  
		}  

		function _getStringLength(str) {  
			var strlen = 0;  
			for (var i = 0; i < str.length; i++) {  
				if (str.charCodeAt(i) > 128) {  
					strlen += 2;  
				} else {  
					strlen++;  
				}
			}
			return strlen;
		}
		
		//特权人操作：前后跳转
		function OperationClick(operationName){
			var operationsRow = document.getElementById("operationsRow");
			var operationsTDTitle = document.getElementById("operationsTDTitle");
			var operationsTDContent = document.getElementById("operationsTDContent");
			operationsTDTitle.innerHTML = '<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.adminOperationTypeJump" />';
			var operatorInfo = lbpm.globals.getOperationParameterJson("isRecoverPassedSubprocess:jumpToNodeId");
			var html = '<select name="jumpToNodeIdSelectObj" onchange="lbpm.globals.setAdminNodeNotifyType(this.value)" alertText="" key="jumpToNodeId"></select>';
			// 跳转重新流转 html
			var isPassedSubprocessNode = lbpm.globals.isPassedSubprocessNode();
			if (isPassedSubprocessNode) {
				html += '<label id="isRecoverPassedSubprocessLabel" class="lui-lbpm-checkbox">';
				html += '<'+'input type="checkbox" id="isRecoverPassedSubprocess" value="true" alertText="" key="isRecoverPassedSubprocess"';
				if(operatorInfo.isRecoverPassedSubprocess == "true"){
					html += " checked='true'";
				}
				html += '>';
				html += '<span class="checkbox-label"><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.adminOperationTypeJump.abandonSubprocess" />';
				html += '</span></label>';
			}

			var availableNodes = getAvailableNodes();
			operationsTDContent.innerHTML = html;
			lbpm.globals.hiddenObject(operationsRow, false);
			
			var jumpToNodeIdSelectObj = $("select[name='jumpToNodeIdSelectObj']")[0];
			var currNode = lbpm.globals.getNodeObj(lbpm.nowNodeId);
			var jumpNodes = getJumpNodes(currNode);
			
			for(var i = 0; i < availableNodes.length; i++){
				var nodeInfo = availableNodes[i];
				// 过滤并行分支中的节点
				if (!containNode(jumpNodes, nodeInfo))
					continue;
				var	option = document.createElement("option");
				var langNodeName = WorkFlow_getLangLabel(nodeInfo.name,nodeInfo["langs"],"nodeName");
				var itemShowStr = nodeInfo.id + "." + langNodeName;
				if(nodeInfo.handlerSelectType == 'org'){
					if(nodeInfo.handlerNames) {
						itemShowStr += "(" + nodeInfo.handlerNames+ ")";
					} else {
						itemShowStr += "(" + lbpm.workitem.constant.COMMONNODEHANDLERORGEMPTY+ ")";
					}
				} else if (nodeInfo.handlerSelectType != null)  {
					itemShowStr += "(" + lbpm.workitem.constant.COMMONLABELFORMULASHOW + ")";
				}
				option.title = itemShowStr;
				var optTextLength = 65;
				itemShowStr = _getStringLength(itemShowStr) > optTextLength ? _getSubString(itemShowStr,optTextLength) 
						: itemShowStr;
				option.appendChild(document.createTextNode(itemShowStr));
				option.value=nodeInfo.id;
				if(operatorInfo.jumpToNodeId == nodeInfo.id){
					option.checked = true;
				}
				jumpToNodeIdSelectObj.appendChild(option); 
			}
			if(operatorInfo.jumpToNodeId == ""){
				jumpToNodeIdSelectObj.selectedIndex = jumpToNodeIdSelectObj.options.length - 1;
			}

			//增加默认的选择节点通知方式 add by wubing date:2015-05-06
			var defaultToNodeId = jumpToNodeIdSelectObj.value;
			lbpm.globals.setAdminNodeNotifyType(defaultToNodeId);

			if (jumpToNodeIdSelectObj.options.length == 0) {
				operationsTDContent.innerHTML = '<bean:message bundle="sys-lbpmservice" key="lbpmNode.flowContent.noJumpNode" /><input type="hidden" alertText="<bean:message bundle="sys-lbpmservice" key="lbpmNode.flowContent.noJumpNode" />" key="jumpToNodeId">';
				$("#rerunIfErrorRow").hide();
			} else {
				$("#rerunIfErrorRow").show();
			}
		};
		//“前后跳转”操作的检查
		function OperationCheck(){
			var jumpToNodeIdSelectObj = $("select[name='jumpToNodeIdSelectObj']")[0];
			if(jumpToNodeIdSelectObj){
				if (jumpToNodeIdSelectObj.options.length == 0) {
					alert('<bean:message bundle="sys-lbpmservice" key="lbpmNode.flowContent.noJumpNode" />');
					return false;
				}
				var node = lbpm.globals.getNodeObj(jumpToNodeIdSelectObj.options[jumpToNodeIdSelectObj.selectedIndex].value);
				if(node && node.handlerIds == "") {
					if (!confirm("<bean:message key='lbpmNode.validate.hanlderEmpty.jump.confirm' bundle='sys-lbpmservice' />")) {
						return false;
					}
				}
			}
			return true;
		};	
		//"前后跳转"操作的获取参数
		function setOperationParam()
		{			
			var input = $("[name='jumpToNodeIdSelectObj']")[0];
			if (input){
				lbpm.globals.setOperationParameterJson(input.options[input.selectedIndex].value, "jumpToNodeId", "param");
				var nodeName=lbpm.nodes[input.options[input.selectedIndex].value].name;
				lbpm.globals.setOperationParameterJson(nodeName, "jumpToNodeName", "param");
				if ($('#rerunIfError').length > 0) {
					lbpm.globals.setOperationParameterJson($("#rerunIfError").attr("checked"), "rerunIfError", "param");
				}
				//子流程
				lbpm.globals.setOperationParameterJson($("[key='isRecoverPassedSubprocess']")[0],"isRecoverPassedSubprocess", "param");
			};	
		};	


		//取得有效的节点
		function getAvailableNodes(){
			var availableNodes = [];
			lbpm.globals.setNodeLevel();
			$.each(lbpm.nodes, function(index, nodeObj) {
				if(lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_START,nodeObj) 
						|| lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_END,nodeObj) 
						|| lbpm.nowNodeId == nodeObj.id 
						|| lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_AUTOBRANCH,nodeObj) 
						|| lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_MANUALBRANCH,nodeObj)
						|| lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SPLIT,nodeObj)
						|| lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_JOIN,nodeObj)
						|| nodeObj.Status == lbpm.constant.STATUS_RUNNING
						|| nodeObj.endLines.length == 0 || nodeObj.startLines.length == 0){
					;
				} else {
					availableNodes.push(nodeObj);
				}
			});
			availableNodes.sort(function (a, b) {
    			var na = a.level;//parseInt(a.id.substring(1));
    			var nb = b.level;//parseInt(b.id.substring(1));
    			return na - nb;
			});
			return availableNodes;
		}
		
		function getJumpNodes(curr) {
			var nodes1 = [];
			nodes1 = _findNextNodes(curr, nodes1);
			var nodes2 = [];
			nodes2 = _findPreNodes(curr, nodes2, true);
			var nodes = [];
			nodes = mergeArray(nodes1,nodes2)
			return nodes;
		}
		
		function mergeArray(arr1, arr2){ 
  			for (var i = 0 ; i < arr1.length ; i ++ ){
      			for(var j = 0 ; j < arr2.length ; j ++ ){
       				if (arr1[i] === arr2[j]){
         				arr1.splice(i,1);
    				}
    		 	}
  			}
  			for(var i = 0; i < arr2.length; i ++){
  				arr1.push(arr2[i]);
  			}
  			return arr1;
 		 }
		
		function _findPreNodes(curr, nodes, isInit) {
			var pres = lbpm.globals.getPreviousNodeObjs(curr.id);
			for (var i = 0; i < pres.length; i ++) {
				var pNode = pres[i];
				if (lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_START,pNode)) {
				    break;
				}else if(lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_GROUPSTART,pNode)){
					pNode = lbpm.globals.getPreviousNodeObj(pNode.groupNodeId);
				}
				// 往上遍历节点时，若一开始的curr是结束并行分支节点，只沿对应的流入分支往上遍历，不经其它分支
				if (isInit && lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_JOIN,curr)) {
					var preNodeOfJoin = findPreNodeOfJoin(curr);
					if (preNodeOfJoin != null && preNodeOfJoin.id != pNode.id) {
						continue;
					}
				}
				if (containNode(nodes, pNode)) {
					continue;
				}
				nodes.push(pNode);
				
				_findPreNodes(pNode, nodes);
				
				if(isCommonDecisionNode(pNode)){// 可以跳到非并发分支
					_findNextNodes(pNode, nodes);
				}
			}
			return nodes;
		}
		
		function _findNextNodes(curr, nodes) {
			var nexts = lbpm.globals.getNextNodeObjs(curr.id);
			for (var i = 0; i < nexts.length; i ++) {
				var nNode = nexts[i];
				if (lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_END,nNode)) {
					continue;
				}else if(lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_GROUPEND,nNode)){
					nNode = lbpm.globals.getNextNodeObj(nNode.groupNodeId);
				}
				if (containNode(nodes, nNode)) {
					continue;
				}
				nodes.push(nNode);
				_findNextNodes(nNode, nodes);
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
		
		function isCommonDecisionNode(node) {
			var nodeDesc = lbpm.nodedescs[node.nodeDescType];
			return nodeDesc.isBranch(node) && !nodeDesc.isConcurrent(node);
		}
		
		function findPreNodeOfJoin(join) {
			// 从事务参数中找出当前结束并行分支节点对应的流入分支源头，并调用getPreNodeOfJoinFromSource得出preNodeOfJoin的值（preNodeOfJoin代表的就是目标流入分支）
			if (lbpm.nowProcessorInfoObj.parameter) {
				var processInfoParamJson = JSON.parse(lbpm.nowProcessorInfoObj.parameter);
				if (processInfoParamJson.conBranchSourceId) {
					var conBranchSourceId = processInfoParamJson.conBranchSourceId;
					if (conBranchSourceId.indexOf("L") == 0) {
						if (lbpm.lines[conBranchSourceId]) {
							conBranchSourceId = lbpm.lines[conBranchSourceId].endNode.id;
						}
					}
					if (lbpm.nodes[conBranchSourceId]) {
						return getPreNodeOfJoinFromSource(join,lbpm.nodes[conBranchSourceId]);
					}
				}
			}
		}
		
		// 根据分支源头标识找出由该流入分支上结束并行分支节点的上一个节点
		function getPreNodeOfJoinFromSource(join, sourceNodeObj, passed) {
			if (passed == null) {
				passed = new Array();
			}
			if (!containNode(passed, sourceNodeObj)) {
				passed.push(sourceNodeObj);
				for (var i = 0; i < sourceNodeObj.endLines.length; i ++) {
					var line = sourceNodeObj.endLines[i];
					if (line.endNode == join) {
						return line.startNode;
					} else {
						var perNodeOfJoin = getPreNodeOfJoinFromSource(join, line.endNode, passed);
						if (perNodeOfJoin != null) {
							return perNodeOfJoin;
						}
					}
				}
			}
		}
		
	})(lbpm.operations);

