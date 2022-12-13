<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/resource/jsp/common.jsp"%>
<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/asset/pda/css/detail.css" />
<c:set var="kmAssetApplyDivertForm"  value="${requestScope[param.formName]}" />
<table id="detailtb"  width=95%>
	<!--内容行-->
		<c:forEach items="${kmAssetApplyDivertForm.fdItems}" var="kmAssetApplyDivertListForm" varStatus="vstatus">
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
				     <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdNo"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDivertListForm.fdCardNo}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdName"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDivertListForm.fdAssetCardName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdCategory"/>
					</td>
					<td class=td_common>
					   <c:out value="${kmAssetApplyDivertListForm.fdCardCate}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdStandard"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDivertListForm.fdCardStandard}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdFirstValue"/>
					</td>
					<td class=td_common>
					   <kmss:showNumber value="${kmAssetApplyDivertListForm.fdFirstValue}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdDivertDate"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDivertListForm.fdDivertDate}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOldDept"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDivertListForm.fdOldDeptName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				    <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNowDept"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDivertListForm.fdNowDeptName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdGetPerson"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDivertListForm.fdGetPersonName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNowPerson"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDivertListForm.fdNowPersonName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOldAddress"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDivertListForm.fdOldAddressName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNewAddress"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyDivertListForm.fdNewAddressName}" />
					</td>
				</tr>
				
			</table>
			</td>
			</tr>
		</c:forEach>
</table>
