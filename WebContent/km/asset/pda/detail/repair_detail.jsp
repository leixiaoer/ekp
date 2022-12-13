<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/resource/jsp/common.jsp"%>
<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/asset/pda/css/detail.css" />
<c:set var="kmAssetApplyRepairForm"  value="${requestScope[param.formName]}" />
<table id="detailtb"  width=95%>
        <tr>
		<td colspan="2" align="center" style="font-size:20px;padding-top:10px"><bean:message bundle="km-asset" key="kmAssetApplyRepairList.cardBaseInfo" /></td>
		</tr>
	<!--内容行-->
		<c:forEach items="${kmAssetApplyRepairForm.fdItems}" var="kmAssetApplyRepairListForm" varStatus="vstatus">
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
				       <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdNo"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRepairListForm.fdCardNo}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdName"/>
					</td>
					<td class=td_common>
					   <c:out value="${kmAssetApplyRepairListForm.fdAssetCardName}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdCategory"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRepairListForm.fdCardCate}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdStandard"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRepairListForm.fdCardStandard}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdFirstValue"/>
					</td>
					<td class=td_common>
						<kmss:showNumber value="${kmAssetApplyRepairListForm.fdFirstValue}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdGetPerson"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRepairListForm.fdResponsiblePersonName}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdRepairType"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRepairListForm.fdRepairType}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdMoney"/>
					</td>
					<td class=td_common>
						<kmss:showNumber value="${kmAssetApplyRepairListForm.fdMoney}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdDegree"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRepairListForm.fdDegree}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				    <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdForeignRepairAdd"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRepairListForm.fdForeignRepairAdd}"/>
					</td>
				</tr>
				
			</table>
			</td>
			</tr>
		</c:forEach>
</table>
<c:if test="${fn:length(kmAssetApplyRepairForm.fdExpendItems)>0}">
<table id="detailtb"  width=95%>
	<!--内容行-->
		<tr>
		<td colspan="2" align="center" style="font-size:20px;padding-top:10px"><bean:message bundle="km-asset" key="kmAssetApplyRepairList.expendInfo" /></td>
		</tr>
		<c:forEach items="${kmAssetApplyRepairForm.fdExpendItems}" var="kmAssetApplyRepairExtendForm" varStatus="vstatuse">
			<tr>
			<td class="detail_wrap_td">
			<table style="text-align: left; width: 100%; border-collapse:collapse; border: 0px;" width=95%>
				<tr>
					<td colspan="2" align="left" class="detail_td_no" valign="middle">
						<span>${vstatuse.index+1}</span> 
					</td>
				</tr>
				<tr>
					<td class=td_title>
				       <bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdName"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRepairExtendForm.fdName}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdStandard"/>
					</td>
					<td class=td_common>
					   <c:out value="${kmAssetApplyRepairExtendForm.fdStandard}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdNum"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyRepairExtendForm.fdNum}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdPrice"/>
					</td>
					<td class=td_common>
						<kmss:showNumber value="${kmAssetApplyRepairExtendForm.fdPrice}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdSubTotal"/>
					</td>
					<td class=td_common>
						<kmss:showNumber value="${kmAssetApplyRepairExtendForm.fdSubTotal}" pattern="###,##0.00"/>
					</td>
				</tr>
			</table>
			</td>
			</tr>
		</c:forEach>
</table>
</c:if>
