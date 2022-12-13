<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="xlang"%>
<%@page import="com.landray.kmss.sys.lbpmservice.taglib.MultiLangTextGroupTag"%>

<table width="590px" id="Label_Tabel">
	<tr LKS_LabelName="<kmss:message key="FlowChartObject.Lang.Label_Base" bundle="sys-lbpm-engine" />">
		<td>
			<table width="100%" class="tb_normal" id="config_table">
				<c:import url="/sys/lbpm/engine/node/common/node_name_attribute.jsp" charEncoding="UTF-8" />
				<tr>
					<td width="100px"><kmss:message key="FlowChartObject.Lang.Node.embeddedId" bundle="sys-lbpmservice-node-group" /></td>
					<td>
						<input name="wf_embeddedRefId" type="hidden" />
						<input name="wf_embeddedName" class="inputsgl" style="width:400px" readonly />
						<span id="SPAN_SelectType1">
							<a href="javascript:void(0);" onclick="selectEmbeddedSubFlow(false, 'wf_embeddedRefId', 'wf_embeddedName', '选择嵌入子流程');"><kmss:message key="FlowChartObject.Lang.select" bundle="sys-lbpm-engine" /></a>
						</span>
					</td>
				</tr>
				<c:import url="/sys/lbpmservice/node/common/node_handler_common_operation.jsp" charEncoding="UTF-8" />
			</table>
		</td>
	</tr>
	<tr id="subFlowTr" LKS_LabelName="<kmss:message key="FlowChartObject.Lang.Node.subFlowChart" bundle="sys-lbpmservice-node-group" />" LKS_LabelId="subFlowChart">
		<td>
		<table style="width:100%;height:100%;" class="tb_normal">
			<tr>
				<td>
				<textarea name="fdSubFlowContent" style="display:none"></textarea>
				<input type="hidden" name="fdTranProcessXML">
				<iframe style="width:100%;height:398px;" scrolling="no" id="WF_IFrame"></iframe>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr LKS_LabelName="<kmss:message key="FlowChartObject.Lang.Label_Popedom" bundle="sys-lbpmservice" />" LKS_LabelId="node_right_tr">
		<td>
		<c:import url="/sys/lbpmservice/node/common/node_right_attribute.jsp" charEncoding="UTF-8" />
		</td>
	</tr>
</table>

<script>
AttributeObject.Init.AllModeFuns.unshift(function() {
	if (FlowChartObject.IsTemplate == true) {
		if(!AttributeObject.NodeData["embeddedRefId"]){
			Doc_HideLabelById("Label_Tabel","subFlowChart");
		}else{
			loadDefaultFlowByRefId();
		}
	}else{
		var NodeData = AttributeObject.NodeData;
		if(NodeData.isInit=="true" && NodeData["embeddedRefId"]){
			var subNodesXML = '<process><nodes></nodes><lines></lines></process>';
			document.getElementsByName("fdSubFlowContent")[0].value = subNodesXML;
			// 构建初始的空白子流程的processData
			var processData = new Array();
			processData.XMLNODENAME = "process";
			processData.nodes = new Array();
			processData.lines = new Array();
			
			var groupStartNode = FlowChartObject.Nodes.GetNodeById(NodeData.startNodeId);
			var subNodes = new Array();
			var subLines = new Array();
			var loadSubNodeLine = function(node) {
				if (node.Type != "groupStartNode" && node.Type != "groupEndNode") {
					// 子节点移除不必要的属性，避免转换成xml时异常
					if (node.Data.startLines) {
						delete node.Data.startLines;
						delete node.Data.endLines;
					}
					
					node.Data.x = -node.Data.x;
					node.Data.y = -node.Data.y;
					subNodes.push(node);
				}
				for (var i=0;i<node.LineOut.length;i++) {
					if (Com_ArrayGetIndex(subLines, node.LineOut[i]) == -1) {
						var nextNode = node.LineOut[i].EndNode;
						if (node.Type != "groupStartNode" && nextNode.Type != "groupEndNode") {
							subLines.push(node.LineOut[i]);
						}
						if(Com_ArrayGetIndex(subNodes, nextNode) == -1){
							loadSubNodeLine(nextNode);
						}
					}
				}
			};
			// 递归寻找出需要显示在子流程图的子节点和连线，并调整坐标，然后把节点以及连线的信息分别填充到processData的nodes和lines中
			loadSubNodeLine(groupStartNode);
			for (var i=0;i<subNodes.length;i++) {
				subNodes[i].FormatXMLData();
				processData.nodes.push(subNodes[i].Data);
			}
			for (var j=0;j<subLines.length;j++) {
				subLines[j].FormatXMLData();
				processData.lines.push(subLines[j].Data);
			}
			// 构建子流程的xml
			subNodesXML = WorkFlow_BuildXMLString(processData, "process");
			// 成功构建并取得子流程的xml后把子节点的坐标还原
			for (var i=0;i<subNodes.length;i++) {
				subNodes[i].Data.x = - subNodes[i].Data.x;
				subNodes[i].Data.y = - subNodes[i].Data.y;
			}
			
			// 填充子流程XML以及流转信息XML到指定隐藏域
			document.getElementsByName("fdSubFlowContent")[0].value = subNodesXML;
			document.getElementsByName("fdTranProcessXML")[0].value = WorkFlow_BuildXMLString(FlowChartObject.StatusData, "process-status", true);
			//iFrame加载子流程图	
			var loadUrl =  '<c:url value="/sys/lbpm/flowchart/page/panel.html" />?embedded=true&edit=false&extend=oa&contentField=fdSubFlowContent&showBar=false&showMenu=false';
			loadUrl += '&template=' + FlowChartObject.IsTemplate;
			loadUrl += '&modelName=' + FlowChartObject.ModelName + '&modelId=' + FlowChartObject.ModelId;
			if (FlowChartObject.StatusData != null) {
				loadUrl += '&statusField=fdTranProcessXML';
			}
			document.getElementById("WF_IFrame").setAttribute("src", loadUrl);
			setTimeout(function(FlowChartObject){
				$("#WF_IFrame").css("width","100%");
				$("#WF_IFrame").css("height","398px");
			},300);
			if (FlowChartObject.IsTemplate == false && FlowChartObject.IsEdit == false) {
				Doc_SetCurrentLabel("Label_Tabel", 2);
			}
		}else{
			loadDefaultFlowByRefId();
		}
	}
});

