<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<table class="tb_normal" width=100%>
<tr>
		<!-- 序号 -->
		<td KMSS_IsRowIndex="1" class="td_normal_title" width="25px;"> 
			<bean:message key="page.serial"/>
		</td>
		<!-- 名称-->
		<td class="td_normal_title" align="center">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdName"/>
		</td>
		<!-- 型号-->
		<td class="td_normal_title" align="center">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdStandard"/>
		</td>
		
		<!-- 数量-->
		<td class="td_normal_title" align="center">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdNum"/>
		</td>
		
		<!-- 单价 -->
		<td class="td_normal_title" align="center">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdPrice"/>
		</td>
		<!-- 小计 -->
		<td class="td_normal_title" align="center">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdSubTotal"/>
		</td>
	</tr>
	<c:forEach items="${kmAssetApplyRepairForm.fdExpendItems}"
			var="kmAssetApplyRepairExtendForm" varStatus="vstatus">
		<tr align="center">
			<td>
				<%-- <c:out value="${kmAssetApplyRepairExtendForm.fdOrder + 1}" /> --%>
				${vstatus.index+1}
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairExtendForm.fdName}"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairExtendForm.fdStandard}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyRepairExtendForm.fdNum}"/>
			</td>
			<td>
				<kmss:showNumber value="${kmAssetApplyRepairExtendForm.fdPrice}" pattern="###,##0.00"/>
			</td>
			<td>
				<kmss:showNumber value="${kmAssetApplyRepairExtendForm.fdSubTotal}" pattern="###,##0.00"/>
			</td>
		</tr>
	</c:forEach>
</table>