<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="sysWfBusinessForm" value="${requestScope[param.formName]}" />
<c:set var="lbpmProcessForm" value="${sysWfBusinessForm.sysWfBusinessForm.internalForm}" />

<%@ include file="/sys/lbpmservice/include/sysLbpmProcess_script.jsp"%>
<input type="hidden" name="sysWfBusinessForm.fdParameterJson" value="" id="sysWfBusinessForm.fdParameterJson">
<input type="hidden" name="sysWfBusinessForm.fdAdditionsParameterJson" value="" id="sysWfBusinessForm.fdAdditionsParameterJson">
<input type="hidden" name="sysWfBusinessForm.fdIsModify" value='' id="sysWfBusinessForm.fdIsModify">
<html:hidden property="sysWfBusinessForm.fdCurHanderId"  styleId="sysWfBusinessForm.fdCurHanderId" />
<html:hidden property="sysWfBusinessForm.fdCurNodeSavedXML"  styleId="sysWfBusinessForm.fdCurNodeSavedXML" />
<html:hidden property="sysWfBusinessForm.fdFlowContent"  styleId="sysWfBusinessForm.fdFlowContent"  />
<html:hidden property="sysWfBusinessForm.fdProcessId"  styleId="sysWfBusinessForm.fdProcessId"  />
<html:hidden property="sysWfBusinessForm.fdKey"  styleId="sysWfBusinessForm.fdKey" />
<input type="hidden" name="sysWfBusinessForm.fdModelId" id="sysWfBusinessForm.fdModelId" value='<c:out value="${sysWfBusinessForm.fdId}" />' >
<input type="hidden" name="sysWfBusinessForm.fdModelName" id="sysWfBusinessForm.fdModelName" value='<c:out value="${sysWfBusinessForm.modelClass.name}" />' >
<html:hidden property="sysWfBusinessForm.fdCurNodeXML"  styleId="sysWfBusinessForm.fdCurNodeXML" />
<html:hidden property="sysWfBusinessForm.fdTemplateModelName"  styleId="sysWfBusinessForm.fdTemplateModelName"/>
<html:hidden property="sysWfBusinessForm.fdTemplateKey" styleId="sysWfBusinessForm.fdTemplateKey"/>
<input type="hidden" name="sysWfBusinessForm.canStartProcess" id="sysWfBusinessForm.canStartProcess" value='' >
<html:hidden property="sysWfBusinessForm.fdTranProcessXML" styleId="sysWfBusinessForm.fdTranProcessXML"/>
<html:hidden property="sysWfBusinessForm.fdDraftorId" styleId="sysWfBusinessForm.fdDraftorId"/>
<html:hidden property="sysWfBusinessForm.fdDraftorName" styleId="sysWfBusinessForm.fdDraftorName"/>
<html:hidden property="sysWfBusinessForm.fdHandlerRoleInfoIds"  styleId="sysWfBusinessForm.fdHandlerRoleInfoIds"/>
<html:hidden property="sysWfBusinessForm.fdHandlerRoleInfoNames"  styleId="sysWfBusinessForm.fdHandlerRoleInfoNames" />
<html:hidden property="sysWfBusinessForm.fdAuditNoteFdId"  styleId="sysWfBusinessForm.fdAuditNoteFdId" />
<html:hidden property="sysWfBusinessForm.fdIdentityId"  styleId="sysWfBusinessForm.fdIdentityId" />
<html:hidden property="sysWfBusinessForm.fdProcessStatus" styleId="sysWfBusinessForm.fdProcessStatus" />
<html:hidden property="sysWfBusinessForm.fdDefaultIdentity" styleId="sysWfBusinessForm.fdDefaultIdentity" />
<input type="hidden" id="sysWfBusinessForm.fdSubFormXML" name="sysWfBusinessForm.fdSubFormXML" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdSubFormXML}" />'>
<input type="hidden" id="sysWfBusinessFormPrefix" name="sysWfBusinessFormPrefix" value='<c:out value="${sysWfBusinessFormPrefix}" />' >
<input type="hidden" id="__docStatus"   value='<c:out value="${sysWfBusinessForm.docStatus}" />' >
<input type="hidden" id="__method"   value='<c:out value="${param.method}" />' >

