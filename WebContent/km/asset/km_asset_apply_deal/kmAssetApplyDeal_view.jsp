<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("dialog.js|calendar.js|jquery.js");
</script>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
   //设置大写值
	$(document).ready(function(){	
		setTotalToChina();
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
<div id="optBarDiv">
 <c:if test="${kmAssetApplyDealForm.docStatus=='10' || kmAssetApplyDealForm.docStatus=='11'|| kmAssetApplyDealForm.docStatus=='20'}">
    <kmss:auth requestURL="/km/asset/km_asset_apply_deal/kmAssetApplyDeal.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button" value="<bean:message key="button.edit"/>" onclick="Com_OpenWindow('kmAssetApplyDeal.do?method=edit&fdId=${JsParam.fdId}','_self');">
    </kmss:auth>
 </c:if>  
    
 <kmss:auth
	requestURL="/km/asset/km_asset_apply_deal/kmAssetApplyDeal.do?method=delete&fdId=${param.fdId}"
	requestMethod="GET">
	<input type="button" value="<bean:message key="button.delete"/>"
		onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyDeal.do?method=delete&fdId=${JsParam.fdId}','_self');">
</kmss:auth> <input type="button" value="<bean:message key="button.close"/>"
	onclick="Com_CloseWindow();"></div>

<p class="txttitle">${txttitle}</p>

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
					  ${kmAssetApplyDealForm.fdApplyTemplateName}</td>
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
				<td width="15%"><xform:datetime property="fdCreateDate" dateTimeType="date" /></td>
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
				<td colspan="3"> 
				    <span style="width:100px">  <kmss:showNumber value="${kmAssetApplyDealForm.fdOldTotalMoney}" pattern="###,##0.00"/>	</span>
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
		</td>
	</tr>
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfProcess_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyDealForm" />
		<c:param name="fdKey" value="KmAssetApplyDealDoc" />
	</c:import>
	<!-- 权限页签 -->
	<tr
		LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
		<table class="tb_normal" width=100%>
			<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyDealForm" />
				<c:param name="moduleModelName"
					value="com.landray.kmss.km.asset.model.KmAssetApplyDeal" />
			</c:import>
		</table>
		</td>
	</tr>
	<!-- 关联机制 -->
	<tr
		LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
		<c:set var="mainModelForm" value="${kmAssetApplyDealForm}"
			scope="request" />
		<c:set var="currModelName"
			value="com.landray.kmss.km.asset.model.KmAssetApplyDeal"
			scope="request" />
		<td><%@ include
			file="/sys/relation/include/sysRelationMain_view.jsp"%>
		</td>
	</tr>
	<!-- 关联机制 -->

	<%--阅读机制--%>
	<c:import url="/sys/readlog/include/sysReadLog_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyDealForm" />
	</c:import>
	

</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>