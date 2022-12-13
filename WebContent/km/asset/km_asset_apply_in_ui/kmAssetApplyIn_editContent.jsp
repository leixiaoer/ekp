<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'baseInfo'}">
		<p class="txttitle">
				<c:if test="${not empty txttitle}">${txttitle}</c:if>
				<c:if test="${empty  txttitle}">
					<bean:message bundle="km-asset" key="table.kmAssetApplyIn"/>
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
					<c:if test="${kmAssetApplyInForm.titleRegulation==null || kmAssetApplyInForm.titleRegulation=='' }">
						<xform:text property="docSubject" style="width:97%" />
					</c:if>
					<c:if test="${kmAssetApplyInForm.titleRegulation!=null && kmAssetApplyInForm.titleRegulation!='' }">
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
					<bean:write name="kmAssetApplyInForm"  property="fdApplyTemplateName" />
				</td>
				<%--申请单编号--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</td>
				<td width="35%">
				   <c:choose>
						<c:when test='${kmAssetApplyInForm.fdNo!=null}'>
						    <xform:text property="fdNo" style="width:85%" />
						</c:when>
						<c:otherwise>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.autoCreate" />
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
			<%-- 入库明细--%>	
			<%@include file="/km/asset/km_asset_apply_in_list/kmAssetApplyInList_edit.jsp"%>
			<%-- 分隔符 --%>
			<tr>
			<td colspan="4">
				<c:if test="${fn:length(myCards) > 0}">
					<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
					</c:import>
				</c:if>
			</td>
			</tr>
			<tr>
				<%-- 附件 --%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyStock.attachment"/>
				</td>
				<td colspan="3">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="kmAssetApplyIn" />									
					</c:import>
				</td>
			</tr>
			<c:if test="${not empty kmAssetApplyInForm.fdExplain}">
			<tr>
				<%--说明 --%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
				</td>
				<td colspan="3">
				    <html:hidden property="fdExplain" />
				    <kmss:showText value="${kmAssetApplyInForm.fdExplain}"></kmss:showText> 
				</td>
			</tr>
			</c:if>
			<tr>
				<%--是否生成资产卡片--%>
				<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyIn.fdIsCreateCard"/>
				</td>
				<td colspan="3">
					<xform:radio property="fdIsCreateCard" >
						<xform:enumsDataSource enumsType="km_asset_apply_in_fd_is_create_card" />
					</xform:radio>
				</td>
			</tr>
			<tr>
				<%--资产卡片是否按到货数量拆分--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyIn.fdIsUnpickByNums"/>
				</td>
				<td colspan="3">				
					<xform:radio property="fdIsUnpickByNums" >
						<xform:enumsDataSource enumsType="km_asset_apply_in_fd_is_unpick_by_nums" />
					</xform:radio>
				</td>
			</tr>
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
					<c:param name="formName" value="kmAssetApplyInForm" />
					<c:param name="fdKey" value="KmAssetApplyInDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
				</c:import>
			</c:if>
			 <%--权限机制 --%>
			<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyInForm" />
				<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyIn" />
			</c:import>
		</c:when>
</c:choose>