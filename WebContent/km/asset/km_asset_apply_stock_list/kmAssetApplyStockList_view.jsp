<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--数字转中文JS  -->
<%@include file="/km/asset/resource/chinaValue.jsp"%>
<table class="tb_normal" width=100% align="center">
	<tr align="center">
		<%--序号--%> 
		<td class="td_normal_title" width=5%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdOrder"/>
		</td>
		<%--资产名称--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdName"/>
		</td>
		<%--规格型号--%>
		<td class="td_normal_title" width=12%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStandard"/>
		</td>
		<%--单位--%>
		<td class="td_normal_title" width=7%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdMeasure"/>
		</td>
		<%--申购数量--%>
		<td class="td_normal_title" width=5%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
		</td>
		<%--单价--%>
		<td class="td_normal_title" width=5%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdPrice"/>
		</td>
		<%--小计--%>
		<td class="td_normal_title" width=5%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdSubTotal"/>
		</td>
		<%--采购人--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStocker"/>
		</td>
		<%--供应商--%>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdProvider"/>
		</td>
		<%--采购日期--%>
		<td class="td_normal_title" width=11%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockDate"/>
		</td>
		<%--备注文本--%>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdRemark"/>
		</td>
	</tr>
	
	<c:forEach items="${kmAssetApplyStockForm.fdItems}"  var="item" varStatus="vstatus">
		<tr KMSS_IsContentRow="1" align="center">
			<td width="5%">${vstatus.index+1}
				<input type="hidden" name="fdItems[${vstatus.index}].fdId" value="${item.fdId}" /> 
				<input type="hidden" name="fdItems[${vstatus.index}].fdAssetApplyStockId" value="${kmAssetApplyStockForm.fdId}" />
			</td>
			<td width=10%>
				<xform:text property="fdItems[${vstatus.index}].fdName" value="${item.fdName }" />
			</td>
			<td width=12%>
				<xform:text property="fdItems[${vstatus.index}].fdStandard" value="${item.fdStandard}" />
			</td>
			<td width=5%>
				<xform:text property="fdItems[${vstatus.index}].fdMeasure" value="${item.fdMeasure}" />
			</td>
			<td width=7%>
				<xform:text property="fdItems[${vstatus.index}].fdStockAmount" value="${item.fdStockAmount}" />
			</td>
			<td width=5%>
				<xform:text property="fdItems[${vstatus.index}].fdPrice" value="${item.fdPrice}" showStatus="noShow"/>
				<kmss:showNumber value="${item.fdPrice}" pattern="###,##0.00"/>
			</td>
			<td width="5%" >
				<xform:text property="fdItems[${vstatus.index}].fdSubTotal"  value="${item.fdSubTotal}" showStatus="noShow"/>
				<kmss:showNumber value="${item.fdSubTotal}" pattern="###,##0.00"/>
			</td>
			<td width="10%" >
				<c:out value="${item.fdStockerName}" />
			</td>
			<td width="15%" >
				<c:out value="${item.fdProviderName}" />
			</td>
			<td width="11%" >
				<c:out value="${item.fdStockDate}" />
			</td>
			<td width="15%" >
				<c:out value="${item.fdRemark}" />
			</td>
		</tr>
	</c:forEach>
</table>
<script type="text/javascript">
	window.onload=function(){
		var totalMoney=document.getElementsByName("fdTotalMoney")[0];
		//更新中文数字
		var chinaValue=document.getElementById("chinaValue");
		chinaValue.innerHTML=showChinaValue(totalMoney.value);
	};
</script>