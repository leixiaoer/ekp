<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<script>
	Com_IncludeFile("dialog.js");
	Com_Parameter.IsAutoTransferPara = true;
	function confirmDelete(msg) {
		var del = confirm("<bean:message key="page.comfirmDelete"/>");
		return del;
	}
</script>
<kmss:windowTitle moduleKey="sys-lbpmservice-support:table.lbpmEmbeddedSubFlow" subjectKey="sys-lbpmservice-support:lbpmEmbeddedSubFlow.templateSet" subject="${lbpmEmbeddedSubFlowForm.fdName}" />

<div id="optBarDiv">
	<kmss:auth
		requestURL="/sys/lbpmservice/support/lbpmEmbeddedSubFlow.do?method=edit&fdId=${param.fdId}"
		requestMethod="GET">
		<input type="button" value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('lbpmEmbeddedSubFlow.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth
		requestURL="/sys/lbpmservice/support/lbpmEmbeddedSubFlow.do?method=delete&fdId=${param.fdId}"
		requestMethod="GET">
		<input type="button" value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('lbpmEmbeddedSubFlow.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle">
	<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.templateSet" />
</p>
<script>
	Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
</script> 
<center>
	<html:hidden name="lbpmEmbeddedSubFlowForm" property="fdId" />
	<table id="Label_Tabel" width=95%>
		<!-- 基本信息 -->
		<tr LKS_LabelName="<bean:message bundle='sys-lbpmservice-support' key='lbpmEmbeddedSubFlow.basicInfo'/>">
			<td>
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.fdName" />
						</td>
						<td width=85% colspan="3">
							<bean:write name="lbpmEmbeddedSubFlowForm" property="fdName" />
						</td>
					</tr>
					<%--适用类别--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.fdCatoryName" />
						</td>
						<td width=85% colspan="3">
							<bean:write name="lbpmEmbeddedSubFlowForm" property="fdCategoryName" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.state" />
						</td>
						<td width=85% colspan="3">
							<c:if test="${lbpmEmbeddedSubFlowForm.fdIsAvailable}">
								<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.fdIsAvailable.true" />
							</c:if>
							<c:if test="${!lbpmEmbeddedSubFlowForm.fdIsAvailable}">
								<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.fdIsAvailable.false" />
							</c:if>
						</td>
					</tr>
					<!-- 排序号 -->
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.fdOrder" />
						</td>
						<td width=85% colspan="3">
							<bean:write property="fdOrder" name="lbpmEmbeddedSubFlowForm" />
						</td>
					</tr>
					<!-- 使用范围 -->
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice-support" key="lbpmEmbeddedSubFlow.scope" />
						</td>
						<td width=85% colspan="3">
							<bean:write property="fdScopeName" name="lbpmEmbeddedSubFlowForm" />
						</td>
					</tr>
					<!-- 说明 -->
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message key="lbpmEmbeddedSubFlow.fdDesc" bundle="sys-lbpmservice-support"/>
						</td>
						<td width=85% colspan="3">
							<bean:write property="fdDesc" name="lbpmEmbeddedSubFlowForm" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							key="model.tempEditorName" /></td>
						<td colspan="3"><bean:write name="lbpmEmbeddedSubFlowForm" property="authEditorNames"/></td>
					</tr>
					<tr>
						<!-- 创建人员 -->
						<td class="td_normal_title" width=15%>
							<bean:message key="model.fdCreator" />
						</td>
						<td width=35%>
							<bean:write property="docCreatorName" name="lbpmEmbeddedSubFlowForm"/>
						</td>
						
						<!-- 创建时间 -->
						<td class="td_normal_title" width=15%>
							<bean:message key="model.fdCreateTime" />
						</td>
						<td width=35%>
							<bean:write property="docCreateTime"  name="lbpmEmbeddedSubFlowForm"/>
						</td>
					</tr>
					
					<tr>
						<!-- 修改人 -->
						<td class="td_normal_title" width=15%>
							<bean:message key="model.docAlteror" />
						</td>
						<td width=35%>
							<bean:write name="lbpmEmbeddedSubFlowForm" property="docAlterorName" />
						</td>
						
						<!-- 修改时间 -->
						<td class="td_normal_title" width=15%>
							<bean:message key="model.fdAlterTime" />
						</td>
						<td width=35%>
							<bean:write name="lbpmEmbeddedSubFlowForm" property="docAlterTime" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr LKS_LabelName="<bean:message bundle='sys-lbpmservice-support' key='lbpmEmbeddedSubFlow.flowInfo'/>">
		 	<td>
		 		<html:textarea property="fdContent" style="display:none"/>
		 		<iframe src="<c:url value="/sys/lbpm/flowchart/page/panel.html" />?embedded=true&extend=oa&template=true&modelName=${param.modelName}&contentField=fdContent&isEmpty=true&FormFieldList=FlowChartObject.FormFieldList"
				style="width:100%;min-height:450px" scrolling="no"></iframe>
		 	</td>
		</tr>	
		
		<!-- 引用模板 -->
		<tr LKS_LabelName="<bean:message bundle='sys-lbpmservice-support' key='lbpmEmbeddedSubFlow.refInfo'/>">
		 	<td>
		 		<ui:iframe src="${LUI_ContextPath}/sys/lbpmservice/support/lbpm_embeddedSubFlow/ref/lbpmEmbeddedSubFlowRef_list.jsp?fdEmbeddedId=${lbpmEmbeddedSubFlowForm.fdId}"></ui:iframe>
			</td>
		</tr>
	</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>