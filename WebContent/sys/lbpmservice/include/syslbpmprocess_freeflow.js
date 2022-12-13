//<--------------自由流JS------------->
//引入jquery-ui，排序用，有的模块没引会报错，这里再引一次
Com_IncludeFile('jquery.ui.js', 'js/jquery-ui/');
lbpm.freeFlow = new Array();
lbpm.freeFlow.defOperRefId = null;
lbpm.freeFlow.defOperRefSignId = null;
lbpm.freeFlow.defFlowPopedom = null;

// 选人添加节点(地址本返回值，节点类型（默认审批节点），开始节点Id)
lbpm.globals.addNodeInFreeFlow=function(rtv,nodeType,beginId) {
	var rtvData = rtv.data;
	if (rtvData.length > 0){
		nodeType = nodeType||"reviewNode";
		if(nodeType=="reviewNode"){
			if (!lbpm.freeFlow.defOperRefId) {
				var data = new KMSSData();
				data.AddBeanData("getOperTypesByNodeService&nodeType=freeFlowReviewNode");
				data = data.GetHashMapArray();
				for(var j=0;j<data.length;j++){
					if(data[j].isDefault=="true"){
						lbpm.freeFlow.defOperRefId = data[j].value;
						break;
					}
				}
			}
		}else if(nodeType=="signNode"){
			if (!lbpm.freeFlow.defOperRefSignId) {
				var data = new KMSSData();
				data.AddBeanData("getOperTypesByNodeService&nodeType=freeFlowSignNode");
				data = data.GetHashMapArray();
				for(var j=0;j<data.length;j++){
					if(data[j].isDefault=="true"){
						lbpm.freeFlow.defOperRefSignId = data[j].value;
						break;
					}
				}
			}
		}
		if(!lbpm.freeFlow.defFlowPopedom){
			lbpm.freeFlow.defFlowPopedom = (Lbpm_SettingInfo["defaultFlowPopedom"] > lbpm.nodes[lbpm.nowNodeId].flowPopedom)?lbpm.nodes[lbpm.nowNodeId].flowPopedom:Lbpm_SettingInfo["defaultFlowPopedom"];
		}
		var FlowChartObject = getFreeFlowChartObject();
		var newNodeObj,beginNode;
		if(beginId){
			beginNode = FlowChartObject.Nodes.GetNodeById(beginId);
		}else{
			var endNodeObj = FlowChartObject.Nodes.GetNodeById("N3");
			beginNode = endNodeObj.LineIn[0].StartNode;
		}
		newNodeObj = FlowChartObject.Nodes.createNodeInFreeFlow(beginNode,nodeType);
		FlowChartObject.Nodes.initNodeDataInFreeFlow(newNodeObj);
		for (var i=0; i<rtvData.length; i++) {
			if (i > 0) {
				newNodeObj.Data["handlerNames"]+=";";
				newNodeObj.Data["handlerIds"]+=";";
			}
			newNodeObj.Data["handlerNames"]+=rtvData[i].name;
			newNodeObj.Data["handlerIds"]+=rtvData[i].id;
		}
		if(nodeType=="reviewNode"){
			newNodeObj.Data["operations"]["refId"]=lbpm.freeFlow.defOperRefId;
		}else if(nodeType=="signNode"){
			newNodeObj.Data["operations"]["refId"]=lbpm.freeFlow.defOperRefSignId;
		}
		if(nodeType=="reviewNode"||nodeType=="signNode"){
			newNodeObj.Data["flowPopedom"]=lbpm.freeFlow.defFlowPopedom;
			newNodeObj.Data["canAddAuditNoteAtt"]=Lbpm_SettingInfo["isCanAddAuditNoteAtt"];
			newNodeObj.Data["canModifyMainDoc"]=Lbpm_SettingInfo["isEditMainDocument"];
			newNodeObj.Data["processType"]="2";
		}
		newNodeObj.Data["notifyType"]=Lbpm_SettingInfo["defaultNotifyType"];
		lbpm.myAddedNodes.push(newNodeObj.Data.id);
		beginNode = newNodeObj;
		//更新流程图
		lbpm.globals.reflushFreeFlow();
		//更新节点列表
		lbpm.globals.updateFreeFlowNodeUL();
		//新增节点默认选中
		$(".lbpm_freeflow_draglist_li[data-node-id='"+newNodeObj.Data.id+"']").click();
		if(!beginId){
			$('.lbpm_freeflow_draglist').scrollTop($('.lbpm_freeflow_draglist')[0].scrollHeight);
		}
	}
}

