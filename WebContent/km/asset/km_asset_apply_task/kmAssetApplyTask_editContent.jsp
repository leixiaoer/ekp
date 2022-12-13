<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'baseInfo'}">
		<p class="txttitle">${txttitle}</p>
			<div class="lui_form_content_frame" style="padding-top:20px">
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyTask.docSubject"/>
						</td>
						<td width="35%" colspan="3">
							<c:if test="${kmAssetApplyTaskForm.titleRegulation==null || kmAssetApplyTaskForm.titleRegulation=='' }">
								<xform:text property="docSubject" style="width:97%" required="true"/>
							</c:if>
							<c:if test="${kmAssetApplyTaskForm.titleRegulation!=null && kmAssetApplyTaskForm.titleRegulation!='' }">
								<xform:text property="docSubject" style="width:97%" showStatus="readOnly" value="${lfn:message('km-asset:kmAssetApplyBase.docSubject.info') }" />
							</c:if>
						</td>
					</tr>
					<tr>
						<!--所属模板 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" />
						</td>
						<td width="35%">
							<html:hidden property="fdApplyTemplateId" />
							<xform:text property="fdApplyTemplateName" style="width:85%" showStatus="view" />
						</td>
						<!--申请单编号 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo" />
						</td>
						<td width="35%">
							<c:choose>
								<c:when test='${kmAssetApplyTaskForm.fdNo!=null}'>
									<xform:text property="fdNo" style="width:85%" showStatus="view" />
								</c:when>
								<c:otherwise>
									<bean:message bundle="km-asset" key="kmAssetApplyBase.autoCreate" />
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<!--申请人-->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator" />
						</td>
						<td width="35%">
							<xform:address propertyId="fdCreatorId" propertyName="fdCreatorName" orgType="ORG_TYPE_PERSON" style="width:85%" showStatus="view" />
						</td>
						<!--申请日期-->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" />
						</td>
						<td width="35%">
							<xform:datetime property="fdCreateDate" showStatus="view" style="width:85%" />
						</td>
					</tr>
					<tr>
						<!-- 分配用户 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyTask.fdAssignUser"/>
						</td>
						<td width="35%">
							<xform:select property="fdAssignUser">
								<xform:enumsDataSource enumsType="km_asset_apply_task_fd_assign_user" />
							</xform:select>
						</td>
						<td class="td_normal_title" width=15%>
							<div class="assignUserCtl">
								<bean:message bundle="km-asset" key="kmAssetApplyTask.kmAssignPersonnel"/>
							</div>
						</td>
						<td width="35%">
							<div class="assignUserCtl">
								<xform:address propertyId="kmAssignPersonnelIds" propertyName="kmAssignPersonnelNames" mulSelect="true" orgType="ORG_TYPE_ALL"  style="width:53%"/>
								<span class="txtstrong">*</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyTask.fdAssetCategory"/>
						</td>
						<td width="35%">
							<%-- <xform:select property="fdAssetCategoryId">
								<xform:beanDataSource serviceBean="kmAssetCategoryService" selectBlock="fdId,fdName" orderBy="fdOrder" />
							</xform:select> --%>
							<xform:dialog propertyId="fdAssetCategoryId" propertyName="fdAssetCategoryName" showStatus="edit" className="inputsgl" style="width:90%;float:left">
								Dialog_SimpleCategory('com.landray.kmss.km.asset.model.KmAssetCategory','fdAssetCategoryId','fdAssetCategoryName',false,';','00');
							</xform:dialog>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
						</td>
						<td>
							<xform:select property="fdAssetAddressId">
								<xform:beanDataSource serviceBean="kmAssetAddressService" selectBlock="fdId,fdAddress" whereBlock="kmAssetAddress.fdIsvalidate=true" orderBy="fdOrder" />
							</xform:select>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyTask.fdPurchaseTime"/>
						</td>
						<td width="35%">
							<xform:select property="fdPurchaseTime">
								<xform:enumsDataSource enumsType="km_asset_apply_task_fd_purchase_time" />
							</xform:select>
						<td class="td_normal_title" width=15%>
							<div class="purchaseTimeCtl">
								<bean:message bundle="km-asset" key="kmAssetApplyTask.fdPurchaseTime.section"/>
							</div>
						</td>
						<td width="35%">
							<div id="startDate" class="purchaseTimeCtl">
								<xform:datetime property="fdStartDate" dateTimeType="date" />
								<span style="position: relative;top:-5px;">—</span>
								<xform:datetime property="fdEndDate" dateTimeType="date" />
								<span class="txtstrong">*</span>
							</div>
						</td>
					</tr>
					
					<!-- 任务查看范围 -->
					<tr>
						<td width="100%" colspan="4">
							<%@ include file="/km/asset/km_asset_apply_task/kmAssetApplyTask_detail.jsp"%>	
						</td>
					</tr>
					<tr>
						<td class="td_normal_title">${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }</td>
						<td colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="formBeanName" value="kmAssetApplyTaskForm" />
								<c:param name="fdKey" value="attachment" />
							</c:import>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyTask.fdDescription"/>
						</td>
						<td width="35%" colspan="3">
							<xform:textarea property="fdDescription" style="width:95%" />
						</td>
					</tr>
					<input type="hidden" name="fdTemplateId" value=""/>
					<input type="hidden" name="fdTemplateName" value=""/>
<!-- 					<tr> -->
<!-- 						<td class="td_normal_title" width=15%> -->
<%-- 							<bean:message bundle="km-asset" key="kmAssetApplyTask.docCreator"/> --%>
<!-- 						</td> -->
<!-- 						<td width="35%"> -->
<%-- 							<xform:address propertyId="docCreatorId" propertyName="docCreatorName" orgType="ORG_TYPE_PERSON" showStatus="view" /> --%>
<!-- 						</td> -->
<!-- 						<td class="td_normal_title" width=15%> -->
<%-- 							<bean:message bundle="km-asset" key="kmAssetApplyTask.docCreateTime"/> --%>
<!-- 						</td> -->
<!-- 						<td width="35%"> -->
<%-- 							<xform:datetime property="docCreateTime" /> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
				</table>
			</div>
		</c:when>
		<c:when test="${param.contentType eq 'other'}">
			<c:if test="${param.approveModel ne 'right'}">
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyTaskForm" />
					<c:param name="fdKey" value="KmAssetApplyTaskDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
				</c:import>
			</c:if>
			 <%--权限机制 --%>
			<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyTaskForm" />
				<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyTask" />
			</c:import>
		</c:when>
</c:choose>