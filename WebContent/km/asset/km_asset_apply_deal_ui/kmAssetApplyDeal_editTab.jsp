<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<script type="text/javascript">
		Com_IncludeFile("calendar.js");
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
			fdOldTotalMoney.value=new Number(sum).toFixed(2);
			oldSpan.innerHTML=new Number(sum).toFixed(2);
			//设置大写
			oldTotalChange();
			}
		
		//自动求报废变卖值合计
		function calculteNewTotal(){
			var sum=DocList_GetSum(document.getElementById("divertlistTB"),/fdApplyDealListForms\[\d+\]\.fdDealMoney/);
			var newSpan=document.getElementById("fdNewTotalMoneySpan");
			var fdNewTotalMoney=document.getElementsByName("fdNewTotalMoney")[0];
			fdNewTotalMoney.value=new Number(sum).toFixed(2);
			newSpan.innerHTML=new Number(sum).toFixed(2);
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
			
			function viewTask(fdTaskId){
				window.open('<c:url value="/km/asset/km_asset_apply_task/kmAssetApplyTask.do" />?method=view&fdId='+fdTaskId,"_blank");
			}
		</script>
		<c:if test="${param.approveModel ne 'right'}">
			<form name="kmAssetApplyDealForm" method="post" action ="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_deal/kmAssetApplyDeal.do">
		</c:if>
		<html:hidden property="fdId" />
		<html:hidden property="fdCreatorId" />
		<html:hidden property="fdDeptId" />
		<html:hidden property="fdCreateDate" />
		<html:hidden property="method_GET" />
		<html:hidden property="docStatus" />
		<html:hidden property="titleRegulation" />
		<html:hidden property="fdTaskId" />
		<html:hidden property="fdTaskDetailRef" />
		<c:choose>
			<c:when test="${param.approveModel eq 'right'}">
				<ui:tabpage collapsed="true" id="reviewTabPage">
					<script>
						LUI.ready(function(){
							setTimeout(function(){
								var reviewTabPage = LUI("reviewTabPage");
								if(reviewTabPage!=null){
									reviewTabPage.element.find(".lui_tabpage_float_collapse").hide();
									reviewTabPage.element.find(".lui_tabpage_float_navs_mark").hide();
								}
							},100)
						})
					</script>
					<c:import url="/km/asset/km_asset_apply_deal_ui/kmAssetApplyDeal_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="baseInfo"></c:param>
		  			</c:import>
				</ui:tabpage>
				<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
					<%--流程--%>
					<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyDealForm" />
						<c:param name="fdKey" value="KmAssetApplyDealDoc" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="isExpand" value="true" />
						<c:param name="approveType" value="right" />
					</c:import>
					<c:import url="/km/asset/km_asset_apply_deal_ui/kmAssetApplyDeal_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="other"></c:param>
		 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
		  			</c:import>
				</ui:tabpanel>
			</c:when>
			<c:otherwise>
				<ui:tabpage expand="false" var-navwidth="90%" >
					<c:import url="/km/asset/km_asset_apply_deal_ui/kmAssetApplyDeal_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="baseInfo"></c:param>
		  			</c:import>
					<c:import url="/km/asset/km_asset_apply_deal_ui/kmAssetApplyDeal_editContent.jsp" charEncoding="UTF-8">
		 		 		<c:param name="contentType" value="other"></c:param>
		  			</c:import>
				</ui:tabpage>
				</form>
			</c:otherwise>
		</c:choose>			
</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyDealForm" />
					<c:param name="fdKey" value="KmAssetApplyDealDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyDealForm" />
					<c:param name="approveType" value="right" />
					<c:param name="needTitle" value="true" />
				</c:import>
			</ui:tabpanel>
		</template:replace>
	</c:when>
	<c:otherwise>
		<template:replace name="nav">
			<%--关联机制(与原有机制有差异)--%>
			<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyDealForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>