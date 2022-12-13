<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("dialog.js|calendar.js|jquery.js");
Com_IncludeFile("doclist.js");
</script>
<script language="JavaScript">

//加载时转换汉字
$(document).ready(function(){	
	oldTotalChange();
	newTotalChange();
});



// 提交表单
function commitMethod(method, saveDraft){
	var docStatus = document.getElementsByName("docStatus")[0];
	if (saveDraft != null && saveDraft == 'true'){
		docStatus.value = "10";
	} else {
		docStatus.value = "20";
	}
    //是否处置附加资产
	var isSubJoin=document.getElementsByName("fdIsDealSubjoin")[0].value;	
         Com_Submit(document.kmAssetApplyDealForm, method);
}

//自动求原值总计
function calculteOldTotal(){
	var sum=DocList_GetSum(document.getElementById("divertlistTB"),/fdApplyDealListForms\[\d+\]\.fdFirstValue/);
	var oldSpan=document.getElementById("fdOldTotalMoneySpan");
	var fdOldTotalMoney=document.getElementsByName("fdOldTotalMoney")[0];
	fdOldTotalMoney.value=sum;
	oldSpan.innerHTML=sum;
	//设置大写
	oldTotalChange();
	}

//自动求报废变卖值合计
function calculteNewTotal(){
	var sum=DocList_GetSum(document.getElementById("divertlistTB"),/fdApplyDealListForms\[\d+\]\.fdDealMoney/);
	var newSpan=document.getElementById("fdNewTotalMoneySpan");
	var fdNewTotalMoney=document.getElementsByName("fdNewTotalMoney")[0];
	fdNewTotalMoney.value=sum;
	newSpan.innerHTML=sum;
	//设置大写
	newTotalChange();
	}

//原值自动设置大写
function oldTotalChange(){
	var oldTotalCount = document.getElementsByName("fdOldTotalMoney")[0].value;
	var oldTotalChina=showChinaValue(oldTotalCount);
	var oldTotalSpan= document.getElementById("upperCaseOldTotal");
	oldTotalSpan.innerText=oldTotalChina;
}

//报废变卖值自动设置大写
function newTotalChange(){
	var newTotalCount = document.getElementsByName("fdNewTotalMoney")[0].value;
	var newTotalChina=showChinaValue(newTotalCount);
	var newTotalSpan= document.getElementById("upperCaseNewTotal");
	newTotalSpan.innerText=newTotalChina;
}

//数字转大写
function  showChinaValue(val){
	var totalValue = val;
	var numberValue = new String(Math.round(totalValue * 100)); //数字金额   
		var chineseValue = ""; //转换后的汉字金额   
		var String1 = '<bean:message bundle="km-asset" key="kmAssetApplyDeal.patten.chinese" />'; //汉字数字   
		var String2 = '<bean:message bundle="km-asset" key="kmAssetApplyDeal.patten.unit" />'; //对应单位   
		var len = numberValue.length; //   numberValue的字符串长度   
		var Ch1; //数字的汉语读法   
		var Ch2; //数字位的汉字读法   
		var nZero = 0; //用来计算连续的零值的个数   
		var String3; //指定位置的数值   
		if (numberValue == "0") {
			//chineseValue = '<bean:message bundle="km-asset" key="kmAssetApplyDeal.patten.init" />';
			return chineseValue;
		}
		String2 = String2.substr(String2.length - len, len); //   取出对应位数的STRING2的值   
		for ( var i = 0; i < len; i++) {
			String3 = parseInt(numberValue.substr(i, 1), 10); //   取出需转换的某一位的值   
			if (i != (len - 3) && i != (len - 7) && i != (len - 11)
					&& i != (len - 15)) {
				if (String3 == 0) {
					Ch1 = "";
					Ch2 = "";
					nZero = nZero + 1;
				} else if (String3 != 0 && nZero != 0) {
					Ch1 = '<bean:message bundle="km-asset" key="kmAssetApplyDeal.patten.zero" />'
							+ String1.substr(String3, 1);
					Ch2 = String2.substr(i, 1);
					nZero = 0;
				} else {
					Ch1 = String1.substr(String3, 1);
					Ch2 = String2.substr(i, 1);
					nZero = 0;
				}
			} else { //   该位是万亿，亿，万，元位等关键位   
				if (String3 != 0 && nZero != 0) {
					Ch1 = '<bean:message bundle="km-asset" key="kmAssetApplyDeal.patten.zero" />'
							+ String1.substr(String3, 1);
					Ch2 = String2.substr(i, 1);
					nZero = 0;
				} else if (String3 != 0 && nZero == 0) {
					Ch1 = String1.substr(String3, 1);
					Ch2 = String2.substr(i, 1);
					nZero = 0;
				} else if (String3 == 0 && nZero >= 3) {
					Ch1 = "";
					Ch2 = "";
					nZero = nZero + 1;
				} else {
					Ch1 = "";
					Ch2 = String2.substr(i, 1);
					nZero = nZero + 1;
				}
				if (i == (len - 11) || i == (len - 3)) { //   如果该位是亿位或元位，则必须写上   
					Ch2 = String2.substr(i, 1);
				}
			}
			chineseValue = chineseValue + Ch1 + Ch2;
		}
		var String4 =0;
		if(len>2){
			String4=parseInt(numberValue.substr(len - 2, 1), 10);
		}
		if (String3 == 0 && String4 == 0) { //   最后一位（分）为0时，加上“整”   
			chineseValue = chineseValue
					+ '<bean:message bundle="km-asset" key="kmAssetApplyDeal.patten.zheng" />';
		}
		return chineseValue;
	}
</script>