<div id="freeflowRow">
	<div class="lui-lbpm-titleNode">
		<bean:message bundle="sys-lbpmservice" key="lbpm.freeFlow.flow" />
	</div>
	<div class="lui-lbpm-detailNode">
		<div id="editFreeFlowDIV" style="display:none;">
			<div id="freeflow_appendNodeDIV">
				<div class="lbpm_freeflow_appendNode lbpm_freeflow_reviewNode" onclick="lbpm.flow_chart_load_Frame();Dialog_Address(true, null, null, null, ORG_TYPE_POSTORPERSON, function myFunc(rtv){lbpm.globals.addNodeInFreeFlow(rtv,'reviewNode');});"><i></i><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.review" /></div>
				<div class="lbpm_freeflow_appendNode lbpm_freeflow_signNode" onclick="lbpm.flow_chart_load_Frame();Dialog_Address(true, null, null, null, ORG_TYPE_POSTORPERSON, function myFunc(rtv){lbpm.globals.addNodeInFreeFlow(rtv,'signNode');});"><i></i><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.sign" /></div>
				<div class="lbpm_freeflow_appendNode lbpm_freeflow_sendNode" onclick="lbpm.flow_chart_load_Frame();Dialog_Address(true, null, null, null, ORG_TYPE_ALL, function myFunc(rtv){lbpm.globals.addNodeInFreeFlow(rtv,'sendNode');});"><i></i><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.send" /></div>
			</div>
			<div class="lbpm_freeflow_modifyFlowContent">
				<a class="com_btn_link" href="javascript:lbpm.globals.modifyFreeFlow('sysWfBusinessForm.fdFlowContent', 'sysWfBusinessForm.fdTranProcessXML');">
					<bean:message bundle="sys-lbpmservice" key="lbpm.freeFlow.modifyFlowContent" />
				</a>&nbsp;
				<a class="com_btn_link lbpm_freeflow_defaultTemp_btn" href="javascript:void(0);">
					<bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.template" />
				</a>
				<ul class="lbpm_freeflow_defaultTemp_btnList">
					<li onclick="lbpm.globals.saveFreeFlowDefaultTemp();"><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.saveDefaultTemp" /></li>
					<li onclick="lbpm.globals.loadFreeFlowDefaultTemp();"><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.loadDefaultTemp" /></li>
				</ul>
			</div>
		</div>
		<div id="viewFreeFlowDIV" style="display:none">
			<a class="com_btn_link" href="javascript:lbpm.globals.viewFreeFlow('sysWfBusinessForm.fdFlowContent', 'sysWfBusinessForm.fdTranProcessXML');">
				<bean:message bundle="sys-lbpmservice" key="lbpm.freeFlow.viewFlowContent" />
			</a>
		</div>
		<div id="flowNodeDIV" style="display:none">
			<ul id="flowNodeUL" class="lbpm_freeflow_draglist">
			</ul>
			<ul class="lbpm_freeflow_add_moreList">
				<li data-node-type="reviewNode"><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.reviewNode" /></li>
				<li data-node-type="signNode"><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.signNode" /></li>
				<li data-node-type="sendNode"><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.sendNode" /></li>
			</ul>
		</div>
	</div>
</div>
<%-- ??????????????????--%>
<c:forEach items="${lbpmProcessForm.curHandlerOperationsReviewJs}" var="reviewJs" varStatus="vstatus">
	<c:import url="${reviewJs}" charEncoding="UTF-8" />