// 自由流行的节点构建
function appendFreeFlowNodeLI(nodeObj, flowNodeUL){
	var nodeId = nodeObj.endLines[0].endNode.id;
	if (nodeId == "N3") {
		return;
	}
	var node = lbpm.nodes[nodeId];
	var html = "";
	var handlerNames = "";
	var handlerDisplayNames = "";
	if(nodeId == "N2"){
		handlerNames = handlerDisplayNames = $("[name='sysWfBusinessForm.fdDraftorName']").val();
	}
	if (node.handlerNames) {
		var handlerIds = node.handlerIds==null?"":node.handlerIds;
		handlerNames = node.handlerNames;
		var dataNextNodeHandler;
		var nextNodeHandlerNames4View="";
		if(node.handlerSelectType){
			if (node.handlerSelectType=="formula") {
				dataNextNodeHandler=lbpm.globals.formulaNextNodeHandler(handlerIds,true,lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SEND,node));
			} else if (node.handlerSelectType=="matrix") {
				dataNextNodeHandler=lbpm.globals.matrixNextNodeHandler(handlerIds,true,lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SEND,node));
			} else if (node.handlerSelectType=="rule") {
				dataNextNodeHandler=lbpm.globals.ruleNextNodeHandler(node.id,handlerIds,true,lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SEND,node));
			} else {
				dataNextNodeHandler=lbpm.globals.parseNextNodeHandler(handlerIds,true,lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SEND,node));
			}
			for(var j=0;j<dataNextNodeHandler.length;j++){
				if(nextNodeHandlerNames4View==""){
					nextNodeHandlerNames4View=dataNextNodeHandler[j].name;
				}else{
					nextNodeHandlerNames4View+=";"+dataNextNodeHandler[j].name;
				}
			}
		}
		if(nextNodeHandlerNames4View == "" && node.handlerIds != null) {
			nextNodeHandlerNames4View = lbpm.constant.COMMONNODEHANDLERORGNULL;
		}
		if(nextNodeHandlerNames4View){
			handlerNames = nextNodeHandlerNames4View;
		}
		var namesArray = handlerNames.split(";");
		// 根据流转方式决定分隔符的具体显示
		var delimiter = ";";
		if (node.processType == "1") {
			delimiter = "/";
		} else if (node.processType == "2") {
			delimiter = "+";
		}
		if (delimiter!=";") {
			handlerNames = handlerNames.replace(/;/g,delimiter);
		}
		// 控制显示长度
		var totalLength=0, maxLength=31;
		if(lbpm && lbpm.approveType == "right"){
			maxLength=10;
		}
		for (var i=0;i<namesArray.length;i++) {
			if (totalLength + namesArray[i].length < maxLength) {
				if (handlerDisplayNames != "") {
					handlerDisplayNames += delimiter + namesArray[i];
				} else {
					handlerDisplayNames += namesArray[i];
				}
			} else {
				if (handlerDisplayNames!="") {
					handlerDisplayNames += delimiter + "...";
				} else {
					handlerDisplayNames = namesArray[i].slice(0,maxLength) + "...";
				}
				break;
			}
			totalLength = handlerDisplayNames.length;
		}
	}
	//节点简称
	var sortName = WorkFlow_getLangLabel(node.name,node["langs"],"nodeName");//lbpm.nodedescs[node.nodeDescType].getSortName();
	//是否可以移动排序
	var isCanMove = node.Status == lbpm.constant.STATUS_NORMAL;
	//图片标识及title
	var statusClassAndTitle = "lbpm_freeflow_status_normal'";
	//节点是否可以编辑
	var canUpdate = false;
	if (node.Status == lbpm.constant.STATUS_NORMAL && node.isFixedNode != 'true') {
		if (lbpm.nowNodeFlowPopedom=="2") {
			canUpdate = true;
		} else if (lbpm.nowNodeFlowPopedom=="1") {
			if (lbpm.myAddedNodes.contains(node.id)) {
				canUpdate = true;
			}
		}
	}
	//编辑流程图按钮是否出现
	var canShowOperation = false;
	var editFreeFlowDIV = document.getElementById("editFreeFlowDIV");
	if(editFreeFlowDIV && editFreeFlowDIV.style.display!="none"){
		canShowOperation = true;
	}
	if(canUpdate && canShowOperation){
		statusClassAndTitle += " title='"+lbpm.constant.FREEFLOW_TIELE_DRAG+"'";
	}
	if(node.isFixedNode == 'true'){
		statusClassAndTitle = "lbpm_freeflow_status_fixed' title='"+lbpm.constant.FREEFLOW_TIELE_FIXED+"'";
	}
	if (node.Status == "2"){
		statusClassAndTitle = "lbpm_freeflow_status_passed' title='"+lbpm.constant.FREEFLOW_TIELE_PASSED+"'";
	} else if (node.Status == "3"){
		statusClassAndTitle = "lbpm_freeflow_status_running' title='"+lbpm.constant.FREEFLOW_TIELE_RUNNING+"'";
	}
	html =  "<li class='"+(isCanMove?"lbpm_freeflow_draglist_li canMove":(node.Status == "2"?
			"lbpm_freeflow_draglist_li_passed":"lbpm_freeflow_draglist_li"))+ 
			(node.isFixedNode == 'true'?" fixed":"")+(!canUpdate ?" fixed":"")+
			"' data-node-id='"+nodeId+"' data-node-type='"+node.XMLNODENAME+"' onclick='lbpmFreeFlowChangeActive(this);'>" +
			"<div class='lbpm_freeflow_item'>" +
			"<i class='lbpm_freeflow_status "+statusClassAndTitle+"></i>" +
			"<div class='lbpm_freeflow_sortName lbpm_freeflow_sortName_"+node.XMLNODENAME+"' title='"+sortName+"'>"+sortName+"</div>" +
			"<div class='lbpm_freeflow_handlerName' title='"+handlerNames+"'>";
	//if (node.handlerSelectType=="org") {
		html+="<input type='hidden' name='freeflow_"+nodeId+"_handlerIds' value='"+(node.handlerIds||"")+"'/>" +
			"<input type='hidden' name='freeflow_"+nodeId+"_handlerNames' value='"+(node.handlerNames||"")+"'/>";
	//}
	if(!handlerDisplayNames && node.isFixedNode != 'true'){
		handlerDisplayNames = lbpm.constant.FREEFLOW_TIELE_ADDHANDLER+"<span class='txtstrong'>*</span>";
	}
	if (canShowOperation && canUpdate){
		html+="<span onclick='lbpmFreeFlowUpdateHandler(this)'>"+handlerDisplayNames+"</span>";
	}else{
		html+="<span>"+handlerDisplayNames+"</span>";
		//html+="<span ajax-href='/ekp/sys/zone/resource/zoneInfo.jsp?fdId="+node.handlerIds+"' onmouseover='if(window.LUI && lbpm && lbpm.person)lbpm.person(event,this,\"flowNodeUL\");'>"+handlerDisplayNames+"</span>";
	}
	html+="</div>";
	if (canShowOperation && node.Status != lbpm.constant.STATUS_PASSED){
		html+="<div class='lbpm_freeflow_operation'>"+
		"<a class='lbpm_freeflow_add' title='"+lbpm.constant.FREEFLOW_TIELE_ADD+"'><i></i></a>";
		if (canUpdate){
			html+="<a class='lbpm_freeflow_edit' title='"+lbpm.constant.FREEFLOW_TIELE_EDIT+"'><i></i></a>";
			html+="<a class='lbpm_freeflow_delete' title='"+lbpm.constant.FREEFLOW_TIELE_DELETE+"'><i></i></a>";
		}
		html+="</div>";
	} 
	html+= "</div><div class='lbpm_freeflow_split'></div></li>" ;
	if(flowNodeUL[0].innerHTML==""){
		flowNodeUL.html(html);
	}else{
		flowNodeUL.append(html);
	}
	appendFreeFlowNodeLI(node, flowNodeUL);
}

