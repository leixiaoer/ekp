<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<script type="text/javascript">
	//当单价或者数量改变时,自动计算小计和合计
	function calculate(value,obj){ 
		//取明细项在表格中的索引;如kmAssetApplyBuyListForms[1].fdApplyAmount,取1
		var index=obj.name.substring(obj.name.indexOf("[") + 1,obj.name.indexOf("]"));
		var amount=document.getElementsByName("kmAssetApplyBuyListForms["+index+"].fdApplyAmount")[0];//数量
		var price=document.getElementsByName("kmAssetApplyBuyListForms["+index+"].fdPrice")[0];//单价
		var subTotal=document.getElementsByName("kmAssetApplyBuyListForms["+index+"].fdSubTotal")[0];//小计隐藏域
		var subTotalSpan=document.getElementById("fdSubTotal"+index);//小计显示域
		if(amount.value!=""&&price.value!=""&&!isNaN(amount.value)&&!isNaN(price.value)){
			//更新小计
			subTotal.value=(parseFloat(amount.value)*parseFloat(price.value)).toFixed(2);
			subTotalSpan.innerHTML=subTotal.value.toString();
			//更新总计
			var totalMoney=document.getElementsByName("fdTotalMoney")[0];//总计隐藏域
			var totalMoneySpan=document.getElementById("fdTotalMoneySpan");//总计显示域
			if(totalMoney.value=="") totalMoney.value="0";
			totalMoney.value=DocList_GetSum(document.getElementById("TABLE_DocList"),
					/kmAssetApplyBuyListForms\[\d+\]\.fdSubTotal/).toFixed(2);
			totalMoneySpan.innerHTML=totalMoney.value.toString();
			//更新中文数字
			var chinaValue=document.getElementById("chinaValue");
			chinaValue.innerHTML=showChinaValue(totalMoney.value);
		}
	}	

	//删除行,重新计算总值
	function deleteRow(){
		//删除行
		//var optTR = DocListFunc_GetParentByTagName("TR");
		DocList_DeleteRow();
		//更新总计
		var totalMoney=document.getElementsByName("fdTotalMoney")[0];
		var totalMoneySpan=document.getElementById("fdTotalMoneySpan");//总计显示域
		if(totalMoney.value==""||!isNaN(totalMoney.value))
			 totalMoney.value="0";
		totalMoney.value=DocList_GetSum(document.getElementById("TABLE_DocList"),
			/kmAssetApplyBuyListForms\[\d+\]\.fdSubTotal/);
		totalMoneySpan.innerHTML=totalMoney.value.toString();
		//更新中文数字
		var chinaValue=document.getElementById("chinaValue");
		chinaValue.innerHTML=showChinaValue(totalMoney.value);
	}
