<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("dialog.js|calendar.js|jquery.js");
</script>
<script language="JavaScript">
// 提交表单
function commitMethod(method, saveDraft){
	var docStatus = document.getElementsByName("docStatus")[0];
	if (saveDraft != null && saveDraft == 'true'){
		docStatus.value = "10";
	} else {
		docStatus.value = "20";
	}
	Com_Submit(document.kmAssetApplyChangeForm, method);
}
</script>
<html:form
	action="/km/asset/km_asset_apply_change/kmAssetApplyChange.do">
	<div id="optBarDiv"><%-- 编辑 --%> <c:if
		test="${kmAssetApplyChangeForm.method_GET=='edit'}">
		<%-- 提交 --%>
		<c:if test="${kmAssetApplyChangeForm.docStatus=='10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="commitMethod('update','true');">
		</c:if>
		<c:if test="${kmAssetApplyChangeForm.docStatus<'20'}">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update','false');">
		</c:if>
		<c:if test="${kmAssetApplyChangeForm.docStatus=='20'}">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update','false');">
		</c:if>
		<c:if test="${kmAssetApplyChangeForm.docStatus>='30'}">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update','false');">
		</c:if>
	</c:if> <%-- 增加--%> <c:if test="${kmAssetApplyChangeForm.method_GET=='add'}">
		<%-- 暂存 --%>
		<input type="button" value="<bean:message key="button.savedraft" />"
			onclick=" commitMethod ('save', 'true');" />
		<%-- 提交 --%>
		<input type="button" value="<bean:message key="button.update" />"
			onclick=" commitMethod ('save');" />
	</c:if> <input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();"></div>
	<p class="txttitle"><c:if test="${not empty txttitle}">${txttitle}</c:if>
	<c:if test="${empty  txttitle}">
		<bean:message bundle="km-asset" key="table.kmAssetApplyChange" />
	</c:if></p>

	<center>
	<table id="Label_Tabel" width="95%" LKS_LabelDefaultIndex="1"
		LKS_OnLabelSwitch="switchLabelEvent">
		<!-- 基本信息 -->
		<tr
			LKS_LabelName="<bean:message bundle="km-asset" key="KmAssetApply.baseApply"/>">
			<td>
			<table class="tb_normal" width=95%>
				<tr>
					<!--标题-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject" />
					</td>
					<td colspan="5">
						<xform:text property="docSubject" style="width:85%" />
					</td>
				</tr>
				<tr>
					<!--所属模板 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
					<td width="19%"><html:hidden property="fdApplyTemplateId" />
					<xform:text property="fdApplyTemplateName" style="width:85%"
						showStatus="view" /></td>
					<!--申请单编号 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
					<td colspan="3"><c:choose>
						<c:when test='${kmAssetApplyChangeForm.fdNo!=null}'>
							<xform:text property="fdNo" style="width:85%" showStatus="view" />
						</c:when>
						<c:otherwise>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.autoCreate" />
						</c:otherwise>
					</c:choose></td>
				</tr>
				<tr>
					<!--申请人-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
					<td width="19%"><xform:address propertyId="fdCreatorId"
						propertyName="fdCreatorName" orgType="ORG_TYPE_PERSON"
						style="width:85%" showStatus="view" /></td>

					<!--申请部门-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
					<td width="19%"><html:hidden property="fdDeptId" /> <xform:address
						propertyId="fdDeptId" propertyName="fdDeptName"
						orgType="ORG_TYPE_DEPT" style="width:85%" showStatus="view" /></td>
					<!--申请日期-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
					<td width="19%"><xform:datetime property="fdCreateDate"
						showStatus="view" style="width:85%" /></td>
				</tr>

				<!-- 变更单明细 -->
				<tr>
					<td width="100%" colspan="6"><c:import
						url="/km/asset/km_asset_apply_change_list/kmAssetApplyChangeList_edit.jsp"
						charEncoding="UTF-8">
					</c:import></td>
				</tr>

				<tr>
					<!--事由-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdReason" />
					</td>
					<td colspan="5">
						<xform:textarea property="fdReason" style="width:100%" />
					</td>
				</tr>

				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
					<td colspan="5"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.km.asset.model.KmAssetApplyChange" />
					</c:import></td>
				</tr>
				<tr>
					<!--说明-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
					<td colspan="5"><html:hidden property="fdExplain" /> <kmss:showText
						value="${kmAssetApplyChangeForm.fdExplain}"></kmss:showText></td>
				</tr>
			</table>
			</td>
		</tr>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyChangeForm" />
			<c:param name="fdKey" value="KmAssetApplyChangeDoc" />
		</c:import>
		<!-- 权限页签 -->
		<tr
			LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyChangeForm" />
					<c:param name="moduleModelName"
						value="com.landray.kmss.km.asset.model.KmAssetApplyChange" />
				</c:import>
			</table>
			</td>
		</tr>

		<!-- 关联机制 -->
		<tr
			LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />"
			style="display: none">
			<c:set var="mainModelForm" value="${kmAssetApplyChangeForm}"
				scope="request" />
			<c:set var="currModelName"
				value="com.landray.kmss.km.asset.model.KmAssetApplyChange"
				scope="request" />
			<td><%@ include
				file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>
		</tr>
		<!-- 关联机制 -->


	</table>
	</center>
	<html:hidden property="fdId" />
	<html:hidden property="fdCreatorId" />
	<html:hidden property="fdDeptId" />
	<html:hidden property="fdCreateDate" />
	<html:hidden property="method_GET" />
	<html:hidden property="docStatus" />
	<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>