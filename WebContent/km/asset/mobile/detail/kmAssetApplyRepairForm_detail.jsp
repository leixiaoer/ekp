<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="kmAssetApplyRepairForm"  value="${requestScope[param.formName]}" />
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
							 <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdNo"/>
						</td>
						<%--资产名称 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdName"/>
						</td>
						<%--资产类别 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdCategory"/>
						</td>
						<%--规格型号 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdStandard"/>
						</td>
						<%--原值 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdFirstValue"/>
						</td>
						<%--责任人 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdGetPerson"/>
						</td>
						<%--维修方式--%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdRepairType"/>
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdMoney"/>
						</td>
						<%--占原值百分比 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdDegree"/>
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdForeignRepairAdd"/>
						</td>
						
					</tr>
					<c:forEach items="${kmAssetApplyRepairForm.fdItems}" var="item" varStatus="vstatus">
						<tr KMSS_IsContentRow="1" align="center">
							<td KMSS_IsRowIndex=1 class="detailTableIndex">
								<span>${vstatus.index+1}</span>
							</td>
							<td>
								<div><c:out value="${item.fdCardNo}" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdAssetCardName}"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdCardCate}" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdCardStandard}"/></div>
							</td>
							<td>
								<div><kmss:showNumber value="${item.fdFirstValue}" pattern="###,##0.00"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdResponsiblePersonName}"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdRepairType}"/></div>
							</td>
							<td>
								<div><kmss:showNumber value="${item.fdMoney}" pattern="###,##0.00"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdDegree}"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdForeignRepairAdd}"/></div>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
	</table>

</div>
</div>

<c:if test="${fn:length(kmAssetApplyRepairForm.fdExpendItems)>0}">
	<p></p>
	<div data-dojo-type="mui/table/ScrollableHContainer">
		<div data-dojo-type="mui/table/ScrollableHView">
		<table class="detailTableNormal" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="detailTableNormalTd">
					<table class="muiNormal" style="width:100%" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<kmss:message key="page.serial" />
							</td>
							<td>
								 <bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdName"/>
							</td>
							<%--型号 --%>
							<td>
								<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdStandard"/>
							</td>
							<td>
								<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdNum"/>
							</td>
							<td>
								<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdPrice"/>
							</td>
							<td>
								<bean:message bundle="km-asset" key="kmAssetApplyRepairExpend.fdSubTotal"/>
							</td>
						</tr>
						<c:forEach items="${kmAssetApplyRepairForm.fdExpendItems}" var="item" varStatus="vstatus">
							<tr KMSS_IsContentRow="1" align="center">
								<td KMSS_IsRowIndex=1 class="detailTableIndex">
									<span>${vstatus.index+1}</span>
								</td>
								<td>
									<c:out value="${item.fdName}"/>
								</td>
								<td>
									<c:out value="${item.fdStandard}" />
								</td>
								<td>
									<c:out value="${item.fdNum}"/>
								</td>
								<td>
									<kmss:showNumber value="${item.fdPrice}" pattern="###,##0.00"/>
								</td>
								<td>
									<kmss:showNumber value="${item.fdSubTotal}" pattern="###,##0.00"/>
								</td>
							</tr>
						</c:forEach>
					</table>
				</td>
			</tr>
		</table>
			
		</div>
	</div>
</c:if>
