<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/resource/jsp/common.jsp"%>
<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/asset/pda/css/detail.css" />
<c:set var="kmAssetApplyBuyForm"  value="${requestScope[param.formName]}" />
<table id="detailtb"  width=95%>
	<!--内容行-->
		<c:forEach items="${kmAssetApplyBuyForm.kmAssetApplyBuyListForms}" var="kmAssetApplyBuyItem" varStatus="vstatus">
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
				       <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdName"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyBuyItem.fdName }" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdStandard"/>
					</td>
					<td class=td_common>
					   <c:out value="${kmAssetApplyBuyItem.fdStandard}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdMeasure"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyBuyItem.fdMeasure}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdApplyAmount"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyBuyItem.fdApplyAmount}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdPrice"/>
					</td>
					<td class=td_common>
					    <kmss:showNumber value="${kmAssetApplyBuyItem.fdPrice}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdSubTotal"/>
					</td>
					<td class=td_common>
					    <kmss:showNumber value="${kmAssetApplyBuyItem.fdSubTotal}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdReceiveDate"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyBuyItem.fdReceiveDate}" />
					</td>
				</tr>
			</table>
			</td>
			</tr>
		</c:forEach>
</table>