</c:forEach>
<c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20'}">
	<!-- ????????????????????????????????? -->
	<div id="manualBranchNodeRow" style="display:none">
		<div class="lui-lbpm-titleNode">
			<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.manualNodeSelect" />
		</div>
		<div class="lui-lbpm-detailNode" id="manualNodeSelectTD">
			
		</div>
	</div>
	<div id="operationMethodsRow">
		<div class="lui-lbpm-titleNode">
			<span class="txtstrong">*</span><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationMethods" />
		</div>
		<div class="lui-lbpm-detailNode" id="operationMethodsGroup">
			
		</div>
	</div>
	<div id="handlerIdentityRow" style="display:none">
		<div class="lui-lbpm-titleNode">
			<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.submitRole" />
		</div>
		<div class="lui-lbpm-detailNode">
			<!-- ??????onchange????????????WorkFlow_GetFlowContent(this); 2009-09-01 by fuyx -->
			<select name="rolesSelectObj" key="handlerId" style="max-width:90%">
			</select>
			<span class="specialIcon"></span>
			<!--[if lte IE 9]>   
		        <style>
					#handlerIdentityRow .lui-lbpm-detailNode select{
					    padding-right: 0;
					}
				
					#handlerIdentityRow .lui-lbpm-detailNode .specialIcon {
					    display: inline;
					    background: none;
					}
		        </style>
			<![endif]-->
		</div>
	</div>
	<div id="nextNodeRow">
		<div class="lui-lbpm-titleNode" id="nextNodeTDTitle">
			<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.nextNode" />
		</div>
		<div class="lui-lbpm-detailNode" id="nextNodeTD">
			&nbsp;
		</div>
	</div>
</c:if>
<c:if test="${sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus!='21' && sysWfBusinessForm.docStatus<'30'}">
	<div id="operationItemsRow">
		<div class="lui-lbpm-titleNode">
			<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationItems" />
		</div>
		<div class="lui-lbpm-detailNode">
			<select name="operationItemsSelect" onchange="lbpm.globals.operationItemsChanged(this);">
			</select>
		</div>
	</div>
	<div id="operationMethodsRow">
		<div class="lui-lbpm-titleNode">
			<span class="txtstrong">*</span><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationMethods" />
		</div>
		<div class="lui-lbpm-detailNode">
			<div id="operationMethodsGroup"></div>
		</div>
	</div>
	<div id="operationsRow" style="display:none;" lbpmMark="operation">
		<div class="lui-lbpm-titleNode"  id="operationsTDTitle">
			&nbsp;
		</div>
		<div class="lui-lbpm-detailNode" id="operationsTDContent">
			&nbsp;
		</div>
	</div>
	<div id="operationsRow_Scope" style="display:none;" lbpmMark="operation">
		<div class="lui-lbpm-titleNode"  id="operationsTDTitle_Scope">
			&nbsp;
		</div>
		<div class="lui-lbpm-detailNode" id="operationsTDContent_Scope">
			&nbsp;
		</div>
	</div>
