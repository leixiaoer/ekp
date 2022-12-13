<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/resource/jsp/common.jsp"%>
<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/asset/pda/css/detail.css" />
<c:set var="kmAssetApplyRentForm"  value="${requestScope[param.formName]}" />
<table id="detailtb"  width=95%>
	<!--内容行-->
		<c:forEach items="${kmAssetApplyRentForm.fdApplyRentListForms}" var="kmAssetApplyRentListForm" varStatus="vstatus">
			<tr>
			<td class="detail_wrap_td">
			<table style="text-align: left; width: 100%; border-collapse:collapse; border: 0px;" width=95%>
				<tr>
					<td colspan="2" align="left" class="detail_td_no" valign="middle">
						<span>${vstatus.index+1}</span>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				       <bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
					</td>
					<td class=td_common>
						  <c:out value="${kmAssetApplyRentListForm.fdCode}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRentListForm.fdAssetCardName}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
					</td>
					<td class=td_common>
					   <c:out value="${kmAssetApplyRentListForm.fdAssetCategoryName}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				    <bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRentListForm.fdStandard}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
					</td>
					<td class=td_common>
						 <kmss:showNumber value="${kmAssetApplyRentListForm.fdFirstValue}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				    <bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRentListForm.docDeptName}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				    <bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
					</td>
					<td class=td_common>
						 <c:out value="${kmAssetApplyRentListForm.fdResponsiblePersonName}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				   <bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRentListForm.fdAssetAddressName}"></c:out>
					</td>
				</tr>
			</table>
			</td>
			</tr>
		</c:forEach>
</table>
