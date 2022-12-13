<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/resource/jsp/common.jsp"%>
<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/asset/pda/css/detail.css" />
<c:set var="kmAssetApplyDealForm"  value="${requestScope[param.formName]}"/>
<table id="detailtb"  width=95%>
	<!--内容行-->
		<c:forEach items="${kmAssetApplyDealForm.fdApplyDealListForms}" var="kmAssetApplyDealListForm" varStatus="vstatus">
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
						<c:out value="${kmAssetApplyDealListForm.fdCode}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
					</td>
					<td class=td_common>
					   <c:out value="${kmAssetApplyDealListForm.fdAssetCardName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDealListForm.fdAssetCategoryName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDealListForm.fdStandard}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetCard.fdBuyDate"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDealListForm.fdBuyDate}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDealListForm.fdResponsiblePersonName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDealListForm.fdAssetAddressName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
					</td>
					<td class=td_common>
					    <kmss:showNumber value="${kmAssetApplyDealListForm.fdFirstValue}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDealList.fdNetValue"/>
					</td>
					<td class=td_common>
					    <kmss:showNumber value="${kmAssetApplyDealListForm.fdNetValue}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDealList.fdRemainValue"/>
					</td>
					<td class=td_common>
					   <kmss:showNumber value="${kmAssetApplyDealListForm.fdRemainValue}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDealList.fdDealMoney"/>
					</td>
					<td class=td_common>
					    <kmss:showNumber value="${kmAssetApplyDealListForm.fdDealMoney}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDeal.fdDealType" />
					</td>
					<td class=td_common>
						<xform:select property="fdApplyDealListForms[${vstatus.index}].fdDealType">
								<xform:enumsDataSource enumsType="km_asset_apply_deal_fd_deal_type" />
						</xform:select>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDealList.fdRemark"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDealListForm.fdRemark}"></c:out>
					</td>
				</tr>
			</table>
			</td>
			</tr>
		</c:forEach>
</table>