</c:if>
<div class="lui-lbpm-fold-add">
<div id="descriptionRow">
	<div class="lui-lbpm-titleNode">
		<span id="mustSignStar" class="txtstrong" style="display:none">*</span><bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.opinion" />
	</div>
	<div class="lui-lbpm-detailNode">
		<table width=100% border=0 class="tb_noborder">
			<tr>
				<td id="fdUsageContentTd" width="85%">
					<span style="display: block;" class="lui-lbpm-opinion-outerBox">	
						<span id="fdUsageContentSpan" style="display: block;border: none;">
							<textarea name="fdUsageContent" class="process_review_content" placeholder="${ lfn:message('sys-lbpmservice:lbpmRight.opinion') }" style="height:100px;width:100%;resize:none;border-bottom: 0" key="auditNode" subject="${lfn:message('sys-lbpmservice:lbpmNode.createDraft.opinion')}" validate="fdUsageContentMaxLength(4000)"></textarea>
						</span>
						<div class="lui-lbpm-opinion-action">
	                    	<div class="lui-lbpm-opinion-action-box">
								<div class="commonUsedOpinion">
									<div class="lui-lbpm-advice">
		                          		<span><bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.commonUsages" /></span>
		                        		<i class="lui-lbpm-downIcon"></i>
		                        		<div class="commonUsedOpinionList">
				                            <ul></ul>
				                        	<div class="lui-lbpm-opinion-custormBtn" onclick="Com_EventPreventDefault();lbpm.globals.openDefiniateUsageWindow();">
				                        		<i class="lui-lbpm-opinion-custormBtn-add"></i>
				                        		<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.commonUsages.definite" />
				                        	</div>
				                        </div>
		                        	</div>
		                     	</div>
		                      <div class="lui-lbpm-opinion-otherFnc">
		                          <div title="<bean:message key="button.saveDraft" bundle="sys-lbpmservice" />" class="saveOpinion lui-lbpm-opinion-btn" id="saveDraftButton" onclick="lbpm.globals.saveDraftAction(this);">
		                            <i></i>
		                          </div>
		                          <div class="lui-lbpm-opinion-more lui-lbpm-opinion-btn" style="display:none">
		                            <i></i>
		                            <div class="lui-lbpm-opinion-moreList">
		                              <ul></ul>
		                            </div>
		                          </div>
		                      </div>
	                      </div>
	                  </div>
					</span>
				</td>
				<%-- <td width="15%">&nbsp;</td> --%>
			</tr>
			<tr id="privateOpinionTr">
				<td>
					<div style="margin-top: 10px"></div>
					<label class='lui-lbpm-checkbox'>
						<input type="checkbox" name="privateOpinion" onclick="lbpm.globals.setPrivateOpinion(this);"/>
						<span class='checkbox-label'><kmss:message key="sys-lbpmservice:lbpmservice.auditnote.privateOpinion" /></span>
					</label>
					<div id="privateOpinionCanViewTr" style="display: none;">
						<input type="hidden" name="privateOpinionCanViewIds" />
						<input type="text" name="privateOpinionCanViewNames" subject="${ lfn:message('sys-lbpmservice:lbpmservice.auditnote.canViewPerson') }" placeholder="${ lfn:message('sys-lbpmservice:lbpmservice.auditnote.placeholder') }" style="height:25px;border:0px;border-bottom:1px solid #b4b4b4;width:85%" onclick="Dialog_Address(true,'privateOpinionCanViewIds','privateOpinionCanViewNames', ';',ORG_TYPE_ALL);" readonly />
						<a href="javascript:;" class="com_btn_link" onclick="Dialog_Address(true,'privateOpinionCanViewIds','privateOpinionCanViewNames', ';',ORG_TYPE_ALL);"><bean:message key="dialog.selectOther" /></a>
						<span class="txtstrong">*</span>
					</div>
				</td>
			</tr>
			<!-- <tr>
				<td><label id="currentNodeDescription"></label></td>
			</tr> -->
		</table>
	</div>
</div>
<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_ext.jsp" charEncoding="UTF-8">
	<c:param name="auditNoteFdId" value="${sysWfBusinessForm.sysWfBusinessForm.fdAuditNoteFdId}" />
	<c:param name="modelName" value="${sysWfBusinessForm.modelClass.name}" />
	<c:param name="modelId" value="${sysWfBusinessForm.fdId}" />
	<c:param name="formName" value="${param.formName}" />
	<c:param name="curHanderId" value="${sysWfBusinessForm.sysWfBusinessForm.fdCurHanderId}"/>
	<c:param name="provideFor" value="pc" />
	<c:param name="approveModel" value="right" />
</c:import>
<div id="assignmentRow" style="display:none;">
	<%-- <div class="lui-lbpm-titleNode">
		<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.assignment" />
	</div> --%>
	<div class="lui-lbpm-detailNode">
		<!-- Attachments -->
		<table class="tb_noborder" width="100%">
			<tr>
				<td>
					<c:import
						url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param
							name="fdKey"
							value="${sysWfBusinessForm.sysWfBusinessForm.fdAuditNoteFdId}" />
						<c:param
							name="formBeanName"
							value="${param.formName}" />
						<c:param
							name="fdModelName"
							value="${sysWfBusinessForm.modelClass.name}"/>
						<c:param
							name="fdModelId"
							value="${sysWfBusinessForm.fdId}"/>
						<c:param name="fdViewType" value="/sys/lbpmservice/support/lbpm_right/js/render_right.js" />
					</c:import>
				</td>
			</tr>
		</table>
	</div>
