<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="kmAssetApplyStockForm"  value="${requestScope[param.formName]}" />
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
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdName"/>
						</td>
						<%--规格型号 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStandard"/>
						</td>
						<%--单位 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdMeasure"/>
						</td>
						<%--数量 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
						</td>
						<%--价格 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdPrice"/>
						</td>
						<%--小计 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdSubTotal"/>
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStocker"/>
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdProvider"/>
						</td>
						<%--日期 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockDate"/>
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdRemark"/>
						</td>
					</tr>
					<c:forEach items="${kmAssetApplyStockForm.fdItems}" var="item" varStatus="vstatus">
						<tr KMSS_IsContentRow="1" align="center">
							<td KMSS_IsRowIndex=1 class="detailTableIndex">
								<span>${vstatus.index+1}</span>
							</td>
							<td>
								<div><c:out value="${item.fdName }" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdStandard }"></c:out></div>
							</td>
							<td>
								<div><c:out value="${item.fdMeasure }"></c:out></div>
							</td>
							<td>
								<div><c:out value="${item.fdStockAmount }"></c:out></div>
							</td>
							<td>
								<div><kmss:showNumber value="${item.fdPrice}" pattern="###,##0.00"/></div>
							</td>
							<td>
								<div><xform:text property="fdItems[${vstatus.index}].fdSubTotal"  value="${item.fdSubTotal}" showStatus="noShow" mobile="true"/>
								<kmss:showNumber value="${item.fdSubTotal}" pattern="###,##0.00"/>
								</div>
							</td>
							<td>
								<div><c:out value="${item.fdStockerName}" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdProviderName}" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdStockDate}" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdRemark}" /></div>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
	</table>

</div>
</div>

