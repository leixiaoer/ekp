<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
 <c:if test="${kmAssetApplyReturnForm.docStatus=='10' || kmAssetApplyReturnForm.docStatus=='11'|| kmAssetApplyReturnForm.docStatus=='20'}">
	<kmss:auth requestURL="/km/asset/km_asset_apply_return/kmAssetApplyReturn.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetApplyReturn.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
</c:if>
	<kmss:auth requestURL="/km/asset/km_asset_apply_return/kmAssetApplyReturn.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyReturn.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle">${txttitle}</p>

<center>
<table id="Label_Tabel" width="95%" LKS_LabelDefaultIndex="1" LKS_OnLabelSwitch="switchLabelEvent">
 <!-- 基本信息 -->
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="KmAssetApply.baseApply"/>">
		<td>
<table class="tb_normal" width=95%>
		<tr>
			<!--标题-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
			<td colspan="5"><xform:text property="docSubject"
				style="width:85%" /></td>
		</tr>
		<tr>
			<!--所属模板 -->
			<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
			<td width="19%">
					  ${kmAssetApplyReturnForm.fdApplyTemplateName}</td>
					<!--申请单编号 -->
			<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
				    <td colspan="3"><xform:text property="fdNo" style="width:85%" />
			</td>
		</tr>		
		
		<tr>
			<!--申请人-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
			<td width="19%"><c:out
			value="${kmAssetApplyReturnForm.fdCreatorName}" /></td>
			<!--申请部门-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
			<td width="19%">
			             <c:out value="${kmAssetApplyReturnForm.fdDeptName}" />
			</td>
			<!--申请日期-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
			<td width="19%"><xform:datetime property="fdCreateDate"  style="width:85%" /></td>
		</tr>
		  	<!--归还单明细 -->
				<tr>
					<td class="td_normal_title" width="100%" colspan="6" align="center"><bean:message
						bundle="km-asset" key="table.kmAssetApplyReturnList" /></td>
				</tr>
                <tr>
					<td width="100%" colspan="6"><c:import
						url="/km/asset/km_asset_apply_return_list/kmAssetApplyReturnList_view.jsp"
						charEncoding="UTF-8">
					</c:import></td>
				</tr>   
		<tr>
			<!--事由-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdReason" /></td>
			<td colspan="5"><kmss:showText value="${kmAssetApplyReturnForm.fdReason}"/></td>
		</tr>
	<tr>
			<!--附件机制-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
			<td colspan="5">
        <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="attachment"/>
			<c:param name="fdModelId" value="${param.fdId }" />
			<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyReturn" />
        </c:import>
			</td>
		</tr>
     		
		<tr>	
		  <!--说明-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
			<td colspan="5">
			    <kmss:showText value="${kmAssetApplyReturnForm.fdExplain}"></kmss:showText>
			</td>
		</tr>
</table>
</td>
</tr>
<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfProcess_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyReturnForm" />
			<c:param name="fdKey" value="KmAssetApplyReturnDoc" />
		</c:import>
		<!-- 权限页签 -->
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table
				class="tb_normal"
				width=100%>
				<c:import
					url="/sys/right/right_view.jsp"
					charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmAssetApplyReturnForm" />
					<c:param
						name="moduleModelName"
						value="com.landray.kmss.km.asset.model.KmAssetApplyReturn" />
				</c:import>
			</table>
			</td>
		</tr>
<!-- 关联机制 -->
	<tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />" style="display:none">
		<c:set
			var="mainModelForm"
			value="${kmAssetApplyChangeForm}"
			scope="request" />
		<c:set
			var="currModelName"
			value="com.landray.kmss.km.asset.model.KmAssetApplyChange"
			scope="request" />
		<td><%@ include file="/sys/relation/include/sysRelationMain_view.jsp"%></td>
	</tr>
	<!-- 关联机制 -->
	<%--阅读机制--%>
	<c:import
		url="/sys/readlog/include/sysReadLog_view.jsp"
		charEncoding="UTF-8">
		<c:param
			name="formName"
			value="kmAssetApplyReturnForm" />
	</c:import>
	
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>