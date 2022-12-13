define(function(){
	var submitFlow={};
	//提交表单事件
	submitFlow.submitFormEvent = lbpm.globals.submitFormEvent=function(formObj, method, clearParameter, moreOptions){
		if(!lbpm.globals.validateBeforeSumbitVersion())
			return false;
		//当简易流程界面是直接返回true,因为逻辑在lbpm.globals.simpleFlowSubmitEvent函数中
		var docStatus = lbpm.constant.DOCSTATUS;
		if(parseInt(docStatus) >= lbpm.constant.STATE_COMPLETED){
			return true;
		}
		var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
		var operatorInfo = lbpm.globals.analysisProcessorInfoToObject();
		if(operatorInfo == null){
			canStartProcess.value = "false";
			return true;
		}
		//下以注释代码为忽视当前处理人不是流程处理人时的校验
		var currentHandlerIds = document.getElementById("sysWfBusinessForm.fdHandlerRoleInfoIds").value;
		if(lbpm.constant.METHOD == lbpm.constant.METHODEDIT && canStartProcess != null){
			var currentIdArray = currentHandlerIds.split(";");
			var flag = false;
			for(var i = 0; i < currentIdArray.length; i++){
				if(lbpm.handlerId.indexOf(currentIdArray[i]) != -1){
					flag = true;
					break;
				}
			}
			if(!flag){
				canStartProcess.value = "false";
				return true;
			}
		}
		if (lbpm.isFreeFlow && lbpm.globals.getNodeSize() <= 3) {
			if (moreOptions) {
				if (!moreOptions.saveDraft) {
					require(["mui/dialog/Tip"],function(tip){
						tip["warn"]({text:lbpm.constant.FREEFLOW_MUSTAPPENDNODE});
					});
					//alert(lbpm.constant.FREEFLOW_MUSTAPPENDNODE);
					return false;
				}
			} else {
				require(["mui/dialog/Tip"],function(tip){
					tip["warn"]({text:lbpm.constant.FREEFLOW_MUSTAPPENDNODE});
				});
				//alert(lbpm.constant.FREEFLOW_MUSTAPPENDNODE);
				return false;
			}
		}
		//检验是否选择了操作项
		var optInfo = $("#operationMethodsGroup").val();
		if(optInfo==""){
			require(["mui/dialog/Tip"],function(tip){
				tip["warn"]({text:lbpm.constant.VALIDATEOPERATIONTYPEISNULL});
			});
			//alert(lbpm.constant.VALIDATEOPERATIONTYPEISNULL);
			return false;	
		}
		var oprArr=optInfo.split(":");
		lbpm.currentOperationType=oprArr[0];
		lbpm.currentOperationName=oprArr[1];
		
		//意见长度检查
		var fdUsageContent=lbpm.operations.getfdUsageContent();
		if (fdUsageContent != null && fdUsageContent.value != "") {
			var maxLength = 4000;
			var contentVal = fdUsageContent.value || "";
			var newvalue = contentVal.replace(/[^\x00-\xff]/g, "***");
			if (newvalue.length > maxLength) {
				//新增审批意见长度判断
//				var msg = lbpm.constant.ERRORMAXLENGTH;
//				var title = lbpm.constant.CREATEDRAFTCOMMONUSAGES;
				var msg = lbpm.constant.ERROR_FDUSAGECONTENT_MAXLENGTH;
				var title = lbpm.constant.OPINION;
				msg = msg.replace(/\{name\}/, title).replace(/\{maxLength\}/, maxLength);
				require(["mui/dialog/Tip"],function(tip){
					tip["warn"]({text:msg,width:'260',height:'150'});
				});
				//alert(msg);
				return false;
			}
		};

		
		var isValidated = lbpm.globals.isUsageContenValidated(lbpm.currentOperationType);
		// 若审批意见校验开关开启则执行如下操作
		if(isValidated == true){
			// 获取校验的意见
			var defalutUsage = "";
			defalutUsage = lbpm.globals.getOperationDefaultUsageValidate(lbpm.currentOperationType);
			var deafultUsageName = defalutUsage.replace("{xx}","");
			// 获取当前提交的输入框中的审批意见
			var fdUsageContent = lbpm.operations.getfdUsageContent();
			if((fdUsageContent.value).indexOf("{xx}")>=0){
				require(["mui/dialog/Tip"],function(tip){
					tip["warn"]({text:Data_GetResourceString('sys-lbpmservice:lbpmUsageContent.fdDescription.details.7')});
				});
				return false;
			}else if(!(deafultUsageName == (fdUsageContent.value))){
				var defalutUsageRep = defalutUsage;
				// 审批意见包含{xx}自定义输入符则进行正则表达式校验
				if(defalutUsage.indexOf("{xx}")>=0){
					//将默认审批中的{xx}替换成\S+正则表达式进行校验
					defalutUsageRep = defalutUsage.replace(/\{xx\}/g,"(\\S{0,})");
				}
				defalutUsageRep = new RegExp("^"+defalutUsageRep+"$");
				// 若校验不通过
				if(!(defalutUsageRep.test(fdUsageContent.value))){
					var prompt = Data_GetResourceString("sys-lbpmservice:lbpmUsageContent.fdDescription.details.7")
	                prompt = prompt.replace("{0}",defalutUsage);
					require(["mui/dialog/Tip"],function(tip){
						tip["warn"]({text:prompt,width:'300',height:'200'});
					});
					return false;
				}
				
			}
			
		 } 
		
		var isExcludeValidated = lbpm.globals.isUsageContenExcludeValidated(lbpm.currentOperationType);
		// 若审批意见排除校验开关开启则执行如下操作
		if(isExcludeValidated == true){
			var excludeUsage = "";
			// 获取排除校验的意见内容
			excludeUsage = lbpm.globals.getOperationDefaultUsageValidate(lbpm.currentOperationType);
			// 获取当前提交的输入框中的审批意见
			var fdUsageContent = lbpm.operations.getfdUsageContent();
				// 审批意见是否包含排除的内容
				if((fdUsageContent.value).indexOf(excludeUsage) !=-1){
						var prompt = Data_GetResourceString("sys-lbpmservice:lbpmUsageContent.fdDescription.details.9")
		                prompt = prompt.replace("{0}",excludeUsage);
						require(["mui/dialog/Tip"],function(tip){
							tip["warn"]({text:prompt,width:'300',height:'200'});
						});
					return false;
				}
		 } 
		//自由流私密意见校验
		if (lbpm.isFreeFlow && Lbpm_SettingInfo.isPrivateOpinion == "true"){
			var isCanpass = true;
			require(["dijit/registry"], function(registry) {
				var switchWgt = registry.byId('privateOpinion');
				if (switchWgt && switchWgt.value=='on') {
				var myWgt = registry.byId('privateOpinionPerson');
				if(myWgt && !myWgt.curIds){
					//alert(Data_GetResourceString('sys-lbpmservice:lbpmservice.auditnote.placeholder'));
					require(["mui/dialog/Tip"],function(tip){
						tip["warn"]({text:Data_GetResourceString('sys-lbpmservice:lbpmservice.auditnote.placeholder')});
					});
						isCanpass = false;
					}
				}
			});
			if(!isCanpass){
				return false;
			}
		}
		
		var oprClass = null;
		if(lbpm.currentOperationType){
			oprClass=lbpm.operations[lbpm.currentOperationType];
			if(oprClass!=null){
				if(!oprClass.check(formObj, method, clearParameter, moreOptions)) return false;
			}	
		}
		
		if(lbpm && lbpm.processorInfoObj && ((lbpm.nowProcessorInfoObj.type == "reviewWorkitem" &&  lbpm.currentOperationType =='handler_pass') 
				|| (lbpm.nowProcessorInfoObj.type == "signWorkitem" &&  lbpm.currentOperationType =='handler_sign')) && lbpm.globals.handlerWrittenValidator) {
			// 手写校验
			if (!lbpm.globals.handlerWrittenValidator()) return false;
		}
		
		var callBack = arguments.callee.caller;
		//提交时才执行提交人身份校验
		if(callBack == Com_Submit){
			//提交人身份校验
			if(!lbpm.isLbpmIdentityCheck && !lbpm.globals.lbpmIdentityCheck(formObj, method, clearParameter, moreOptions)){
				return false;
			}
		}
		
		lbpm.globals.setParameterOnSubmit();
		if(oprClass != null && oprClass.setOperationParam) {
			oprClass.setOperationParam();
			lbpm.events.fireListener(lbpm.constant.EVENT_SETOPERATIONPARAM, null);
		}
		if ($("input[name='futureNode']:checked").length > 0){
			var eleObj = $("input[name='sysWfBusinessForm.fdParameterJson']");
			if(eleObj.length>0 && eleObj[0].value){
				var jsonObj = $.parseJSON(eleObj[0].value);
				if(!jsonObj["param"] || !jsonObj["param"]["futureNodeId"]){
					require(["mui/dialog/Tip"],function(tip){
						tip["warn"]({text:lbpm.constant.CHKNEXTNODENOTNULL});
					});
					return false;
				}
			}
		}
		//alert(document.getElementById("sysWfBusinessForm.fdParameterJson").value);
		return true;
	};

	//设置标准的参数项在提交前,此函数一定要在操作的setOperationParam函数前运行，方便操作扩展的时候可以覆盖一些标准的参数
	submitFlow.setParameterOnSubmit = lbpm.globals.setParameterOnSubmit=function(){
		var operatorInfo = lbpm.nowProcessorInfoObj;
		//var operatorInfo = lbpm.globals.getOperationParameterJson("workitemId:handlerId");
		var taskId = lbpm.globals.getOperationParameterJson("id");
	 	//设置Json参数
	 	lbpm.globals.setOperationParameterJson(taskId==null?"":taskId,"taskId"); //工作项ID
	 	//lbpm.globals.setOperationParameterJson(lbpm.handlerId==null?"":lbpm.handlerId,"handlerId"); //处理人ID
	 	//流程实例ID
	 	lbpm.globals.setOperationParameterJson($("[name='sysWfBusinessForm.fdProcessId']")[0].value,"processId"); 
	 	//活动类型
	 	lbpm.globals.setOperationParameterJson(operatorInfo.type,"activityType");
		//设置操作类型
		if(lbpm.currentOperationType)
			lbpm.globals.setOperationParameterJson(lbpm.currentOperationType.toString(),"operationType");
		//设置操作名称
		if(lbpm.currentOperationName)
			lbpm.globals.setOperationParameterJson(lbpm.currentOperationName,"operationName", "param");
		
		//如果有分支设置分支
		var futureNodeCheckboxs=$("input[name='futureNode'][type='checkbox']");
		//判断是并行分支还是人工决策分支（如checkbox类型则是并行分支）
		if(futureNodeCheckboxs.length>0){
			var futureNodes="";
			var futureNodesChekBoxGroup;
			require(['dojo/topic','dijit/registry'],function(topic,registry){
				futureNodesChekBoxGroup=registry.byId("sys_lbpmservice_mobile_workitem_FutureNodesChekBoxGroup");
				futureNodes=futureNodesChekBoxGroup.value.replace(/;/g, ',');
			});
			lbpm.globals.setOperationParameterJson(futureNodes,"futureNodeId","param");
		}
		else{
			$("input[name='futureNode']:checked").each(function(i){
				lbpm.globals.setOperationParameterJson(this,null,"param");
			});
		}
		
		//通知方式
		$("input[name='sysWfBusinessForm.fdSystemNotifyType']").each(function(i){
			lbpm.globals.setOperationParameterJson(this,"notifyType", "param");
		});

		//通知方式优先级 add by wubing date:2014-09-18
		$("input[name='sysWfBusinessForm.fdNotifyLevel']:checked").each(function(i){
			lbpm.globals.setOperationParameterJson(this,"notifyLevel","param");
		});

		//流程结束后 --notifyOnFinish
		$("#notifyOnFinish").each(function(i){
			lbpm.globals.setOperationParameterJson(this,"notifyOnFinish", "param");
		});

		//意见--auditNode
		var auditNodeObj=lbpm.operations.getfdUsageContent();
		if(auditNodeObj) lbpm.globals.setOperationParameterJson(auditNodeObj,"auditNote", "param");
		//私密意见
		var $privateOpinion=$("input[name='privateOpinionCanViewIds']");
		if($privateOpinion.val()) lbpm.globals.setOperationParameterJson($privateOpinion[0],"privateOpinionIds", "param");
		//@处理人
		if(lbpm.globals.filterNoticeHandler){
			var noticeHandlerIds = lbpm.globals.filterNoticeHandler();
			var noticeHandlerIdsObj = $("input[name='noticeHandlerIds']")[0];
			if(noticeHandlerIds){
				lbpm.globals.setOperationParameterJson(noticeHandlerIdsObj,"noticeHandlerIds", "param");
			}
		}
		$("input[name='sysWfBusinessForm.fdAuditNoteFdId']").each(function(i){
			lbpm.globals.setOperationParameterJson(this,"auditNoteFdId", "param");
		});
		$("input[name='sysWfBusinessForm.fdAuditNoteFrom']").each(function(i){
			lbpm.globals.setOperationParameterJson(this, "auditNoteFrom", "param");
		});
		
		//即席子流程提交前处理
		$("input[name='nextAdHocRouteId']:checked").each(function(i){
			lbpm.nextAdHocRouteId = this.value;
			lbpm.globals.setAdHocSubNode();
		});
		//特权人操作或者起草人操作无需初始化
		if(lbpm.currentOperationType && lbpm.operations[lbpm.currentOperationType] && lbpm.operations[lbpm.currentOperationType].isPassType){
			//初始化嵌入子流程信息（已初始化过的节点将不再初始化，包含在起草节点修改组节点信息中的初始化）
			lbpm.globals.setEmbeddedNodeInfo();
		}
		lbpm.globals.setModifyParameterOnSubmit();
	};
	
	lbpm.globals.setEmbeddedNodeInfo = function(){
		//嵌入子流程根据redId获得流程图xml
		var getContentByRefId = function(fdRefId){
			var fdContent = "";
			var ajaxurl = Com_Parameter.ContextPath + 'sys/lbpmservice/support/lbpmEmbeddedSubFlow.do?method=getContentByRefId&fdRefId='+fdRefId;
			var kmssData = new KMSSData();
			kmssData.SendToUrl(ajaxurl, function(http_request) {
				var responseText = http_request.responseText;
				var json = eval("("+responseText+")");
				if (json.fdContent){
					fdContent = json.fdContent;
				}
			},false);
			return fdContent;
		}
		//获得组节点之间的连线
		var getGroupLineById = function(nodeId,flowInfo){
			for(var i=0;i<flowInfo.nodes.length;i++){
				if(flowInfo.nodes[i].groupNodeId == nodeId && flowInfo.nodes[i].XMLNODENAME == ("groupStartNode")){
					for(var j=0;i<flowInfo.lines.length;j++){
						if(flowInfo.lines[j]["startNodeId"] == flowInfo.nodes[i].id){
							return flowInfo.lines[j];
						}
					}
				}
			}
			return null;
		}
		//需要从组节点继承的属性
		var needCopyData = ["subFormId","subFormName","subFormMobileId","subFormMobileName","subFormPrintId", "subFormPrintName",
    	    "nodeCanViewCurNodeIds","nodeCanViewCurNodeNames","otherCanViewCurNodeIds","otherCanViewCurNodeNames","canModifyNotionPopedom","canModifyFlow"];
		//从组节点继承属性
		var setSubNodeInfoByGroupNode = function(newNode,groupNode){
    		for(var i=0;i<needCopyData.length;i++){
    			if((!newNode[needCopyData[i]] || newNode[needCopyData[i]]=="false") && groupNode[needCopyData[i]] != undefined){
    				newNode[needCopyData[i]] = groupNode[needCopyData[i]];
    			}
    		}
    	}
		//当前流程图对象
		var nowFlow = WorkFlow_LoadXMLData(lbpm.globals.getProcessXmlString());
		//当前节点下标
		var nowNodeIndex = parseInt(nowFlow.nodesIndex, 10);
		//当前连线下标
		var nowLineIndex = parseInt(nowFlow.linesIndex, 10);
		//嵌入的节点及连线信息
		var newNodeAndLineInfo = {};
		//嵌入子流程节点，fdRefId对应信息
		var fdEmbeddedInfo = [];
		for(var i=0;i<nowFlow.nodes.length;i++){
			if(nowFlow.nodes[i].XMLNODENAME == "embeddedSubFlowNode" && nowFlow.nodes[i].embeddedRefId && nowFlow.nodes[i].isInit != "true"){
				var fdContent = getContentByRefId(nowFlow.nodes[i].embeddedRefId);
				if(fdContent){
					//嵌入的流程图对象
					var embeddedFlow = WorkFlow_LoadXMLData(fdContent);
					//新旧节点ID对应关系,key:旧id，value:新id
					var nodeInfo = {};
					//嵌入的节点
					var newNodes = [];
					for(var j = 0;j<embeddedFlow.nodes.length;j++){
						//复制嵌入的节点，添加groupNodeId，groupNodeType，坐标变为负的（隐藏），
						//重置id，并记录新旧节点id对应关系，添加到嵌入的节点数组中
						var newNode = $.extend(true, {}, embeddedFlow.nodes[j]);
						newNode.groupNodeId = nowFlow.nodes[i].id;
						newNode.groupNodeType = "embeddedSubFlowNode";
						newNode.x = -newNode.x;
						newNode.y = -newNode.y;
						nodeInfo[embeddedFlow.nodes[j].id] = newNode.id = "N"+(++nowNodeIndex);
						//从组节点继承属性
						setSubNodeInfoByGroupNode(newNode,nowFlow.nodes[i]);
						newNodes.push(newNode);
					}
					lbpm.globals.replaceModifyHandlerNodeIds(newNodes,nodeInfo);
					//将嵌入的节点记录到嵌入的节点及连线信息对象中，key：当前嵌入子流程节点id
					newNodeAndLineInfo[nowFlow.nodes[i].id] = {};
					newNodeAndLineInfo[nowFlow.nodes[i].id]["newNodes"] = newNodes;
					//嵌入的连线
					var newLines = [];
					for(var j = 0;j<embeddedFlow.lines.length;j++){
						//复制嵌入的连线，根据记录的新旧节点id对应关系修改startNodeId，endNodeId
						//重置id，添加到嵌入的连线数组中
						var newLine = $.extend(true, {}, embeddedFlow.lines[j]);
						newLine.startNodeId = nodeInfo[newLine.startNodeId];
						newLine.endNodeId = nodeInfo[newLine.endNodeId];
						delete newLine.points;
						newLine.id = "L"+(++nowLineIndex);
						newLines.push(newLine);
					}
					//将嵌入的连线记录到嵌入的节点及连线信息对象中，key：当前嵌入子流程节点id
					newNodeAndLineInfo[nowFlow.nodes[i].id]["newLines"] = newLines;
					//添加标识，标识该节点已经初始化过
					nowFlow.nodes[i].isInit = "true";
					fdEmbeddedInfo.push({nodeId:nowFlow.nodes[i].id,fdRefId:nowFlow.nodes[i].embeddedRefId});
				}
			}
		}
		for(var nodeId in newNodeAndLineInfo){
			//遍历嵌入的节点及连线信息对象，将嵌入的节点及嵌入的连线合并到当前流程图对象中
			nowFlow.nodes = nowFlow.nodes.concat(newNodeAndLineInfo[nodeId]["newNodes"]);
			nowFlow.lines = nowFlow.lines.concat(newNodeAndLineInfo[nodeId]["newLines"]);
			//找出没有连入和连出的节点
			var noStartId = "";var noEndId = "";
			for(var i = 0;i<newNodeAndLineInfo[nodeId]["newNodes"].length;i++){
				var newNodeId = newNodeAndLineInfo[nodeId]["newNodes"][i].id;
				var isExitStart = false;var isExitEnd = false;
				for(var j = 0;j<newNodeAndLineInfo[nodeId]["newLines"].length;j++){
					if(newNodeAndLineInfo[nodeId]["newLines"][j].startNodeId == newNodeId){
						isExitStart = true;
					}
					if(newNodeAndLineInfo[nodeId]["newLines"][j].endNodeId == newNodeId){
						isExitEnd = true;
					}
				}
				if(!isExitStart){
					noStartId = newNodeId;
				}
				if(!isExitEnd){
					noEndId = newNodeId;
				}
			}
			//找到组之间的连线
			var line = getGroupLineById(nodeId,nowFlow);
			if(line!=null){
				//复制一份，一个修改startNodeId为没有连入节点，一个修改endNodeId为没有连出的节点
				var newLine = $.extend(true, {}, line);
				newLine.startNodeId = noStartId;
				line.endNodeId = noEndId;
				newLine.id = "L"+(++nowLineIndex);
				delete newLine.points;
				delete line.points;
				//添加复制的连线到当前流程图对象中
				nowFlow.lines.push(newLine);
			}
		}
		//嵌入子流程节点，fdRefId对应信息
		if(fdEmbeddedInfo.length>0){
			var processXMLObj = document.getElementsByName("sysWfBusinessForm.fdFlowContent")[0];
			//修改当前流程图对象的节点下标及连线下标
			nowFlow.nodesIndex = nowNodeIndex+"";
			nowFlow.linesIndex = nowLineIndex+"";
			//为fdFlowContent重新设值
			processXMLObj.value = WorkFlow_BuildXMLString(nowFlow);
			//lbpm.globals.parseXMLObj();
			if(!lbpm.modifys){
				lbpm.modifys = {};
			}
			$("input[name='sysWfBusinessForm.fdIsModify']")[0].value = "1";
			lbpm.lbpmEmbeddedInfo = fdEmbeddedInfo;
		}
	}
	
	//替换可修改和必须修改的节点Id
	lbpm.globals.replaceModifyHandlerNodeIds = function(nodes,nodeMap){
		var attMap = ["canModifyHandlerNodeIds","mustModifyHandlerNodeIds","canHandlerJumpNodeIds","nodeCanViewCurNodeIds","deRefuseNodeIds","refuseNodeIds"];
		for(var i=0;i<nodes.length; i++){
			var nodeObj = nodes[i];
			for(var h=0;h<attMap.length; h++){
				var attr = attMap[h];
				if(nodeObj[attr]){
					var oldIds = nodeObj[attr].split(";");
					for(var j = 0;j<oldIds.length;j++){
						if(nodeMap[oldIds[j]]){
							oldIds[j] = nodeMap[oldIds[j]];
						}
					}
					nodeObj[attr] = oldIds.join(";");
				}
			}
		}
	}
	
	//设置下一环节（即席子流程节点)
	lbpm.globals.setAdHocSubNode = function(){
		if ($("input[name='nextAdHocRouteId']").length == 1) {
			return;
		}
		var adHocSubFlowNode = lbpm.nodes[lbpm.nowAdHocSubFlowNodeId];
		var firstSubNode = lbpm.nodes[adHocSubFlowNode.startNodeId].endLines[0].endNode;
		
		//当前详版的流程图对象
		var nowFlow = WorkFlow_LoadXMLData(lbpm.globals.getProcessXmlString());
		
		var nextNodeObj = lbpm.globals.getNextNodeObj(lbpm.nowNodeId);
		// 重新进入即席子流程节点前要清除掉原来的子节点定义
		if (nextNodeObj.id == lbpm.nowAdHocSubFlowNodeId) {
			var getGroupSubStartLine = function(groupStartNodeId,flowInfo){
				for(var i=0;i<flowInfo.lines.length;i++){
					if(flowInfo.lines[i]["startNodeId"] == groupStartNodeId){
						return flowInfo.lines[i]; //获取组开始节点的流出线
					}
				}
				return null;
			};
			
			var deleteSubNodes = function(subNode, flowInfo){
				if (subNode.endLines.length > 0) {
					var targetNodeIndex = -1;
					for(var i=0;i<flowInfo.nodes.length;i++){
						if(flowInfo.nodes[i].id == subNode.id){
							var targetLineIndex = -1;
							for(var j=0;j<flowInfo.lines.length;j++){
								if(flowInfo.lines[j]["startNodeId"] == subNode.id){
									targetLineIndex = j;
									break;
								}
							}
							if (targetLineIndex != -1) {
								flowInfo.lines.splice(targetLineIndex,1); //移除连线
								targetNodeIndex = i;
								break;
							}
						}
					}
					if (targetNodeIndex != -1) {
						flowInfo.nodes.splice(targetNodeIndex,1); //移除组内子节点
					}
					
					deleteSubNodes(subNode.endLines[0].endNode, flowInfo);
				}
			};
			
			// 删除原组内子节点以及调整组内连线
			deleteSubNodes(firstSubNode,nowFlow);
			var subStartLine = getGroupSubStartLine(adHocSubFlowNode.startNodeId, nowFlow);
			subStartLine.endNodeId = adHocSubFlowNode.endNodeId;
			delete subStartLine.points;
		}
		
		//当前节点下标
		var nowNodeIndex = parseInt(nowFlow.nodesIndex, 10);
		//当前连线下标
		var nowLineIndex = parseInt(nowFlow.linesIndex, 10);
		//新旧节点ID对应关系,key:旧id，value:新id
		var nodeMap = {};
		// 添加被选中的route内的子节点到流程图内
		for (var i=0;i<lbpm.adHocRoutes.length; i++) {
			if (lbpm.adHocRoutes[i].startNodeId == lbpm.nextAdHocRouteId) {
				var adHocRoute = lbpm.adHocRoutes[i];
				var newNodes = [];
				for (var j=0;j<adHocRoute.subNodes.length; j++) {
					var subNodeObj = adHocRoute.subNodes[j].data;
					var subNode = $.extend(true, {}, subNodeObj);
					// 设置节点处理人id以及name信息
					subNode.routeId = lbpm.nextAdHocRouteId;
					subNode.sourceNodeId = subNodeObj.id;
					nodeMap[subNodeObj.id] = subNode.id = "N"+(++nowNodeIndex);
					subNode.x = -subNodeObj["x"];
					subNode.y = -subNodeObj["y"];
					subNode.groupNodeId = lbpm.nowAdHocSubFlowNodeId;
					subNode.groupNodeType = "adHocSubFlowNode";
					newNodes.push(subNode);
				}
				//替换可修改和必须修改的节点Id
				lbpm.globals.replaceModifyHandlerNodeIds(newNodes,nodeMap);
				var newLines = [];
				for(var j = 0;j<adHocRoute.subLines.length;j++){
					//复制被选中的route内的连线，根据记录新旧节点id对应关系修改连线的startNodeId，endNodeId
					var subLineObj = adHocRoute.subLines[j].data;
					var subLine = $.extend(true, {}, subLineObj);
					subLine.startNodeId = nodeMap[subLine.startNodeId];
					subLine.endNodeId = nodeMap[subLine.endNodeId];
					delete subLine.points;
					subLine.id = "L"+(++nowLineIndex);
					newLines.push(subLine);
				}
				
				//将被选中的route内的节点及连线合并到当前流程图对象中
				nowFlow.nodes = nowFlow.nodes.concat(newNodes);
				nowFlow.lines = nowFlow.lines.concat(newLines);
				
				var getGroupSubEndLine = function(groupEndNodeId,flowInfo){
					for(var j=0;j<flowInfo.lines.length;j++){
						if(flowInfo.lines[j]["endNodeId"] == groupEndNodeId){
							return flowInfo.lines[j];
						}
					}
					return null;
				}
				
				var line = getGroupSubEndLine(adHocSubFlowNode.endNodeId, nowFlow);
				var newLine = $.extend(true, {}, line);
				newLine.startNodeId = newNodes[newNodes.length-1].id;
				line.endNodeId = newNodes[0].id;
				newLine.id = "L"+(++nowLineIndex);
				delete newLine.points;
				delete line.points;
				nowFlow.lines.push(newLine);
				
				nowFlow.nodesIndex = nowNodeIndex+"";
				nowFlow.linesIndex = nowLineIndex+"";
			}
		}
		
		var processXMLObj = document.getElementsByName("sysWfBusinessForm.fdFlowContent")[0];
		processXMLObj.value = WorkFlow_BuildXMLString(nowFlow);
		if(!lbpm.modifys){
			lbpm.modifys = {};
		}
		$("input[name='sysWfBusinessForm.fdIsModify']")[0].value = "1";
	};
	
	submitFlow.getProcessXmlString = lbpm.globals.getProcessXmlString = function(){
		// 到服务器加载详细信息
		var processXml = document.getElementsByName("sysWfBusinessForm.fdFlowContent")[0].value;
		var data = new KMSSData();
		var fdIsModify=$("input[name='sysWfBusinessForm.fdIsModify']")[0];
		if(fdIsModify==null || fdIsModify.value!="1"){
			data.SendToUrl(Com_Parameter.ContextPath + "sys/lbpm/flowchart/page/detail.jsp?processId=" + lbpm.globals.getWfBusinessFormModelId(), function(req) {
				processXml = req.responseText;
			}, false);
		}
		var xmlObj = XML_CreateByContent(processXml);	
		var xmlNodes = XML_GetNodesByPath(xmlObj,"/*/nodes/*");
		if(xmlNodes && lbpm.modifys){
			$.each(lbpm.modifys, function(index, nodeData) {
				for(var i=0,l=xmlNodes.length;i <l;i++){
					if(xmlNodes[i].getAttribute("id") == nodeData.id){
						for(nodeField in nodeData){
							xmlNodes[i].setAttribute(nodeField,nodeData[nodeField]);
						}	
					}	
				}
			});	
		}	
		return (xmlObj.xml || new XMLSerializer().serializeToString(xmlObj));
	};

	submitFlow.setModifyParameterOnSubmit = lbpm.globals.setModifyParameterOnSubmit = function() {
		if(lbpm.modifys){
			var fdFlowContent=$("[name='sysWfBusinessForm.fdFlowContent']")[0];
			var fdIsModify=$("input[name='sysWfBusinessForm.fdIsModify']")[0];
			var jsonArr=new Array();
			if(fdIsModify.value!="1"){
				var nodesModifyXML="";
				$.each(lbpm.modifys, function(index, nodeData) {
					nodesModifyXML+=WorkFlow_BuildXMLString(nodeData,lbpm.nodes[index].XMLNODENAME, true);
				});
				if(nodesModifyXML!=""){
					nodesModifyXML="<process><nodes>"+nodesModifyXML+"</nodes></process>";
					//fdFlowContent.value=nodesModifyXML;
					//附加操作类型
					var jsonObj={};
					jsonObj.xml=nodesModifyXML;
					if(lbpm.globals.toRefuseThisNodeHandlerChange){
						jsonObj.toRefuseThisNodeHandlerChange = lbpm.globals.toRefuseThisNodeHandlerChange;
					}
					var paramObj={};
					paramObj.param=jsonObj;
					paramObj.type="additions_modifyNodeAttribute";
					jsonArr.push(paramObj);
				}
			}else{		
				fdFlowContent.value=lbpm.globals.getProcessXmlString();	
				//附加操作类型
				var jsonObj={};
				jsonObj.type="additions_modifyProcess";
				if (lbpm.nowFreeSubFlowNodeId != null || lbpm.nowAdHocSubFlowNodeId != null || lbpm.lbpmEmbeddedInfo) {
					jsonObj.type="additions_modifySubFlowNode";
					if(lbpm.lbpmEmbeddedInfo){
						jsonObj.lbpmEmbeddedInfo = lbpm.lbpmEmbeddedInfo;
					}
				}
				jsonObj.field="fdFlowContent";
				jsonArr.push(jsonObj); 			
			}
			if(jsonArr.length>0) {
				var additionParamObj=$("input[name='sysWfBusinessForm.fdAdditionsParameterJson']")[0];
				additionParamObj.value=lbpm.globals.objectToJSONString(jsonArr);
			}
		}
	};
	
	//提交人校验
	require(["dijit/registry","dojo/topic","dojo/dom-construct","dojo/dom-style","mui/dialog/Dialog","mui/util","dojo/_base/array","mui/i18n/i18n!sys-mobile"],
	 function(registry,topic,domConstruct,domStyle,Dialog,util,array,msg){
		
		
		window.createRolesListItem = function(props) {
			var itemRenderer = '<input type="checkbox" data-dojo-type="mui/form/CheckBox" name="_select_box_roles" value="!{value}" data-dojo-props="tag:\'li\',mul:false,text:\'!{text}\',checked:!{checked},pop:true">';
			itemRenderer = itemRenderer.replace(
					'!{text}', util.formatText(props.text.replace("'","&#039;"))).replace(
					'!{checked}', props.selected).replace(
					'!{value}', props.value);
			var item = domConstruct.toDom(itemRenderer);
			return item;
		};
		
		lbpm.globals.lbpmIdentityCheck= function(formObj, method, clearParameter, moreOptions){
			//暂存无需必填
			if(moreOptions && moreOptions.saveDraft){
				return true;
			}
			
			var handlerIdentityRow = document.getElementById("handlerIdentityRow");
			if(lbpm.nowNodeId=='N2' && Lbpm_SettingInfo['isShowDraftsmanStatus'] == 'true' 
					&& Lbpm_SettingInfo['isPopupWindowRemindSubmitter'] == 'true' && handlerIdentityRow.style.display != 'none'){
			 	
				var rolesSelectObj = registry.byId('rolesSelectObj');
 				if (rolesSelectObj == null) {
 					return;
 				}
 				
 				var handlerIdentityIdsObj = document.getElementById("sysWfBusinessForm.fdHandlerRoleInfoIds");
				var handlerIdentityNamesObj = document.getElementById("sysWfBusinessForm.fdHandlerRoleInfoNames");
				
				var handlerIdentityIds = handlerIdentityIdsObj.value;
 				var rolesIdsArray = handlerIdentityIds.split(";");
 				var handlerIdentityNames = handlerIdentityNamesObj.value;
 			    var handlerRoleInfoNames = lbpm.globals.getHandlerRoleInfoNamesByOrgConfig(handlerIdentityIds);
 				if(handlerRoleInfoNames){
 					handlerIdentityNames = handlerRoleInfoNames;
 				}
 			    var rolesNamesArray = handlerIdentityNames.split(";")
 				if(rolesIdsArray.length <= 1){//只有一个岗位时直接跳过
 					return true;
 				}
 				
 				var dialogNode = domConstruct.create('div', {
					className : 'muiCheckBoxPopWarp'
				});
				var listNode = domConstruct.create('ul', {
					className : 'muiRadioGroupPopList'
				},dialogNode);
				
				var data = [];
				var rolesValue = rolesSelectObj.get('value');
 				for (var i = 0; i < rolesIdsArray.length; i++) {
 					var obj = {value: rolesIdsArray[i], text: rolesNamesArray[i], selected : false};
 					if(rolesValue == rolesIdsArray[i]){
 						obj.selected = true;
 					}
 					data.push(obj);
 				}
				
 				for(var i = 0;i<data.length;i++){
 					var listItem = createRolesListItem(data[i]);
 					listNode.appendChild(listItem);
 				}
 				
				var buttons = [{
					title:msg['mui.button.cancel'],
					fn : function(dialog) {
						dialog.hide();
					}
				},{
					title:msg['mui.button.ok'],
					fn : function(dialog) {
						array.forEach(dialog.htmlWdgts,function(wdt){
							if (wdt && wdt.name == '_select_box_roles' && wdt.checked) {
								rolesSelectObj.set('value',wdt.value);
								return false;
							}
						});
						lbpm.isLbpmIdentityCheck = true;
						dialog.hide();
						//回调
						Com_Submit(formObj, method, clearParameter, moreOptions);//回调Com_submit函数
					}
				}];
				var rolesDialog = Dialog.element({
					canClose : false,
					showClass : 'muiDialogElementShow muiFormSelect',
					element : dialogNode,
					buttons : buttons,
					position:'bottom',
					'scrollable' : false,
					'parseable' : true
				});
				var title = domConstruct.toDom("<div class='muiDialogElementButton_bottom' style='width:50%;float:left;'><bean:message bundle='sys-lbpmservice' key='lbpmProcess.processor.identity.validate.title' /></div>");
				domConstruct.place(title, rolesDialog.buttonsDom[0],'after');
				domStyle.set(title,'font-size','1.7rem');
				domStyle.set(rolesDialog.buttonsDom[0],'width','15%');
				domStyle.set(rolesDialog.buttonsDom[1],'width','15%');
				domStyle.set(title,'width','70%');
				return false;
			}
			return true;
		};
	 });
	
	/**
	 *  版本冲突进行覆盖提交时需要先进行校验或者正常提交校验
 	 * 目的是校验会审/会签支持人工决策（最后一个需要进行人工决策的处理）
	 */
	window.validateBeforeSumbitVersion = lbpm.globals.validateBeforeSumbitVersion = function(){
		if(!lbpm || !lbpm.nowNodeId){
			return true;
		}
		
		/*会审/会签人工决策校验*/
		//先进行操作判断，如果不满足给定的操作则默认通过，给定的操作是通过即将流向设置方法全局搜索得到的可能性，和产品沟通是通过和签字才有
		var opers = ["handler_pass","handler_giveup","drafter_submit","handler_sign"];
		if(lbpm.currentOperationType && opers.indexOf(lbpm.currentOperationType) == -1){
			return true;
		}
		
		var currentNodeObj = lbpm.nodes[lbpm.nowNodeId];
		var nextNodeObj = lbpm.globals.getNextNodeObj(lbpm.nowNodeId);
		if(!currentNodeObj || !nextNodeObj 
			|| (lbpm.nowProcessorInfoObj.type != "reviewWorkitem"
			&& lbpm.nowProcessorInfoObj.type != "signWorkitem")
			|| nextNodeObj.nodeDescType != "manualBranchNodeDesc" 
			|| currentNodeObj.processType != "2"
			|| !lbpm.globals.isLastHandler()){
			return true;
		}
		
		//若是最后一个处理人（会审/会签+人工决策），需要将即将流程内容设置为可编辑，并校验
		lbpm.noValidateFutureNode = false;//需要校验
		var operationsTDContent = document.getElementById("operationsTDContent");
		var html = lbpm.globals.generateNextNodeInfo();
		lbpm.globals.innerHTMLGenerateNextNodeInfo(html, operationsTDContent);
		
		//执行校验进行定位
		return lbpm.globals.common_operationCheckForPassType();
	};
	
	Com_Parameter.event["submit"][Com_Parameter.event["submit"].length] = lbpm.globals.submitFormEvent;
	require(["dojo/request","dojo/query"],function(request,query){
		//暂存时保存流程相关的参数
		Com_Parameter.event["submit"].push(function(formObj, method, clearParameter, moreOptions){
			var docStatus = document.getElementsByName("docStatus")[0].value;
			if(!(docStatus=="10" || docStatus=="11")){
				return true;
			}
		
			var fdModelId =  document.getElementsByName("sysWfBusinessForm.fdModelId")[0].value;
			var fdModelName =  document.getElementsByName("sysWfBusinessForm.fdModelName")[0].value;
			var fdKey =  document.getElementsByName("sysWfBusinessForm.fdKey")[0].value;
		
			if(moreOptions && !moreOptions.saveDraft){
				var url = Com_Parameter.ContextPath + "sys/lbpm/engine/jsonp.jsp";
				var pjson = {
					"s_bean" : "lbpmTempStorageDataBean",
					"fdModelId" : fdModelId,
					"fdModelName" : fdModelName,
					"fdKey" : fdKey,
					"op" : "delete",
					"_d" : new Date().toString()
				};
				request.post(url,{data:pjson,handleAs:'json'}).then(
					function(data){
						//errcode=0
					},
					function(error){
						//errcode=1
					}
				);
				return true;
			}
		
			var tdata = {};
			
			//如果有分支设置分支
			var futureNodeCheckboxs=query("input[name='futureNode'][type='checkbox']");
			//判断是并行分支还是人工决策分支（如checkbox类型则是并行分支）
			if(futureNodeCheckboxs.length>0){
				//启动并行分支是多选，所以单独处理
				tdata["futureNode"]="";
				query("input[name='futureNode']:checked").forEach(function(domObj){
					tdata["futureNode"]+=tdata["futureNode"]==""?domObj.value:","+domObj.value;
				});		
			}
			else{
				query("input[name='futureNode']:checked").forEach(function(domObj){
					tdata["futureNode"]=domObj.value;
				});
			}
			
		
			//通知方式优先级 
			query("input[name='sysWfBusinessForm.fdNotifyLevel']:checked").forEach(function(domObj){
				tdata["fdNotifyLevel"] = domObj.value;
			});
		
			//意见--auditNode
			var fdUsageContent =  document.getElementsByName("fdUsageContent")[0].value;
			tdata["fdUsageContent"] = fdUsageContent;
		
			var data = lbpm.globals.objectToJSONString(tdata);
			var url = Com_Parameter.ContextPath + "sys/lbpm/engine/jsonp.jsp";
			var pjson = {
				"s_bean" : "lbpmTempStorageDataBean",
				"fdModelId" : fdModelId,
				"fdModelName" : fdModelName,
				"fdKey" : fdKey,
				"op" : "add",
				"fdData" :data,
				"_d" : new Date().toString()
			};
			request.post(url,{data:pjson,handleAs:'json'}).then(
				function(data){
					//errcode=0
				},
				function(error){
					//errcode=1
				}
			);
			return true;
		});
	});
	return submitFlow;
});
require(["dojo/ready","dojo/request","dojo/query","dojo/topic","dijit/registry"],function(ready,request,query,topic,registry){
	//暂存时加载流程相关的参数
	topic.subscribe('initComplete',function(){
		var docStatus = document.getElementsByName("docStatus")[0].value;
		if(!(docStatus=="10" || docStatus=="11")){
			return ;
		}
	
		var fdModelId =  document.getElementsByName("sysWfBusinessForm.fdModelId")[0].value;
		var fdModelName =  document.getElementsByName("sysWfBusinessForm.fdModelName")[0].value;
		var fdKey =  document.getElementsByName("sysWfBusinessForm.fdKey")[0].value;
		var url = Com_Parameter.ContextPath + "sys/lbpm/engine/jsonp.jsp";
		var pjson = {
			"s_bean" : "lbpmTempStorageDataBean",
			"fdModelId" : fdModelId,
			"fdModelName" : fdModelName,
			"fdKey" : fdKey,
			"op" : "get",
			"_d" : new Date().toString()
		};
		request.post(url,{data:pjson,handleAs:'json'}).then(
			function(json){
				if(json["errcode"]=="0"){
					var fdUsageContent = document.getElementsByName("fdUsageContent");
					if(fdUsageContent[0] != null){
						fdUsageContent[0].value=json["fdUsageContent"]||"";
					}
				}
			},
			function(error){
				//errcode=1
			}
		);
	});
});