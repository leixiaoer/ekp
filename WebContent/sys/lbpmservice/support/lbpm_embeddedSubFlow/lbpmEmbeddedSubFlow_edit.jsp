<%@page import="com.landray.kmss.sys.xform.util.LangUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%-- <%@ include file="/sys/ui/jsp/jshead.jsp"%> --%>
<c:set var="sysFormTemplateFormPrefix" value="" />
<c:set var="fdKey" value="" />
<script src="<c:url value="/sys/lbpm/flowchart/js/workflow.js"/>"></script>
<script language="JavaScript">
	Com_IncludeFile("dialog.js");
	Com_IncludeFile("formula.js");
	Com_IncludeFile("data.js");
	
	//限定范围仅为一个时才允许使用跟主文档相关的变量
	function _GetSysDictObj(){
		var rtnVal = ""
		var scopeName = $("input[name='fdScopeId']").val();
		if (!scopeName){
			return rtnVal;
		}else{
			var scopeNameArr = new Array();
			scopeNameArr = scopeName.split(";");
			if (scopeNameArr.length === 1){
				return Formula_GetVarInfoByModelName(scopeName);
			}else{
				return rtnVal;
			}
		}
	}
	
	// 流程图初始内容，用于比较流程图内容是否有修改
	if(window.LBPM_Template_InitFlowContent == null) {
		LBPM_Template_InitFlowContent = new Array();
	}
	
	// 数据初始化
	function LBPM_Template_LoadProcessData(key) {
		var content = $("textarea[name='fdContent']").val();
		if(content == "") {
			LBPM_Template_InitFlowContent[key] = "";
		} else {
			var processData = WorkFlow_LoadXMLData(content);
			if(LBPM_Template_InitFlowContent[key] == "" || typeof(LBPM_Template_InitFlowContent[key]) == "undefined"){
				LBPM_Template_InitFlowContent[key] = WorkFlow_BuildXMLString(processData, "process");
			}
		}
	}

	Com_AddEventListener(window, "load", function() {
		LBPM_Template_LoadProcessData("lbpmEmbedded");
		// 添加标签切换事件
		var table = document.getElementById("embeddedFlowTr");
		while((table != null) && (table.tagName.toLowerCase() != "table")){
			table = table.parentNode;
		}
		if(table != null && window.Doc_AddLabelSwitchEvent){
			Doc_AddLabelSwitchEvent(table, "EmbeddedSubFlow_OnLabelSwitch");
		}
	});
	
	//标签切换时加载公式信息
	function EmbeddedSubFlow_OnLabelSwitch(tableName, index) {
		var trs = document.getElementById(tableName).rows;
		if(trs[index].id!="embeddedFlowTr")
			return;
		EmbeddedSubFlow_Load_FlowChartObject();
	}
	
	function EmbeddedSubFlow_Load_FlowChartObject(){
		var iframe = document.getElementById("Embedded_WF_IFrame").contentWindow;
		if(iframe && iframe.FlowChartObject){
			var LBPM_Template_FormFieldList = _GetSysDictObj();
			iframe.FlowChartObject.FormFieldList = LBPM_Template_FormFieldList;
		}else{
			setTimeout(EmbeddedSubFlow_Load_FlowChartObject,500);
		}
	}
	
	// 提交校验
	Com_Parameter.event["submit"][Com_Parameter.event["submit"].length] = function() {
		var key = "lbpmEmbedded";
		if(LBPM_Template_InitFlowContent[key] == null) {
			return false;
		} 
		var FlowChartObject = document.getElementById("Embedded_WF_IFrame").contentWindow.FlowChartObject;
		if(!FlowChartObject.CheckFlow(true)) {
			// 流程图校验
			return false;
		}
		//嵌入子流程流入流出校验
		if(FlowChartObject.Nodes.all.length==0){
			alert("<bean:message bundle='sys-lbpmservice-support' key='lbpmEmbeddedSubFlow.noNodeInfo'/>");
			return false;
		}
		var noLineInNum = 0;var noLineOutNum = 0;
		for(var i=0; i<FlowChartObject.Nodes.all.length; i++){
			var node = FlowChartObject.Nodes.all[i];
			//检查流入
			if(node.CanLinkInCount>0 && node.LineIn.length==0){
				noLineInNum++;
				if(!(node.Desc && !node.Desc.isBranch(node.Data))){
					FlowChartObject.SelectElement(node);
					alert("<bean:message bundle='sys-lbpmservice-support' key='lbpmEmbeddedSubFlow.lineOutInfo'/>");
					return false;
				}
			}
			//检查流出
			if(node.CanLinkOutCount>0 && node.LineOut.length==0){
				noLineOutNum++;
				if(!(node.Desc && !node.Desc.isBranch(node.Data))){
					FlowChartObject.SelectElement(node);
					alert("<bean:message bundle='sys-lbpmservice-support' key='lbpmEmbeddedSubFlow.lineOutInfo'/>");
					return false;
				}
			}
		}
		if(noLineInNum!=1 || noLineOutNum!=1){
			alert("<bean:message bundle='sys-lbpmservice-support' key='lbpmEmbeddedSubFlow.lineInfo'/>")
			return false;
		}
		// 判断到连线链接的不是分支节点，则不保存连线上的分支条件
		for(var i=0; i<FlowChartObject.Lines.all.length; i++){
			var line = FlowChartObject.Lines.all[i];
			if(line.Data.condition || line.Data.disCondition){
				var node = line.StartNode;
				if (node != null) {
					var nodeDescObj = node.Desc;
					if (nodeDescObj && !((nodeDescObj["isBranch"](node)) && !nodeDescObj["isHandler"](node))) {
						delete line.Data.condition;
						delete line.Data.disCondition;
					}
				}
			}
		}
		var processData = FlowChartObject.BuildFlowData();
		
		// 设置流程内容
		var xml = WorkFlow_BuildXMLString(processData, "process");
		$("textarea[name='fdContent']").val(xml);
		// 比较流程内容是否修改
		var _fdIsModified = $("input[name='fdIsModified']");
		if(LBPM_Template_InitFlowContent[key] != xml || _fdIsModified.val() == 'true') {
			_fdIsModified.val("true");
		} else {
			_fdIsModified.val("false");
		}
		return true;
	};

	//所属分类的弹框
	function lbpmEmbeddedSubFlowCategoryTreeDialog() {
		Dialog_Tree(false, 'fdCategoryId', 'fdCategoryName', ',', 
				'lbpmEmbeddedSubFlowCategoryTreeService&parentId=!{value}', 
				"${lfn:message('sys-lbpmservice-support:category.set')}", 
				null, null, null, null, null, 
				"${lfn:message('sys-lbpmservice-support:category.set')}");
	}
	
	//使用范围
	function lbpmEmbeddedSubFlowCategoryScopeDialog() {
		Dialog_Tree(true,'fdScopeId', 'fdScopeName',';','lbpmEmbeddedSubFlowScopeTreeService','<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.selectScope" />',false);
	}
	
