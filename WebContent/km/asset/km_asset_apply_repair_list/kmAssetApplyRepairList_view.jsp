<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<table class="tb_normal" width=100%>
<tr>
         <td  class="td_normal_title" align="center" width="20px">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdOrder"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="8%"> 
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdNo"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdName"/>
		</td>
		
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdCategory"/>
		</td>
		
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdStandard"/>
		</td>
		<!-- 原值 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdFirstValue"/>
		</td>
		<!-- 责任人 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdGetPerson"/>
		</td>
		<!-- 维修方式 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdRepairType"/>
		</td>
		<!--维修费用 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdMoney"/>
		</td>
		<!-- 占原值百分比 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdDegree"/>
		</td>
		<!-- 外部维修单位-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdForeignRepairAdd"/>
		</td>
	</tr>
	<c:forEach items="${kmAssetApplyRepairForm.fdItems}" var="kmAssetApplyRepairListForm" varStatus="vstatus">
		<tr align="center">
		    <td  width="25px">
				${vstatus.index+1}
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairListForm.fdCardNo}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairListForm.fdAssetCardName}"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairListForm.fdCardCate}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairListForm.fdCardStandard}"/>
			</td>
			<td>
				<kmss:showNumber value="${kmAssetApplyRepairListForm.fdFirstValue}" pattern="###,##0.00"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairListForm.fdResponsiblePersonName}"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairListForm.fdRepairType}"/>
			</td>
			<td>
				<kmss:showNumber value="${kmAssetApplyRepairListForm.fdMoney}" pattern="###,##0.00"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairListForm.fdDegree}"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairListForm.fdForeignRepairAdd}"/>
			</td>
		</tr>
	</c:forEach>
</table>