</div>
<div class="lui-lbpm-fold">
<c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20'}">
	<!--?????????????????? -->
	<div id="notifyLevelRow">
		<div class="lui-lbpm-titleNode">
			<bean:message bundle="sys-notify" key="sysNotifyTodo.level.title" />
		</div>
		<div class="lui-lbpm-detailNode" id="notifyLevelTD">
			<c:if test="${sysWfBusinessForm.docStatus=='11'}">
			<nobr></nobr> 
			</c:if>
			<kmss:editNotifyLevel property="sysWfBusinessForm.fdNotifyLevel" value=""/>
		</div>
	</div>
</c:if>				
<%-- ????????????--%>
<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != null && sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != ''}">
	<input type="hidden" name="sysWfBusinessForm.fdSystemNotifyType" value="" id="sysWfBusinessForm.fdSystemNotifyType">
	<c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20'}">
		<div id="notifyOptionTR">
			<div class="lui-lbpm-titleNode">
				<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.notifyOption" />
			</div>
			<div class="lui-lbpm-detailNode">
				<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.notifyToDraft.message1" />
				<input type="text" class="inputSgl" style="width:25px;" id="dayOfNotifyDrafter" key="dayOfNotifyDrafter" validate="digits,min(0)" maxlength="3"><bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.day" />
				<input type="text" class="inputSgl" style="width:25px;" id="hourOfNotifyDrafter" key="hourOfNotifyDrafter" validate="digits,min(0)" maxlength="4"><bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.hour" />
				<input type="text" class="inputSgl" style="width:25px;" id="minuteOfNotifyDrafter" key="minuteOfNotifyDrafter" validate="digits,min(0)" maxlength="5"><bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.minute" />
				<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.notifyToDraft.message2" /><br>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<label class='lui-lbpm-checkbox'>
				<input type="checkbox" id="notifyDraftOnFinish" value="true" alertText="" key="notifyOnFinish">
				<span class='checkbox-label'><bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.notifyToDraft.message3" /></span>
				</label>
				&nbsp;&nbsp;
				<label class='lui-lbpm-checkbox'>
				<input type="checkbox" id="notifyForFollow" value="true" alertText="" key="notifyForFollow">
				<span class='checkbox-label'><bean:message key="lbpmFollow.button.follow" bundle="sys-lbpmservice-support" /></span>
				</label>
			</div>
		</div>
	</c:if>
	<c:if test="${sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30'}">
		<div id="notifyOptionTR">
			<div class="lui-lbpm-titleNode">
				<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.notifyOption" />
			</div>
			<div class="lui-lbpm-detailNode">
				<label class='lui-lbpm-checkbox'>
				<input type="checkbox" id="notifyOnFinish" value="true" alertText="" key="notifyOnFinish">
				<span class='checkbox-label'><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.notifyOption.message" /></span>
				</label>
				&nbsp;&nbsp;
				<label class='lui-lbpm-checkbox'>
				<input type="checkbox" id="notifyForFollow" value="true" alertText="" key="notifyForFollow">
				<span class='checkbox-label'><bean:message key="lbpmFollow.button.follow" bundle="sys-lbpmservice-support" /></span>
				</label>
			</div>
		</div>
	</c:if>
</c:if>
<div id="fdFlowDescriptionRow">
	<div class="lui-lbpm-titleNode">
		<bean:message bundle="sys-lbpmservice" key="lbpmProcess.history.description" />
	</div>
	<div class="lui-lbpm-detailNode">
		<div id="fdFlowDescription"></div>
		<div style="text-align: right;">
			<span class="lui-lbpm-more lookMore"><bean:message bundle="sys-lbpmservice" key="lbpmRight.lookmore" /></span>
          	<span class="lui-lbpm-moreFold"><bean:message bundle="sys-lbpmservice" key="lbpmRight.close" /></span>
		</div>
	</div>