function getFreeFlowChartObject(){
	var sysWfBusinessFormPrefix = $("input[name='sysWfBusinessFormPrefix']").val();
	return document.getElementById(sysWfBusinessFormPrefix + "WF_IFrame").contentWindow.FlowChartObject;
}

//修改处理人（仅选中且可编辑的才能更改）
function lbpmFreeFlowUpdateHandler(dom){
	var $activeLi = $(dom).closest(".lbpm_freeflow_draglist_li");
	var $handlerInfoDiv = $(dom).closest(".lbpm_freeflow_handlerName");
	if($activeLi.hasClass("active")){
		var oldHandlerIds = $handlerInfoDiv.find("input[name$=handlerIds]").val();
		var idField = $handlerInfoDiv.find("input[name$=handlerIds]").attr("name");
		var nameField = $handlerInfoDiv.find("input[name$=handlerNames]").attr("name");
		var nodeId = $activeLi.attr("data-node-id");
		var node = lbpm.nodes[nodeId];
		if(node){
			var callback = function(){
				var handlerIds = $handlerInfoDiv.find("input[name$=handlerIds]").val();
				if(oldHandlerIds!=handlerIds){
					var nodeId = $activeLi.attr("data-node-id");
					var handlerNames = $handlerInfoDiv.find("input[name$=handlerNames]").val();
					var FlowChartObject = getFreeFlowChartObject();
					var node = FlowChartObject.Nodes.GetNodeById(nodeId);
					node.Data["handlerIds"]=handlerIds;
					node.Data["handlerNames"]=handlerNames;
					node.Refresh();
					lbpm.globals.reflushFreeFlow();
					lbpmFreeFlowChangeHandlerInfo(node,$handlerInfoDiv);
				}
			}
			if(node.handlerSelectType=='org'){
				var nodeType = $activeLi.attr("data-node-type");
				var orgType = ORG_TYPE_POSTORPERSON | ORG_TYPE_ROLE;;
				if(nodeType=="sendNode"){
					orgType = ORG_TYPE_ALL | ORG_TYPE_ROLE;;
				}
				selectByOrg(idField,nameField,orgType,callback);
			}else if(node.handlerSelectType=='matrix'){
				selectByMatrix(idField,nameField,callback);
			}else if(node.handlerSelectType=='formula'){
				selectByFormula(idField,nameField,callback);
			}
		}
	}
}

//使用组织架构选择
function selectByOrg(idField, nameField, orgType, callback){
	var orgType = ORG_TYPE_POSTORPERSON | ORG_TYPE_ROLE;
	Dialog_Address(true, idField, nameField, null, orgType, callback);
}

//使用公式定义器选择
function selectByFormula(idField, nameField, callback){
	Formula_Dialog(idField,
			nameField,
			lbpm.globals.getFormFieldList(), 
			"com.landray.kmss.sys.organization.model.SysOrgElement[]",
			callback,
			"com.landray.kmss.sys.lbpm.engine.formula.LbpmFunction",
			lbpm.modelName);
}

//使用矩阵组织选择
function selectByMatrix(idField, nameField, callback){
	// 弹出矩阵组织设置窗口
	var dialog = new KMSSDialog();
	dialog.FormFieldList = lbpm.globals.getFormFieldList();
	dialog.ModelName = lbpm.modelName;
	dialog.BindingField(idField, nameField);
	dialog.URL = Com_Parameter.ContextPath + "sys/lbpmservice/node/common/node_handler_matrix_config.jsp";
	var size = getSizeForAddress();
	dialog.SetAfterShow(callback);
	dialog.Show(size.width, size.height);
}

