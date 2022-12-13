<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="mainModelForm" value="${requestScope[param.formName]}" scope="request"/>
<div data-dojo-type="mui/table/ScrollableHContainer">
	<div data-dojo-type="mui/table/ScrollableHView">
	<table class="detailTableNormal" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="detailTableNormalTd">
				<table class="muiNormal" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<kmss:message key="page.serial" />
						</td>
						<%--资产名称 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdName"/>
						</td>
						<%--规格型号 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdStandard"/>
						</td>
						<%--单位 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdMeasure"/>
						</td>
						<%--申购数量 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdApplyAmount"/>
						</td>
						<%--预估价格 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdPrice"/>
						</td>
						<%--小计 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdSubTotal"/>
						</td>
						<%--建议到货日期 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyBuyList.fdReceiveDate"/>
						</td>
					</tr>
					<c:forEach items="${mainModelForm.kmAssetApplyBuyListForms}" var="kmAssetApplyBuyItem" varStatus="vstatus">
						<tr KMSS_IsContentRow="1" align="center">
							<td KMSS_IsRowIndex=1 class="detailTableIndex">
								<span>${vstatus.index+1}</span>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyBuyItem.fdName }"></c:out></div>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyBuyItem.fdStandard }"></c:out></div>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyBuyItem.fdMeasure }"></c:out></div>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyBuyItem.fdApplyAmount }"></c:out></div>
							</td>
							<td>
								<div><kmss:showNumber value="${kmAssetApplyBuyItem.fdPrice}" pattern="###,##0.00"/></div>
							</td>
							<td>
								<div><kmss:showNumber value="${kmAssetApplyBuyItem.fdSubTotal}" pattern="###,##0.00"/></div>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyBuyItem.fdReceiveDate}" /></div>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
	</table>

</div>
</div>

