<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="kmAssetApplyGetForm"  value="${requestScope[param.formName]}" />
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
							<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdNo"/>
						</td>
						<%--资产名称 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdName"/>
						</td>
						<%--资产类别 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdCategory"/>
						</td>
						<%--规格型号 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdStandard"/>
						</td>
						<%--原值 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
						</td>
						<%--领用日期 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetDate"/>
						</td>
						<%--资产使用部门--%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetDept"/>
						</td>
						<%--责任人 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetPerson"/>
						</td>
						<%--存放地点--%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetAddress"/>
						</td>
					</tr>
					<c:forEach items="${kmAssetApplyGetForm.fdItems}" var="item" varStatus="vstatus">
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
								<div><c:out value="${item.fdGetDate}"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdGetDeptName}"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdGetPersonName}"/></div>
							</td>
							<td>
								<div><c:out value="${item.fdAssetAddressName}"/></div>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
	</table>

</div>
</div>

