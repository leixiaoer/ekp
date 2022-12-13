<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>
	Com_IncludeFile("dialog.js|doclist.js|calendar.js");
</script>
<script>
	DocList_Info.push("TABLE_DocList_Stock") ;
	DocList_Info.push("TABLE_DocList_In") ;
</script>
<script  language="JavaScript">
	//防止通过URL直接进入页面而没有选择类别
	var fdModelId='${JsParam.fdModelId}';
	var fdModelName='${JsParam.fdModelName}';
	var url='<c:url value="/km/asset/km_asset_apply_in/kmAssetApplyIn.do" />?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}';
	if(fdModelId!=null&&fdModelName!=''){
			url+="&fdModelId="+fdModelId+"&fdModelName="+fdModelName;
		}     
	Com_NewFile('com.landray.kmss.km.asset.model.KmAssetApplyTemplate',url);

	// 提交表单
	function commitMethod(method, saveDraft){
		var TABLE_DocList=document.getElementById("TABLE_DocList_In");
		if(TABLE_DocList.getElementsByTagName("input").length==0){
			alert("<bean:message bundle='km-asset' key='kmAssetApplyInList.noList' />");
			return;
		}
		var docStatus = document.getElementsByName("docStatus")[0];
		if (saveDraft != null && saveDraft == 'true'){
			docStatus.value = "10";
		} else {
			docStatus.value = "20";
		}
		Com_Submit(document.kmAssetApplyInForm, method);
	}

	
</script>

<html:form action="/km/asset/km_asset_apply_in/kmAssetApplyIn.do" >
<div id="optBarDiv">
	<c:if test="${kmAssetApplyInForm.method_GET=='edit'}">
		<%-- 暂存 --%>
		<c:if test="${ kmAssetApplyInForm.docStatus == '10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="commitMethod('update', 'true');">
		</c:if>
		<%-- 提交 --%>
		<c:if test="${kmAssetApplyInForm.docStatus=='10'||kmAssetApplyInForm.docStatus=='11'||kmAssetApplyInForm.docStatus=='20' }">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update');">
		</c:if>
	</c:if>
	<c:if test="${kmAssetApplyInForm.method_GET=='add'}">
		<%-- 暂存--%>
		<input type="button" value="<bean:message key="button.savedraft" />"
			onclick="commitMethod('save', 'true');" />
		<%--提交--%>
		<input type=button value="<bean:message key="button.submit"/>"
			onclick="commitMethod('save');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

	<p class="txttitle">
		<c:if test="${not empty txttitle}">${txttitle}</c:if>
		<c:if test="${empty  txttitle}">
			<bean:message bundle="km-asset" key="table.kmAssetApplyIn"/>
		</c:if>
	</p>
<center>
<table id="Label_Tabel"  width=95%>
	<%-- 申请单信息 --%>
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="kmAssetApplyBuy.page.tab1" />">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<%--标题--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
					</td>
					<td colspan="3">
						<xform:text property="docSubject" style="width:85%" />
					</td>
				</tr>
				
				<tr>
					<%--类别--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
					</td>
					<td width="35%">
						<html:hidden property="fdApplyTemplateId" />
						<bean:write name="kmAssetApplyInForm"  property="fdApplyTemplateName" />
					</td>
					<%--申请单编号--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
					</td>
					<td width="35%">
						<c:if test="${kmAssetApplyInForm.method_GET=='edit'}">
							${kmAssetApplyInForm.fdNo}
						</c:if>
						<c:if test="${kmAssetApplyInForm.method_GET=='add'}">
							<bean:message  bundle="km-asset" key="kmAssetApplyStock.fdNo.describe"/>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<%--拟单人--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
					</td>
					<td width="35%">
						<xform:address propertyId="fdCreatorId" propertyName="fdCreatorName" orgType="ORG_TYPE_PERSON" showStatus="view" />
					</td>
					<%-- 拟单日期 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" />
					</td>
					<td width="35%">
						<xform:datetime property="fdCreateDate" showStatus="view" />
					</td>
				</tr>
				
				
				
				<%-- 入库明细--%>	
				<%@include file="/km/asset/km_asset_apply_in_list/kmAssetApplyInList_edit.jsp"%>
				
				<%-- 分隔符 --%>
				<tr><td colspan="4">&nbsp;</td></tr>
				
				<tr>
					<%-- 附件 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyStock.attachment"/>
					</td>
					<td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="kmAssetApplyIn" />									
						</c:import>
					</td>
				</tr>
				
				<tr>
					<%--说明 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
					</td>
					<td colspan="3">
					    <html:hidden property="fdExplain" />
					    <kmss:showText value="${kmAssetApplyInForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>
				
				<tr>
					<%--是否生成资产卡片--%>
					<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyIn.fdIsCreateCard"/>
					</td>
					<td colspan="3">
						<xform:radio property="fdIsCreateCard" >
							<xform:enumsDataSource enumsType="km_asset_apply_in_fd_is_create_card" />
						</xform:radio>
					</td>
				</tr>
				
				<tr>
					<%--资产卡片是否按到货数量拆分--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyIn.fdIsUnpickByNums"/>
					</td>
					<td colspan="3">				
						<xform:radio property="fdIsUnpickByNums" >
							<xform:enumsDataSource enumsType="km_asset_apply_in_fd_is_unpick_by_nums" />
						</xform:radio>
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
	
	<%-- 流程--%>
	<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyInForm" />
		<c:param name="fdKey" value="KmAssetApplyInDoc" />
	</c:import>
	
	<%-- 权限 --%>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_edit.jsp"  charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyInForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyIn" />
				</c:import>
			</table>
		</td>
	</tr> 
	
	<%--关联机制--%>
	<tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
		<c:set var="mainModelForm" value="${kmAssetApplyInForm}" scope="request"/>
		<c:set var="currModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyIn" scope="request"/>
		<td>
			<%@ include	file="/sys/relation/include/sysRelationMain_edit.jsp"%>
		</td>
	</tr>
	
	
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<html:hidden property="docStatus" />
 <html:hidden property="fdCreatorId" />
<html:hidden property="fdDeptId" />
<html:hidden property="fdCreateDate" />
<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>