<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/resource/jsp/common.jsp"%>
<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/asset/pda/css/detail.css" />
<c:set var="kmAssetApplyInForm"  value="${requestScope[param.formName]}" />
<table id="detailtb"  width=95%>
	<!--内容行-->
		<c:forEach items="${kmAssetApplyInForm.kmAssetApplyInListForms}" var="item" varStatus="vstatus">
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
				       <bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdStockNo}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetApplyInList.fdName"/>
					</td>
					<td class=td_common>
					   <c:out value="${item.fdName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdStockAmount}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdReceiveAmount"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdReceiveAmount}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyInList.fdAssetCategory"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdAssetCategoryName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				    <bean:message bundle="km-asset" key="kmAssetApplyInList.fdNo"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdNo}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyInList.fdCode"/>
					</td>
					<td class=td_common>
						<c:if test="${not empty item.fdCode}">
							<c:out value="${item.fdCode}"></c:out>
						</c:if>
						<c:if test="${codeRule=='2'&&kmAssetApplyInForm.docStatus!='30'}">
							<bean:message bundle="km-asset"  key="kmAssetApplyInList.fdCodeAuto" />
						</c:if>	
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyInList.fdDeptCode"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdDeptCode}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyInList.fdInNum"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdInNum}" />
					</td>
				</tr>
				
			</table>
			</td>
			</tr>
		</c:forEach>
</table>