//更改节点列表显示信息（包括处理人及提示）
function lbpmFreeFlowChangeHandlerInfo(node,$handlerInfoDiv,needUpdate){
	if(!lbpm.freeFlow.emptyHandlerNodes){
		lbpm.freeFlow.emptyHandlerNodes = [];
	}
	var index = $.inArray(node.Data["id"],lbpm.freeFlow.emptyHandlerNodes);
	if(node.Data["handlerIds"]){
		if(index>-1){
			lbpm.freeFlow.emptyHandlerNodes.splice(index,1);
		}
	}else{
		if(index<0){
			lbpm.freeFlow.emptyHandlerNodes.push(node.Data["id"]);
		}
	}
	var handlerNames = node.Data.handlerNames;
	var dataNextNodeHandler;
	var nextNodeHandlerNames4View="";
	var nodeObj = lbpm.nodes[node.Data["id"]];
	if(nodeObj.handlerSelectType){
		var handlerIds = nodeObj.handlerIds==null?"":nodeObj.handlerIds;
		if (nodeObj.handlerSelectType=="formula") {
			dataNextNodeHandler=lbpm.globals.formulaNextNodeHandler(handlerIds,true,lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SEND,nodeObj));
		} else if (nodeObj.handlerSelectType=="matrix") {
			dataNextNodeHandler=lbpm.globals.matrixNextNodeHandler(handlerIds,true,lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SEND,nodeObj));
		} else if (nodeObj.handlerSelectType=="rule") {
			dataNextNodeHandler=lbpm.globals.ruleNextNodeHandler(nodeObj.id,handlerIds,true,lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SEND,nodeObj));
		} else {
			dataNextNodeHandler=lbpm.globals.parseNextNodeHandler(handlerIds,true,lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SEND,nodeObj));
		}
		for(var j=0;j<dataNextNodeHandler.length;j++){
			if(nextNodeHandlerNames4View==""){
				nextNodeHandlerNames4View=dataNextNodeHandler[j].name;
			}else{
				nextNodeHandlerNames4View+=";"+dataNextNodeHandler[j].name;
			}
		}
	}
	if(nextNodeHandlerNames4View == "" && nodeObj.handlerIds != null) {
		nextNodeHandlerNames4View = lbpm.constant.COMMONNODEHANDLERORGNULL;
	}
	if(nextNodeHandlerNames4View){
		handlerNames = nextNodeHandlerNames4View;
	}
	var titleHandlerName = handlerNames;
	var handlerDisplayNames = "";
	var namesArray = handlerNames.split(";");
	// 根据流转方式决定分隔符的具体显示
	var delimiter = ";";
	if (node.Data.processType == "1") {
		delimiter = "/";
	} else if (node.Data.processType == "2") {
		delimiter = "+";
	}
	if (delimiter!=";") {
		titleHandlerName = handlerNames.replace(/;/g,delimiter);
	}
	// 控制显示长度
	var totalLength=0, maxLength=31;
	if(lbpm && lbpm.approveType == "right"){
		maxLength=10;
	}
	for (var i=0;i<namesArray.length;i++) {
		if (totalLength + namesArray[i].length < maxLength) {
			if (handlerDisplayNames != "") {
				handlerDisplayNames += delimiter + namesArray[i];
			} else {
				handlerDisplayNames += namesArray[i];
			}
		} else {
			if (handlerDisplayNames!="") {
				handlerDisplayNames += delimiter + "...";
			} else {
				handlerDisplayNames = namesArray[i].slice(0,maxLength) + "...";
			}
			break;
		}
		totalLength = handlerDisplayNames.length;
	}
	$handlerInfoDiv.attr("title",titleHandlerName);
	if(!handlerDisplayNames || handlerDisplayNames === lbpm.constant.COMMONNODEHANDLERORGEMPTY){
		handlerDisplayNames = lbpm.constant.FREEFLOW_TIELE_ADDHANDLER+"<span class='txtstrong'>*</span>";
	}
	$handlerInfoDiv.find("span").html(handlerDisplayNames);
	if(needUpdate){
		$handlerInfoDiv.find("input[name$=handlerIds]").val(node.Data["handlerIds"]);
		$handlerInfoDiv.find("input[name$=handlerNames]").val(node.Data["handlerNames"]);
		var nodeName = WorkFlow_getLangLabel(node.Data["name"],node.Data["langs"],"nodeName");
		$handlerInfoDiv.prev(".lbpm_freeflow_sortName").attr("title",nodeName).text(nodeName);
	}
}

//更改选中的节点
function lbpmFreeFlowChangeActive(dom){
	if($(dom).hasClass("lbpm_freeflow_draglist_li_passed")){
		return;
	}
	$(".lbpm_freeflow_draglist").find('.lbpm_freeflow_draglist_li').removeClass('active');
	$(dom).addClass('active');
}

// 自由流行内删除节点
function deleteFreeFlowNode(dom){
	var nodeId = $(dom).closest("li.lbpm_freeflow_draglist_li").attr("data-node-id");
	lbpm.globals.delNodeInFreeFlow(nodeId);
	$(dom).closest("li.lbpm_freeflow_draglist_li").remove();
	if(lbpm.freeFlow.emptyHandlerNodes){
		var index = $.inArray(nodeId,lbpm.freeFlow.emptyHandlerNodes);
		if(index>-1){
			lbpm.freeFlow.emptyHandlerNodes.splice(index,1);
		}
	}
}

//删除节点
lbpm.globals.delNodeInFreeFlow=function(nodeId) {
	var FlowChartObject = getFreeFlowChartObject();
	var delNodeObj = FlowChartObject.Nodes.GetNodeById(nodeId);
	FlowChartObject.Nodes.deleteNodeInFreeFlow(delNodeObj);
	lbpm.globals.reflushFreeFlow();
}

//更新流程图
lbpm.globals.reflushFreeFlow=function() {
	var FlowChartObject = getFreeFlowChartObject();
	var flowXml = FlowChartObject.BuildFlowXML();
	if (!flowXml)
		return;
	var processXMLObj = document.getElementsByName("sysWfBusinessForm.fdFlowContent")[0];
	processXMLObj.value = flowXml;
	lbpm.globals.parseXMLObj();
	lbpm.modifys = {};
	$("input[name='sysWfBusinessForm.fdIsModify']")[0].value = "1";
	lbpm.events.mainFrameSynch();
}