</script>
<!--数字转中文JS  -->
<%@include file="/km/asset/resource/chinaValue.jsp"%>
<table class="tb_normal" width=100% id="TABLE_DocList" align="center">
	<!-- 表头 -->
	<tr align="center">
		<%--序号--%> 
		<td class="td_normal_title" style="width: 5%">
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdOrder"/>
		</td>
		<%--资产名称--%>
		<td class="td_normal_title" style="width: 15%">
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdName"/>
		</td>
		<%--规格型号--%>
		<td class="td_normal_title" style="width: 20%">
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdStandard"/>
		</td>
		<%--单位--%>
		<td class="td_normal_title" style="width: 10%">
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdMeasure"/>
		</td>
		<%--申购数量--%>
		<td class="td_normal_title" style="width: 7%">
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdApplyAmount"/>
		</td>
		<%--预估单价--%>
		<td class="td_normal_title" style="width: 7%">
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdPrice"/>
		</td>
		<%--小计--%>
		<td class="td_normal_title" style="width: 7%" >
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdSubTotal"/>
		</td>
		<%--建议到货日期--%>
		<td class="td_normal_title" style="width: 20%" >
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdReceiveDate"/>
		</td>
		<%--添加按钮--%>
		<td class="td_normal_title" style="width: 9%;" align="center">
			<a id="add2"  href="#" onclick="DocList_AddRow();">
				<img src="${KMSS_Parameter_StylePath}/icons/add.gif" border="0" />
			</a>
		</td>
	</tr>
	
	<!-- 基准行 -->
	<tr KMSS_IsReferRow="1" style="display: none">
		<td KMSS_IsRowIndex="1" width="5%"></td>
		<td width="15%" >
			<xform:text	property="kmAssetApplyBuyListForms[!{index}].fdName" required="true" style="width:85%" validators="maxLength(200)"
				subject='<%=ResourceUtil.getString(request,"kmAssetApplyBuyList.fdName","km-asset")%>'/>
		</td>
		<td width="19%" >
			<xform:text	property="kmAssetApplyBuyListForms[!{index}].fdStandard" style="width:85%" validators="maxLength(200)"
				subject='<%=ResourceUtil.getString(request,"kmAssetApplyBuyList.fdStandard","km-asset")%>' />
		</td>
		<td width="10%" >
			<xform:text	property="kmAssetApplyBuyListForms[!{index}].fdMeasure" style="width:85%" validators="maxLength(36)"
				subject='<%=ResourceUtil.getString(request,"kmAssetApplyBuyList.fdMeasure","km-asset")%>' />
		</td>
		<td width="7%" >
			<xform:text	property="kmAssetApplyBuyListForms[!{index}].fdApplyAmount"
				required="true" validators="digits scaleLength(0) maxLength(4) min(1)" style="width:80%" onValueChange="calculate"
				subject='<%=ResourceUtil.getString(request,"kmAssetApplyBuyList.fdApplyAmount","km-asset")%>'/>
		</td>
		<td width="7%" >
			<xform:text	property="kmAssetApplyBuyListForms[!{index}].fdPrice"
				required="true"  validators="number scaleLength(2) maxLength(36) min(0)"  style="width:80%"  onValueChange="calculate"
				subject='<%=ResourceUtil.getString(request,"kmAssetApplyBuyList.fdPrice","km-asset")%>'/>
		</td>
		<td width="7%" >
			<input type="hidden" name="kmAssetApplyBuyListForms[!{index}].fdSubTotal" />
			<span id="fdSubTotal!{index}"></span>
		</td>
		<td width="20%">
			<xform:datetime property="kmAssetApplyBuyListForms[!{index}].fdReceiveDate" style="width:90%" dateTimeType="date"  validators="datetimevalidators"  />
		</td>
		<!-- 删除、上移、下移按钮 -->
		<td width="10%" align="center">
			<a href="#" onclick="deleteRow();"><img
				src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
		</td>
	</tr>
	
	<c:forEach items="${kmAssetApplyBuyForm.kmAssetApplyBuyListForms}"  var="kmAssetApplyBuyItem" varStatus="vstatus">
		<tr KMSS_IsContentRow="1">
			<td width="5%">${vstatus.index+1}
				<input type="hidden" name="kmAssetApplyBuyListForms[${vstatus.index}].fdId" value="${kmAssetApplyBuyItem.fdId}" /> 
				<input type="hidden" name="kmAssetApplyBuyListForms[${vstatus.index}].kmAssetApplyBuyId" value="${kmAssetApplyBuyForm.fdId}" />
			</td>
			<td width=15%>
				<xform:text property="kmAssetApplyBuyListForms[${vstatus.index}].fdName" value="${kmAssetApplyBuyItem.fdName}"
					subject='<%=ResourceUtil.getString(request,"kmAssetApplyBuyList.fdName","km-asset")%>'
					style="width:85%"  required="true" validators="maxLength(200)"/>
			</td>
			<td width=19%>
				<xform:text property="kmAssetApplyBuyListForms[${vstatus.index}].fdStandard" value="${kmAssetApplyBuyItem.fdStandard}"
					subject='<%=ResourceUtil.getString(request,"kmAssetApplyBuyList.fdStandard","km-asset")%>' 
					style="width:85%"  required="false" validators="maxLength(200)" />
			</td>
			<td width=10%>
				<xform:text property="kmAssetApplyBuyListForms[${vstatus.index}].fdMeasure" value="${kmAssetApplyBuyItem.fdMeasure}"
					subject='<%=ResourceUtil.getString(request,"kmAssetApplyBuyList.fdMeasure","km-asset")%>'
					style="width:85%"  required="false" validators="maxLength(36)"/>
			</td>
			<td width=7%>
				<xform:text property="kmAssetApplyBuyListForms[${vstatus.index}].fdApplyAmount"
					style="width:80%"  required="true" value="${kmAssetApplyBuyItem.fdApplyAmount}"
					subject='<%=ResourceUtil.getString(request,"kmAssetApplyBuyList.fdApplyAmount","km-asset")%>' 
					onValueChange="calculate" validators="digits scaleLength(0) maxLength(4)" />
			</td>
			<td width=7%>
				<xform:text property="kmAssetApplyBuyListForms[${vstatus.index}].fdPrice"
					style="width:80%"  required="true" value="${kmAssetApplyBuyItem.fdPrice}" 
					subject='<%=ResourceUtil.getString(request,"kmAssetApplyBuyList.fdPrice","km-asset")%>'
					onValueChange="calculate" validators="number scaleLength(2) maxLength(36)" />
			</td>
			<td width="7%" >
				<html:hidden property="kmAssetApplyBuyListForms[${vstatus.index}].fdSubTotal" value="${kmAssetApplyBuyItem.fdSubTotal}" />
				<span id="fdSubTotal${vstatus.index}">${kmAssetApplyBuyItem.fdSubTotal}</span>
			</td>
			<td width=20%>
				<xform:datetime property="kmAssetApplyBuyListForms[${vstatus.index}].fdReceiveDate" style="width:90%" dateTimeType="date"  />
			</td>
			<!-- 删除、上移、下移按钮 -->
			<td width="10%" align="center">
				<a href="#" onclick="deleteRow();"><img
					src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
			</td>
		</tr>
	</c:forEach>
</table>

<c:if test="${kmAssetApplyBuyForm.method_GET=='add'}">
	<!-- 初始表格 -->
	<script type="text/javascript">
		window.onload=function(){
			setTimeout(function(){
				for (var i = 0; i < 1; i ++) {
				DocList_AddRow('TABLE_DocList');
				}
			},50);
		};
	</script>
</c:if>
<c:if test="${kmAssetApplyBuyForm.method_GET=='edit'}">
	<script type="text/javascript">
		window.onload=function(){
			var totalMoney=document.getElementsByName("fdTotalMoney")[0];
			//更新中文数字
			var chinaValue=document.getElementById("chinaValue");
			chinaValue.innerHTML=showChinaValue(totalMoney.value);
		};
	</script>
</c:if>
