<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>

<table width="590px" id="Label_Tabel">
	<tr LKS_LabelName="<kmss:message key="FlowChartObject.Lang.Label_Base" bundle="sys-lbpm-engine" />">
		<td>
			<table width="100%" class="tb_normal" id="config_table">
				<c:import url="/sys/lbpm/engine/node/common/node_name_attribute.jsp" charEncoding="UTF-8" />
				<tr>
					<td width="100px"><kmss:message key="FlowChartObject.Lang.Node.concurrencyBranchJoinType" bundle="sys-lbpm-engine-node-joinnode" /></td>
					<td width="490px" id="config_type">
						<div>
							<label><input type="radio" name="wf_joinType" value="all" checked onclick="switchJoinType();"><kmss:message key="FlowChartObject.Lang.Node.concurrencyBranchJoinAllType" bundle="sys-lbpm-engine-node-joinnode" /></label>
							<label><input type="radio" name="wf_joinType" value="anyone" onclick="switchJoinType();"><kmss:message key="FlowChartObject.Lang.Node.concurrencyBranchJoinAnyoneType" bundle="sys-lbpm-engine-node-joinnode" /></label>
							<label><input type="radio" name="wf_joinType" value="formula" onclick="switchJoinType();"><kmss:message key="FlowChartObject.Lang.Node.concurrencyBranchJoinFormulaType" bundle="sys-lbpm-engine-node-joinnode" /></label>
							<label><input type="radio" name="wf_joinType" value="custom" onclick="switchJoinType();"><kmss:message key="FlowChartObject.Lang.Node.concurrencyBranchJoinCustomType" bundle="sys-lbpm-engine-node-joinnode" /></label>
						</div>
						<div joinType="formula" style="display:none;">
							<input type="hidden" name="wf_formulaJoinTypeValue">
							<input name="wf_formulaJoinTypeText" class="inputsgl" readonly style="width:80% ">
							<a href="#" onclick="openExpressionEditor();"><kmss:message key="FlowChartObject.Lang.Line.formula" bundle="sys-lbpm-engine" /></a>
						</div>
						<div joinType="custom" style="display:none;">
							<input type="hidden" name="wf_customJoinTypeValue">
							<input name="wf_customJoinTypeText" class="inputsgl" readonly style="width:80% ">
							<a href="#" onclick="Dialog_Address(false, 'wf_customJoinTypeValue', 'wf_customJoinTypeText', null, ORG_TYPE_POSTORPERSON);"><kmss:message key="FlowChartObject.Lang.select" bundle="sys-lbpm-engine" /></a>
							<span class="txtstrong">*</span>
						</div>
					</td>
				</tr>
				<tr>
					<td width="100px"><kmss:message key="FlowChartObject.Lang.Line.tip" bundle="sys-lbpm-engine" /></td>
					<td width="490px">
					<kmss:message key="FlowChartObject.Lang.Node.concurrencyBranchJoinTipInfo" bundle="sys-lbpm-engine-node-joinnode" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr LKS_LabelName="<kmss:message key="FlowChartObject.Lang.Label_Event" bundle="sys-lbpm-engine" />">
		<td>
		<c:import url="/sys/lbpm/flowchart/page/node_event_attribute.jsp" charEncoding="UTF-8" />
		</td>
	</tr>
	<c:import url="/sys/lbpmservice/node/common/node_custom_notify_attribute.jsp" charEncoding="UTF-8">
		<c:param name="nodeType" value="${param.nodeType}" />
		<c:param name="modelName" value="${param.modelName }" />
	</c:import>
</table>
<script>
function openExpressionEditor() {
	Formula_Dialog(document.getElementsByName("wf_formulaJoinTypeValue")[0],
			document.getElementsByName("wf_formulaJoinTypeText")[0],
			FlowChartObject.FormFieldList,
			"Boolean",
			null,
			"com.landray.kmss.sys.lbpm.engine.formula.LbpmFunction;com.landray.kmss.sys.lbpm.engine.node.joinnode.JoinFunction",
			FlowChartObject.ModelName);
}

function switchJoinType() {
	var joinType = document.getElementsByName("wf_joinType"),
		i,
		typeValue,
		panel = document.getElementById("config_type");
	for (i = 0; i < joinType.length; i++) {
		if (joinType[i].checked) {
			typeValue = joinType[i].value;
			break;
		}
	}
	var rows = panel.getElementsByTagName('div');
	for (i = 0; i < rows.length; i++) {
		var row = rows[i];
		var attrType = row.getAttribute('joinType');
		if (attrType != null && attrType != '') {
			if (attrType == typeValue) {
				row.style.display = '';
			} else {
				row.style.display = "none";
			}
		}
	}
}

AttributeObject.Init.AllModeFuns.push(switchJoinType);

AttributeObject.CheckDataFuns.push(function(data) {
	if (data.joinType == "custom") {
		if (data.customJoinTypeValue == "") {
			alert('<kmss:message key="FlowChartObject.Lang.Node.concurrencyBranchJoinCustomJoinTypeValueNotNull" bundle="sys-lbpm-engine-node-joinnode" />');
			return false;
		}
	} else {
		data.customJoinTypeValue = "";
		data.customJoinTypeText = "";
	}
	
	if (data.joinType != "formula") {
		data.formulaJoinTypeValue = "";
		data.formulaJoinTypeText = "";
	}
});
</script>