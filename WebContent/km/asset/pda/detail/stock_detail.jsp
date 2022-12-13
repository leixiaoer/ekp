<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/resource/jsp/common.jsp"%>
<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/asset/pda/css/detail.css" />
<c:set var="kmAssetApplyStockForm"  value="${requestScope[param.formName]}" />
<table id="detailtb"  width=95%>
	<!--内容行-->
		<c:forEach items="${kmAssetApplyStockForm.fdItems}" var="item" varStatus="vstatus">
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
				       <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdName"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdName }" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				      <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStandard"/>
					</td>
					<td class=td_common>
					   <c:out value="${item.fdStandard}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdMeasure"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdMeasure}" />
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
				     <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdPrice"/>
					</td>
					<td class=td_common>
					    <kmss:showNumber value="${item.fdPrice}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdSubTotal"/>
					</td>
					<td class=td_common>
						<xform:text property="fdItems[${vstatus.index}].fdSubTotal"  value="${item.fdSubTotal}" showStatus="noShow"/>
				        <kmss:showNumber value="${item.fdSubTotal}" pattern="###,##0.00"/>
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStocker"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdStockerName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdProvider"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdProviderName}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockDate"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdStockDate}" />
					</td>
				</tr>
				<tr>
					<td class=td_title>
				     <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdRemark"/>
					</td>
					<td class=td_common>
						<c:out value="${item.fdRemark}" />
					</td>
				</tr>
				
			</table>
			</td>
			</tr>
		</c:forEach>
</table>
