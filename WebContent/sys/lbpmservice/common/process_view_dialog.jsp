<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="sysWfBusinessForm" value="${requestScope[param.formName]}" />
<c:set var="lbpmProcessForm" value="${sysWfBusinessForm.sysWfBusinessForm.internalForm}" /> 
<link type="text/css" rel="stylesheet" href="<c:url value="/sys/lbpmservice/common/css/process_tab_main.css?s_cache=${LUI_Cache}"/>"/> 

<%@ include file="/sys/lbpmservice/include/sysLbpmProcess_script.jsp"%> 
		<!--引入暂存按钮-->
		<c:import url="/sys/lbpmservice/import/sysLbpmProcess_saveDraft.jsp" charEncoding="UTF-8"> 
			<c:param name="formName" value="${param.formName}">
			</c:param>
		</c:import>
		
		<!--引入切换表单按钮-->
		<%@ include file="/sys/lbpmservice/import/sysLbpmProcess_subform.jsp"%>
		
		<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}">
		<c:if test="${empty param.onClickSubmitButton}">
		<form name="sysWfProcessForm" method="POST"
				action="<c:url value="/sys/lbpmservice/support/lbpm_process/lbpmProcess.do" />">
		</c:if>
		</c:if>
		<input type="hidden" id="sysWfBusinessForm.fdParameterJson" name="sysWfBusinessForm.fdParameterJson" value='' >
		<input type="hidden" id="sysWfBusinessForm.fdAdditionsParameterJson" name="sysWfBusinessForm.fdAdditionsParameterJson" value='' >
		<input type="hidden" id="sysWfBusinessForm.fdIsModify" name="sysWfBusinessForm.fdIsModify" value='' >
		<input type="hidden" id="sysWfBusinessForm.fdCurHanderId" name="sysWfBusinessForm.fdCurHanderId" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdCurHanderId}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdCurNodeSavedXML" name="sysWfBusinessForm.fdCurNodeSavedXML" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdCurNodeSavedXML}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdFlowContent" name="sysWfBusinessForm.fdFlowContent" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdProcessId" name="sysWfBusinessForm.fdProcessId" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdProcessId}" />'>
		<input type="hidden" id="sysWfBusinessForm.fdKey" name="sysWfBusinessForm.fdKey" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdKey}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdModelId" name="sysWfBusinessForm.fdModelId" value='<c:out value="${sysWfBusinessForm.fdId}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdModelName" name="sysWfBusinessForm.fdModelName" value='<c:out value="${sysWfBusinessForm.modelClass.name}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdCurNodeXML" name="sysWfBusinessForm.fdCurNodeXML" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdCurNodeXML}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdTemplateModelName" name="sysWfBusinessForm.fdTemplateModelName" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdTemplateModelName}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdTemplateKey" name="sysWfBusinessForm.fdTemplateKey" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdTemplateKey}" />' >
		<input type="hidden" id="sysWfBusinessForm.canStartProcess" name="sysWfBusinessForm.canStartProcess" value='' >
		<input type="hidden" id="sysWfBusinessForm.fdTranProcessXML" name="sysWfBusinessForm.fdTranProcessXML" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdTranProcessXML}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdDraftorId" name="sysWfBusinessForm.fdDraftorId" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdDraftorId}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdDraftorName" name="sysWfBusinessForm.fdDraftorName" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdDraftorName}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdHandlerRoleInfoIds" name="sysWfBusinessForm.fdHandlerRoleInfoIds" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdHandlerRoleInfoIds}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdHandlerRoleInfoNames" name="sysWfBusinessForm.fdHandlerRoleInfoNames" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdHandlerRoleInfoNames}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdAuditNoteFdId" name="sysWfBusinessForm.fdAuditNoteFdId" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdAuditNoteFdId}" />' >
		<input type="hidden" id="docStatus" name="docStatus" value='<c:out value="${sysWfBusinessForm.docStatus}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdIdentityId" name="sysWfBusinessForm.fdIdentityId" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdIdentityId}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdProcessStatus" name="sysWfBusinessForm.fdProcessStatus" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdProcessStatus}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdSubFormXML" name="sysWfBusinessForm.fdSubFormXML" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdSubFormXML}" />'>
		<!-- 留下其他信息处理的域，为了兼容特权人修改流程图信息时保存其他设计的信息 -->
		<input type="hidden" id="sysWfBusinessForm.fdOtherContentInfo" name="sysWfBusinessForm.fdOtherContentInfo" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdOtherContentInfo}" />'>
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
					if(classValue=="active"){
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
	   		<script src="<c:url value="/sys/lbpmservice/common/process_view_dialog.js?s_cache=${LUI_Cache}"/>"></script>
			<c:if test="${(sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30') || sysWfBusinessForm.docStatus == '11' || sysWfBusinessForm.docStatus == '10'}">
					<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}">
							<ui:button order="1" parentId="toolbar" text="${lfn:message('sys-lbpmservice:lbpmNode.processingNode.identifyRole.button.approve')}" 
	 								id="approveButton" onclick="process_handerApprove();" style="display:none;">
							</ui:button>
							
							<c:if test="${sysWfBusinessForm.docStatus!='21'}">
								<ui:button order="1" parentId="toolbar" text="${lfn:message('sys-lbpmservice:lbpmNode.processingNode.identifyRole.button.drafter')}" 
		 								id="drafterOptButton" onclick="lbpm.globals.openExtendRoleOptWindow('drafter');" style="display:none;">
								</ui:button>
							</c:if>
						
							<c:if test="${sysWfBusinessForm.docStatus!='10'}"><!--//fix #27954 起草人将流程撤回到起草节点后，特权人进入流程，不应该出现特权操作-->
								<ui:button order="1" parentId="toolbar" text="${lfn:message('sys-lbpmservice:lbpmNode.processingNode.identifyRole.button.authority')}" 
	 								id="authorityOptButton" onclick="lbpm.globals.openExtendRoleOptWindow('authority');" style="display:none;">
								</ui:button>
							</c:if>
							<!-- 流程跟踪 -->
							<ui:button order="1" parentId="toolbar" text="${lfn:message('sys-lbpmservice-support:lbpmFollow.button.follow')}" 
										id="followOptButton"  style="display:none;" onclick="lbpm.globals.followOptButtonClick();">
							</ui:button>
								<!-- 取消跟踪 -->
							<ui:button order="1" parentId="toolbar" text="${lfn:message('sys-lbpmservice-support:lbpmFollow.button.cancelFollow')}" 
										id="cancelFollowOptButton"  style="display:none;" onclick="lbpm.globals.cancelFollowOptButtonClick();">
							</ui:button>
					</c:if>
			</c:if>
			<c:choose>
				<c:when test="${(sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30') || sysWfBusinessForm.docStatus == '11' || sysWfBusinessForm.docStatus == '10'}">
					<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}">
							<!-- 已处理人操作，撤回审批，催办等 -->
							<c:if test="${sysWfBusinessForm.docStatus!='21'}">
								<!-- 增加div隐藏，彻底隐藏原审批按钮 -->
								<div style="display:none;">
									<span id="historyhandlerOpt" style="display:none;"></span>
								</div>
								<ui:button order="1" parentId="toolbar" text="${lfn:message('sys-lbpmservice:lbpmNode.processingNode.identifyRole.button.historyhandler')}" 
		 								id="historyhandlerOptButton" onclick="lbpm.globals.openExtendRoleOptWindow('historyhandler','','','true');" style="display:none;">
								</ui:button>
							</c:if>
					</c:if>
				</c:when>
			</c:choose>
			<table class="tb_normal process_review_panel" width="100%" style="display:none" id="processDev">
				<%-- #152384-参数获取文件路径直接import输出导致安全问题-开始
				<c:if test="${not empty param.historyPrePage}">
					<c:import url="${param.historyPrePage}" charEncoding="UTF-8"/>
				</c:if>
				#152384-参数获取文件路径直接import输出导致安全问题-结束 --%>
				<!--update by wubing date 2016-03-17,开放驳回到起草时，起草人可以进入处理-->
				
				<c:if test="${(sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30') || sysWfBusinessForm.docStatus == '11'}">
					<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}"><%-- start action --%>
						<!-- 起草人，当前处理人和特权人能显示 -->
						<c:if test="${lbpmProcessForm.fdIsDrafter eq 'true' || lbpmProcessForm.fdIsAdmin eq 'true' || lbpmProcessForm.fdIsHander eq 'true' }">
							<c:if test="${requestScope.showLimitTimeOperation eq 'true' }"><!-- 是否显示：开关或者是否有限时 -->
								<!-- 办理限时开始 -->
								<tr id="limitTimeRow">
									<td class="td_normal_title" width="15%">
										<!-- 办理限时剩余 -->
										<c:if test="${requestScope.showTimeType eq 'limit' }">
											<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.limitTimeRow" />
										</c:if>
										<!-- 办理超时 -->
										<c:if test="${requestScope.showTimeType eq 'timeout' }">
											<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.timeoutRow" />
										</c:if>
									</td>
									<td colspan="3">
										<c:if test="${requestScope.showTimeType eq 'limit' }">
											<span class="limit_time_span">${requestScope.limitDay }</span> <bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.day" /> <span class="limit_time_span">${requestScope.limitHour }</span> <bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.hour" /> <span class="limit_time_span">${requestScope.limitMinute }</span> <bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.minute" /> <span class="limit_time_span">${requestScope.limitSecond }</span> <bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.second" />
										</c:if>
										<c:if test="${requestScope.showTimeType eq 'timeout' }">
											<span class="limit_time_span">${requestScope.timeoutDay }</span> <bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.day" /> <span class="limit_time_span">${requestScope.timeoutHour }</span> <bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.hour" /> <span class="limit_time_span">${requestScope.timeoutMinute }</span> <bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.minute" /> <span class="limit_time_span">${requestScope.timeoutSecond }</span> <bean:message bundle="sys-lbpmservice" key="FlowChartObject.Lang.Node.second" />
										</c:if>
									</td>
								</tr>
								<script>
									$(document).ready(function() {
										$(".limit_time_span").css("border-radius","2px");
										$(".limit_time_span").css("padding","2px 7px");
									});
								</script>
								<!-- 办理限时结束 -->
							</c:if>
						</c:if>
						<c:if test="${(lbpmProcessForm.fdIsDrafter ne 'true' && lbpmProcessForm.fdIsAdmin ne 'true' && lbpmProcessForm.fdIsHander ne 'true') || requestScope.showLimitTimeOperation ne 'true' }">
							<!-- 办理限时开始 -->
							<tr id="limitTimeRow" style="display:none">
								<td class="td_normal_title" width="15%"></td>
								<td colspan="3"></td>
							</tr>
						</c:if>
					<tr id="operationItemsRow">
						<td class="td_normal_title" width="15%">
							<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationItems" />
						</td>
						<td colspan="3">
							<select name="operationItemsSelect" onchange="lbpm.globals.operationItemsChanged(this);">
							</select>
							<span></span>
						</td>
					</tr>
					<%-- 起草人选择人工分支节点 --%>
					<c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20'}">
						<tr id="manualBranchNodeRow" style="display:none">
							<td class="td_normal_title" width="15%">
								<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.manualNodeSelect" />
							</td>
							<td colspan="3" id="manualNodeSelectTD">
		
							</td>
						</tr>
					</c:if>
					<tr id="operationMethodsRow">
						<td class="td_normal_title" width="15%">
							<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationMethods" />
						</td>
						<td colspan="3">
						<div id="operationMethodsGroup" style="float: left; margin-right: 10px;"></div>
						</td>
					</tr>
					<%-- 动态加载操作--%>
					<c:forEach items="${lbpmProcessForm.curHandlerOperationsReviewJs}" var="reviewJs" varStatus="vstatus">
						<c:import url="${reviewJs}" charEncoding="UTF-8" />
					</c:forEach>
	
					<%-- 用于起草节点 ,显示即将流向--%>
					<c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20'}">
						<tr style="display:none;">
							<td id="nextNodeTDTitle" class="td_normal_title" width="15%">
								<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.nextNode" />
							</td>
							<td colspan="3" id="nextNodeTD">
								&nbsp;
							</td>
						</tr>
					</c:if>
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
					<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != null && sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != ''}">
					<tr id="checkChangeFlowTR" style="display:none;">
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
								<a class="com_btn_link" href="javascript:lbpm.globals.modifyProcess('sysWfBusinessForm.fdFlowContent','sysWfBusinessForm.fdTranProcessXML');">
									<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.modifyFlow" />
								</a>
							</label>
							<label id="modifyEmbeddedSubFlowDIV" style="display:none;">
								
							</label>
						</td>
					</tr>
					</c:if>
					<!--通知紧急程度 -->
					<tr id="notifyLevelRow">
						<td class="td_normal_title"  width="15%">
							<bean:message bundle="sys-notify" key="sysNotifyTodo.level.title" />
						</td>
						<td colspan="3" id="notifyLevelTD">
							<c:if test="${sysWfBusinessForm.docStatus=='11'}">
							<!--文档驳回后，起草人的重新提交页面 紧急度和提交选项 请左对齐-->
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
									<td id="optionButtons" colspan="2">
										<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.commonUsages" />:&nbsp;&nbsp;
										<select name="commonUsages" onchange="lbpm.globals.setUsages(this);" style="width: 120px; overflow-x: hidden">
											<option value="">
												<bean:message key="page.firstOption" />
											</option>
										</select>
										<a href="javascript:;" class="com_btn_link" style="margin: 0 10px;" onclick="Com_EventPreventDefault();lbpm.globals.openDefiniateUsageWindow();">
											<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.commonUsages.definite" />
										</a>
										<c:if test="${sysWfBusinessForm.docStatus>='20'}">
											<a href="javascript:;" class="com_btn_link" id="saveDraftButton" onclick="lbpm.globals.saveDraftAction(this);">
												<bean:message key="button.saveDraft" bundle="sys-lbpmservice" />
											</a>
										</c:if>
										<input type="hidden" name="noticeHandlerIds" id="noticeHandlerIds">
										<a href="javascript:;" class="com_btn_link" style="margin-left:10px;" onclick="lbpm.globals.selectHistoryHandlers(this,'fdUsageContent');"><bean:message bundle="sys-lbpmservice" key="lbpm.process.noticeHandler.name" /></a><span style='display:none'>(<span id="noticeHandlerNum">0</span>/<span id="noticeHandlerTotal">0</span>)</span>
									</td>
								</tr>
								<tr>
									<td id="fdUsageContentTd" width="98%">
										<span id="fdUsageContentSpan" style="display: block;">	
											<textarea name="fdUsageContent" class="process_review_content" style="width:98%;padding: 0;" key="auditNode" subject="${lfn:message('sys-lbpmservice:lbpmNode.createDraft.opinion')}" validate="fdUsageContentMaxLength(4000)"></textarea>
											<span id="mustSignStar" class="txtstrong" style="margin-top:62px;position:absolute;display:none">*</span>
										</span>
									</td>
									<td>
										<input id="process_review_button" class="process_review_button" style="display:none" type=button value="<bean:message key="button.submit"/>"
											onclick="beforeLbpmSubmit();<%String onClickSubmitButton = org.apache.commons.lang.StringEscapeUtils.escapeHtml(request.getParameter("onClickSubmitButton"));
											if (onClickSubmitButton == null || onClickSubmitButton.length() == 0) {
												out.print("Com_Submit(document.sysWfProcessForm, 'update');");
											} else {
												out.print(onClickSubmitButton);
											}%>"/>
											
										<script>
										function beforeLbpmSubmit(){
											if (document.forms == null || document.forms.length < 1 || window.$GetFormValidation == null) {
												return;
											}
											var validation = $GetFormValidation(document.forms[0]);
											if (validation) {
												//判断是否为可通过类型并且是否为表单暂存
												var isPassType = (lbpm.currentOperationType == null || (lbpm.operations[lbpm.currentOperationType] && lbpm.operations[lbpm.currentOperationType].isPassType)) && !lbpm.saveFormData;
												lbpm.events.fireListener(lbpm.constant.EVENT_BEFORELBPMSUBMIT,{validation:validation,isPassType:isPassType});
												//判断是否含有自定义表单
												var $xform = $(".sysDefineXform");
												if($xform.length>0){
													if(!lbpm.saveFormData){
														//不为表单暂存需恢复流程能否往下走的状态
														var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
														$(canStartProcess).prop("value","true");
													}else{
														//为表单暂存需修改暂存状态，防止暂存时校验失败后，又不想再暂存，直接提交导致必填校验被移除
														lbpm.saveFormData = false;
													}
													if(isPassType){
														//重置表单必填校验
														validation.resetElementsValidate($xform[0]);
														//重置附件必填
														_lbpmChangeAttValidate(false);
														// 重置流程必填校验
														$('.lbpmNextRouteInfoRow').each(function(index,ele){
															validation.resetElementsValidate(ele);	
														});
													}else{
														//移除表单必填校验
														validation.removeElements($xform[0],'required');
														//移除附件必填
														_lbpmChangeAttValidate(true);
														// 移除流程必填校验
														$('.lbpmNextRouteInfoRow').each(function(index,ele){
															validation.removeElements(ele,'required');	
														});
													}
												}
											}
										}
										
										function _lbpmChangeAttValidate(remove){
											if(window.Attachment_ObjectInfo){
												for(var tmpKey in window.Attachment_ObjectInfo){
													if(window.Attachment_ObjectInfo[tmpKey]){
														if(remove){
															if(!window.Attachment_ObjectInfo[tmpKey]._reqired){
																window.Attachment_ObjectInfo[tmpKey]._reqired = window.Attachment_ObjectInfo[tmpKey].required;
															}
															window.Attachment_ObjectInfo[tmpKey].required = false;
														}else{
															if(window.Attachment_ObjectInfo[tmpKey]._reqired!=null){
																window.Attachment_ObjectInfo[tmpKey].required = window.Attachment_ObjectInfo[tmpKey]._reqired;
																delete window.Attachment_ObjectInfo[tmpKey]._reqired;
															}
														}
													}
												}
											}
										}
										</script>
									</td>
								</tr>
								<tr>
									<td colspan="2">
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
					<tr id="notifyOptionTR">
						<td class="td_normal_title" width="15%">
							<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.notifyOption" />
						</td>
						<td colspan="3">
							<label id="notifyOnFinishLabel">
							<input type="checkbox" id="notifyOnFinish" value="true" alertText="" key="notifyOnFinish">
							<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.notifyOption.message" />
							</label>
							&nbsp;&nbsp;
							<label id="notifyForFollowLabel" style="display:none;">
							<input type="checkbox" id="notifyForFollow" value="true" alertText="" key="notifyForFollow">
							<bean:message key="lbpmFollow.button.follow" bundle="sys-lbpmservice-support" />
							</label>
						</td>
					</tr>
					</c:if>
					<c:import url="/sys/lbpmservice/common/process_ext.jsp" charEncoding="UTF-8">
						<c:param name="modelName" value="${sysWfBusinessForm.modelClass.name}" />
						<c:param name="modelId" value="${sysWfBusinessForm.fdId}" />
						<c:param name="formName" value="${param.formName}" />
					</c:import>
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
													value="${param.formName}"/>
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
						</td>
					</tr>
					
					</c:if><%-- end action --%>
				</c:if>
	     		
			</table>

	    <%--
	    <div name="process_body" class="process_body_checked_true">

	    </div>
	     --%>
	    <!--end 流程处理  -->
	      <div name="process_body" class="process_body_checked_true">
	      		<table class="tb_normal process_review_panel" width="100%">
	      		<%-- 流程说明 --%>
	      		<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="sys-lbpmservice" key="lbpmProcess.history.description" />
					</td>
					<td colspan="3">
						<span id="fdFlowDescription"></span>	 
					</td>
				</tr>
	      		<%-- 审批意见 --%>
	      		<c:if test="${not empty sysWfBusinessForm.docStatus}">
				<tr class="tr_normal_title">
					<td align="left" colspan="4">
						<label><input type="checkbox" value="true" checked onclick="lbpm.globals.showHistoryDisplay(this);">
						<bean:message bundle="sys-lbpmservice" key="lbpmProcess.history.description.show" /></label>
					</td>
				</tr>
				<tr id="historyTableTR">
					<td colspan="4" id="historyInfoTableTD" ${resize_prefix}onresize="lbpm.load_Frame();" style="padding: 0;">
						<iframe id="historyInfoTableIframe" width="100%" style="margin-bottom: -3px;border: none;" scrolling="no" FRAMEBORDER=0></iframe>
					</td>
				</tr>
				</c:if>
				
	      		<c:if test="${(sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30') || sysWfBusinessForm.docStatus == '11'}">
					<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}"><%-- start action --%>
				
					</c:if>
					<%-- end action --%>
					
					
					
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
						<label><input type="checkbox" value="true" onclick="lbpm.globals.showDetails(checked);">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.details" /></label>wangx-log
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
	     		
				<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != null && sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != ''}">
				<tr class="tr_normal_title" style="display:none">
					<td align="left" colspan="4">
						<label><input type="checkbox" id="flowGraphicShowCheckbox" value="true" onclick="this.checked ? $('#flowGraphic').show() : $('#flowGraphic').hide();">
						<bean:message bundle="sys-lbpmservice" key="lbpm.tab.graphic" /></label>
					</td>
				</tr>
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
			</c:if>
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

	<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}">
	<c:if test="${empty param.onClickSubmitButton}">
	</form>
	</c:if>
	</c:if>

	<script>
	if(lbpm.adminOperationsReviewJs.length>0){
		lbpm.globals.includeFile("/sys/lbpmservice/node/node_common_review.js","<%=request.getContextPath()%>");	
	}
	</script>
