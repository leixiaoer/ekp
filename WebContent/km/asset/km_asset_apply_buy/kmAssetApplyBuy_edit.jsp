<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>

<script>Com_IncludeFile("doclist.js|calendar.js|dialog.js");</script>
<script>
	//防止没有选择类别而进入页面
	var fdModelId='${JsParam.fdModelId}';
	var fdModelName='${JsParam.fdModelName}';
	var url='<c:url value="/km/asset/km_asset_apply_buy/kmAssetApplyBuy.do" />?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}';
	if(fdModelId!=null&&fdModelName!=''){
			url+="&fdModelId="+fdModelId+"&fdModelName="+fdModelName;
		}   
	Com_NewFile('com.landray.kmss.km.asset.model.KmAssetApplyTemplate',url);


	// 提交表单
	function commitMethod(method, saveDraft){
		var TABLE_DocList=document.getElementById("TABLE_DocList");
		if(TABLE_DocList.getElementsByTagName("input").length==0){
			alert("<bean:message bundle='km-asset' key='kmAssetApplyBuyList.noList' />");
			return;
		}		
		var docStatus = document.getElementsByName("docStatus")[0];
		if (saveDraft != null && saveDraft == 'true'){
			docStatus.value = "10";
		} else {
			docStatus.value = "20";
		}
		Com_Submit(document.kmAssetApplyBuyForm, method);
	}
</script>

<html:form action="/km/asset/km_asset_apply_buy/kmAssetApplyBuy.do">
<div id="optBarDiv">
	<c:if test="${kmAssetApplyBuyForm.method_GET=='edit'}">
		<%-- 暂存 --%>
		<c:if test="${ kmAssetApplyBuyForm.docStatus == '10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="commitMethod('update', 'true');">
		</c:if>
		<%-- 提交 --%>
		<c:if test="${kmAssetApplyBuyForm.docStatus=='10'||kmAssetApplyBuyForm.docStatus=='11'||kmAssetApplyBuyForm.docStatus=='20' }">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update');">
		</c:if>
	</c:if>
	<c:if test="${kmAssetApplyBuyForm.method_GET=='add'}">
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
		<bean:message bundle="km-asset" key="table.kmAssetApplyBuy"/>
	</c:if>
</p>
<center>
<table id="Label_Tabel"  width=95%>
	<%-- 申请单信息 --%>
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="kmAssetApplyBuy.page.tab1" />">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<%-- 标题 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
					</td>
					<td colspan="3">
						<xform:text property="docSubject" style="width:85%" />
					</td>
				</tr>
				
				<tr>
					<%-- 类别--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
					</td>
					<td width="35%">
						<html:hidden property="fdApplyTemplateId" />
						<bean:write name="kmAssetApplyBuyForm"  property="fdApplyTemplateName" />
					</td>
					<%-- 申请单编号 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
					</td>
					<td width="35%">
						<c:if test="${kmAssetApplyBuyForm.method_GET=='edit'}">
							${kmAssetApplyBuyForm.fdNo}
						</c:if>
						<c:if test="${kmAssetApplyBuyForm.method_GET=='add'}">
							<bean:message  bundle="km-asset" key="kmAssetApplyBuy.fdNo.describe"/>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<%-- 申请人 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
					</td>
					<td width="35%">
						<xform:address propertyId="fdCreatorId" propertyName="fdCreatorName" orgType="ORG_TYPE_PERSON" showStatus="view" />
					</td>
					<%-- 申请部门 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept"/>
					</td>
					<td width="35%">
						<xform:address propertyId="fdDeptId" propertyName="fdDeptName" orgType="ORG_TYPE_DEPT" showStatus="view" />
					</td>
				</tr>
				
				<tr>
					<%-- 申请日期 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
					</td>
					<td width="35%">
						<xform:datetime property="fdCreateDate" showStatus="view" />
					</td>
					<%-- 是否在计划内 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdIsPlan"/>
					</td>
					<td width="35%">
						<xform:radio property="fdIsPlan" >
							<xform:enumsDataSource enumsType="km_asset_apply_buy_fd_is_plan" />
						</xform:radio>
					</td>
				</tr>
				
				<%-- 分隔符 --%>
				<tr><td colspan="4">&nbsp;</td></tr>
				
				<tr>
					<%-- 申购明细标题 --%>
					<td colspan="4" class="td_normal_title" align="center">
						<bean:message bundle="km-asset" key="table.kmAssetApplyBuyList"/>
					</td>
				</tr>
				
				<tr>
					<%-- 申请明细--%>
					<td colspan="4">
						<%@include file="/km/asset/km_asset_apply_buy_list/kmAssetApplyBuyList_edit.jsp"%>
					</td>
				</tr>
				
				<tr>
					<%-- 合计 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdTotalMoney"/>
					</td>
					<td colspan="3">
							<html:hidden property="fdTotalMoney" />
							<span id="fdTotalMoneySpan" style="width: 10%">${kmAssetApplyBuyForm.fdTotalMoney}</span>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<%--中文大写--%>
							<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
							<span id="chinaValue"></span>
					</td>
				</tr>
				
				<tr>
					<%--申请事由--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdReason"/>
					</td>
					<td colspan="3">
						<xform:textarea property="fdReason" style="width:100%" />
					</td>
				</tr>
				
				<tr>
					<%-- 附件 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBuy.attachment"/>
					</td>
					<td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="kmAssetApplyBuy" />									
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
					    <kmss:showText value="${kmAssetApplyBuyForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>
				
				<%-- 分隔符 --%>
				<tr><td colspan="4">&nbsp;</td></tr>
				
				<tr>
					<%-- 调拨方式 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdStyle"/>
					</td>
					<td colspan="3">
						<xform:radio property="fdStyle"  required="true">
							<xform:enumsDataSource enumsType="km_asset_apply_buy_fd_style" />
						</xform:radio>
					</td>
				</tr>
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdMoneyIdea"/>
					</td>
					<td colspan="3">
						<xform:textarea property="fdMoneyIdea" style="width:100%" />
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
	
	<%-- 流程--%>
	<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyBuyForm" />
		<c:param name="fdKey" value="KmAssetApplyBuyDoc" />
	</c:import>

	
		<%-- 权限 --%>
		<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
				<table class="tb_normal" width=100%>
					<c:import url="/sys/right/right_edit.jsp"  charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyBuyForm" />
						<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyBuy" />
					</c:import>
				</table>
			</td>
		</tr> 
	
	<%--关联机制--%>
	<tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
		<c:set var="mainModelForm" value="${kmAssetApplyBuyForm}" scope="request"/>
		<c:set var="currModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyBuy" scope="request"/>
		<td>
			<%@ include	file="/sys/relation/include/sysRelationMain_edit.jsp"%>
		</td>
	</tr>
	
</table>

</center>
<html:hidden property="fdId" />
<html:hidden property="docStatus" />
<html:hidden property="method_GET" />
  <html:hidden property="fdCreatorId" />
	<html:hidden property="fdDeptId" />
	<html:hidden property="fdCreateDate" />
<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>