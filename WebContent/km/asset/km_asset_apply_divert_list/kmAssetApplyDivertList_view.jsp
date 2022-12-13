<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<table class="tb_normal" width=100%>
	<tr>
	    <td  class="td_normal_title" align="center" width="25px">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOrder"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="7%"> 
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdNo"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="7%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdName"/>
		</td>
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="7%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdCategory"/>
		</td>
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="6%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdStandard"/>
		</td>
		<!-- 原值 -->
		<td class="td_normal_title" align="center" width="6%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdFirstValue"/>
		</td>
		<!-- 调拨日期 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdDivertDate"/>
		</td>
		<!-- 原使用部门 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOldDept"/>
		</td>
		<!-- 现使用部门 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNowDept"/>
		</td>
		<!-- 原责任人 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdGetPerson"/>
		</td>
		<!-- 现责任人 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNowPerson"/>
		</td>
		<!-- 原地点 -->
		<td class="td_normal_title" align="center" width="7%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOldAddress"/>
		</td>
		<!-- 现地点 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNewAddress"/>
		</td>
	</tr>
	<c:forEach items="${kmAssetApplyDivertForm.fdItems}"
			var="kmAssetApplyDivertListForm" varStatus="vstatus">
		<tr align="center">
			<td  width="25px">
				${vstatus.index+1}
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdCardNo}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdAssetCardName}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdCardCate}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdCardStandard}" />
			</td>
			<td>
			    <kmss:showNumber value="${kmAssetApplyDivertListForm.fdFirstValue}" pattern="###,##0.00"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdDivertDate}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdOldDeptName}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdNowDeptName}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdGetPersonName}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdNowPersonName}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdOldAddressName}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyDivertListForm.fdNewAddressName}" />
			</td>
		</tr>
	</c:forEach>
</table>