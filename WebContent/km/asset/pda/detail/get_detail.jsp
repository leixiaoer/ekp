<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/resource/jsp/common.jsp"%>
<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/asset/pda/css/detail.css" />
<c:set var="kmAssetApplyGetForm"  value="${requestScope[param.formName]}" />
<table id="detailtb"  width=95%>
	<!--内容行-->
		<c:forEach items="${kmAssetApplyGetForm.fdItems}" var="kmAssetApplyGetListForm" varStatus="vstatus">
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
				       <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdNo"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyGetListForm.fdCardNo}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdName"/>
					</td>
					<td class=td_common>
					   <c:out value="${kmAssetApplyGetListForm.fdAssetCardName}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdCategory"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyGetListForm.fdCardCate}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				    <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdStandard"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyGetListForm.fdCardStandard}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
					</td>
					<td class=td_common>
					    <kmss:showNumber value="${kmAssetApplyGetListForm.fdFirstValue}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetDate"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyGetListForm.fdGetDate}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetDept"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyGetListForm.fdGetDeptName}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				    <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetPerson"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyGetListForm.fdGetPersonName}"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				    <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetAddress"/>
					</td>
					<td class=td_common>
						<c:out value="${kmAssetApplyGetListForm.fdAssetAddressName}"/>
					</td>
				</tr>
			</table>
			</td>
			</tr>
		</c:forEach>
</table>
