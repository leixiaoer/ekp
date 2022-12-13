<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'baseInfo'}">
		<p class="txttitle">
			<c:if test="${not empty txttitle}">${txttitle}</c:if>
			<c:if test="${empty  txttitle}">
				<bean:message bundle="km-asset" key="table.kmAssetApplyGet"/>
			</c:if>
		</p>
		<div class="lui_form_content_frame" style="padding-top:20px"> 
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject" />
					</td>
					<td width="85%" colspan="5">
						<c:if test="${kmAssetApplyGetForm.titleRegulation==null || kmAssetApplyGetForm.titleRegulation=='' }">
							<xform:text property="docSubject" style="width:97%" />
						</c:if>
						<c:if test="${kmAssetApplyGetForm.titleRegulation!=null && kmAssetApplyGetForm.titleRegulation!='' }">
							<xform:text property="docSubject" style="width:97%" showStatus="readOnly" value="${lfn:message('km-asset:kmAssetApplyBase.docSubject.info') }" />
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
					<td width="19%"><html:hidden property="fdApplyTemplateId" />
					<html:hidden property="fdApplyTemplateName" />
					<c:out value="${kmAssetApplyGetForm.fdApplyTemplateName}"/></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
					<td width="51%" colspan="3">
					<c:choose>
						<c:when test='${kmAssetApplyGetForm.fdNo!=null}'>
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
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
					<td width="19%">
						<html:hidden property="fdCreatorId" />
						<xform:text property="fdCreatorName" value="${kmAssetApplyGetForm.fdCreatorName}" showStatus="view"></xform:text>
					</td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
					<td width="19%">
					    <html:hidden property="fdDeptId" />
						<xform:text property="fdDeptName" value="${kmAssetApplyGetForm.fdDeptName}" showStatus="view"></xform:text>
					</td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
					<td width="19%">
					    <html:hidden property="fdCreateDate" />
					    <xform:datetime property="fdCreateDate" dateTimeType="date" showStatus="view"/>
					</td>
				</tr>
				<!-- 领用明细 -->
				<tr>
					<td width="100%" colspan="6">
						<c:import url="/km/asset/km_asset_apply_get_list/kmAssetApplyGetList_edit.jsp" charEncoding="UTF-8">
						</c:import>
						<c:if test="${fn:length(myCards) > 0}">
							<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
							</c:import>
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdReason" />
					</td>
					<td width="85%" colspan="5">
						<xform:textarea property="fdReason" style="width:97%" />
					</td>

				</tr>
				<!--附件机制-->
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
					<td colspan="5">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="attachment" />
							<c:param name="fdModelId" value="${param.fdId }" />
							<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyGet" />
						</c:import>
					</td>
				</tr>
				<c:if test="${not empty kmAssetApplyGetForm.fdExplain}">
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
					<td width="85%" colspan="5">
					  <html:hidden property="fdExplain" />
					    <kmss:showText value="${kmAssetApplyGetForm.fdExplain}"></kmss:showText> 
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
				<c:param name="formName" value="kmAssetApplyGetForm" />
				<c:param name="fdKey" value="KmAssetApplyGetDoc" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
			</c:import>
		</c:if>
		 <%--权限机制 --%>
		<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyGetForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyGet" />
		</c:import>
	</c:when>
</c:choose>