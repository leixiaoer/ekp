<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="kmAssetApplyDealForm"  value="${requestScope[param.formName]}" />
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
						<td>
							<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
						</td>
						<%--资产名称 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
						</td>
						<%--资产类别 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
						</td>
						<%--规格型号 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
						</td>
						<%--采购日期 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetCard.fdBuyDate"/>
						</td>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
						</td>
						<%--存放地点--%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
						</td>
						<%--原值 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
						</td>
						
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdNetValue"/>
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdRemainValue"/>
						</td>
						<%--报废变卖值--%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdDealMoney"/>
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDeal.fdDealType" />
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdRemark"/>
						</td>
					</tr>
					<c:forEach items="${kmAssetApplyDealForm.fdApplyDealListForms}" var="item" varStatus="vstatus">
						<tr KMSS_IsContentRow="1" align="center">
							<td KMSS_IsRowIndex=1 class="detailTableIndex">
								<span>${vstatus.index+1}</span>
							</td>
							<td>
								<div><c:out value="${item.fdCode}" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdAssetCardName}"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdAssetCategoryName}" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdStandard}"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdBuyDate}" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdResponsiblePersonName}"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdAssetAddressName}"/></div>
							</td>
							<td>
								<div><kmss:showNumber value="${item.fdFirstValue}" pattern="###,##0.00"/></div>
							</td>
							<td>
								<div><kmss:showNumber value="${item.fdNetValue}" pattern="###,##0.00"/></div>
							</td>
							<td>
								<div><kmss:showNumber value="${item.fdRemainValue}" pattern="###,##0.00"/></div>
							</td>
							<td>
								<div><kmss:showNumber value="${item.fdDealMoney}" pattern="###,##0.00"/></div>
							</td>
							<td>
								<div><xform:select property="fdApplyDealListForms[${vstatus.index}].fdDealType" mobile="true">
												<xform:enumsDataSource enumsType="km_asset_apply_deal_fd_deal_type" />
										</xform:select></div>
							</td>
							<td>
								<div><c:out value="${item.fdRemark}"/></div>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
	</tr>
	</table>

</div>
</div>