</script>
<kmss:windowTitle moduleKey="sys-lbpmservice-support:table.lbpmEmbeddedSubFlow" subjectKey="sys-lbpmservice-support:lbpmEmbeddedSubFlow.templateSet" subject="${lbpmEmbeddedSubFlowForm.fdName}" />
<html:form action="/sys/lbpmservice/support/lbpmEmbeddedSubFlow.do" >
	<div id="optBarDiv">
		<c:if test="${lbpmEmbeddedSubFlowForm.method_GET=='edit'}">
			<%--更新--%>
			<input type=button value="<bean:message key="button.update"/>"
				onclick="Com_Submit(document.lbpmEmbeddedSubFlowForm, 'update');">
		</c:if>
		 <c:if test="${lbpmEmbeddedSubFlowForm.method_GET=='add' || lbpmEmbeddedSubFlowForm.method_GET=='clone'}">
		 	<%--新增--%>
			<input type=button value="<bean:message key="button.save"/>"
				onclick="Com_Submit(document.lbpmEmbeddedSubFlowForm, 'save');">
			<input type=button value="<bean:message key="button.saveadd"/>"
				onclick="Com_Submit(document.lbpmEmbeddedSubFlowForm, 'saveadd');">
		</c:if> 
			<%--关闭--%>
			<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
	</div>
	
	<p class="txttitle">
		<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.templateSet" />
	</p>
	<center>
	<script>
		Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
	</script> 
	<table id="Label_Tabel" width=95%>
		<tr LKS_LabelName="<bean:message bundle='sys-lbpmservice-support' key='lbpmEmbeddedSubFlow.basicInfo'/>">
			<td>
				<table class="tb_normal" width=100%>
					<html:hidden property="fdId" />
					<%--节点集名称--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.fdName" />
						</td>
						<td width=85% colspan="3">
							<xform:text property="fdName" style="width:80%;" required="true"></xform:text>
						</td>
					</tr>
					<%--类别--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.fdCatoryName" />
						</td>
						<td width=85% colspan="3">
							<xform:dialog required="true" subject="${lfn:message('sys-lbpmservice-support:lbpmEmbeddedSubFlow.fdCatoryName') }" propertyId="fdCategoryId" style="width:80%"
								propertyName="fdCategoryName" dialogJs="lbpmEmbeddedSubFlowCategoryTreeDialog()">
							</xform:dialog>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.state" />
						</td>
						<td width=85% colspan="3">
							<xform:radio property="fdIsAvailable" showStatus="edit" >
								<xform:simpleDataSource value="true"><bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.state.enable" />&nbsp;&nbsp;</xform:simpleDataSource>
								<xform:simpleDataSource value="false"><bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.state.disable" />&nbsp;&nbsp;</xform:simpleDataSource>
							</xform:radio>
							<c:if test="${lbpmEmbeddedSubFlowForm.fdIsAvailable==null }">
								<script type="text/javascript">
									$("input[name='fdIsMobileView']:first").attr('checked', 'checked');
								</script>
							</c:if>
						</td>
					</tr>
					<!-- 排序号 -->
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.fdOrder" />
						</td>
						<td width=85% colspan="3">
							<xform:text property="fdOrder" style="width:80%;" validators="digits min(0)" />
						</td>
					</tr>
					 <!-- 使用范围 -->
					 <tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.scope" />
						</td>
						<td width=85% colspan="3">
							<!-- 被选中的模板ID集合“;”分割 -->
							<xform:text property="fdScopeId" showStatus="noShow"></xform:text>
							<xform:textarea property="fdScopeName" showStatus="edit" style="width:96%" htmlElementProperties="readOnly onclick='lbpmEmbeddedSubFlowCategoryScopeDialog();'"></xform:textarea>
							<a href="javascript:void(0);" onclick="lbpmEmbeddedSubFlowCategoryScopeDialog();"><bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.selectScope" /></a>
							<br>
							<bean:message key="lbpmEmbeddedSubFlow.scope.desc" bundle="sys-lbpmservice-support"/>
						</td>
					</tr>
					<%--说明--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message key="lbpmEmbeddedSubFlow.fdDesc" bundle="sys-lbpmservice-support"/>
						</td>
						<td width=85% colspan="3"><html:textarea property="fdDesc" style="width:97%;" /></td>
					</tr>
					<!-- 可维护者 -->
					<tr>
						<td class="td_normal_title" width=15%><bean:message key="model.tempEditorName" /></td>
						<td colspan="3">
							<xform:address textarea="true" mulSelect="true" propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
							<div class="description_txt">
								<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.description.cate.tempEditor" />
							</div>
						</td>
					</tr>
					<%---新建时，不显示 创建人，创建时间 ---%>
	               <c:if test="${lbpmEmbeddedSubFlowForm.method_GET=='edit'}">
						<tr>
							<!-- 创建人员 -->
							<td class="td_normal_title" width=15%>
								<bean:message key="model.fdCreator" />
							</td>
							<td width=35%>
								<html:text property="docCreatorName" readonly="true" style="width:50%;" />
							</td>
							
							<!-- 创建时间 -->
							<td class="td_normal_title" width=15%>
								<bean:message key="model.fdCreateTime" />
							</td>
							<td width=35%>
								<html:text property="docCreateTime" readonly="true" style="width:50%;" />
							</td>
						</tr>
						<c:if test="${not empty lbpmEmbeddedSubFlowForm.docAlterorName}">
							<tr>
								<!-- 修改人 -->
								<td class="td_normal_title" width=15%>
									<bean:message key="model.docAlteror" />
								</td>
								<td width=35%>
									<html:text property="docAlterorName" readonly="true" style="width:50%;" />
								</td>
								
								<!-- 修改时间 -->
								<td class="td_normal_title" width=15%>
									<bean:message key="model.fdAlterTime" />
								</td>
								<td width=35%>
									<html:text property="docAlterTime" readonly="true" style="width:50%;" />
								</td>
							</tr>
						</c:if>
					</c:if>
			</table>
			</td>
		</tr>
  			
		<tr id="embeddedFlowTr" LKS_LabelName="<bean:message bundle='sys-lbpmservice-support' key='lbpmEmbeddedSubFlow.flowInfo'/>">
		 	<td>
		 		<html:hidden property="fdIsModified" />
		 		<html:textarea property="fdContent" style="display:none"/>
		 		<iframe src="<c:url value="/sys/lbpm/flowchart/page/panel.html" />?embedded=true&edit=true&extend=oa&template=true&contentField=fdContent&isEmpty=true&FormFieldList=FlowChartObject.FormFieldList"
				style="width:100%;height:500px" scrolling="no" id="Embedded_WF_IFrame"></iframe>
		 	</td>
		</tr>	
	</table>
	</center>
	
	<html:hidden property="method_GET" />
	<script>
		$KMSSValidation();
	</script>
</html:form>

<%@ include file="/resource/jsp/edit_down.jsp"%>