// 更新整个自由流行的显示
lbpm.globals.updateFreeFlowNodeUL=function(isInit) {
	var flowNodeUL = $("#flowNodeUL");
	if(flowNodeUL.length > 0){
		flowNodeUL.html('');
		appendFreeFlowNodeLI(lbpm.nodes["N1"], flowNodeUL);
		//选中当前节点
		$(".lbpm_freeflow_draglist .lbpm_freeflow_status_running").closest("li.lbpm_freeflow_draglist_li").addClass("active");
		var canShowOperation = false;
		var editFreeFlowDIV = document.getElementById("editFreeFlowDIV");
		if(editFreeFlowDIV && editFreeFlowDIV.style.display!="none"){
			canShowOperation = true;
		}
		if(canShowOperation){
			//初始化拖动排序
			var sortableParam = {
				items : "li.canMove",
				cancel : "li.fixed",
				placeholder : 'lbpm_freeflow_placeholder',
				update : function(event, ui){
					//排序后更新流程图
					var FlowChartObject = getFreeFlowChartObject();
					//更新前节点连线信息（开始节点为key，连线及结束节点的对象）
					var oldInfo = {};
					for(var i=0; i<FlowChartObject.Lines.all.length; i++){
						var line = FlowChartObject.Lines.all[i].Data;
						if(!oldInfo[line.startNodeId]){
							oldInfo[line.startNodeId]={};
						}
						oldInfo[line.startNodeId]["lineId"] = line.id;
						oldInfo[line.startNodeId]["endNodeId"] = line.endNodeId;
					}
					//当前按顺序排列的节点
					var newInfo = [];
					newInfo.push("N1");
					$(".lbpm_freeflow_draglist").children("li").each(function(){
						newInfo.push($(this).attr("data-node-id"));
					});
					newInfo.push("N3");
					//按新顺序，若当前节点和下一节点与旧信息中不一致，则认为发生改变，获得旧信息中的连线重新连接当前节点及下一节点
					for(var i=0;i<newInfo.length-1;i++){
						var beginNode = FlowChartObject.Nodes.GetNodeById(newInfo[i]);
						var endNode = FlowChartObject.Nodes.GetNodeById(newInfo[i+1]);
						if(oldInfo[newInfo[i]] && oldInfo[newInfo[i]]["endNodeId"] && oldInfo[newInfo[i]]["endNodeId"]!=newInfo[i+1]){
							var line = FlowChartObject.Lines.GetLineById(oldInfo[newInfo[i]]["lineId"]);
							if(line){
								line.LinkNode(beginNode, endNode, '3', '1');
								line.Refresh(FlowChartObject.LINE_REFRESH_TYPE_DOM);
							}
						}
						//刷新结束节点坐标为开始节点想x,y+80
						endNode.MoveTo(beginNode.Data.x, beginNode.DOMElement.trans.y + 20*4);
					}
					//更新流程图
					lbpm.globals.reflushFreeFlow();
				}
			};
			var num = setInterval(function(){//兼容Safari最新版没办法动态加载COM_INCLUDEFILE导致的sortable找不到问题 122229 by suyb
				if(typeof $(".lbpm_freeflow_draglist").sortable !== 'undefined' && $(".lbpm_freeflow_draglist").sortable){
					clearInterval(num);
					$(".lbpm_freeflow_draglist").sortable(sortableParam);
				}
			}, 200)
			$(".lbpm_freeflow_add").mouseover(function(){
				var nodeId = $(this).closest("li.lbpm_freeflow_draglist_li").attr("data-node-id");
				$(".lbpm_freeflow_add_moreList").attr("data-node-id",nodeId);
				$(".lbpm_freeflow_add_moreList").show();
				var left = $(this).offset().left-$(".lbpm_freeflow_add_moreList").width()/2+14;
				var top = $(this).offset().top+23;
				var h = document.documentElement.scrollTop || document.body.scrollTop;
				$(".lbpm_freeflow_add_moreList").css({
					"left" : left,
				    "top" : top-h
				});
			});
			$(".lbpm_freeflow_add").mouseout(function(){
				var event = window.event;
				var toEle = event.toElement || event.relatedTarget;
		    	if(toEle && $(toEle).closest('.lbpm_freeflow_add_moreList').length>0){
		    		var $li =  $(this).closest("li.lbpm_freeflow_draglist_li");
		    		if(!$li.hasClass("active")){
		    			$li.addClass("temp");
		    		}
		    		return;
		    	}
				$(".lbpm_freeflow_add_moreList").hide();
			});
			$(".lbpm_freeflow_edit").click(function(){
				var $li = $(this).closest("li.lbpm_freeflow_draglist_li");
				var nodeId = $li.attr("data-node-id");
				var FlowChartObject = getFreeFlowChartObject();
				var editNodeObj = FlowChartObject.Nodes.GetNodeById(nodeId);
				editNodeObj.ShowAttributePanel(function(Node){
					lbpm.globals.reflushFreeFlow();
					lbpmFreeFlowChangeHandlerInfo(Node,$li.find(".lbpm_freeflow_handlerName"),true);
				});
			});
			$(".lbpm_freeflow_delete").click(function(){
				var _self = this;
				if (window.LUI) {
					seajs.use(['lui/dialog'], function(dialog) {
						dialog.confirm(lbpm.constant.FREEFLOW_DELETENODEMSG,function(data){
							if(data){
								deleteFreeFlowNode(_self);
							}
						});
					});
				}else{
					if(confirm(lbpm.constant.FREEFLOW_DELETENODEMSG)){
						deleteFreeFlowNode(_self);
					}
				}
			});
			//节点名称切换
			$(".lbpm_freeflow_sortName").mouseover(function(){
				//没有编辑权限，不显示切换节点名称下拉
				if($(this).parent().find("a.lbpm_freeflow_edit").length==0){
					return;
				}
				if($(".lbpm_freeflow_sortName_nameList").length==0){
					var html = "<ul class='lbpm_freeflow_sortName_nameList'>";
					//加载节点名列表
					var data = new KMSSData();
					data.AddBeanData("lbpmBaseInfoService");
					data = data.GetHashMapArray();
					if(data.length>0 && data[0].nodeNameSelectItem!=null && data[0].nodeNameSelectItem!=""){
						var nodeNameList = data[0].nodeNameSelectItem.split(";");
						for(var i=0; i<nodeNameList.length; i++){
							html+="<li>"+nodeNameList[i]+"</li>";
						}
					}
					html+="</ul>"
					$("#flowNodeDIV").append(html);
					$(".lbpm_freeflow_sortName_nameList").mouseout(function(){
						var event = window.event;
						var toEle = event.toElement || event.relatedTarget;
				    	if(toEle && $(toEle).closest('.lbpm_freeflow_sortName_nameList').length>0){
				    		return;
				    	}
						$(this).hide();
					});
					$(".lbpm_freeflow_sortName_nameList li").click(function(){
						var nodeId = $(this).parent().attr("data-node-id");
						var $li = $(".lbpm_freeflow_draglist_li[data-node-id='"+ nodeId +"']");
						var FlowChartObject = getFreeFlowChartObject();
						var nodeObj = FlowChartObject.Nodes.GetNodeById(nodeId);
						var newName = $(this).text();
						nodeObj.Data["name"] = newName;
						if(nodeObj.Data["langs"]){
							var langs = JSON.parse(nodeObj.Data["langs"]);
							if(langs["nodeName"] && _userLang){
								for(var i=0;i<langs["nodeName"].length;i++){
									if(langs["nodeName"][i]["lang"]==_userLang){
										langs["nodeName"][i]["value"]=newName;
										break;
									}
								}
								nodeObj.Data["langs"] = JSON.stringify(langs);
							}
						}
						lbpm.globals.reflushFreeFlow();
						$li.find(".lbpm_freeflow_sortName").attr("title",newName).text(newName);
						$(".lbpm_freeflow_sortName_nameList").hide();
					});
				}
				if($(".lbpm_freeflow_sortName_nameList li").length>0){
					var nodeId = $(this).closest("li.lbpm_freeflow_draglist_li").attr("data-node-id");
					$(".lbpm_freeflow_sortName_nameList").attr("data-node-id",nodeId);
					$(".lbpm_freeflow_sortName_nameList").show();
					var left = $(this).offset().left-$(".lbpm_freeflow_sortName_nameList").width()/2+$(this).width()/2;
					var top = $(this).offset().top+20;
					var h = document.documentElement.scrollTop || document.body.scrollTop;
					$(".lbpm_freeflow_sortName_nameList").css({
						"left" : left,
					    "top" : top-h
					});
				}
			});
			$(".lbpm_freeflow_sortName").mouseout(function(){
				var event = window.event;
				var toEle = event.toElement || event.relatedTarget;
		    	if(toEle && $(toEle).closest('.lbpm_freeflow_sortName_nameList').length>0){
		    		return;
		    	}
				$(".lbpm_freeflow_sortName_nameList").hide();
			});
			//流转方式切换
			$(".lbpm_freeflow_status").mouseover(function(){
				//没有编辑权限，不显示切换流转方式下拉
				if($(this).parent().find("a.lbpm_freeflow_edit").length==0){
					return;
				}
				if($(".lbpm_freeflow_process_typeList").length==0){
					var html = "<ul class='lbpm_freeflow_process_typeList'>";
					html+="<li data-value='"+lbpm.constant.PROCESSTYPE_SERIAL+"'>"+lbpm.constant.COMMONNODEHANDLERPROCESSTYPESERIAL+"</li>";
					html+="<li data-value='"+lbpm.constant.PROCESSTYPE_SINGLE+"'>"+lbpm.constant.COMMONNODEHANDLERPROCESSTYPESINGLE+"</li>";
					html+="<li data-value='"+lbpm.constant.PROCESSTYPE_ALL+"'>"+lbpm.constant.COMMONNODEHANDLERPROCESSTYPEALL+"</li>";
					html+="</ul>"
					$("#flowNodeDIV").append(html);
					$(".lbpm_freeflow_process_typeList").mouseout(function(){
						var event = window.event;
						var toEle = event.toElement || event.relatedTarget;
				    	if(toEle && $(toEle).closest('.lbpm_freeflow_process_typeList').length>0){
				    		return;
				    	}
						$(this).hide();
					});
					$(".lbpm_freeflow_process_typeList li").click(function(){
						var nodeId = $(this).parent().attr("data-node-id");
						var $li = $(".lbpm_freeflow_draglist_li[data-node-id='"+ nodeId +"']");
						var $handlerInfoDiv =$li.find(".lbpm_freeflow_handlerName");
						var FlowChartObject = getFreeFlowChartObject();
						var nodeObj = FlowChartObject.Nodes.GetNodeById(nodeId);
						nodeObj.Data["processType"] = $(this).attr("data-value");
						lbpm.globals.reflushFreeFlow();
						$(".lbpm_freeflow_process_typeList").hide();
						lbpmFreeFlowChangeHandlerInfo(nodeObj,$handlerInfoDiv);
					});
				}
				var nodeId = $(this).closest("li.lbpm_freeflow_draglist_li").attr("data-node-id");
				$(".lbpm_freeflow_process_typeList").attr("data-node-id",nodeId);
				if(lbpm.nodes[nodeId] && lbpm.nodes[nodeId]["processType"]){
					$(".lbpm_freeflow_process_typeList li").removeClass("checked");
					$(".lbpm_freeflow_process_typeList li[data-value='"+lbpm.nodes[nodeId]["processType"]+"']").addClass("checked");
					$(".lbpm_freeflow_process_typeList").show();
					var left = $(this).offset().left-$(".lbpm_freeflow_process_typeList").width()/2+$(this).width()/2;
					var top = $(this).offset().top+20;
					var h = document.documentElement.scrollTop || document.body.scrollTop;
					$(".lbpm_freeflow_process_typeList").css({
						"left" : left,
					    "top" : top-h
					});
				}
			});
			$(".lbpm_freeflow_status").mouseout(function(){
				var event = window.event;
				var toEle = event.toElement || event.relatedTarget;
		    	if(toEle && $(toEle).closest('.lbpm_freeflow_process_typeList').length>0){
		    		return;
		    	}
				$(".lbpm_freeflow_process_typeList").hide();
			});
			if(isInit){
				$(".lbpm_freeflow_add_moreList").mouseout(function(){
					var event = window.event;
					var toEle = event.toElement || event.relatedTarget;
			    	if(toEle && $(toEle).closest('.lbpm_freeflow_add_moreList').length>0){
			    		return;
			    	}
			    	$(".lbpm_freeflow_draglist_li[data-node-id='"+ $(this).attr("data-node-id")+"']").removeClass('temp');
			    	$(this).hide();
				});
				$(".lbpm_freeflow_add_moreList li").click(function(){
					var nodeType = $(this).attr("data-node-type");
					var nodeId = $(this).parent().attr("data-node-id");
					lbpm.flow_chart_load_Frame();
					var orgType = ORG_TYPE_POSTORPERSON;
					if(nodeType=="sendNode"){
						orgType = ORG_TYPE_ALL;
					}
					Dialog_Address(true, null, null, null, orgType, function myFunc(rtv){
						lbpm.globals.addNodeInFreeFlow(rtv,nodeType,nodeId);
					});
					$(".lbpm_freeflow_add_moreList").hide();
				});
			}
		}
	}
}

