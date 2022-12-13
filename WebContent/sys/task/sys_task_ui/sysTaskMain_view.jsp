<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.ResourceUtil" %>
<%@ page import="com.landray.kmss.sys.task.util.SysTaskMainLevelUtil" %>
<template:include ref="default.view" sidebar="no">
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${sysTaskMainForm.docSubject} - ${ lfn:message('sys-task:module.sys.task') }"></c:out>
	</template:replace>
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="5">
			<%--未结项的任务才可以进行执行反馈、任务评价、更新进度、终止任务/取消终止、分解子任务、编辑、驳回任务等操作--%>	
			<c:if test="${sysTaskMainForm.fdStatus != '6' }">
			<%--执行反馈--%>	
			<c:if test="${sysTaskMainForm.fdStatus != '4' }">
				<kmss:auth
					requestURL="/sys/task/sys_task_feedback/sysTaskFeedback.do?method=add&flag=${param.flag}&fdTaskId=${param.fdId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('sys-task:button.feedback')}" order="3" id="feedback"
						onclick="feedback();">
					</ui:button>
				</kmss:auth>
			</c:if>
			<%--任务评价--%>	
			<kmss:auth
				requestURL="/sys/task/sys_task_evaluate/sysTaskEvaluate.do?method=add&flag=${param.flag}&fdTaskId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('sys-task:button.evaluate')}" order="3" id="evaluate"
					onclick="evaluate();">
				</ui:button>
			</kmss:auth>
			<%-- 驳回指派 --%>
			<c:if test="${sysTaskMainForm.fdStatus == '1' && fdIsAllowReject == 'true' && sysTaskMainForm.fdAppointId != currentPerson }">
			<kmss:auth
				requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=rejectTask&fdTaskId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('sys-task:button.rejectTask')}" order="3" id="rejectTask" 
					onclick="rejectTask();">
				</ui:button>
			</kmss:auth>
			</c:if>
			<%--任务结项--%>	
			<kmss:auth
				requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=closeTask&flag=${param.flag}&fdId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('sys-task:button.closeTask')}"  order="4" id="closeTask" onclick="closeTask();">
				</ui:button>
			</kmss:auth>
			<%--分解子任务--%>
			<c:if test="${sysTaskMainForm.fdStatus != '4' && sysTaskMainForm.fdStatus != '3' }">
				<c:if test="${sysTaskMainForm.fdResolveFlag != 'true' }">
					<kmss:auth
						requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=addChildTask&fdTaskId=${param.fdId}&flag=${param.flag}"
						requestMethod="GET">
						<ui:button text="${lfn:message('sys-task:button.sub.task')}" order="3" id="addChildTask"
							onclick="addchild();">
						</ui:button>
					</kmss:auth>
				</c:if>
			</c:if>
			<kmss:auth
				requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=updateStop&fdTaskId=${param.fdId}"
				requestMethod="GET">
				<%--终止任务--%>
				<c:if test="${sysTaskMainForm.fdStatus != '4' && sysTaskMainForm.fdStatus != '1' && sysTaskMainForm.fdStatus != '3' && sysTaskMainForm.fdStatus != '5'}">
					<ui:button text="${lfn:message('sys-task:button.terminate')}"  order="3" id="updateStop"
						onclick="updateStop();">
					</ui:button>
				</c:if>
				<%--取消终止--%>
				<c:if test="${sysTaskMainForm.fdStatus == '4'}">
					<ui:button text="${lfn:message('sys-task:button.cancel.terminate')}" order="3" id="updateCancelStop"
						onclick="updateCancelStop();">
					</ui:button>
				</c:if>
			</kmss:auth>
			<%--驳回任务(不存在子任务的任务才可以进行驳回)--%>
			<c:if test="${sysTaskMainForm.fdStatus == '3' && childSize == 0 }">
				<kmss:auth requestURL="/sys/task/sys_task_overrule/sysTaskOverrule.do?method=add&fdTaskId=${param.fdId}" requestMethod="GET">
					<ui:button text="${lfn:message('sys-task:table.sysTaskOverrule')}" order="4" id="overrule"
						onclick="overrule();">
					</ui:button>
				</kmss:auth> 
			</c:if>
			<%--编辑--%>
			<kmss:auth
				requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=edit&flag=${param.flag}&fdId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('button.edit')}" order="4" id="edit"
					onclick="editDoc();">
				</ui:button>
			</kmss:auth>
			</c:if>
			<%--复制任务--%>
			<kmss:auth
				requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=copyTask&fdTaskId=${param.fdId}"
				requestMethod="GET">
					 <ui:button order="4" text="${lfn:message('sys-task:button.copy') }" 
							onclick="copyDoc('${sysTaskMainForm.fdParentId}');">
					 </ui:button>
			</kmss:auth>
			<%--设为关注--%>
			<c:if test="${isAttention != null&&isAttention=='false' }">
				<ui:button text="${lfn:message('sys-task:button.attention')}"  order="4" id="attention" onclick="attention();">
				</ui:button>
			</c:if>
			<%--取消关注--%>
			<c:if test="${isAttention != null&&isAttention=='true' }"> 
				<ui:button text="${lfn:message('sys-task:sysTask.button.disAttention')}" order="4" id="disAttention" onclick="disAttention();">
				</ui:button>
			</c:if>
			<%--删除--%>
			<kmss:auth
				requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=delete&flag=${param.flag}&fdId=${param.fdId}"
				requestMethod="GET">
					<ui:button text="${lfn:message('button.delete')}"  order="5" id="delete"
						onclick="LUIconfirm('${ lfn:message('page.comfirmDelete')}','sysTaskMain.do?method=delete&fdId=${JsParam.fdId}');">
					</ui:button>
			</kmss:auth>
			<%--关闭--%> 
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" id="closeWindow">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<%--导航路径--%>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('sys-task:module.sys.task') }" href="/sys/task/" target="_self">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('sys-task:table.sysTaskMain') }" href="/sys/task/" target="_self">
			</ui:menu-item>
		</ui:menu>
	</template:replace>
	<%--主内容--%>
	<template:replace name="content">
		<%--任务样式--%>
		<style>
			.noteDiv {
				position: absolute;
				white-space: nowrap;
				height: 100px;
				width: 250px;
			}
			.ttb_noborder, .ttd_noborder, .ttb_noborder td{
				border: 0px;
				padding:0px;
				border-collapse:collapse;
			}
			.task_slideDown {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowd_blue.png) no-repeat 0 3px;cursor: pointer;}
			.task_slideUp {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowU_blue.png) no-repeat 0 3px;cursor: pointer;}
			.pro_barline {width: 113px;height: 7px;display:inline-block; background: #e5e4e1;border: 1px solid #d2d1cc;text-align: left;border-radius: 4px;}
			.pro_barline .complete{height: 7px;background: #00a001;border-radius: 3px;}
			.pro_barline .uncomplete{height: 7px;background: #ff8b00;border-radius: 3px;}
		</style>
		<%request.setAttribute("fdLevel",SysTaskMainLevelUtil.getfdLevel());%>
		<script type="text/javascript">
			seajs.use(['lui/dialog','lui/topic','lui/toolbar'], function(dialog,topic,toolbar) {
				
				window.onload = function(){
					// 当权重小于1时，显示<1%
					var parentId = "${sysTaskMainForm.fdParentId }",
						parentWeights = "${sysTaskMainForm.fdParentWeights}";
					if (parentId && parentWeights) {
						var percent = parseInt(parentWeights);
						if (percent < 1 || isNaN(percent)) {
							$(".taskPercent").text("<1%");
						}
					}
				};
				
				//任务反馈后会发回刷新事件，在这个事件中再查找上一级页面刷新待办
				topic.subscribe('successReloadPage', function() {
					try{
						if(window.opener!=null) {
							try {
								if (window.opener.LUI) {
									window.opener.LUI.fire({ type: "topic", name: "successReloadPage" });
									window.location.reload();
									return;
								}
							} catch(e) {}
							if (window.LUI) {
								LUI.fire({ type: "topic", name: "successReloadPage" }, window.opener);
							}
							var hrefUrl= window.opener.location.href;
							var localUrl = location.href;
							if(hrefUrl.indexOf("/sys/notify/")>-1 && localUrl.indexOf("/sys/notify/")==-1)
								window.opener.location.reload();
							window.location.reload();
						}
					}catch(e){}
				});				
				
				window.feedback=function(){
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=isClose&fdTaskId=${JsParam.fdId}"/>',
						function(data){
							if(data!=null && data.isClose =="false"){
								Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_feedback/sysTaskFeedback.do?method=add&flag=${JsParam.flag}&fdTaskId=${JsParam.fdId}','_blank');
							}else{
								dialog.alert("${lfn:message('sys-task:button.closeTask.confirm.message2')}");
								return;
							}
						},'json');
				};
				
				window.evaluate=function(){
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=isClose&fdTaskId=${JsParam.fdId}"/>',
							function(data){
								if(data!=null && data.isClose =="false"){
									Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_evaluate/sysTaskEvaluate.do?method=add&flag=${JsParam.flag}&fdTaskId=${JsParam.fdId}','_blank');
								}else{
									dialog.alert("${lfn:message('sys-task:button.closeTask.confirm.message2')}");
									return;
								}
							},'json');
				};
				
				// 驳回指派
				window.rejectTask = function(){
					var url = '${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=rejectTask&fdTaskId=${JsParam.fdId}';
					dialog.iframe('/sys/task/sys_task_ui/sysTaskMain_rejectTask_iframe.jsp',
							"<bean:message key='button.rejectTask.enter' bundle='sys-task'/>",function(data){
						if(data && data.rejectReason) {
							window.LUI.fire({'type':'topic','name':'btn_disabled','data':true} , window );
							var myForm = document.createElement("form");
							myForm.method = "post";
							myForm.action = url;
							var myInput = document.createElement("input");
							myInput.setAttribute("name", "fdRejectReason");
							myInput.setAttribute("value", data.rejectReason);
							myForm.appendChild(myInput);
							document.body.appendChild(myForm);
							myForm.submit();
							document.body.removeChild(myForm);
						}
					},{width:550,height:380});
				};
				
				window.showRejectList = function(performId){
					var url="/sys/task/sys_task_reject/sysTaskReject_list.jsp?taskId=${param.fdId }&performId=" + performId;
					dialog.iframe(url, " ", function(arg){
						
					},{width:680,height:465,buttons:[{
       					name : "${lfn:message('sys-ui:ui.dialog.button.cancel')}",
       					value : false,
       					styleClass : 'lui_toolbar_btn_gray',
       					fn : function(value, dialog) {
       						dialog.hide(value);
       					}
       				}]});
				};
				
				window.addchild = function(){
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=isClose&fdTaskId=${JsParam.fdId}"/>',
							function(data){
								if(data!=null && data.isClose =="false"){
									if(!checkLeverNumber())return;Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=addChildTask&fdTaskId=${JsParam.fdId}&flag=${JsParam.flag}','_blank');
								}else{
									dialog.alert("${lfn:message('sys-task:button.closeTask.confirm.message2')}");
									return;
								}
							},'json');
				};
				window.updateStop = function(){
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=isClose&fdTaskId=${JsParam.fdId}"/>',
							function(data){
								if(data!=null && data.isClose =="false"){
									LUIconfirm("${lfn:message('sys-task:button.terminate.confirm.message')}",'${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=updateStop&fdTaskId=${JsParam.fdId}');
								}else{
									dialog.alert("${lfn:message('sys-task:button.closeTask.confirm.message2')}");
									return;
								}
							},'json');
				};
				window.updateCancelStop = function(){
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=isClose&fdTaskId=${JsParam.fdId}"/>',
							function(data){
								if(data!=null && data.isClose =="false"){
									LUIconfirm('${lfn:message('sys-task:button.terminate.cancel.confirm.message')}','${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=updateCancelStop&fdTaskId=${JsParam.fdId}');
								}else{
									dialog.alert("${lfn:message('sys-task:button.closeTask.confirm.message2')}");
									return;
								}
							},'json');
				};
				window.overrule = function(){
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=isClose&fdTaskId=${JsParam.fdId}"/>',
							function(data){
								if(data!=null && data.isClose =="false"){
									Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_overrule/sysTaskOverrule.do?method=add&fdTaskId=${JsParam.fdId}','_blank');
								}else{
									dialog.alert("${lfn:message('sys-task:button.closeTask.confirm.message2')}");
									return;
								}
							},'json');
				};
				window.editDoc = function(){
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=isClose&fdTaskId=${JsParam.fdId}"/>',
							function(data){
								if(data!=null && data.isClose =="false"){
									if ('${JsParam.fdModelName}'==''){
										Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=edit&flag=${JsParam.flag}&fdId=${JsParam.fdId}','_self');
									}else{
										Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=edit&flag=${JsParam.flag}&fdId=${JsParam.fdId}&fdModelName=${JsParam.fdModelName}','_self');										
									}
								}else{
									dialog.alert("${lfn:message('sys-task:button.closeTask.confirm.message2')}");
									return;
								}
							},'json');
				};
				//设为关注
				window.attention=function(){
					window._load = dialog.loading();
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=updateAttention&fdTaskId=${JsParam.fdId}"/>',
						function(data){ 
							if(window._load!=null)
								window._load.hide();
							if(data!=null && data.status==true){
								dialog.success('<bean:message key="button.attention.message" bundle="sys-task"/>');
								 LUI('toolbar').removeButton(LUI('attention'));
								 LUI('toolbar').addButtons([toolbar.buildButton({text:'${lfn:message("sys-task:sysTask.button.disAttention")}',id:'disAttention',click:'disAttention()',order:'4'})]);
							}else{
								dialog.failure('<bean:message key="return.optFailure" />');
							}
						},'json');
				};
				//取消关注
				window.disAttention=function(){
					window._load = dialog.loading();
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=updateAttention&fdTaskId=${JsParam.fdId}&isAttention=true"/>',
						function(data){
							if(window._load!=null)
								window._load.hide();
							if(data!=null && data.status==true){
								dialog.success('<bean:message key="button.noattention.message" bundle="sys-task" />');
								 LUI('toolbar').removeButton(LUI('disAttention'));
								 LUI('toolbar').addButtons([toolbar.buildButton({text:'${lfn:message("sys-task:button.attention")}',id:'attention',click:'attention()',order:'4'})]);
							}else{
								dialog.failure('<bean:message key="return.optFailure" />');
							}
						},'json');
				};
				//任务结项
				window.closeTask=function(){
					var msg="${lfn:message('sys-task:button.closeTask.confirm.message')}";
					dialog.confirm(msg,function(value){
						if(value==true){
							window._load = dialog.loading();
							$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=closeTask&fdId=${JsParam.fdId}"/>',
								function(data){
									if(window._load!=null)
										window._load.hide();
									if(data!=null && data.status==true){
										dialog.success('<bean:message key="sysTaskMain.status.close" bundle="sys-task"/>');
										 window.location.reload();
										 topic.publish("successReloadPage");
									}else{
										dialog.failure('<bean:message key="return.optFailure" />');
									}
								},'json');
						}
					});
				};
				//复制任务
				window.copyDoc=function(parentId){
					var copyTaskUrl = '${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=copyTask&fdTaskId=${JsParam.fdId}';
					var copyChildTaskUrl = '${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=copyChildTask&fdTaskId=${JsParam.fdId}&fdParentTaskId='+parentId+'&flag=${JsParam.flag}';
					if (parentId != null && parentId != "") {
						dialog.iframe('/sys/task/sys_task_ui/sysTaskMain_copyTask_iframe.jsp',
								"<bean:message key='ui.dialog.operation.title' bundle='sys-ui'/>",
								function (value){
									
								},{width:436,height:218,params:{copyTaskUrl:copyTaskUrl,copyChildTaskUrl:copyChildTaskUrl,data:parentId,dialog:dialog}}
						);
					} else {
						$.post('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=checkAuth&checkUrl',
							function(checkAuth){
								if (checkAuth != null && checkAuth.haveAuth == "true") {
									Com_OpenWindow(copyTaskUrl,'_blank');
								} else {
									dialog.alert("${lfn:message('sys-task:button.copy.confirm.message3')}");
								}
						},'json');
					}
				};
				//确认框
				window.LUIconfirm=function(msg,url){
					window.taskURL=url;
					dialog.confirm(msg,function(value){
						if(value==true){
							Com_OpenWindow(window.taskURL,"_self");
						}
					});
				};
				//任务分解级别不能超过3层
				window.checkLeverNumber=function(){
					var lever = ${currentLevel};
					var fdMaxLevel = "${fdLevel}";
					if(lever >= fdMaxLevel){
						dialog.alert("${ lfn:message('sys-task:sysTaskMain.lever.message1')}"+fdMaxLevel+"${ lfn:message('sys-task:sysTaskMain.lever.message2')}");
						return false;
					}
					return true;
				};
				//展开、收起
				window.showMoreSet=function(){
					if(document.getElementById("show_more_set_id").style.display==""){
						document.getElementById("showMoreSet").className ="task_slideDown";
						document.getElementById("showMoreSet").innerHTML="<bean:message bundle='sys-task' key='sysTaskMain.more.set.slideDown' />";
						document.getElementById("show_more_set_id").style.display="none";
					}else{
						document.getElementById("showMoreSet").className ="task_slideUp";
						document.getElementById("showMoreSet").innerHTML="<bean:message bundle='sys-task' key='sysTaskMain.more.set.slideUp' />";
						document.getElementById("show_more_set_id").style.display="";
					}
				};
			});
		</script>
		<html:form action="/sys/task/sys_task_main/sysTaskMain.do">
			<html:hidden property="fdId" />
			<html:hidden property="docStatus" />
			<html:hidden property="fdRootId" />
			<html:hidden property="docCreatorId" />
			<html:hidden property="fdWorkId" />
			<html:hidden property="fdPhaseId" />
			<html:hidden property="fdModelId" /> 
			<html:hidden property="fdModelName" />
			<html:hidden property="fdKey" />
			<html:hidden property="method_GET" />
			<div class="lui_form_content_frame" >
				<p class="lui_form_subject">
					<bean:message bundle="sys-task" key="table.sysTaskMain" />
				</p>
				<table class="tb_normal" width=100%>	
					<tr>
						<td colspan="4" >
							<iframe width="100%" height="400px" frameborder="0" scrolling="auto"  src='<c:url value="/sys/task/import/taskChart4Pc.jsp" />?fdId=${JsParam.fdId}'></iframe>
						</td>
					</tr>
					
					<tr>
						<%--任务名称--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="sys-task" key="sysTaskMain.docSubject" />
						</td>
						<td width="35%">
							<c:out value="${sysTaskMainForm.docSubject}" />
						</td>
						<%--指派人--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-task" key="sysTaskMain.fdAppoint" />
						</td>
						<td width="35%">
							<c:out value="${sysTaskMainForm.fdAppointName}" />
						</td>
					</tr>
					<tr>
						<%--接收人--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-task" key="table.sysTaskMainPerform" />
						</td>
						<td width=35%>
							<c:choose>
				                <c:when test="${haveReject == true }">
				                	<c:forEach items="${performList}" var="perform" varStatus="vstatus">
				                		<c:out value="${perform.fdName }" />
				                		<c:if test="${perform.isReject == 'true' }">
				                			（<bean:message key="sysTaskMain.showReject.txt1" arg0="${perform.rejectUser }" bundle="sys-task"/>
				                			<a title="${lfn:message('sys-task:sysTaskMain.showReject.txt2')}" onclick="showRejectList('${perform.fdId }')">
				                			<span class="com_btn_link">${lfn:message('sys-task:sysTaskMain.showReject.txt2')}</span></a>）
				                		</c:if>
				                		<c:if test="${!vstatus.last }">;</c:if>
				                	</c:forEach>
				                </c:when>
				                <c:otherwise>
				                	<c:out value="${sysTaskMainForm.fdPerformName}" />
				                </c:otherwise>
				            </c:choose>
						</td>
						<%--抄送人--%>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="sys-task" key="sysTaskMainCc.fdCcId" />
						</td>
						<td width="35%">
							<c:out value="${sysTaskMainForm.fdCcNames}" />
						</td>
					</tr>					
					<kmss:ifModuleExist path="/third/ywork/">
					<tr id="fdWeiXinExecutor">
					    <%--外部参与人--%>
                        <td class="td_normal_title" width=15%>
                            <bean:message bundle="sys-task" key="sysTaskMain.outParticipant" />
                        </td>
                        <td width=35% colspan="3">
                            <bean:message bundle="sys-task" key="sysTaskMain.fdWeiXinExecutor" />:
                            ${sysTaskMainForm.fdWeiXinExecutorJson}
                            <br><bean:message bundle="sys-task" key="sysTaskMain.fdWeiXinRelevantPerson" />:
                            ${sysTaskMainForm.fdWeiXinRelevantPersonJson}
                            <br><font color="red"><bean:message bundle="sys-task" key="sysTaskMain.note" /></font>
                        </td>
					</tr>
					</kmss:ifModuleExist>
					<tr>
						<%--要求完成时间--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-task" key="sysTaskMain.fdPlanCompleteTime" />
						</td>
						<td width=35%>
							<c:out value="${sysTaskMainForm.fdPlanCompleteDate}" />&nbsp;<c:out value="${sysTaskMainForm.fdPlanCompleteTime}" />
						</td>
						<%--是否过期--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-task" key="sysTaskMain.pastdue.yesno"/>
						</td>
						<td width=35%>
							<sunbor:enumsShow value="${sysTaskMainForm.fdPastDue}" enumsType="sys_task_yesno"></sunbor:enumsShow>
						</td>
					</tr>
					
					<tr>
						<%--上级任务--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-task" key="sysTaskMain.fdParentId" />
						</td>
						<td width=35% colspan="3"><c:choose> 
							<c:when test="${sysTaskMainForm.fdParentName != null}">
								<a class="com_btn_link" href="${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId=${sysTaskMainForm.fdParentId}"  target="_self">
									<c:out value="${sysTaskMainForm.fdParentName}" />
								</a>
							</c:when>
							<c:otherwise>
								<bean:message bundle="sys-task" key="sysTaskMain.no.message"/>
							</c:otherwise>
						</c:choose></td>
					</tr>
					<tr>
						<%--任务来源--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-task" key="sysTaskMain.fdSourceSubject" />
						</td>
						<td colspan="3"><c:choose>
							<c:when test="${not empty sysTaskMainForm.fdSourceSubject && not empty sysTaskMainForm.fdSourceUrl}">
								<a class="com_btn_link" data-href='<c:url value="${sysTaskMainForm.fdSourceUrl}"/>' target="_blank" onclick="Com_OpenNewWindow(this)" >
									<c:out value="${sysTaskMainForm.fdSourceSubject}" />
								</a>
							</c:when>
							<c:when test="${not empty sysTaskMainForm.fdSourceSubject && empty sysTaskMainForm.fdSourceUrl}">
								<c:out value="${sysTaskMainForm.fdSourceSubject}" />
							</c:when>
							<c:otherwise>
								<bean:message bundle="sys-task" key="sysTaskMain.no.message"/>
							</c:otherwise>
						</c:choose></td>
					</tr>
					<tr>
						<%--任务状态--%>
						<td class="td_normal_title" width=15%>
							<bean:message key="sysTaskMain.fdStatus" bundle="sys-task" />
						</td>
						<td width=35%>
							<kmss:showTaskStatus taskStatus="${sysTaskMainForm.fdStatus}" showText= "true" />
						</td>
						<%--任务进度--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-task" key="sysTaskFeedback.fdProgress" />
						</td>
						<td width=35%>
							<c:out value="${sysTaskMainForm.fdProgress}" />%
							<div class='pro_barline'>
								<c:if test="${sysTaskMainForm.fdProgress=='100' }">
									<div class='complete' style="width:${sysTaskMainForm.fdProgress}%"></div>
								</c:if>
								<c:if test="${sysTaskMainForm.fdProgress!='100' }">
									<div class='uncomplete' style="width:${sysTaskMainForm.fdProgress}%"></div>
								</c:if>
							</div>
							<%--更新进度按钮--%>
							<c:if test="${sysTaskMainForm.fdStatus != '6' && sysTaskMainForm.fdStatus != '4'  && childSize==0 }">
							<kmss:auth
								requestURL="/sys/task/sys_task_feedback/sysTaskFeedback.do?method=add&flag=${param.flag}&fdTaskId=${param.fdId}"
								requestMethod="GET">
								<ui:button text="${lfn:message('sys-task:button.feedback.progress')}"  style="margin-left:10px;"
									onclick="feedback();">
								</ui:button>
							</kmss:auth>
							</c:if>
							
						</td>
					</tr>
					<tr>
						<%--任务内容描述--%>
						<td class="td_normal_title" width=15% valign="middle">
							<bean:message bundle="sys-task" key="sysTaskMain.docContent" />
						</td>
						<td width=35% colspan="3">
							<xform:rtf property="docContent"></xform:rtf>
						</td>
					</tr>
					<tr>
						<%--附件--%>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-task" key="sysTaskMain.attachment" />
						</td>
						<td width=35% colspan=3>
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attachment" />
								<c:param name="formBeanName" value="sysTaskMainForm" />
							</c:import>
						</td>
					</tr>
					<!-- 督办模块扩展字段 -->
					<kmss:ifModuleExist path="/km/supervise/">
						<c:if test="${sysTaskMainForm.fdModelName == 'com.landray.kmss.km.supervise.model.KmSuperviseMain'}">
							<c:import url="/km/supervise/import/kmSupervise_task_view.jsp" charEncoding="UTF-8">
							</c:import>
						</c:if>
					</kmss:ifModuleExist>
					
					<tr>
						<%--更多设置按钮--%>
						<td colspan="4" style="text-align: center;">
							<a href="javascript:void(0);" onclick="showMoreSet();" id="showMoreSet"  class="task_slideDown"><bean:message bundle='sys-task' key='sysTaskMain.more.set.slideDown' /></a>
						</td>
					</tr>
					<tr id="show_more_set_id" style="display: none">
						<%--设置--%>
						<td width="100%" colspan=4 style="padding: 0px;">
							<table width="100%" class="tb_normal" height="100%" cellspacing="1" cellpadding="5">
								<tr>
									<%--权限范围仅限此文档 --%>
									<td class="td_normal_title" colspan="4" width="15%">
										<c:choose>
											<c:when test="${sysTaskMainForm.fdResolveFlag == 'true'}">
												<input type="checkbox" checked disabled/>
											</c:when>
											<c:otherwise>
												<input type="checkbox"  disabled/>
											</c:otherwise>
										</c:choose>
										<bean:message bundle="sys-task" key="sysTaskMain.fdResolveFlag" />						
										<span class="com_help"><bean:message bundle="sys-task" key="sysTaskMain.fdResolveFlag.help" /></span>
									</td>
								</tr>
								<%--当前进度
								<tr>
									<td class="td_normal_title" width="15%">
										<bean:message bundle="sys-task" key="sysTaskFeedback.fdProgress" />
									</td>
									<td width=85% colspan=3><c:choose>
										<c:when test="${sysTaskMainForm.fdProgressAuto == 'true'}">
											<input type="checkbox" checked disabled/>
										</c:when>
										<c:otherwise>
											<input type="checkbox"  disabled/>
										</c:otherwise>
									</c:choose><bean:message bundle="sys-task" key="sysTaskMain.fdProgressAuto" /></td>
								</tr>
								--%>
								<html:hidden property="fdProgressAuto"/>
								
								<tr>
									<%--任务类型--%>
									<td class="td_normal_title" width="15%">
										<bean:message key="sysTaskMain.fdCategoryId" bundle="sys-task" />
									</td>
									<c:choose>
										<c:when test="${sysTaskMainForm.fdParentId != null}">
											<td width="35%">							
												<c:out value="${sysTaskMainForm.fdCategoryName}" />
											</td>
											<%--如果存在父任务,显示权重--%>
											<td class="td_normal_title" width=15%>
												<bean:message bundle="sys-task" key="sysTaskMain.fdWeights" />
											</td>
											<td width=35% class="taskPercent"><c:out value="${sysTaskMainForm.fdParentWeights}"/>%</td>
										</c:when>
										<c:otherwise>
											<td width=85% colspan=3>
												<c:out value="${sysTaskMainForm.fdCategoryName}" />
											</td>
										</c:otherwise>
									</c:choose>									
								</tr>
								<%--可阅读者
								<tr>
									<td class="td_normal_title" width="15%">
										<bean:message bundle="sys-task" key="sysTaskMainReader.docReaderIds" />
									</td>
									<td  colspan=3><c:out value="${sysTaskMainForm.docReaderNames}"/></td>
								</tr>
								--%>
								<tr>
									<%--通知方式--%>
									<td class="td_normal_title" width="15%">
										<bean:message bundle="sys-task" key="sysTaskMain.fdNotifyType" />
									</td>
									<td width="35%" colspan=3>
										<kmss:showNotifyType value="${sysTaskMainForm.fdNotifyType}" />
									</td>
								</tr>
								<tr>
									<%--创建者--%>
									<td class="td_normal_title" width=15%>
										<bean:message bundle="sys-task" key="sysTaskMain.docCreatorId" />
									</td>
									<td width=35%>
										<c:out value="${sysTaskMainForm.docCreatorName}" />
									</td>
									<%--创建时间--%>
									<td class="td_normal_title" width=15%>
										<bean:message bundle="sys-task" key="sysTaskMain.docCreateTime" />
									</td>
									<td width=35%>
										<c:out value="${sysTaskMainForm.docCreateTime}" />
									</td>
								</tr>
							</table>		
						</td>	
					</tr>
				</table>
			</div>
			
			<ui:tabpage expand="false" >
				<%--执行反馈页签--%>
				<ui:content title="${lfn:message('sys-task:tag.feedback')}" expand="true">
					<ui:event event="show"> 
						document.getElementById("feedbackList").src= '<c:url value="/sys/task/sys_task_feedback_ui/sysTaskFeedback_list.jsp" />?fdTaskId=${JsParam.fdId}&feedbackcount=${feedbackcount}';
					</ui:event>
					<iframe id="feedbackList" width=100% height=100% frameborder=0 scrolling=no></iframe>
				</ui:content>
				<%--评价页签 --%>
				<ui:content title="${lfn:message('sys-task:tag.evaluate')}">
					<ui:event event="show"> 
						document.getElementById("evaluateList").src= '<c:url value="/sys/task/sys_task_evaluate_ui/sysTaskEvaluate_list.jsp" />?fdTaskId=${JsParam.fdId}';
					</ui:event>
					<iframe id="evaluateList" width=100% height=100% frameborder=0 scrolling=no></iframe>
				</ui:content>
				<%-- 驳回记录--%>
				<ui:content title="${lfn:message('sys-task:sysTaskOverrule.record')}">
					<ui:event event="show" > 
						document.getElementById("overruleList").src= '<c:url value="/sys/task/sys_task_overrule_ui/sysTaskOverrule_list.jsp" />?fdTaskId=${JsParam.fdId}';;
					</ui:event>
					<iframe id="overruleList" width=100% height=100% frameborder=0 scrolling=no></iframe>
				</ui:content>
				<kmss:ifModuleExist  path = "/km/collaborate/">
				<%request.setAttribute("communicateTitle",ResourceUtil.getString("sysTaskMain.taskCommunicate","sys-task"));%>
				<%--沟通与代办 --%>
				
				<c:import url="/km/collaborate/import/kmCollaborateMain_view.jsp" charEncoding="UTF-8">
					<c:param name="commuTitle"	value="${communicateTitle}" />
					<c:param name="formName" value="sysTaskMainForm" />
					<c:param name="docSubject" value="${sysTaskMainForm.docSubject}" />
				</c:import>
				</kmss:ifModuleExist>
				<%--阅读机制 --%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="sysTaskMainForm" />
				</c:import>
				<%--日程机制--%>
				<c:if test="${sysTaskMainForm.syncDataToCalendarTime=='submit'}">
					<ui:content title="${ lfn:message('sys-agenda:module.sys.agenda.syn') }" >
						<table class="tb_normal" width=100%>
							<%--同步时机--%>
							<tr>
								<td class="td_normal_title" width="15%">
							 		<bean:message bundle="sys-agenda" key="module.sys.agenda.syn.time" />
							 	</td>
							 	<td colspan="3">
							 		<xform:radio property="syncDataToCalendarTime">
						       			<xform:enumsDataSource enumsType="sysTaskMain_syncDataToCalendarTime" />
									</xform:radio>
								</td>
							</tr>
							<%--日程(普通模式)--%>
							<tr>
								<td colspan="4" style="padding: 0px;">
								 	<c:import url="/sys/agenda/import/sysAgendaMain_general_view.jsp"	charEncoding="UTF-8">
								    	<c:param name="formName" value="sysTaskMainForm" />
								    	<c:param name="fdKey" value="reviewMainDoc" />
								    	<c:param name="fdPrefix" value="sysAgendaMain_formula_view" />
								 	</c:import>
						 		</td>
						 	</tr>
						</table>
					</ui:content>
				</c:if>
				<!-- 分享机制  -->
				<kmss:ifModuleExist path="/third/ywork/">
					<c:import url="/third/ywork/ywork_share/yworkDoc_share.jsp"
						charEncoding="UTF-8">
						<c:param name="modelId" value="${sysTaskMainForm.fdId}" />
						<c:param name="modelName" value="com.landray.kmss.sys.task.model.SysTaskMain" />
						<c:param name="showRecord" value="false" />
					</c:import>
				</kmss:ifModuleExist>
			</ui:tabpage>
		</html:form>
	</template:replace>
</template:include>
<!-- 外部参与人显示控制 -->
<kmss:ifModuleExist path="/third/ywork/">
	<script type="text/javascript">
		flowShow();
		function flowShow(){
			var processId = '${sysTaskMainForm.fdId}';
			var taskId = "";
			var url = '<c:url value="/third/ywork/ywork_doc/yworkDoc.do?method=isMFlowVisible" />'+"&processId="+processId+"&taskId="+taskId;
			$.post(url,function(data){
				status = data.status;
				if(data.status=="1"){
					$("#fdWeiXinExecutor").show();
				}else{
					$("#fdWeiXinExecutor").hide();
				}
			},"json");
		}
	</script>
</kmss:ifModuleExist>