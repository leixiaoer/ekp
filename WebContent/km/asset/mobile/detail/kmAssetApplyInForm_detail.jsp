<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="kmAssetApplyInForm"  value="${requestScope[param.formName]}" />
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
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
						</td>
						<%--资产名称 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyInList.fdName"/>
						</td>
						<%--采购数量 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
						</td>
						<%--已到数量 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdReceiveAmount"/>
						</td>
						<%--类别 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyInList.fdAssetCategory"/>
						</td>
						<%--资产序列号 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetApplyInList.fdNo"/>
						</td>
						<%--资产编码--%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyInList.fdCode"/>
						</td>
						<%--机构代码 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyInList.fdDeptCode"/>
						</td>
						<%--到货数量--%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyInList.fdInNum"/>
						</td>
					</tr>
					<c:forEach items="${kmAssetApplyInForm.kmAssetApplyInListForms}" var="item" varStatus="vstatus">
						<tr KMSS_IsContentRow="1" align="center">
							<td KMSS_IsRowIndex=1 class="detailTableIndex">
								<span>${vstatus.index+1}</span>
							</td>
							<td>
								<div><c:out value="${item.fdStockNo}" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdName }"></c:out></div>
							</td>
							<td>
								<div><c:out value="${item.fdStockAmount }"></c:out></div>
							</td>
							<td>
								<div><c:out value="${item.fdReceiveAmount }"></c:out></div>
							</td>
							<td>
								<div><c:out value="${item.fdAssetCategoryName }"></c:out></div>
							</td>
							<td>
								<div><c:out value="${item.fdNo }"></c:out></div>
							</td>
							<td>
								<div>
								<c:if test="${not empty item.fdCode}">
											<c:out value="${item.fdCode}"></c:out>
								</c:if>
								<c:if test="${codeRule=='2'&&kmAssetApplyInForm.docStatus!='30'}">
									<bean:message bundle="km-asset"  key="kmAssetApplyInList.fdCodeAuto" />
								</c:if>	
								</div>
							</td>
							<td>
								<div><c:out value="${item.fdDeptCode}" /></div>
							</td>
							<td>
								<div><c:out value="${item.fdInNum}" /></div>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
	</table>

</div>
</div>