//初始化公式定义器所需的变量
lbpm.globals.initFreeFlowFormList = function(){
	var sysWfBusinessFormPrefix = $("input[name='sysWfBusinessFormPrefix']").val();
	var iframe = document.getElementById(sysWfBusinessFormPrefix + "WF_IFrame").contentWindow;
	if(iframe && iframe.FlowChartObject && iframe.FlowChartObject.FormFieldList){
		iframe.FlowChartObject.FormFieldList = lbpm.globals.getFormFieldList();
	}else{
		setTimeout(lbpm.globals.initFreeFlowFormList,500);
	}
}

// 查看自由流的流程图
lbpm.globals.viewFreeFlow=function(contentField, statusField){
	var fieldList = lbpm.globals.getFormFieldList();

	if(typeof(_thirdSysFormList) == "object" ){//第三方系统集成表单参数
		fieldList = fieldList.concat(_thirdSysFormList);
	}
	
	var param = {
		processData: document.getElementsByName(contentField)[0].value,
		statusData: document.getElementsByName(statusField)[0].value,
		Window:window,
		FormFieldList:fieldList,
	};
	var fdIsAllowSetupApprovalType="0";
	var fdTemplateModelName = document.getElementById("sysWfBusinessForm.fdTemplateModelName").value;
	var fdTemplateKey = document.getElementById("sysWfBusinessForm.fdTemplateKey").value;
	var modelName = lbpm.globals.getWfBusinessFormModelName();
	var flowPopedom = lbpm.nowNodeFlowPopedom;
	var url='/sys/lbpm/flowchart/page/freeflowPanel.jsp?edit=false&extend=oa&template=false&flowType=1&flowPopedom='+ flowPopedom +'&modelName='+modelName+'&deployApproval=' + fdIsAllowSetupApprovalType + '&templateModel=' + fdTemplateModelName + '&templateKey=' + fdTemplateKey + "&modelId=" + lbpm.globals.getWfBusinessFormModelId() + "&popup=true";
	Com_Parameter.Dialog = param;
	seajs.use(['lui/jquery','lui/dialog'], function($, dialog) {
			dialog.iframe(url,lbpm.constant.FREEFLOW,function(rtn){
			},{width:1080,height:640,params:param});
	});
}

