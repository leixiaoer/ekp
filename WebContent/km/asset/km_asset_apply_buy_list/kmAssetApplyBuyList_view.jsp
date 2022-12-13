<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--数字转中文JS -->
<%@include file="/km/asset/resource/chinaValue.jsp"%>

<table class="tb_normal" width=100% align="center">
	<!-- 表头 -->
	<tr align="center">
		<%--序号--%> 
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdOrder"/>
		</td>
		<%--资产名称--%>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdName"/>
		</td>
		<%--规格型号--%>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdStandard"/>
		</td>
		<%--单位--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdMeasure"/>
		</td>
		<%--申购数量--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdApplyAmount"/>
		</td>
		<%--预估单价--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdPrice"/>
		</td>
		<%--小计--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdSubTotal"/>
		</td>
		<%--建议到货日期--%>
		<td class="td_normal_title" width=20%>
			<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdReceiveDate"/>
		</td>
	</tr>
	
	<c:forEach items="${kmAssetApplyBuyForm.kmAssetApplyBuyListForms}"  var="kmAssetApplyBuyItem" varStatus="vstatus">
		<tr KMSS_IsContentRow="1" align="center">
			<td width="10%">${vstatus.index+1}
				<input type="hidden" name="kmAssetApplyBuyListForms[${vstatus.index}].fdId" value="${kmAssetApplyBuyItem.fdId}" /> 
				<input type="hidden" name="kmAssetApplyBuyListForms[${vstatus.index}].kmAssetApplyBuyId" value="${kmAssetApplyBuyForm.fdId}" />
			</td>
			<td width=15%>
			    <c:out value="${kmAssetApplyBuyItem.fdName}" />
			</td>
			<td width=15%>
			    <c:out value="${kmAssetApplyBuyItem.fdStandard}"/>
			</td>
			<td width=10%>
			     <c:out value="${kmAssetApplyBuyItem.fdMeasure}"/>
			</td>
			<td width=10%>
				 <c:out value="${kmAssetApplyBuyItem.fdApplyAmount}"/>
			</td>
			<td width=10%>
			    <kmss:showNumber value="${kmAssetApplyBuyItem.fdPrice}" pattern="###,##0.00"/>
			</td>
			<td width="10%" >
				<kmss:showNumber value="${kmAssetApplyBuyItem.fdSubTotal}" pattern="###,##0.00"/>
			</td>
			<td width=20%>
				<xform:datetime  property="kmAssetApplyBuyListForms[${vstatus.index}].fdReceiveDate" dateTimeType="date" 	/>
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