<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'baseInfo'}">
		<p class="txttitle">
			<c:if test="${not empty txttitle}">${txttitle}</c:if>
			<c:if test="${empty  txttitle}">
				<bean:message bundle="km-asset" key="table.kmAssetApplyRepair"/>
			</c:if>
		</p>
		<div class="lui_form_content_frame" style="padding-top:20px">
			<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
						<td width="85%" colspan="5">
							<c:if test="${kmAssetApplyRepairForm.titleRegulation==null || kmAssetApplyRepairForm.titleRegulation=='' }">
								<xform:text property="docSubject" style="width:97%" />
							</c:if>
							<c:if test="${kmAssetApplyRepairForm.titleRegulation!=null && kmAssetApplyRepairForm.titleRegulation!='' }">
								<xform:text property="docSubject" style="width:97%" showStatus="readOnly" value="${lfn:message('km-asset:kmAssetApplyBase.docSubject.info') }" />
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
						<td width="19%"><html:hidden property="fdApplyTemplateId" />
						<html:hidden property="fdApplyTemplateName" />
						${kmAssetApplyRepairForm.fdApplyTemplateName}</td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
						<td width="51%" colspan="3">
						<c:choose>
							<c:when test='${kmAssetApplyRepairForm.fdNo!=null}'>
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
							<xform:text property="fdCreatorName" value="${kmAssetApplyRepairForm.fdCreatorName}" showStatus="view"></xform:text>
						</td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
						<td width="19%">
						    <html:hidden property="fdDeptId" />
							<xform:text property="fdDeptName" value="${kmAssetApplyRepairForm.fdDeptName}" showStatus="view"></xform:text>
						</td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
						<td width="19%">
						    <html:hidden property="fdCreateDate" />
						    <xform:datetime property="fdCreateDate" dateTimeType="date" showStatus="view"/>
						</td>
					</tr>
					
					<!-- 资产基本信息 -->
					<tr>
						<td width="100%" colspan="6" class="td_normal_title" align="center">
					 	<bean:message bundle="km-asset" key="kmAssetApplyRepairList.cardBaseInfo" />
						</td>
					</tr>
					
					<!-- 维修保养明细 -->
					<tr>
						<td width="100%" colspan="6"><c:import
							url="/km/asset/km_asset_apply_repair_list/kmAssetApplyRepairList_edit.jsp"
							charEncoding="UTF-8">
						</c:import>
						<c:if test="${fn:length(myCards) > 0}">
							<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
							</c:import>
						</c:if>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-asset" key="kmAssetApplyRepair.fdIsUsedExpend" /></td>
						<td width="35%" colspan="5"><xform:radio
							property="fdIsUsedExpend" onValueChange="event_fdIsUsedExpend(this.value);">
							<xform:enumsDataSource enumsType="km_asset_repair_is_used_expend"/>
						</xform:radio>
						</td>
					</tr>
					
					<!-- 耗材基本信息 -->
					<tr id="RepairExpendInfoBase">
						<td width="100%" class="td_normal_title" colspan="6" align="center">
					 	<bean:message bundle="km-asset" key="kmAssetApplyRepairList.expendInfo" />
						</td>
					</tr>
					
					<!-- 耗材明细 -->	  
					<tr id="RepairExpendInfo">
						<td width="100%" colspan="6"><c:import
							url="/km/asset/km_asset_apply_repair_expend/kmAssetApplyRepairExpend_edit.jsp"
							charEncoding="UTF-8"> 
						</c:import></td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-asset" key="kmAssetApplyRepair.fdTotalMoney" /></td>
						<td width="85%" colspan="5"><xform:text
							property="fdTotalMoney" style="width:25%" htmlElementProperties="readonly='readonly'" className="inputread"/>
							&nbsp;&nbsp;&nbsp;&nbsp;
								<%--中文大写--%>
								<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
								<span id="chinaValue"></span>
							</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyRepair.fdStartEndDate" />
						</td>
						<td colspan="5">
							<table style="border: 0" width="70%">
							<tr>
								<td width="25%" style="border: 0" >
									<xform:datetime property="fdStartDate" dateTimeType="date" style="width:85%" validators="compareTime" onValueChange="checkForm"/> 
								</td>
								<td width="5%" style="border: 0" >
									<bean:message bundle="km-asset" key="kmAssetApplyRent.to"/>
								</td>
								<td width="25%" style="border: 0" >
									<xform:datetime property="fdEndDate" dateTimeType="date" style="width:85%" validators="compareTime" onValueChange="checkForm"/>
								</td>
								<td width="40%" style="border: 0" >
									<bean:message bundle="km-asset" key="kmAssetApplyRent.total"/>&nbsp;
									<xform:text property="dateNum" style="width:50px" htmlElementProperties="readonly='true' "  className="inputread"/>
									<bean:message bundle="km-asset" key="kmAssetApplyRent.day"/>
								</td>
							</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-asset" key="kmAssetApplyRepair.fdReason" /></td>
						<td width="85%" colspan="5"><xform:textarea property="fdReason" style="width:97%"/></td>
					</tr>
					<tr>
						<!--附件机制-->
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
						<td colspan="5"><c:import
							url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
							charEncoding="UTF-8">
							<c:param name="fdKey" value="attachment" />
							<c:param name="fdModelId" value="${param.fdId }" />
							<c:param name="fdModelName"
								value="com.landray.kmss.km.asset.model.KmAssetApplyRepair" />
						</c:import></td>
					</tr>
					<c:if test="${not empty kmAssetApplyRepairForm.fdExplain}">
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
						<td width="85%" colspan="5">
						 <html:hidden property="fdExplain" />
				         <kmss:showText value="${kmAssetApplyRepairForm.fdExplain}"></kmss:showText> 
						</td>
					</tr>
					</c:if>
					<input type="hidden" name="fdTemplateId" value=""/>
					<input type="hidden" name="fdTemplateName" value=""/>
				</table>
		</div>
		
		<script>
			var validation = $KMSSValidation();
		
			seajs.use(['km/asset/resource/dateUtil'],function(dateUtil){
			//自定义校验器:校验召开时间不能晚于结束时间
			validation.addValidator('compareTime','结束时间不能早于开始时间',function(v, e, o){
				 var result=true;
				 var fdStartDate=$('[name="fdStartDate"]');
				 var fdEndDate=$('[name="fdEndDate"]');
				 if( fdStartDate.val() && fdEndDate.val() ){
					var start=dateUtil.parseDate(fdStartDate.val());
					var end=dateUtil.parseDate(fdEndDate.val());
					if( start.getTime()>end.getTime() ){
						result=false;
					}
				 }
				return result;
			 });
		});
		</script>
	</c:when>
	<c:when test="${param.contentType eq 'other'}">
		<c:if test="${param.approveModel ne 'right'}">
			<%--流程--%>
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyRepairForm" />
				<c:param name="fdKey" value="KmAssetApplyRepairDoc" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
			</c:import>
		</c:if>
		 <%--权限机制 --%>
		<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyRepairForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRepair" />
		</c:import>
	</c:when>
</c:choose>