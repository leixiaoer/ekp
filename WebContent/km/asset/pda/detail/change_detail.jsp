<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/resource/jsp/common.jsp"%>
<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/asset/pda/css/detail.css" />
<c:set var="kmAssetApplyChangeForm"  value="${requestScope[param.formName]}" />
<table id="detailtb"  width=95%>
	<!--内容行-->
		<c:forEach items="${kmAssetApplyChangeForm.fdApplyChangeListForms}" var="kmAssetApplyChangeListForm" varStatus="vstatus">
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
						<c:out value="${kmAssetApplyChangeListForm.fdCode}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
					</td>
					<td class=td_common>
					 <c:out value="${kmAssetApplyChangeListForm.fdAssetCardName}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyChangeListForm.fdAssetCategoryName}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyChangeListForm.fdStandard}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetDept"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyChangeListForm.fdNewDeptName}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
					</td>
					<td class=td_common>
						 <c:out value="${kmAssetApplyChangeListForm.fdNewResponsiblePersonName}"></c:out>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyChangeListForm.fdNewAddressName}"></c:out>
					</td>
				</tr>
			</table>
			</td>
			</tr>
		</c:forEach>
</table>