//自由流私密意见
lbpm.globals.setPrivateOpinion=function(dom){
	if ($(dom).is(":checked")) {
		$("#privateOpinionCanViewTr").show();
		$("input[name='privateOpinionCanViewNames']").attr("validate","required");
	}else{
		$("#privateOpinionCanViewTr").hide();
		$("input[name='privateOpinionCanViewIds']").val("");
		$("input[name='privateOpinionCanViewNames']").val("").attr("validate","");
		$("#privateOpinionCanViewTr").closest("td").find(".validation-advice").hide();
	}
}

//自由流默认模板初始化
$(function(){
	$(".lbpm_freeflow_defaultTemp_btn").mouseover(function(){
		$(".lbpm_freeflow_defaultTemp_btnList").show();
		var left = $(this).offset().left-$(".lbpm_freeflow_defaultTemp_btnList").width()/2+$(this).width()/2;
		var top = $(this).offset().top+23;
		var h = document.documentElement.scrollTop || document.body.scrollTop;
		$(".lbpm_freeflow_defaultTemp_btnList").css({
			"left" : left,
		    "top" : top-h
		});
	});
	$(".lbpm_freeflow_defaultTemp_btn").mouseout(function(){
		var event = window.event;
		var toEle = event.toElement || event.relatedTarget;
    	if(toEle && $(toEle).closest('.lbpm_freeflow_defaultTemp_btnList').length>0){
    		return;
    	}
		$(".lbpm_freeflow_defaultTemp_btnList").hide();
	});
	$(".lbpm_freeflow_defaultTemp_btnList").mouseout(function(){
		var event = window.event;
		var toEle = event.toElement || event.relatedTarget;
    	if(toEle && $(toEle).closest('.lbpm_freeflow_defaultTemp_btnList').length>0){
    		return;
    	}
		$(".lbpm_freeflow_defaultTemp_btnList").hide();
	});
})

