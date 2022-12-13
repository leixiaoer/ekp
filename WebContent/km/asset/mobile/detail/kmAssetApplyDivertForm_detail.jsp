<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="kmAssetApplyDivertForm"  value="${requestScope[param.formName]}" />
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
							<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdNo"/>
						</td>
						<%--资产名称 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdName"/>
						</td>
						<%--资产类别 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdCategory"/>
						</td>
						<%--规格型号 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdStandard"/>
						</td>
						<%--原值 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdFirstValue"/>
						</td>
						<%--调拨日期 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdDivertDate"/>
						</td>
						<%--原使用部门--%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOldDept"/>
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNowDept"/>
						</td>
						<%--责任人 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdGetPerson"/>
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNowPerson"/>
						</td>
						<%--存放地点--%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOldAddress"/>
						</td>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNewAddress"/>
						</td>
					</tr>
					<c:forEach items="${kmAssetApplyDivertForm.fdItems}" var="item" varStatus="vstatus">
						<tr KMSS_IsContentRow="1" align="center">
							<td KMSS_IsRowIndex=1 class="detailTableIndex">
								<span>${vstatus.index+1}</span>
							</td>
							<td>
								<c:out value="${item.fdCardNo}" />
							</td>
							<td>
								<c:out value="${item.fdAssetCardName}"/>
							</td>
							<td>
								<c:out value="${item.fdCardCate}" />
							</td>
							<td>
								<c:out value="${item.fdCardStandard}"/>
							</td>
							<td>
								<kmss:showNumber value="${item.fdFirstValue}" pattern="###,##0.00"/>
							</td>
							<td>
								<c:out value="${item.fdDivertDate}"/>
							</td>
							<td>
								<c:out value="${item.fdOldDeptName}"/>
							</td>
							<td>
								<c:out value="${item.fdNowDeptName}"/>
							</td>
							<td>
								<c:out value="${item.fdGetPersonName}"/>
							</td>
							<td>
								<c:out value="${item.fdNowPersonName}"/>
							</td>
							<td>
								<c:out value="${item.fdOldAddressName}"/>
							</td>
							<td>
								<c:out value="${item.fdNewAddressName}"/>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
	</table>
</div>
</div>

