<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<template:include ref="default.view" sidebar="no" showQrcode="false">
	 <template:replace name="head">
		<style type="text/css">
			@media print {
				.com_goto{
					display: none;
				}
				#toolBarDiv{
					display: none;
				}
			}
		</style>
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmAssetApplyDealForm.docSubject} - ${ lfn:message('km-asset:module.km.asset')}"></c:out>
	</template:replace>
	<template:replace name="content">
<script>
	seajs.use(['lui/jquery'], function($){
	   //设置大写值
		$(document).ready(function(){	
			setTotalToChina();
		});
	});

	//自动设置大写
	function setTotalToChina(){
		var oldTotalCount ="${kmAssetApplyDealForm.fdOldTotalMoney}";
		var oldTotalChina=showChinaValue(oldTotalCount);
		var oldTotalSpan= document.getElementById("upperCaseOldTotal");

		var newTotalCount ="${kmAssetApplyDealForm.fdNewTotalMoney}";
		var newTotalChina=showChinaValue(newTotalCount);
		var newTotalSpan= document.getElementById("upperCaseNewTotal");
		
		oldTotalSpan.innerText=oldTotalChina;
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
			//	chineseValue = '<bean:message bundle="km-asset" key="kmAssetApplyDeal.patten.init" />';
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
<div style="padding-top:50px">
<p class="txttitle">${txttitle}</p>
<div class="lui_form_content_frame">
<table class="tb_normal" width=100%>
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
					<td width="25%">
					  <c:out value="${kmAssetApplyDealForm.fdApplyTemplateName}"/></td>
					<!--申请单编号 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
				    <td colspan="3"><xform:text property="fdNo" style="width:35%" />
				</td>
			
			</tr>

			<tr>
				<!--申请人-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
				<td width="25%"><c:out
					value="${kmAssetApplyDealForm.fdCreatorName}" /></td>				
			   <!--申请部门-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
				<td width="15%"><c:out
					value="${kmAssetApplyDealForm.fdDeptName}" /></td>
				<!--申请日期-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
				<td width="15%"><xform:datetime property="fdCreateDate" dateTimeType="datetime" /></td>
			</tr>

			<tr>
				<!--事由-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyDeal.reason" /></td>
				<td colspan="5"><kmss:showText value="${kmAssetApplyDealForm.fdReason}" /></td>
			</tr>

				<!-- 处置单明细 -->
				<tr>
					<td class="td_normal_title" width="100%" colspan="6" align="center"><bean:message
						bundle="km-asset" key="table.kmAssetApplyDealList" /></td>
				</tr>
                <tr>
					<td width="100%" colspan="6"><c:import
						url="/km/asset/km_asset_apply_deal_list/kmAssetApplyDealList_view.jsp"
						charEncoding="UTF-8">
					</c:import></td>
				</tr>  

			<tr>
				<!--资产原值合计-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyDeal.fdOldTotalMoney" /></td>
				<td colspan="5">
				    <span style="width:100px"><kmss:showNumber value="${kmAssetApplyDealForm.fdOldTotalMoney}" pattern="###,##0.00"/>	</span>
					&nbsp;&nbsp;<bean:message bundle="km-asset"
					key="kmAssetApplyDeal.upperCase" />&nbsp;&nbsp;&nbsp;&nbsp;<span
					id="upperCaseOldTotal"></span></td>
			</tr>
			
			<tr>
				<!--资产报废变卖值合计-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyDeal.fdNewTotalMoney" /></td>
				<td colspan="5">
				    <span style="width:100px">  <kmss:showNumber value="${kmAssetApplyDealForm.fdNewTotalMoney}" pattern="###,##0.00"/> 	</span>
			        &nbsp;&nbsp;<bean:message bundle="km-asset"
					key="kmAssetApplyDeal.upperCase" />&nbsp;&nbsp;&nbsp;&nbsp;<span
					id="upperCaseNewTotal"></span></td>
			</tr>

            <tr>
			<!--是否同时处置资产-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyDeal.fdIsDealSubjoin" /></td>
				<td colspan="5"><xform:select property="fdIsDealSubjoin">
					<xform:enumsDataSource enumsType="common_yesno" />
				</xform:select></td>
			</tr>

			<tr>
				<!--附件机制-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
				<td colspan="5"><c:import
					url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
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
				<td colspan="5">
				   <kmss:showText value="${kmAssetApplyDealForm.fdExplain}"></kmss:showText> 
				</td>
			</tr>
		</table>
		<br/>
		<table class="tb_normal" width="100%">
		   <tr>
		   		<td class="td_normal_title" width="100%" align="center">
				    审批记录
				</td>
			</tr>
			<tr>
				<td width="100%">
				    <c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyDealForm" />
					</c:import>
				</td>
			</tr>
		</table>
		<div id="toolBarDiv" style="padding-top:20px;text-align:right;">
		      <input type="button" class="lui_form_button"  value="<bean:message key='button.print' />"  onclick="window.print();"  style="width:100px;height:60px;font-size:18px"/>
	    </div>
</div>
</div>
</template:replace>
</template:include>