<html:form action="/km/asset/km_asset_apply_deal/kmAssetApplyDeal.do">
	<div id="optBarDiv"><%-- 编辑 --%> <c:if
		test="${kmAssetApplyDealForm.method_GET=='edit'}">
		<%-- 提交 --%>
		<c:if test="${kmAssetApplyDealForm.docStatus=='10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="commitMethod('update','true');">
		</c:if>
		<c:if test="${kmAssetApplyDealForm.docStatus<'20'}">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update','false');">
		</c:if>
		<c:if test="${kmAssetApplyDealForm.docStatus=='20'}">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update','false');">
		</c:if>
		<c:if test="${kmAssetApplyDealForm.docStatus>='30'}">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update','false');">
		</c:if>
	</c:if> <%-- 增加--%> <c:if test="${kmAssetApplyDealForm.method_GET=='add'}">
		<%-- 暂存 --%>
		<input type="button" value="<bean:message key="button.savedraft" />"
			onclick="commitMethod ('save', 'true');" />
		<%-- 提交 --%>
		<input type="button" value="<bean:message key="button.update" />"
			onclick="commitMethod ('save');" />
	</c:if> <input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();"></div>

	<p class="txttitle"><c:if test="${not empty txttitle}">${txttitle}</c:if>
	<c:if test="${empty  txttitle}">
		<bean:message bundle="km-asset" key="table.kmAssetApplyDeal" />
	</c:if></p>
	<center>
	<table id="Label_Tabel" width="95%"
		LKS_OnLabelSwitch="switchLabelEvent">
		<!-- 基本信息 -->
		<tr
			LKS_LabelName="<bean:message bundle="km-asset" key="KmAssetApply.baseApply"/>">
			<td>
			<table class="tb_normal" width=95%>
				<tr>
					<!--标题-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
					<td colspan="5"><xform:text property="docSubject" style="width:85%" /></td>
				</tr>
				<tr>
					<!--类别 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
					<td width="19%"><html:hidden property="fdApplyTemplateId" />
					<xform:text property="fdApplyTemplateName" style="width:85%"
						showStatus="view" /></td>
					<!--申请单编号 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
					<td colspan="3"><c:choose>
						<c:when test='${kmAssetApplyDealForm.fdNo!=null}'>
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
					<td width="19%"><xform:address propertyId="fdDeptId"
						propertyName="fdDeptName" orgType="ORG_TYPE_DEPT"
						style="width:85%" showStatus="view" /></td>
					<!--申请日期-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
					<td width="19%"><xform:datetime property="fdCreateDate"
						dateTimeType="date" style="width:85%" showStatus="view" /></td>
				</tr>

				<tr>
					<!--事由-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyDeal.reason" />
					</td>
					<td colspan="5">
						<xform:textarea property="fdReason" style="width:100%" />
					</td>
				</tr>

				<!-- 处置单明细 -->
				<tr>
					<td width="100%" colspan="6"><c:import
						url="/km/asset/km_asset_apply_deal_list/kmAssetApplyDealList_edit.jsp"
						charEncoding="UTF-8">
					</c:import></td>
				</tr>
				<tr>
					<!--资产原值合计-->

					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyDeal.fdOldTotalMoney" /></td>
					<td colspan="5"><html:hidden property="fdOldTotalMoney" /> <span
						id="fdOldTotalMoneySpan" style="width: 100px">${kmAssetApplyDealForm.fdOldTotalMoney}</span>
					&nbsp;&nbsp; <bean:message bundle="km-asset"
						key="kmAssetApplyDeal.upperCase" />&nbsp;&nbsp;&nbsp;&nbsp;<span
						id="upperCaseOldTotal"></span></td>
				</tr>

				<tr>
					<!--资产报废变卖值合计-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyDeal.fdNewTotalMoney" /></td>
					<td colspan="5"><html:hidden property="fdNewTotalMoney" /> <span
						id="fdNewTotalMoneySpan" style="width: 100px">${kmAssetApplyDealForm.fdNewTotalMoney}</span>
					&nbsp;&nbsp; <bean:message bundle="km-asset"
						key="kmAssetApplyDeal.upperCase" />&nbsp;&nbsp;&nbsp;&nbsp;<span
						id="upperCaseNewTotal"></span></td>
				</tr>

				<tr>
					<!--是否同时处理附加资产-->
					<td colspan="6"><xform:checkbox property="fdIsDealSubjoin">
						<xform:simpleDataSource value="1">
							<bean:message bundle="km-asset"
								key="kmAssetApplyDeal.fdIsDealSubjoin" />
						</xform:simpleDataSource>
					</xform:checkbox></td>
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
							value="com.landray.kmss.km.asset.model.KmAssetApplyDeal" />
					</c:import></td>
				</tr>


				<tr>
					<!--说明-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
					<td colspan="5"><html:hidden property="fdExplain" /> <kmss:showText
						value="${kmAssetApplyDealForm.fdExplain}"></kmss:showText></td>
				</tr>
			</table>
			</td>
		</tr>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyDealForm" />
			<c:param name="fdKey" value="KmAssetApplyDealDoc" />
			<c:param name="showHistoryOpers" value="true" />
		</c:import>
		<!-- 权限机制-->
		<tr
			LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />"
			style="display: none">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyDealForm" />
					<c:param name="moduleModelName"
						value="com.landray.kmss.km.asset.model.KmAssetApplyDeal" />
				</c:import>
			</table>
			</td>
		</tr>
		<!-- 权限机制 -->
		<!-- 关联机制 -->
		<tr
			LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />"
			style="display: none">
			<c:set var="mainModelForm" value="${kmAssetApplyDealForm}"
				scope="request" />
			<c:set var="currModelName"
				value="com.landray.kmss.km.asset.model.KmAssetApplyDeal"
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
	<html:hidden property="fdTaskId" />
	<html:hidden property="fdTaskDetailRef" />
	<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>