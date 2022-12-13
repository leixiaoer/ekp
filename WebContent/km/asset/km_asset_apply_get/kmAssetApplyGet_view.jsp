<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
<c:if test="${kmAssetApplyGetForm.docStatus=='10' || kmAssetApplyGetForm.docStatus=='11'|| kmAssetApplyGetForm.docStatus=='20'}">
	<kmss:auth requestURL="/km/asset/km_asset_apply_get/kmAssetApplyGet.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetApplyGet.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
</c:if>
	<kmss:auth requestURL="/km/asset/km_asset_apply_get/kmAssetApplyGet.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyGet.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle">${txttitle}</p>

<center>
<table  id="Label_Tabel" width=95%>
		<tr
			LKS_LabelName="<bean:message bundle='km-asset' key='kmAssetApplyGet.baseinfo'/>">
			<td>
			<table class="tb_normal" width=95%>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
					<td width="85%" colspan="5"><xform:text property="docSubject"
						style="width:85%" /></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
					<td width="19%">${kmAssetApplyGetForm.fdApplyTemplateName}</td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
					<td width="51%" colspan="3"><xform:text property="fdNo"
						style="width:85%" /></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
					<td width="19%">
					<c:out value="${kmAssetApplyGetForm.fdCreatorName}" /></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
					<td width="19%">
					<c:out value="${kmAssetApplyGetForm.fdDeptName}" />
					</td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
					<td width="19%"><xform:datetime property="fdCreateDate" dateTimeType="date"/></td>
				</tr>
				<!-- 领用明细 -->
				<tr>
					<td class="td_normal_title" width="100%" colspan="6" align="center"><bean:message
						bundle="km-asset" key="table.kmAssetApplyGetList" /></td>
				</tr>
				<tr>
					<td width="100%" colspan="6"><c:import
						url="/km/asset/km_asset_apply_get_list/kmAssetApplyGetList_view.jsp"
						charEncoding="UTF-8">
					</c:import></td>
				</tr> 
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdReason" /></td>
					<td width="85%" colspan="5"><kmss:showText  value="${kmAssetApplyGetForm.fdReason}"/></td>

				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
					<td colspan="5"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId }"/>
						<c:param name="fdModelName"
							value="com.landray.kmss.km.asset.model.KmAssetApplyGet" />
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
					<td width="85%" colspan="5">
					   <kmss:showText value="${kmAssetApplyGetForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>
				
			</table>
			</td>
		</tr>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfProcess_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyGetForm" />
			<c:param name="fdKey" value="KmAssetApplyGetDoc" />
			<c:param name="showHistoryOpers" value="true" />
		</c:import>
			<%-- 权限机制--%>
		<tr
			LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyGetForm" />
					<c:param name="moduleModelName"
						value="com.landray.kmss.km.asset.model.KmAssetApplyGet" />
				</c:import>
			</table>
			</td>
		</tr>
	<!-- 关联机制 -->
		<tr
			LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
			<c:set var="mainModelForm" value="${kmAssetApplyGetForm}"
				scope="request" />
			<c:set var="currModelName"
				value="com.landray.kmss.km.asset.model.KmAssetApplyGet"
				scope="request" />
			<td><%@ include
				file="/sys/relation/include/sysRelationMain_view.jsp"%>
			</td>
		</tr>
		<!-- 关联机制 -->
		<%--阅读机制--%>
		<c:import url="/sys/readlog/include/sysReadLog_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyGetForm" />
		</c:import>
		
	</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>