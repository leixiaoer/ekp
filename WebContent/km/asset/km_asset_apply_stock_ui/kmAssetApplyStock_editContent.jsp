<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'baseInfo'}">
	<p class="txttitle">
		<c:if test="${not empty txttitle}">${txttitle}</c:if>
		<c:if test="${empty txttitle}">
			<bean:message bundle="km-asset" key="table.kmAssetApplyStock"/>
		</c:if>
	</p>
	 <div class="lui_form_content_frame" style="padding-top:20px">
	      <table class="tb_normal" width=100%>
		      <tr>
				<%--标题--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
				</td>
				<td colspan="3">
					<c:if test="${kmAssetApplyStockForm.titleRegulation==null || kmAssetApplyStockForm.titleRegulation=='' }">
						<xform:text property="docSubject" style="width:97%" />
					</c:if>
					<c:if test="${kmAssetApplyStockForm.titleRegulation!=null && kmAssetApplyStockForm.titleRegulation!='' }">
						<xform:text property="docSubject" style="width:97%" showStatus="readOnly" value="${lfn:message('km-asset:kmAssetApplyBase.docSubject.info') }" />
					</c:if>
				</td>
			</tr>
			
			<tr>
				<%--类别--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
				</td>
				<td width="35%">
					<html:hidden property="fdApplyTemplateId" />
					<bean:write name="kmAssetApplyStockForm"  property="fdApplyTemplateName" />
				</td>
				<%--申请单编号--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</td>
				<td width="35%">
				   <c:choose>
						<c:when test='${kmAssetApplyStockForm.fdNo!=null}'>
						    <xform:text property="fdNo" style="width:85%" />
						</c:when>
						<c:otherwise>
						<bean:message
						bundle="km-asset" key="kmAssetApplyBase.autoCreate" />
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			
			<tr>
				<%--拟单人--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
				</td>
				<td width="35%">
					<xform:address propertyId="fdCreatorId" propertyName="fdCreatorName" orgType="ORG_TYPE_PERSON" showStatus="view" />
				</td>
				<%-- 拟单日期 --%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" />
				</td>
				<td width="35%">
					<xform:datetime property="fdCreateDate" showStatus="view" />
				</td>
			</tr>
			
			<tr>
				<%-- 采购明细标题 --%>
				<td colspan="4" class="td_normal_title" align="center">
					<bean:message bundle="km-asset" key="table.kmAssetApplyStockList"/>
				</td>
			</tr>
			
			<tr>
				<%-- 采购单明细--%>
				<td colspan="4">
					<%@include file="/km/asset/km_asset_apply_stock_list/kmAssetApplyStockList_edit.jsp"%>
					<c:if test="${fn:length(myCards) > 0}">
						<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
						</c:import>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<%-- 合计 --%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyStock.fdTotalMoney"/>
				</td>
				<td colspan="3">
					<html:hidden property="fdTotalMoney"/>
					<span  id="fdTotalMoneySpan" style="width: 10%">${kmAssetApplyStockForm.fdTotalMoney}</span>
					<%--中文大写--%>
					<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
					<span id="chinaValue"></span>
				</td>
			</tr>
			
			<tr>
				<%--采购事项--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyStock.fdStockMatter"/>
				</td>
				<td colspan="3">
					<xform:textarea property="fdStockMatter" style="width:97%" />
				</td>
			</tr>
			
			<tr>
				<%-- 附件 --%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyStock.attachment"/>
				</td>
				<td colspan="3">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="kmAssetApplyStock" />									
					</c:import>
				</td>
			</tr>
			
			<c:if test="${not empty kmAssetApplyStockForm.fdExplain}">
			<tr>
				<%--说明 --%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
				</td>
				<td colspan="3">
					<html:hidden property="fdExplain" />
		             <kmss:showText value="${kmAssetApplyStockForm.fdExplain}"></kmss:showText>
				</td>
			</tr>
			</c:if>
			<input type="hidden" name="fdTemplateId" value=""/>
			<input type="hidden" name="fdTemplateName" value=""/>
		</table>
	</div>
	<script>
		$KMSSValidation();
	</script>
	</c:when>
	<c:when test="${param.contentType eq 'other'}">
		<c:if test="${param.approveModel ne 'right'}">
			<%--流程--%>
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyStockForm" />
				<c:param name="fdKey" value="KmAssetApplyStockDoc" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
			</c:import>
		</c:if>
		 <%--权限机制 --%>
		<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyStockForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyStock" />
		</c:import>
	</c:when>
</c:choose>