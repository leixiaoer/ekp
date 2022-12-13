<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/km/asset/km_asset_apply_get/kmAssetApplyGet.do">
<script>
Com_IncludeFile("dialog.js|xform.js|doclist.js");
Com_IncludeFile("calendar.js");

//提交表单
function commitMethod(method, saveDraft){
	var docStatus = document.getElementsByName("docStatus")[0];
	if (saveDraft != null && saveDraft == 'true'){
		docStatus.value = "10";
	} else {
		docStatus.value = "20";
	}
	Com_Submit(document.kmAssetApplyGetForm, method);
}
</script>
<div id="optBarDiv">
	<c:if test="${kmAssetApplyGetForm.method_GET=='edit'}">
	    <c:if test="${ kmAssetApplyGetForm.docStatus == '10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="commitMethod('update', 'true');">
		</c:if>
		<c:if test="${kmAssetApplyGetForm.docStatus=='10'||kmAssetApplyGetForm.docStatus=='11'||kmAssetApplyGetForm.docStatus=='20' }">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update');">
		</c:if>
	</c:if>
	<c:if test="${kmAssetApplyGetForm.method_GET=='add'}">
	    <input type="button" value="<bean:message key="button.savedraft" />"
			onclick="commitMethod('save', 'true');" />
		<input type=button value="<bean:message key="button.submit"/>"
			onclick="commitMethod('save');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>
	<p class="txttitle">
		<c:if test="${not empty txttitle}">${txttitle}</c:if>
		<c:if test="${empty  txttitle}">
			<bean:message bundle="km-asset" key="table.kmAssetApplyGet"/>
		</c:if>
	</p>

<center>
	<table id="Label_Tabel" width=95%>
		<tr LKS_LabelName="<bean:message bundle='km-asset' key='kmAssetApplyGet.baseinfo'/>">
			<td>
			<table class="tb_normal" width=95%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject" />
					</td>
					<td width="85%" colspan="5">
						<xform:text property="docSubject" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" />
					</td>
					<td width="19%">
						<html:hidden property="fdApplyTemplateId" />
						<html:hidden property="fdApplyTemplateName" />
						${kmAssetApplyGetForm.fdApplyTemplateName}
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo" />
					</td>
					<td width="51%" colspan="3">
					<c:choose>
						<c:when test='${kmAssetApplyGetForm.fdNo!=null}'>
						    <xform:text property="fdNo" style="width:85%" />
						</c:when>
						<c:otherwise>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.autoCreate" />
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator" />
					</td>
					<td width="19%">
						<html:hidden property="fdCreatorId" />
						<xform:text property="fdCreatorName" value="${kmAssetApplyGetForm.fdCreatorName}" showStatus="view"></xform:text>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept" />
					</td>
					<td width="19%">
					    <html:hidden property="fdDeptId" />
						<xform:text property="fdDeptName" value="${kmAssetApplyGetForm.fdDeptName}" showStatus="view"></xform:text>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" />
					</td>
					<td width="19%">
					    <html:hidden property="fdCreateDate" />
					    <xform:datetime property="fdCreateDate" dateTimeType="date" showStatus="view"/>
					</td>
				</tr>
				<!-- 领用明细 -->
				<tr>
					<td width="100%" colspan="6">
						<c:import
							url="/km/asset/km_asset_apply_get_list/kmAssetApplyGetList_edit.jsp"
							charEncoding="UTF-8">
						</c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdReason" />
					</td>
					<td width="85%" colspan="5">
						<xform:textarea property="fdReason" style="width:100%" />
					</td>
				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.attachMent" />
					</td>
					<td colspan="5">
						<c:import
							url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
							charEncoding="UTF-8">
							<c:param name="fdKey" value="attachment" />
							<c:param name="fdModelId" value="${param.fdId }" />
							<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyGet" />
						</c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain" />
					</td>
					<td width="85%" colspan="5">
						<html:hidden property="fdExplain" />
				    	<kmss:showText value="${kmAssetApplyGetForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyGetForm" />
			<c:param name="fdKey" value="KmAssetApplyGetDoc" />
			<c:param name="showHistoryOpers" value="true" />
		</c:import>
		<!-- 权限机制-->
		<tr
			LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />"
			style="display: none">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyGetForm" />
					<c:param name="moduleModelName"
						value="com.landray.kmss.km.asset.model.KmAssetApplyGet" />
				</c:import>
			</table>
			</td>
		</tr>
		<!-- 权限机制 -->
		<%---关联机制 开始----%>
		<tr
			LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
			<c:set var="mainModelForm" value="${kmAssetApplyGetForm}"
				scope="request" />
			<c:set var="currModelName"
				value="com.landray.kmss.km.asset.model.KmAssetApplyGet"
				scope="request" />
			<td><%@ include
				file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>
		</tr>
	</table>
	</center>
<html:hidden property="fdId" />
<html:hidden property="docStatus" value="20"/>
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>