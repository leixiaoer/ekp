<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>
	
	Com_IncludeFile("doclist.js|calendar.js|dialog.js");
	Com_IncludeFile("providerDialog.js",Com_Parameter.ContextPath+"km/provider/resource/js/","js",true); 
</script>
<script>
	//防止通过URL直接进入页面而没有选择类别
	var fdModelId='${JsParam.fdModelId}';
	var fdModelName='${JsParam.fdModelName}';
	var url='<c:url value="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do" />?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}';
	if(fdModelId!=null&&fdModelName!=''){
			url+="&fdModelId="+fdModelId+"&fdModelName="+fdModelName;
		}   
	Com_NewFile('com.landray.kmss.km.asset.model.KmAssetApplyTemplate',url);


	// 提交表单
	function commitMethod(method, saveDraft){
		var TABLE_DocList=document.getElementById("TABLE_DocList");
		if(TABLE_DocList.getElementsByTagName("input").length==0){
			alert("<bean:message bundle='km-asset' key='kmAssetApplyStockList.noList' />");
			return;
		}
		var docStatus = document.getElementsByName("docStatus")[0];
		if (saveDraft != null && saveDraft == 'true'){
			docStatus.value = "10";
		} else {
			docStatus.value = "20";
		}
		Com_Submit(document.kmAssetApplyStockForm, method);
	}
</script>
<html:form action="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do" enctype="multipart/form-data" >
<div id="optBarDiv">
	<c:if test="${kmAssetApplyStockForm.method_GET=='edit'}">
		<%-- 暂存 --%>
		<c:if test="${ kmAssetApplyStockForm.docStatus == '10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="commitMethod('update', 'true');">
		</c:if>
		<%-- 提交 --%>
		<c:if test="${kmAssetApplyStockForm.docStatus=='10'||kmAssetApplyStockForm.docStatus=='11'||kmAssetApplyStockForm.docStatus=='20' }">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update');">
		</c:if>
	</c:if>
	<c:if test="${kmAssetApplyStockForm.method_GET=='add'}">
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
		<bean:message bundle="km-asset" key="table.kmAssetApplyStock"/>
	</c:if>
</p>

<center>
<table id="Label_Tabel"  width=95%>
	<%-- 采购单信息 --%>
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="kmAssetApplyStock.page.tab1" />">
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
						<bean:write name="kmAssetApplyStockForm"  property="fdApplyTemplateName" />
					</td>
					<%--申请单编号--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
					</td>
					<td width="35%">
						<c:if test="${kmAssetApplyStockForm.method_GET=='edit'}">
							${kmAssetApplyStockForm.fdNo}
						</c:if>
						<c:if test="${kmAssetApplyStockForm.method_GET=='add'}">
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
				
				<tr>
					<%-- 采购明细标题 --%>
					<td colspan="4" class="td_normal_title" align="center">
						<bean:message bundle="km-asset" key="table.kmAssetApplyStockList"/>
					</td>
				</tr>
				
				<tr>
					<%-- 采购单明细--%>
					<td colspan="4">
						<%@include file="/km/asset/km_asset_apply_stock_list/kmAssetApplyStockList_edit.jsp"%>
					</td>
				</tr>
				
				<tr>
					<%-- 合计 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyStock.fdTotalMoney"/>
					</td>
					<td colspan="3">
						<html:hidden property="fdTotalMoney"/>
						<span  id="fdTotalMoneySpan" style="width: 10%">${kmAssetApplyStockForm.fdTotalMoney}</span>
						<%--中文大写--%>
						<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
						<span id="chinaValue"></span>
					</td>
				</tr>
				
				<tr>
					<%--采购事项--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyStock.fdStockMatter"/>
					</td>
					<td colspan="3">
						<xform:textarea property="fdStockMatter" style="width:100%" />
					</td>
				</tr>
				
				<tr>
					<%-- 附件 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyStock.attachment"/>
					</td>
					<td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="kmAssetApplyStock" />									
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
			             <kmss:showText value="${kmAssetApplyStockForm.fdExplain}"></kmss:showText>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<%-- 流程--%>
	<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyStockForm" />
		<c:param name="fdKey" value="KmAssetApplyStockDoc" />
	</c:import>
	
	<%-- 权限 --%>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_edit.jsp"  charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyStockForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyStock" />
				</c:import>
			</table>
		</td>
	</tr> 
	
	<%--关联机制--%>
	<tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
		<c:set var="mainModelForm" value="${kmAssetApplyStockForm}" scope="request"/>
		<c:set var="currModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyStock" scope="request"/>
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