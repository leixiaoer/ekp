<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<script>
	//当单价或者数量改变时,自动计算小计和总和合计
	function calculate(value,obj){
		//取明细项在表格中的索引;如fdItems[1].fdApplyAmount,取1
		var beginIndex=obj.name.indexOf('[');
		var endIndex = obj.name.indexOf(']');
		var index = obj.name.substring(beginIndex + 1, endIndex);
		console.log(index);
		var amount=document.getElementsByName("fdExpendItems["+index+"].fdNum")[0];//数量
		var price=document.getElementsByName("fdExpendItems["+index+"].fdPrice")[0];//单价
		var subTotal=document.getElementsByName("fdExpendItems["+index+"].fdSubTotal")[0];//小计
		
		if(amount.value!=""&&price.value!=""&&!isNaN(amount.value)&&!isNaN(price.value)){
			//更新小计
			subTotal.value=new Number(parseFloat(amount.value)*parseFloat(price.value)).toFixed(2);
		}
        AssetCountTotal();
	}	
	function AssetCountTotal(){
		//所有总和
		var totalMoney=document.getElementsByName("fdTotalMoney")[0];
		//耗材明细总和
		var expendTotal=DocList_GetSum(document.getElementById("TABLE_DocList"),/fdExpendItems\[\d+\]\.fdSubTotal/);
		//维修明细总和
		var repairTotal=DocList_GetSum(document.getElementById("RepairlistTB"),/fdItems\[\d+\]\.fdMoney/);
		totalMoney.value = expendTotal+repairTotal;
		//更新中文数字
		var chinaValue=document.getElementById("chinaValue");
		chinaValue.innerHTML=showChinaValue(totalMoney.value);

	}

</script>
<table class="tb_normal" width=100% id="TABLE_DocList">
	<tr>
		<!-- 序号 -->
		<td KMSS_IsRowIndex="1" class="td_normal_title" width="5%"> 
			<bean:message key="page.serial"/>
		</td>
		<!-- 名称-->
		<td class="td_normal_title" align="center" style="width: 25%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdName"/>
		</td>
		<!-- 型号-->
		<td class="td_normal_title" align="center" style="width: 35%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdStandard"/>
		</td>
		
		<!-- 数量-->
		<td class="td_normal_title" align="center" style="width: 10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdNum"/>
		</td>
		
		<!-- 单价 -->
		<td class="td_normal_title" align="center" style="width: 10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdPrice"/>
		</td>
		<!-- 小计 -->
		<td class="td_normal_title" align="center" style="width: 10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdSubTotal"/>
		</td>
		<!-- 操作 -->
		<c:if test="${kmAssetApplyRepairForm.docStatus!='30'}">
			<td class="td_normal_title" align="center" style="width: 5%;">
				<img src="${KMSS_Parameter_StylePath}icons/add.gif"
					style="cursor:pointer" onclick="DocList_AddRow('TABLE_DocList');">
			</td>
		</c:if>
	</tr>
	<!--基准行-->
	<tr KMSS_IsReferRow="1" style="display:none" class="fdItem">
		<td KMSS_IsRowIndex="1">!{index}
		</td>
		<td>
		 <input type="hidden" name="fdExpendItems[!{index}].fdOrder" value="!{index}" />
		   <input type="hidden" name="fdExpendItems[!{index}].fdApplyRepairId" value="${kmAssetApplyRepairForm.fdId}"/>
			<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairExpend.fdName","km-asset")%>'  property="fdExpendItems[!{index}].fdName" showStatus="edit" style="width:85%;" required="true"/>
		</td>
		<td>
			<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairExpend.fdStandard","km-asset")%>' property="fdExpendItems[!{index}].fdStandard" showStatus="edit" style="width:85%;" required="true"/>
		</td>
		<td>
			<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairExpend.fdNum","km-asset")%>' property="fdExpendItems[!{index}].fdNum" showStatus="edit" style="width:85%;" required="true" validators="number" onValueChange="calculate"/>
		</td>
		<td>
			<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairExpend.fdPrice","km-asset")%>' property="fdExpendItems[!{index}].fdPrice" showStatus="edit" style="width:85%;" required="true" validators="currency-dollar" onValueChange="calculate"/>
		</td>
		<td>
			<xform:text property="fdExpendItems[!{index}].fdSubTotal" style="width:95%;" htmlElementProperties="readonly='readonly'" showStatus="readOnly" className="inputread"/>
		</td>
		<c:if test="${fsExpenseMainForm.docStatus!='20'}">
			<td>
				<img src="${KMSS_Parameter_StylePath}icons/delete.gif"
						style="cursor:pointer" onclick="DocList_DeleteRow();AssetCountTotal();">
			</td>
		</c:if>
	</tr>
	<!--内容行-->
	<c:forEach items="${kmAssetApplyRepairForm.fdExpendItems}"
		var="kmAssetApplyRepairExpendForm" varStatus="vstatus">
		<tr KMSS_IsContentRow="1" class="fdItem">
			<td  KMSS_IsRowIndex="1">${vstatus.index+1}
			</td>
			<td>
			<input type="hidden" name="fdExpendItems[${vstatus.index}].fdOrder" value="${vstatus.index+1}" /> 
			<input type="hidden" name="fdExpendItems[${vstatus.index}].fdApplyRepairId" value="${kmAssetApplyRepairForm.fdId}"/>
				<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairExpend.fdName","km-asset")%>' property="fdExpendItems[${vstatus.index}].fdName" value="${kmAssetApplyRepairExpendForm.fdName}" style="width:85%;" required="true"/>
			</td>
			<td>
				<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairExpend.fdStandard","km-asset")%>' property="fdExpendItems[${vstatus.index}].fdStandard" value="${kmAssetApplyRepairExpendForm.fdStandard}" style="width:85%;" required="true"/>
			</td>
			<td>
				<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairExpend.fdNum","km-asset")%>' property="fdExpendItems[${vstatus.index}].fdNum" value="${kmAssetApplyRepairExpendForm.fdNum}" style="width:85%;" required="true" validators="number" onValueChange="calculate"/>
			</td>
			<td>
				<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairExpend.fdPrice","km-asset")%>' property="fdExpendItems[${vstatus.index}].fdPrice" value="${kmAssetApplyRepairExpendForm.fdPrice}" style="width:85%;" required="true" validators="currency-dollar" onValueChange="calculate"/>
			</td>
			<td>
				<xform:text property="fdExpendItems[${vstatus.index}].fdSubTotal" showStatus="readOnly" value="${kmAssetApplyRepairExpendForm.fdSubTotal}" style="width:95%;" />
			</td>
			<c:if test="${fsExpenseMainForm.docStatus!='20'}">
				<td>
					<img src="${KMSS_Parameter_StylePath}icons/delete.gif"
						style="cursor:pointer" onclick="DocList_DeleteRow();AssetCountTotal();">
				</td>
			</c:if>
		</tr>
	</c:forEach>
</table>