//自由流存为默认模板
lbpm.globals.saveFreeFlowDefaultTemp=function(){
	$(".lbpm_freeflow_defaultTemp_btnList").hide();
	//自由流检查处理人是否为空
	if (lbpm.freeFlow.emptyHandlerNodes && lbpm.freeFlow.emptyHandlerNodes.length>0){
		alert(lbpm.constant.FREEFLOW_TIELE_NODE+lbpm.freeFlow.emptyHandlerNodes.join("、")+lbpm.constant.FREEFLOW_TIELE_NOHANDLER);
		return;
	}
	if (window.LUI) {
		seajs.use(['lui/dialog'], function(dialog) {
			dialog.confirm(lbpm.constant.FREEFLOW_TIELE_SAVECONFIRM,function(data){
				if(data){
					lbpm.globals.saveFreeFlowTemp();
				}
			});
		});
	}else{
		if(confirm(lbpm.constant.FREEFLOW_TIELE_SAVECONFIRM)){
			lbpm.globals.saveFreeFlowTemp();
		}
	}
}

//自由流保存默认模板
lbpm.globals.saveFreeFlowTemp=function(){
	var processXMLObj = document.getElementsByName("sysWfBusinessForm.fdFlowContent")[0];
	var url = Com_Parameter.ContextPath + 'sys/lbpmservice/support/lbpmFreeflowDefaultTempAction.do?method=saveOrUpdateDefaultTemp';
	var data = {"fdProcessId":lbpm.modelId,"fdContent":processXMLObj.value};
	$.ajax({
		type : "POST",
		data : data,
		url : url,
		async : false,
		dataType : "json",
		success : function(json){
			if (window.LUI) {
				seajs.use(['lui/dialog'], function(dialog) {
					dialog.alert(json.msg);
				});
			}else{
				alert(json.msg);
			}
		},
		beforeSend : function() {
			if (window.LUI) {
				seajs.use(['lui/dialog'], function(dialog) {
					window.freeflow_save = dialog.loading();
				});
			}
		},
		complete : function() {
			if (window.LUI) {
				seajs.use(['lui/dialog'], function(dialog) {
					if(window.freeflow_save != null) {
						window.freeflow_save.hide(); 
					}
				});
			}
		}
	});
}

//自由流加载默认模板
lbpm.globals.loadFreeFlowDefaultTemp=function(){
	$(".lbpm_freeflow_defaultTemp_btnList").hide();
	var url = Com_Parameter.ContextPath + 'sys/lbpmservice/support/lbpmFreeflowDefaultTempAction.do?method=loadFreeFlowDefaultTemp';
	var data = {"fdProcessId":lbpm.modelId};
	$.ajax({
		type : "POST",
		data : data,
		url : url,
		async : false,
		dataType : "json",
		success : function(json){
			if(json && json.status){
				if(json.status == "00"){
					var param={};
				    param.xml=json.fdContent;
					lbpm.events.fireListener(lbpm.constant.EVENT_MODIFYPROCESS,param);
				}
				if (window.LUI) {
					seajs.use(['lui/dialog'], function(dialog) {
						dialog.alert(json.msg);
					});
				}else{
					alert(json.msg);
				}
			}
		},
		beforeSend : function() {
			if (window.LUI) {
				seajs.use(['lui/dialog'], function(dialog) {
					window.freeflow_load = dialog.loading();
				});
			}
		},
		complete : function() {
			if (window.LUI) {
				seajs.use(['lui/dialog'], function(dialog) {
					if(window.freeflow_load != null) {
						window.freeflow_load.hide(); 
					}
				});
			}
		}
	});
}

//提交时，去掉handlerIds，handlerNames值，此值无用且不去掉，为矩阵之类时会出非法字符提示
Com_Parameter.event["confirm"].push(function(){
	$(".lbpm_freeflow_draglist .lbpm_freeflow_draglist_li,.lbpm_freeflow_draglist_li_passed").each(function(){
		var $handlerInfoDiv = $(this).find(".lbpm_freeflow_handlerName");
		$handlerInfoDiv.find("input[name$=handlerIds]").val("");
		$handlerInfoDiv.find("input[name$=handlerNames]").val("");
	})
	return true;
});
//提交失败，更新节点列表，因上面去掉了handlerIds，handlerNames值，需重新添加
Com_Parameter.event["submit_failure_callback"].push(function(){
	//更新节点列表
	lbpm.globals.updateFreeFlowNodeUL();
});