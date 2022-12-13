<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'baseInfo'}">
		<p class="txttitle">
				<c:if test="${not empty txttitle}">${txttitle}</c:if>
				<c:if test="${empty  txttitle}">
					<bean:message bundle="km-asset" key="table.kmAssetApplyRent"/>
				</c:if>
			</p>
		<div class="lui_form_content_frame" style="padding-top:20px">
		<table class="tb_normal" width=100%>
				<tr>
					<!--标题-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject" />
					</td>
					<td colspan="5">
						<c:if test="${kmAssetApplyRentForm.titleRegulation==null || kmAssetApplyRentForm.titleRegulation=='' }">
							<xform:text property="docSubject" style="width:97%" />
						</c:if>
						<c:if test="${kmAssetApplyRentForm.titleRegulation!=null && kmAssetApplyRentForm.titleRegulation!='' }">
							<xform:text property="docSubject" style="width:97%" showStatus="readOnly" value="${lfn:message('km-asset:kmAssetApplyBase.docSubject.info') }" />
						</c:if>
					</td>
				</tr>
				<tr>
					<!--所属模板 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/></td>
					<td width="19%">
					     <html:hidden property="fdApplyTemplateId" />
						 <xform:text property="fdApplyTemplateName" style="width:85%" showStatus="view"/>
					</td>
							<!--申请单编号 -->
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
						    	<td colspan="3">  <c:choose>
								<c:when test='${kmAssetApplyRentForm.fdNo!=null}'>
								    <xform:text property="fdNo" style="width:85%" showStatus="view"/>
								</c:when>
								<c:otherwise>
								<bean:message
								bundle="km-asset" key="kmAssetApplyBase.autoCreate" />
							    </c:otherwise>
							</c:choose> 
							</td>
				</tr>	
				<tr>
					<!--申请人-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator" />
					</td>
					<td width="19%">
						<xform:address propertyId="fdCreatorId" propertyName="fdCreatorName" orgType="ORG_TYPE_PERSON" style="width:85%"  showStatus="view"/>
					</td>			
					<!--申请部门-->
					<td class="td_normal_title" width=15%>
				 		<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept" />
					</td>
					<td width="19%">
					<html:hidden property="fdDeptId" />
						<xform:address propertyId="fdDeptId" propertyName="fdDeptName" orgType="ORG_TYPE_DEPT" style="width:85%" showStatus="view"/>
					</td>
					<!--申请日期-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" />
					</td>
					<td width="19%">
						<xform:datetime property="fdCreateDate"  style="width:85%" showStatus="view"/>
					</td>
				</tr>
		         <tr>
					<td width="100%" colspan="6">
						<c:import url="/km/asset/km_asset_apply_rent_list/kmAssetApplyRentList_edit.jsp" charEncoding="UTF-8">
						</c:import>
						<c:if test="${fn:length(myCards) > 0}">
							<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
							</c:import>
						</c:if>
					</td>
				</tr>  
				<tr>
					<!--借用期限-->
					<td class="td_normal_title" width=15%><bean:message bundle="km-asset" key="kmAssetApplyRent.deadline"/></td>
					<td colspan="5">
						<table style="border: 0" width="70%">
						<tr>
							<td width="7%" style="border: 0" >
								<bean:message bundle="km-asset" key="kmAssetApplyRent.from"/>
							</td>
							<td width="25%" style="border: 0" >
								<xform:datetime property="fdStartDate" dateTimeType="date"  onValueChange="startSetDay()"/>
							</td>
							<td width="5%" style="border: 0" >
								<bean:message bundle="km-asset" key="kmAssetApplyRent.to"/>
							</td>
							<td width="25%" style="border: 0" >
								<xform:datetime property="fdEndDate" dateTimeType="date"  onValueChange="endSetDay()"/>
							</td>
							<td width="40%" style="border: 0" >
								<bean:message bundle="km-asset" key="kmAssetApplyRent.total"/>&nbsp;
								<xform:text property="fdDays" htmlElementProperties="readonly='true' "/>
								<bean:message bundle="km-asset" key="kmAssetApplyRent.day"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				
			<tr>
		   	 <!-- 借入单位 -->
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyRent.fdForeignBranch"/>
				</td><td width="19%">
					<xform:text property="fdForeignBranch" style="width:95%" />
				</td>
			  <!-- 借入部门 -->
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyRent.fdForeignDept"/>
				</td><td colspan="3">
					<xform:text property="fdForeignDept" style="width:95%" />
				</td>
			</tr>		
			<tr>
				<!--借出单位 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyRent.fdRentBranch" /></td>
				<td width="19%">
					<xform:address propertyId="fdRentBranchId" propertyName="fdRentBranchName" orgType="ORG_TYPE_ORGORDEPT" style="width:95%" />
				</td>
				<!--借出部门-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyRent.fdRentDept" /></td>
				<td colspan="3">
					<xform:address propertyId="fdRentDeptId" propertyName="fdRentDeptName" orgType="ORG_TYPE_ORGORDEPT" style="width:95%" />
				</td>
			</tr>
		
		       <tr>	
			  <!--借出事由-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyRent.reason" /></td>
				<td colspan="5"><xform:textarea property="fdReason" style="width:97%" /></td>
			</tr>
			
			<tr>
				<!--附件机制-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
				<td colspan="5">
		       <c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="attachment"/>
				<c:param name="fdModelId" value="${param.fdId }" />
				<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRent" />
		       </c:import>
				</td>
			</tr>
				
			<c:if test="${not empty kmAssetApplyRentForm.fdExplain}">
			<tr>	
			  <!--说明-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
				<td colspan="5">
				    <html:hidden property="fdExplain" />
				    <kmss:showText value="${kmAssetApplyRentForm.fdExplain}"></kmss:showText> 
				</td>
			</tr>
			</c:if>
			<input type="hidden" name="fdTemplateId" value=""/>
			<input type="hidden" name="fdTemplateName" value=""/>
		</table>
		
		</div>
		<script>
			Com_IncludeFile("calendar.js");
			$KMSSValidation();
		</script>
		</c:when>
		<c:when test="${param.contentType eq 'other'}">
			<c:if test="${param.approveModel ne 'right'}">
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRentForm" />
					<c:param name="fdKey" value="KmAssetApplyRentDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
				</c:import>
			</c:if>
			 <%--权限机制 --%>
			<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyRentForm" />
				<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRent" />
			</c:import>
		</c:when>
</c:choose>