</div>	
<c:if test="${sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30'}">
	<!-- ?????????????????? -->
	<div id="processStatusRow" style="display:none">
		<div class="lui-lbpm-titleNode">
			<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.processStatus" />
		</div>
		<div class="lui-lbpm-detailNode">
			<label id="processStatusLabel"></label>
		</div>
	</div>
	<div id="currentHandlersRow">
		<div class="lui-lbpm-titleNode">
			<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.currentProcessor" />
		</div>
		<div class="lui-lbpm-detailNode">
			<div id="currentHandlersLabel" style="word-break:break-all">
				<kmss:showWfPropertyValues idValue="${sysWfBusinessForm.fdId}" propertyName="handerNameDetail" />
			</div>
		</div>
	</div>			
	<div id="historyHandlersRow">
		<div class="lui-lbpm-titleNode">
			<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.finishProcessor" />
		</div>
		<div class="lui-lbpm-detailNode">
			<div id="historyHandlersLabel" style="word-break:break-all">
				<kmss:showWfPropertyValues idValue="${sysWfBusinessForm.fdId}" propertyName="historyHanderName" />
			</div>
		</div>
	</div>
</c:if>

<!--  ???????????????????????????????????????????????????????????? ??????  -->
<table>
<tr class="tr_normal_title" style="display:none">
	<td align="left" colspan="4">
		<label class='lui-lbpm-checkbox'><input type="checkbox" id="flowGraphicShowCheckbox" value="true" onclick="this.checked ? $('#flowGraphic').show() : $('#flowGraphic').hide();">
		<span class='checkbox-label'><bean:message bundle="sys-lbpmservice" key="lbpm.tab.graphic" /></span></label>
	</td>
</tr>

<tr id="flowGraphicTemp">
	<td  ${resize_prefix}onresize="lbpm.flow_chart_load_Frame();" colspan="4">
		
		<script>
			$("#${sysWfBusinessFormPrefix}WF_IFrame").ready(function() {
				lbpm.globals.updateFreeFlowNodeUL(true);
				lbpm.globals.initFreeFlowFormList();
				var lbpm_panel_reload = function() {
					$("#${sysWfBusinessFormPrefix}WF_IFrame").attr('src', function (i, val) {
						return val;
					});
					lbpm.freeFlow.emptyHandlerNodes = [];
					lbpm.globals.updateFreeFlowNodeUL();
					$("#${sysWfBusinessFormPrefix}WF_IFrame")[0].onload = function() {    
						lbpm.globals.initFreeFlowFormList();
	            	};
				};
				lbpm.events.addListener(lbpm.constant.EVENT_MODIFYNODEATTRIBUTE, lbpm_panel_reload);
				lbpm.events.addListener(lbpm.constant.EVENT_MODIFYPROCESS, lbpm_panel_reload);
				lbpm.events.addListener(lbpm.constant.EVENT_SELECTEDMANUAL, lbpm_panel_reload);
				lbpm.events.addListener(lbpm.constant.EVENT_CHANGEROLE, lbpm_panel_reload);
			});
			$('#flowGraphicShowCheckbox').bind('click', function() {
				$('#workflowInfoTD').each(function() {
					var str = this.getAttribute('onresize');
					if (str) {
						(new Function(str))();
					}
				});
			});
		</script>
		
	</td>
</tr>
</table>

 
</div>
</div>
<!-- ?????????????????? -->
<div class="lui-lbpm-foldOrUnfold">
    <div class="lui-lbpm-foldOrUnfold-box">
      <div>
        <span><bean:message bundle="sys-lbpmservice" key="lbpmRight.fold" /></span>
        <i></i>
      </div>
    </div>
</div>
<script>
if(lbpm){
	lbpm.approveType = "right";
}
</script>