<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<table class="tb_normal" width=100%>
	<tr>
	    <td  class="td_normal_title" align="center" width="20px"> 
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdOrder"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdNo"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdName"/>
		</td>
		
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdCategory"/>
		</td>
		
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdStandard"/>
		</td>
		<!-- 原值 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
		</td>
		<!-- 领用日期 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetDate"/>
		</td>
		<!--资产使用部门 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetDept"/>
		</td>
		<!-- 责任人 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetPerson"/>
		</td>
		<!-- 存放地点 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetAddress"/>
		</td>
	</tr>
	<c:forEach items="${kmAssetApplyGetForm.fdItems}"
			var="kmAssetApplyGetListForm" varStatus="vstatus">
		<tr align="center">
		    <td  width="25px">
				${vstatus.index+1}
			</td>
			<td>
				<c:out value="${kmAssetApplyGetListForm.fdCardNo}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyGetListForm.fdAssetCardName}"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyGetListForm.fdCardCate}" />
			</td>
			<td>
				<c:out value="${kmAssetApplyGetListForm.fdCardStandard}"/>
			</td>
			<td>
			   <kmss:showNumber value="${kmAssetApplyGetListForm.fdFirstValue}" pattern="###,##0.00"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyGetListForm.fdGetDate}"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyGetListForm.fdGetDeptName}"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyGetListForm.fdGetPersonName}"/>
			</td>
			<td>
				<c:out value="${kmAssetApplyGetListForm.fdAssetAddressName}"/>
			</td>
		</tr>
	</c:forEach>
</table>