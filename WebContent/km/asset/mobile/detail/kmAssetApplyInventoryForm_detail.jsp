<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="kmAssetApplyInventoryForm"  value="${requestScope[param.formName]}" />
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
							<bean:message bundle="km-asset" key="kmAssetApplyInList.fdName"/>
						</td>
						<%--资产编码--%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyInList.fdCode"/>
						</td>
						<%--责任人 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
						</td>
						<%--存放地点类别 --%>
						<td>
							 <bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
						</td>
						<%--使用部门 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
						</td>
						<%--资产状态 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus"/>
						</td>
						<%--备注文本 --%>
						<td>
							<bean:message bundle="km-asset" key="kmAssetApplyInventory.fdText"/>
						</td>
					</tr>
					<c:forEach items="${kmAssetApplyInventoryForm.fdDetail_Form}" var="kmAssetApplyInventoryDetailForm" varStatus="vstatus">
						<tr KMSS_IsContentRow="1" align="center">
							<td KMSS_IsRowIndex=1 class="detailTableIndex">
								<span>${vstatus.index+1}</span>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyInventoryDetailForm.fdAssetCardName}" /></div>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyInventoryDetailForm.fdAssetCardCode}"></c:out></div>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyInventoryDetailForm.fdResponsiblePersonName}"></c:out></div>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyInventoryDetailForm.fdAssetAddressName}"></c:out></div>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyInventoryDetailForm.docDeptName}"></c:out></div>
							</td>
							<td>
								<div>
											<xform:select property="fdDetail_Form[${vstatus.index}].fdAssetStatus" showPleaseSelect="true">
												<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
											</xform:select>
							    </div>
							</td>
							<td>
								<div><c:out value="${kmAssetApplyInventoryDetailForm.fdText}"></c:out></div>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
	</table>

</div>
</div>