function loadDefaultFlowByRefId(){
	var ajaxurl = Com_Parameter.ContextPath + 'sys/lbpmservice/support/lbpmEmbeddedSubFlow.do?method=getContentByRefId&fdRefId=';
	ajaxurl += AttributeObject.NodeData["embeddedRefId"];
	var kmssData = new KMSSData();
	kmssData.SendToUrl(ajaxurl, function(http_request) {
		var responseText = http_request.responseText;
		var json = eval("("+responseText+")");
		if (json.fdContent){
			$("textarea[name='fdSubFlowContent']").val(json.fdContent);
			var loadUrl =  '<c:url value="/sys/lbpm/flowchart/page/panel.html" />?embedded=true&edit=false&extend=oa&contentField=fdSubFlowContent&showBar=false&showMenu=false';
			loadUrl += '&template=' + FlowChartObject.IsTemplate;
			loadUrl += '&modelName=' + FlowChartObject.ModelName + '&modelId=' + FlowChartObject.ModelId;
			document.getElementById("WF_IFrame").setAttribute("src", loadUrl);
		}
	},false);
}

function selectEmbeddedSubFlow(isMulti, idField, nameField, title){
	idField = document.getElementsByName(idField)[0];
	nameField = document.getElementsByName(nameField)[0];
	var dialog = new KMSSDialog(isMulti, true);
	dialog.BindingField(idField, nameField);
	dialog.winTitle = title;
	var node = dialog.CreateTree(title);
	node.AppendBeanData("lbpmEmbeddedSubFlowTreeService&type=cate&cateId=!{value}","lbpmEmbeddedSubFlowTreeService&type=doc&cateId=!{value}&modelName="+FlowChartObject.ModelName);
	dialog.SetAfterShow(function(rtnVal){
		if (rtnVal != null && rtnVal.data && rtnVal.data.length>0) {
			Doc_ShowLabelById("Label_Tabel","subFlowChart");
			$("textarea[name='fdSubFlowContent']").val(rtnVal.data[0].content);
			var loadUrl =  '<c:url value="/sys/lbpm/flowchart/page/panel.html" />?embedded=true&edit=false&extend=oa&contentField=fdSubFlowContent&showBar=false&showMenu=false';
			loadUrl += '&template=' + FlowChartObject.IsTemplate;
			loadUrl += '&modelName=' + FlowChartObject.ModelName + '&modelId=' + FlowChartObject.ModelId;
			setTimeout(function(){
				document.getElementById("WF_IFrame").setAttribute("src", loadUrl);
			},0);
		}
	});
	dialog.Show();
}

Com_AddEventListener(window, "load", function() {
	// 添加标签切换事件
	var table = document.getElementById("subFlowTr");
	while((table != null) && (table.tagName.toLowerCase() != "table")){
		table = table.parentNode;
	}
	if(table != null && window.Doc_AddLabelSwitchEvent){
		Doc_AddLabelSwitchEvent(table, "EmbeddedSubFlow_OnLabelSwitch");
	}
});

function EmbeddedSubFlow_OnLabelSwitch(tableName, index) {
	var trs = document.getElementById(tableName).rows;
	if(trs[index].id!="subFlowTr")
		return;
	setTimeout(function(){
		$("#WF_IFrame").css("width","100%");
		$("#WF_IFrame").css("height","398px");
	},300);
}
</script>