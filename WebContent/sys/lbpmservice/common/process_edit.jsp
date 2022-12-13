<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="sysWfBusinessForm" value="${requestScope[param.formName]}" />
<c:set var="lbpmProcessForm" value="${sysWfBusinessForm.sysWfBusinessForm.internalForm}" />
<link type="text/css" rel="stylesheet" href="<c:url value="/sys/lbpmservice/common/css/process_tab_main.css?s_cache=${LUI_Cache}"/>"/> 
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
<input type="hidden" id="__docStatus"   value='<c:out value="${sysWfBusinessForm.docStatus}" />' >
<input type="hidden" id="__method"   value='<c:out value="${param.method}" />' >
		<script>
		$(document).ready(function(){
			$("li[name='process_head_tab']").click(function(){
				$("li[name='process_head_tab']").attr("class","");
				$(this).attr("class","active");
				
				//兼容有些模块下无法触发onresize事件的问题
				var isClick=$(this).attr("data-isClick");
				var dataLoad=$(this).attr("data-load");
				if(!isClick){
					$(this).attr("data-isClick","true");
					if(dataLoad){
						lbpm[dataLoad]();
					}
				}
				
				$("div[name='process_body']").attr("class","process_body_checked_false");
				var lis=$(this).parent().children();
				for(var i=0;i<lis.length;i++){
					var classValue=$(lis[i]).attr("class");
					if(classValue==="active"){
						var process_bodys=$("div[name='process_body']");
						$(process_bodys[i]).attr("class","process_body_checked_true");
					}
				}
			});
		});
		</script>
		<!--begin 选项卡头部 -->
	    <div class="lui_flowstate_tab_heading">
	         <ul class="lui_flowstate_tabhead">
	          <li name="process_head_tab" class="active"><a href="javascript:void(0);">${ lfn:message('sys-lbpmservice-support:lbpm.process.status.processHandle') }</a></li>
	          <li name="process_head_tab" data-load="process_status_load_Frame"><a href="javascript:void(0);">${ lfn:message('sys-lbpmservice-support:lbpm.process.status.processStatus') }</a></li>
	          <li name="process_head_tab" data-load="flow_chart_load_Frame"><a href="javascript:void(0);">${ lfn:message('sys-lbpmservice-support:lbpm.process.status.processChart') }</a></li>
	          <li name="process_head_tab" data-load="flow_table_load_Frame"><a href="javascript:void(0);">${ lfn:message('sys-lbpmservice-support:lbpm.process.status.processTable') }</a></li>
	          <li name="process_head_tab" data-load="flow_log_load_Frame"><a href="javascript:void(0);">${ lfn:message('sys-lbpmservice-support:lbpm.process.status.processLog') }</a></li>
	          <li name="process_head_tab" data-load="process_restart_Log_Frame" id="liProcess_restart_Log_Frame"><a href="javascript:void(0);">${ lfn:message('sys-lbpmservice-support:lbpm.process.status.processRestartLog') }</a></li>
	        </ul>
	    </div>
	    <!--end 选项卡头部 -->
	    
	    <!--begin 流程处理  -->
	    <div name="process_body" class="process_body_checked_true">
	    			<table class="tb_normal process_review_panel" width="100%">
	    	<%-- #152384-参数获取文件路径直接import输出导致安全问题-开始
			<c:if test="${not empty param.historyPrePage}">
				<c:import url="${param.historyPrePage}" charEncoding="UTF-8"/>
			</c:if>
			#152384-参数获取文件路径直接import输出导致安全问题-结束 --%>
			<%--
			<c:if test="${sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30'}">
				<tr class="tr_normal_title" id="extendRoleOptRow">
					<td align="right" colspan="4">
						<c:if test="${sysWfBusinessForm.docStatus!='21'}">
						<span id="historyhandlerOpt" style="display:none;"></span>
						<a href="javascript:void(0);" id="drafterOptButton" class="com_btn_link" style="display:none; margin: 0 10px 0 0;"
							onclick="lbpm.globals.openExtendRoleOptWindow('drafter');">
							<bean:message key="lbpmNode.processingNode.identifyRole.button.drafter" bundle="sys-lbpmservice" />
						</a>
						</c:if>
						<a href="javascript:void(0);" id="authorityOptButton" class="com_btn_link" style="display:none; margin: 0 10px 0 0;"
							onclick="lbpm.globals.openExtendRoleOptWindow('authority');">
							<bean:message key="lbpmNode.processingNode.identifyRole.button.authority" bundle="sys-lbpmservice" />
						</a>
					</td>
				</tr>
			</c:if>
			--%>
			<tr class="tr_normal_title" id="followOptRow">
					<td align="right" colspan="4">
						<!-- 流程跟踪 -->
						<a href="javascript:void(0);" id="followOptButton" class="com_btn_link" style="display:none; margin: 0 10px 0 0;">
							<bean:message key="lbpmFollow.button.follow" bundle="sys-lbpmservice-support" />
						</a>
						<!-- 取消跟踪 -->
						<a href="javascript:void(0);" id="cancelFollowOptButton" class="com_btn_link" style="display:none; margin: 0 10px 0 0;">
							<bean:message key="lbpmFollow.button.cancelFollow" bundle="sys-lbpmservice-support" />
						</a>
					</td>
				</tr>
			<tr>
				<td class="td_normal_title" width="15%">
					<bean:message bundle="sys-lbpmservice" key="lbpmProcess.history.description" />
				</td>
				<td colspan=3>
					<span id="fdFlowDescription"></span>	 
				</td>
			</tr>
			<c:if test="${not empty sysWfBusinessForm.docStatus && param.method!='add'}">
			<tr class="tr_normal_title">
				<td align="left" colspan="4">
					<label><input type="checkbox" value="true" checked="checked" onclick="lbpm.globals.showHistoryDisplay(this);">
					<bean:message bundle="sys-lbpmservice" key="lbpmProcess.history.description.show" /></label>
				</td>
			</tr>
			<tr id="historyTableTR" style="padding: 0;display: none;">
				<td colspan=4 id="historyInfoTableTD" ${resize_prefix}onresize="lbpm.load_Frame();" style="padding: 0;">
					<iframe id="historyInfoTableIframe" width="100%" style="margin-bottom: -3px;border: none;" scrolling="no" FRAMEBORDER=0></iframe>
				</td>
			</tr>
			</c:if>
			<%-- 动态加载操作--%>
			<c:forEach items="${lbpmProcessForm.curHandlerOperationsReviewJs}" var="reviewJs" varStatus="vstatus">
				<c:import url="${reviewJs}" charEncoding="UTF-8" />
			</c:forEach>
			<c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20'}">
				<%-- 起草人选择人工分支节点 --%>
				<tr id="manualBranchNodeRow" style="display:none">
					<td class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.manualNodeSelect" />
					</td>
					<td colspan="3" id="manualNodeSelectTD">

					</td>
				</tr>
				<tr id="operationMethodsRow">
					<td class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationMethods" />
					</td>
					<td colspan="3">
					<div id="operationMethodsGroup"></div>
					</td>
				</tr>
				
				<c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20'}">
					<tr id="handlerIdentityRow" style="display:none">
						<td class="td_normal_title"  width="15%">
							<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.submitRole" />
						</td>
						<td colspan="3">
							<%-- 删除onchange事件中的WorkFlow_GetFlowContent(this); 2009-09-01 by fuyx --%>
							<select name="rolesSelectObj" key="handlerId">
							</select>
						</td>
					</tr>
				</c:if>									
				<tr id="nextNodeRow">
					<td id="nextNodeTDTitle" class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.nextNode" />
					</td>
					<td colspan="3" id="nextNodeTD">
						&nbsp;
					</td>
				</tr>
				<tr id="freeSubFlowNodeRow" style="display:none">
					<td class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpm.group.freeSubFlow" />
					</td>
					<td colspan=3>
					<div id="freeSubFlowNodeDIV">
						<ul id="freeSubFlowNodeUL">
						</ul>
					</div>
					</td>
				</tr>
			</c:if>
			<c:if test="${sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus!='21' && sysWfBusinessForm.docStatus<'30'}">
				<tr id="operationItemsRow">
					<td class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationItems" />
					</td>
					<td colspan="3">
						<select name="operationItemsSelect" onchange="lbpm.globals.operationItemsChanged(this);">
						</select>
					</td>
				</tr>
				<tr id="operationMethodsRow">
					<td class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationMethods" />
					</td>
					<td colspan="3">
					<div id="operationMethodsGroup"></div>
					</td>
				</tr>
				<tr id="operationsRow" style="display:none;" lbpmMark="operation">
					<td id="operationsTDTitle" class="td_normal_title" width="15%">
						&nbsp;
					</td>
					<td id="operationsTDContent" colspan="3">
						&nbsp;
					</td>
				</tr>
				<tr id="operationsRow_Scope" style="display:none;" lbpmMark="operation">
					<td id="operationsTDTitle_Scope" class="td_normal_title" width="15%">
						&nbsp;
					</td>
					<td id="operationsTDContent_Scope" colspan="3">
						&nbsp;
					</td>
				</tr>
			</c:if>
			<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != null && sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != ''}">
				<c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'30'}">
					<tr id="checkChangeFlowTR">
						<td class="td_normal_title" width="15%">
							<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.changeProcessor" />
						</td>
						<td colspan="3">
							<label id="changeProcessorDIV" style="display:none;">
								<a href="javascript:;" class="com_btn_link" onclick="Com_EventPreventDefault();lbpm.globals.changeProcessorClick();">
									<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.changeProcessor.button" />
								</a>&nbsp;&nbsp;
							</label>
							
							<label id="modifyFlowDIV" style="display:none;">
								<a class="com_btn_link" href="javascript:lbpm.globals.modifyProcess('sysWfBusinessForm.fdFlowContent', 'sysWfBusinessForm.fdTranProcessXML');">
									<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.modifyFlow" />
								</a>
							</label>
							
							<label id="modifyEmbeddedSubFlowDIV" style="display:none;">
								
							</label>
						</td>
					</tr>
				</c:if>
			</c:if>
			<!--通知紧急程度 -->
			<tr id="notifyLevelRow">
				<td class="td_normal_title"  width="15%">
					<bean:message bundle="sys-notify" key="sysNotifyTodo.level.title" />
				</td>
				<td colspan="3" id="notifyLevelTD">
					<c:if test="${sysWfBusinessForm.docStatus=='11'}">
					<nobr></nobr> 
					</c:if>
					<kmss:editNotifyLevel property="sysWfBusinessForm.fdNotifyLevel" value=""/> 
				</td>
			</tr>
			<tr id="descriptionRow">
				<td class="td_normal_title" width="15%">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.opinion" />
				</td>
				<td colspan="3">
					<table width=100% border=0 class="tb_noborder">
						<tr>
							<td id="optionButtons">
								<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.commonUsages" />:&nbsp;&nbsp;
								<select name="commonUsages" onchange="lbpm.globals.setUsages(this);" style="width: 120px; overflow-x: hidden">
								<option value=""><bean:message key="page.firstOption" /></option>
								</select>
								<a href="javascript:;" class="com_btn_link" style="margin: 0 10px;" onclick="Com_EventPreventDefault();lbpm.globals.openDefiniateUsageWindow();">
								<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.commonUsages.definite" />
								</a>
								<c:if test="${sysWfBusinessForm.docStatus>='20'}">
								<a href="javascript:;" class="com_btn_link" id="saveDraftButton" onclick="lbpm.globals.saveDraftAction(this);">
								<bean:message key="button.saveDraft" bundle="sys-lbpmservice" />
								</a>
								</c:if>
							</td>
						</tr>
						<tr>
							<td id="fdUsageContentTd" width="85%">
								<span id="fdUsageContentSpan" style="display: block;">	
									<textarea name="fdUsageContent" class="inputMul" style="width:97%;padding: 0;" key="auditNode" subject="${lfn:message('sys-lbpmservice:lbpmNode.createDraft.opinion')}" validate="fdUsageContentMaxLength(4000)"></textarea>
									<span id="mustSignStar" class="txtstrong" style="margin-top:65px;position:absolute;display:none">*</span>
								</span>
							</td>
							<%-- <td width="15%">&nbsp;</td> --%>
						</tr>
						<tr>
							<td>
							<div id="nodeDescriptionDiv">
								<div class="lui_kmCard_wrap">
									<p class="lui_kmCard_title">
										<label id="currentNodeDescription"></label>
									</p>
									<div id="extNodeDescriptionDiv">
										<c:import url="/sys/lbpm/flowchart/page/nodeDescription_ext_show.jsp" charEncoding="UTF-8">
											<c:param name="modelId" value="${sysWfBusinessForm.fdId}" />
											<c:param name="modelName" value="${param.modelName}" />
											<c:param name="formName" value="${param.formName}" />
											<c:param name="provideFor" value="pc" />
										</c:import>
									</div>
								</div>
							</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_ext.jsp" charEncoding="UTF-8">
				<c:param name="auditNoteFdId" value="${sysWfBusinessForm.sysWfBusinessForm.fdAuditNoteFdId}" />
				<c:param name="modelName" value="${sysWfBusinessForm.modelClass.name}" />
				<c:param name="modelId" value="${sysWfBusinessForm.fdId}" />
				<c:param name="formName" value="${param.formName}" />
				<c:param name="curHanderId" value="${sysWfBusinessForm.sysWfBusinessForm.fdCurHanderId}"/>
				<c:param name="provideFor" value="pc" />
			</c:import>
			<%-- 通知选项--%>
			<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != null && sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != ''}">
				<input type="hidden" name="sysWfBusinessForm.fdSystemNotifyType" value="" id="sysWfBusinessForm.fdSystemNotifyType">
			<c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20'}">
			<tr id="notifyOptionTR">
				<td class="td_normal_title" width="15%">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.notifyOption" />
				</td>
				<td colspan="3">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.notifyToDraft.message1" />
					<input type="text" class="inputSgl" style="width:30px;" id="dayOfNotifyDrafter" key="dayOfNotifyDrafter" validate="digits,min(0)" maxlength="3"><bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.day" />
					<input type="text" class="inputSgl" style="width:30px;" id="hourOfNotifyDrafter" key="hourOfNotifyDrafter" validate="digits,min(0)" maxlength="4"><bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.hour" />
					<input type="text" class="inputSgl" style="width:30px;" id="minuteOfNotifyDrafter" key="minuteOfNotifyDrafter" validate="digits,min(0)" maxlength="5"><bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.minute" />
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.notifyToDraft.message2" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<label>
					<input type="checkbox" id="notifyDraftOnFinish" value="true" alertText="" key="notifyOnFinish">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.notifyToDraft.message3" />
					</label>
					&nbsp;&nbsp;
					<label style="display:none;">
					<input type="checkbox" id="notifyForFollow" value="true" alertText="" key="notifyForFollow">
					<bean:message key="lbpmFollow.button.follow" bundle="sys-lbpmservice-support" />
					</label>
				</td>
			</tr>
			</c:if>
			<c:if test="${sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30'}">
			<tr id="notifyOptionTR">
				<td class="td_normal_title" width="15%">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.notifyOption" />
				</td>
				<td colspan="3">
					<label>
					<input type="checkbox" id="notifyOnFinish" value="true" alertText="" key="notifyOnFinish">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.notifyOption.message" />
					</label>
					&nbsp;&nbsp;
					<label style="display:none;">
					<input type="checkbox" id="notifyForFollow" value="true" alertText="" key="notifyForFollow">
					<bean:message key="lbpmFollow.button.follow" bundle="sys-lbpmservice-support" />
					</label>
				</td>
			</tr>
			</c:if>
			</c:if>
			
				<tr id="assignmentRow" style="display:none;">
					<td class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.assignment" />
					</td>
					<td colspan="3">
						<!-- Attachments -->
						<c:forEach items="${sysWfBusinessForm.sysWfBusinessForm.fdAttachmentsKeyList}" var="fdAttachmentsKey" varStatus="statusKey">
							<table class="tb_noborder" width="100%" id="${fdAttachmentsKey}" style="display:none;" name="attachmentTable">
								<tr>
									<td>
										<c:import
											url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
											charEncoding="UTF-8">
											<c:param
												name="fdKey"
												value="${fdAttachmentsKey}" />
											<c:param
												name="formBeanName"
												value="${param.formName}" />
											<c:param
												name="fdModelName"
												value="${sysWfBusinessForm.modelClass.name}"/>
											<c:param
												name="fdModelId"
												value="${sysWfBusinessForm.fdId}"/>
											 <c:param name="uploadAfterSelect" value="true" />
										</c:import>
									</td>
								</tr>
							</table>
						</c:forEach>
						<%-- <table class="tb_noborder" width="100%">
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
									</c:import>
								</td>
							</tr>
						</table> --%>
					</td>
				</tr>
			
			<%-- <c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20'}">
				<tr id="handlerIdentityRow" style="display:none">
					<td class="td_normal_title"  width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.submitRole" />
					</td>
					<td colspan="3">
						删除onchange事件中的WorkFlow_GetFlowContent(this); 2009-09-01 by fuyx
						<select name="rolesSelectObj" key="handlerId">
						</select>
					</td>
				</tr>
			</c:if> --%>
			<c:if test="${sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30'}">
				<%-- 当前流程状态 --%>
				<tr id="processStatusRow" style="display:none">
					<td class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.processStatus" />
					</td>
					<td colspan="3">
						<label id="processStatusLabel"></label>
					</td>
				</tr>
				<tr id="currentHandlersRow">
					<td class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.currentProcessor" />
					</td>
					<td colspan="3">
						<div id="currentHandlersLabel" style="word-break:break-all">
							<kmss:showWfPropertyValues idValue="${sysWfBusinessForm.fdId}" propertyName="handerNameDetail" />
						</div>
					</td>
				</tr>
				<tr id="historyHandlersRow">
					<td class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.finishProcessor" />
					</td>
					<td colspan="3">
						<div id="historyHandlersLabel" style="word-break:break-all">
							<kmss:showWfPropertyValues idValue="${sysWfBusinessForm.fdId}" propertyName="historyHanderName" />
						</div>
					</td>
				</tr>
			</c:if>
			
			<xform:isExistRelationProcesses relationType="all">
			<tr class="tr_normal_title">
				<td align="left" colspan="4">
					<label><input type="checkbox" id="relationProcessCheckBox" value="true">
					<bean:message bundle="sys-lbpmservice" key="lbpm.tab.relationProcesses" /></label>
				</td>
			</tr>
			<xform:isExistRelationProcesses relationType="parent">
					<tr id="parentFlowTR" style="display:none">
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice" key="label.parentFlow" />
						</td>
						<td colspan=3>
							<xform:showParentProcesse />
						</td>
					</tr>
			</xform:isExistRelationProcesses>
			<xform:isExistRelationProcesses relationType="subs">
					<tr id="subFlowTR" style="display:none">
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-lbpmservice" key="label.subFlow" />
						</td>
						<td colspan=3>
							<xform:showSubProcesses />
						</td>
					</tr>
			</xform:isExistRelationProcesses>
			</xform:isExistRelationProcesses>
			
			<tr class="tr_normal_title" style="display:none">
				<td align="left" colspan="4">
					<label><input type="checkbox" id="flowGraphicShowCheckbox" value="true" onclick="this.checked ? $('#flowGraphic').show() : $('#flowGraphic').hide();">
					<bean:message bundle="sys-lbpmservice" key="lbpm.tab.graphic" /></label>
				</td>
			</tr>
			

			
			<tr class="tr_normal_title" style="display:none">
				<td align="left" colspan="4">
					<label><input type="checkbox" value="true" onclick="lbpm.globals.showDetails(checked);">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.details" /></label>
				</td>
			</tr>
			<tr id="showDetails" style="display:none">
				<td colspan="4">
					<table id="Label_Tabel_Workflow_Info" width=100%>
						
						
					</table>		
				</td>
			</tr>
			<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != null && sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != ''}">
				<tr id="nodeCanViewCurNodeTR" style="display:none;">
					<td class="td_normal_title" width="15%"><bean:message bundle="sys-lbpmservice" key="lbpmSupport.curNodeCanViewCurNode" /></td>
					<td>
						<input type="hidden" name="wf_nodeCanViewCurNodeIds">
						<textarea name="wf_nodeCanViewCurNodeNames" style="width:85%" readonly></textarea>
						<a href="javascript:;" class="com_btn_link" onclick="lbpm.globals.selectNotionNodes();"><bean:message key="dialog.selectOther" /></a>
					</td>
				</tr>
				<tr id="otherCanViewCurNodeTR" style="display:none;">
					<td class="td_normal_title" width="15%"><bean:message bundle="sys-lbpmservice" key="lbpmSupport.curNodeotherCanViewCurNode" /></td>
					<td>
						<input type="hidden" name="wf_otherCanViewCurNodeIds">
						<textarea name="wf_otherCanViewCurNodeNames" style="width:85%" readonly></textarea>
						<a href="javascript:;" class="com_btn_link" onclick="Dialog_Address(true,'wf_otherCanViewCurNodeIds','wf_otherCanViewCurNodeNames', ';',ORG_TYPE_ALL,function myFunc(rtv){lbpm.globals.updateXml(rtv,'otherCanViewCurNode');});"><bean:message key="dialog.selectOther" /></a>
					</td>
				</tr>
			</c:if>
		</table>
	    	
	    </div>
	    <!--end 流程处理  -->
	    
	    <!-- begin流程状态 -->
	    <div name="process_body" class="process_body_checked_false">
	     <table width=100%>
	     	<tr>
				<td  id="processStatusTD" ${resize_prefix}onresize="lbpm.process_status_load_Frame();">
					<iframe width="100%" height="100%" scrolling="no" FRAMEBORDER=0></iframe>
				</td>
			</tr>
	     </table>
	    </div>
	    <!-- end流程状态 -->
	    
	    <!-- begin流程图 -->
	    <div name="process_body" class="process_body_checked_false">
		    <table class="tb_normal process_review_panel" width="100%">
		    	<tr id="flowGraphic">
				<td id="workflowInfoTD" ${resize_prefix}onresize="lbpm.flow_chart_load_Frame();" colspan="4">
					<iframe width="100%" height="100%" scrolling="no" id="${sysWfBusinessFormPrefix}WF_IFrame"></iframe>
					<script>
					$("#${sysWfBusinessFormPrefix}WF_IFrame").ready(function() {
						var lbpm_panel_reload = function() {
							$("#${sysWfBusinessFormPrefix}WF_IFrame").attr('src', function (i, val) {return val;});
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
					$('#relationProcessCheckBox').bind('click', function() {
						if (this.checked==true) {
							if ($('#parentFlowTR')) {
								$('#parentFlowTR').show();
							}
							if ($('#subFlowTR')) {
								$('#subFlowTR').show();
							}
						} else {
							if ($('#parentFlowTR')) {
								$('#parentFlowTR').hide();
							}
							if ($('#subFlowTR')) {
								$('#subFlowTR').hide();
							}
						}
						
					});
					</script>
				</td>
			</tr>
	    
		    </table>
	    </div>
	    <!-- end流程图 -->
	    
	    <!-- begin流程表格 -->
	    <div name="process_body" class="process_body_checked_false">
	    	<table width=100%>
	    		<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != null && sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != ''}">
					<tr LKS_LabelName="<bean:message bundle="sys-lbpmservice" key="lbpm.tab.table" />">
						<td id="workflowTableTD" ${resize_prefix}onresize="lbpm.flow_table_load_Frame();">
							<iframe width="100%" height="100%" scrolling="no" id="${sysWfBusinessFormPrefix}WF_TableIFrame" FRAMEBORDER=0></iframe>
						</td>
					</tr>
				</c:if>
	    	</table>
	    </div>
	    <!-- end流程表格 -->
	    
	    <!-- begin流程日志 -->
	    <div name="process_body" class="process_body_checked_false">
		    <table width=100%>
		    	<tr LKS_LabelName="<bean:message bundle="sys-lbpmservice" key="label.flowLog" />">
							<td  id="flowLogTableTD" ${resize_prefix}onresize="lbpm.flow_log_load_Frame();">
								<iframe width="100%" height="100%" scrolling="no" FRAMEBORDER=0></iframe>
							</td>
				</tr>
		    </table>    	
	    </div>
	    <!-- end流程日志 -->
	    
	    <!-- begin重启日志 -->
	    <div name="process_body" class="process_body_checked_false">
		    <table width=100%>
		    	<tr LKS_LabelName="<bean:message bundle="sys-lbpmservice" key="label.flowLog" />">
					<td  id="lbpmProcessRestartLogTD" ${resize_prefix}onresize="lbpm.process_restart_Log_Frame();">
						<iframe width="100%" height="100%" scrolling="no" FRAMEBORDER=0></iframe>
					</td>
				</tr>
		    </table>    	
	    </div>
	    <!-- end重启日志 -->
	    
