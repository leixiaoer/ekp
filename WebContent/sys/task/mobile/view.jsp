<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ page import="com.landray.kmss.sys.task.util.SysTaskMainLevelUtil" %>
<%request.setAttribute("fdLevel",SysTaskMainLevelUtil.getfdLevel());%>
<template:include ref="mobile.view" compatibleMode="true" isNative="true">
	<template:replace name="head">
		<mui:min-file name="mui-task-view.css"/>
	    <mui:min-file name="mui-task.js"/>
	    <link rel="stylesheet" href="<%=request.getContextPath()%>/sys/task/mobile/resource/css/view_new.css?s_cache=${MUI_Cache}">
	</template:replace>
	<template:replace name="title">
		<c:if test="${not empty sysTaskMainForm.docSubject}">
			<c:out value="${ sysTaskMainForm.docSubject}"></c:out>
		</c:if>
		<c:if test="${empty sysTaskMainForm.docSubject}">
			<c:out value="${lfn:message('sys-task:module.sys.task') }"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="content">
		<div id="scrollView"  class="gray"
			data-dojo-type="mui/view/DocScrollableView"
			data-dojo-mixins="mui/list/_ViewPushAppendMixin">
			<xform:text property="docCreateTime" showStatus="noShow"></xform:text>
			<div class="muiTaskInfoBanner">
				<dl class="txtInfoBar">
					<dt>
						<!-- 任务名称 -->
						<xform:text property="docSubject"></xform:text>
					</dt>
					<!-- <dd> -->
						<!-- 进度 -->
						<!-- <div class="progressBar"> -->
							<%-- <span class="progressStatus">
								<div class="progresstxt">
									<span>${lfn:message('sys-task:sysTaskMain.fdProgress')}:</span>
									<c:out value=" ${sysTaskMainForm.fdProgress}"></c:out>
									<span class="percentage">%</span>
								</div>
							</span>  --%>
						<!-- </div> -->
					<!-- </dd> -->
					<dd class="task_date">
						<!-- <i class="mui mui-meeting_date"></i> -->
						<!-- 截止时间 -->
						${lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime')}:
						<xform:datetime property="fdPlanCompleteDate" dateTimeType="date"></xform:datetime>&nbsp;
						<xform:datetime property="fdPlanCompleteTime" dateTimeType="time"></xform:datetime>
						<!-- 截止日期 -->
						<span class="deadLineunit"></span>
						
					</dd>
					<dd>
						<!-- 任务来源 -->
						<c:if test="${not empty sysTaskMainForm.fdSourceSubject && (not empty sysTaskMainForm.fdSourceUrl || not empty sysTaskMainForm.fdSourceType)}">
							<c:if test="${sysTaskMainForm.fdSourceType=='KK_IM'}">
								<c:set var="muiTaskKKIMSource" value="muiTaskKKIMSource"></c:set>
							</c:if>
							<div class="muiTaskLink ${muiTaskKKIMSource }" ontouchstart="onSourceClick()">
									<span class="muiTaskLinkTitle">
										<bean:message bundle="sys-task" key="sysTaskMain.fdSourceSubject" />
									</span>
									<span class="muiTaskLinkSubject">
										<c:out value="${sysTaskMainForm.fdSourceSubject}" />
									</span>
									<span class="muiTaskLinkR">
										<i class="muiAttachmentItemExpand mui mui-forward"></i>
									</span>
								
							</div>
						</c:if>
					</dd>
				</dl> 
				<%-- 状态 --%>
				<%-- <span class="viewTaskStatus">
					<c:import url="/sys/task/mobile/import/status.jsp" charEncoding="UTF-8">
						<c:param name="status" value="${ sysTaskMainForm.fdStatus}"></c:param>
					</c:import>
				</span>  --%>
				<div class="TaskProgress">
					<div class="progressClip">
						<div class="progressLeft"></div>
						<div class="progressRight rightHidden"></div>
					</div>
					<div class="progressValue"></div>
				</div>
			</div>
			<div data-dojo-type="mui/fixed/Fixed" id="fixed">
				<div data-dojo-type="mui/fixed/FixedItem">
					<%--切换页签--%>
					<div class="muiHeader">
						<div
							data-dojo-type="mui/nav/MobileCfgNavBar" 
							data-dojo-props="defaultUrl:'/sys/task/mobile/view_nav.jsp?feedbackcount=${feedbackcount}' ">
						</div>
					</div>
				</div>
			</div>

			<%--任务内容页签--%>
			<div id="contentView" data-dojo-type="dojox/mobile/View">		
				<div class="sysTaskPanel" data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false">
					<div class="muiTaskPanel" data-dojo-type="mui/panel/Content"  data-dojo-props="title:'${lfn:message('sys-task:sysTaskMain.docContent')}',icon:'mui-docRecord'">
						<div class="txtContent">
							<%--任务内容--%>
							<div class="muiTaskContentDiv">
								<xform:rtf property="docContent" mobile="true"></xform:rtf>
								<%-- 后续考虑提取成“空内容组件”--%>
								<c:if test="${empty sysTaskMainForm.docContent }">
									<div class="muiListNoDataArea">
										<div class="muiListNoDataInnerArea">
											<div class="muiListNoDataContainer muiListNoDataIcon">
											<i class="mui mui_taskComment"></i></div>
										</div>
										<div class="muiListNoDataTxt">
											${lfn:message('sys-task:mui.sysTaskMain.no.content')}
										</div>
									</div>
								</c:if>
							</div>
						
							<c:if test="${not empty sysTaskMainForm.fdSourceSubject && empty sysTaskMainForm.fdSourceUrl}">
								<div class="muiTaskLink">
									<div class="muiTaskLinkTitle">
										<bean:message bundle="sys-task" key="sysTaskMain.fdSourceSubject" />
									</div>
									<div class="muiTaskLinkSubject">
										<c:out value="${sysTaskMainForm.fdSourceSubject}" />
									</div>
								</div>
							</c:if>
						</div>
					</div>
					
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
		            	<c:param name="fdKey" value="attachment"/>
		            	<c:param name="formName" value="sysTaskMainForm"/>
		            </c:import> 
		       		
       				<%-- 上级任务 --%>
					<c:if test="${sysTaskMainForm.fdParentName != null}">
						<div class="viewParentTask" ontouchstart="window.location.href='../sys_task_main/sysTaskMain.do?method=view&fdId=${sysTaskMainForm.fdParentId}'">
							<span class="ParentTaskTitle">
								<bean:message bundle="sys-task" key="sysTaskMain.fdParentId" />
							</span>
							<span class="ParentTaskSubject">
								<c:out value="${sysTaskMainForm.fdParentName}" />
							</span>
							<span class="ParentTaskR">
								<i class="muiAttachmentItemExpand mui mui-forward"></i>
							</span>
						</div>
					</c:if>
					<!-- 相关人员 -->
		            <div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('sys-task:mui.sysTaskMain.related.members')}',icon:'mui-memberGroup'">
						<div class="txtContent">
							<ul class="muiTaskList performPersonContainer">
								<%--指派人--%>
								<li>
									<div data-dojo-type="mui/person/PersonList"
										data-dojo-props="title:'${lfn:message('sys-task:sysTaskMain.fdAppoint')}',detailTitle:'${lfn:message('sys-task:sysTaskMain.fdAppoint')}',personId:'${sysTaskMainForm.fdAppointId }'">
									</div>
								</li>
								<%--负责人--%>
								<li>
									<div data-dojo-type="mui/person/PersonList"
										data-dojo-props="title:'${lfn:message('sys-task:sysTaskMain.fdPerform')}',detailTitle:'${lfn:message('sys-task:sysTaskMain.fdPerform')}',personId:'${sysTaskMainForm.fdPerformId }'">
									</div>
								</li>
								<c:if test="${not empty sysTaskMainForm.fdCcIds }">
								<%--抄送人--%>
								<li>
									<div data-dojo-type="mui/person/PersonList"
										data-dojo-props="title:'${lfn:message('sys-task:sysTaskMainPerform.toSysOrgCc')}',detailTitle:'${lfn:message('sys-task:sysTaskMainPerform.toSysOrgCc')}',personId:'${sysTaskMainForm.fdCcIds }'">
									</div>
								</li>
								</c:if>
							</ul>
						</div>
					</div>
					
				</div>
			</div>
			
			<%--子任务页签--%>
			<div id="childTaskView"  data-dojo-type="dojox/mobile/View" data-dojo-mixins="sys/task/mobile/resource/js/ResizeViewMixin">
			    <ul id="tableFdChildTask" data-dojo-type="sys/task/mobile/resource/js/list/SysTaskJsonStoreList" 
			    	data-dojo-mixins="sys/task/mobile/resource/js/list/CalendarItemListMixin"
			    	data-dojo-props="url:'/sys/task/sys_task_main/sysTaskIndex.do?method=list&orderby=docCreateTime&ordertype=down&parentTaskId=${sysTaskMainForm.fdId }'">
				</ul>
			</div>
			<%--反馈页签--%>
			<div id="feedbackView"  data-dojo-type="dojox/mobile/View">
				<div class="sysTaskPanel" data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false">
					<div data-dojo-type="mui/panel/Content"  data-dojo-props="title:'${lfn:message('sys-task:mui.sysTaskMain.feedback')}',icon:'mui-feedbackMsg'">
						<ul data-dojo-type="sys/task/mobile/resource/js/list/SysTaskJsonStoreList" 
					    	data-dojo-mixins="sys/task/mobile/resource/js/list/FeedbackItemListMixin"
					    	data-dojo-props="url:'/sys/task/sys_task_feedback/sysTaskFeedback.do?method=list&fdTaskId=${sysTaskMainForm.fdId}',lazy:false">
						</ul>
					</div>
					<div data-dojo-type="mui/panel/Content"  data-dojo-props="title:'${lfn:message('sys-task:button.evaluate')}',icon:'mui-thumbsUp'">
						<ul data-dojo-type="sys/task/mobile/resource/js/list/SysTaskJsonStoreList" 
					    	data-dojo-mixins="sys/task/mobile/resource/js/list/EvaluateItemListMixin"
					    	data-dojo-props="url:'/sys/task/sys_task_evaluate/sysTaskEvaluate.do?method=list&fdTaskId=${sysTaskMainForm.fdId}',lazy:false">
						</ul>
					</div>
				</div>
			</div>
			
			<%--分解图页签--%>
			<div id="picView" data-dojo-type="dojox/mobile/View">
				<%--任务分解图/责任分解图选项--%>
       			<div class="sysTask_analyse">
					<iframe width="100%" height="400px" frameborder="0" scrolling="auto" id="readFrame" ></iframe>
				</div>
			</div>
			<!-- 底部页签 -->
			<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" id ="toobarGrops">
			  	<!-- 未结项的任务才可以进行执行反馈、任务评价、更新进度、终止任务/取消终止、分解子任务、编辑、驳回任务等操作 -->
			  	<!-- 编辑 -->
		       <%-- <c:if test="${sysTaskMainForm.fdStatus != '6' }">
					<kmss:auth
						requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=edit&flag=${param.flag}&fdId=${param.fdId}"
						requestMethod="GET">
						<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit " 
						 	 data-dojo-props='colSize:2,href:"/sys/task/sys_task_main/sysTaskMain.do?method=edit&flag=${param.flag}&fdId=${param.fdId}",transition:"slide"'>编辑</li>
					</kmss:auth>
				</c:if> --%>
					<c:if test="${sysTaskMainForm.fdStatus != '6' }">
						<c:if test="${sysTaskMainForm.fdStatus != '4' }">
						<%-- 执行反馈 --%>
						
						<kmss:auth
							requestURL="/sys/task/sys_task_feedback/sysTaskFeedback.do?method=add&flag=${param.flag}&fdTaskId=${param.fdId}"
							requestMethod="GET">
							<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtn muiBtnFeedback" 
			  					data-dojo-props="href:'/sys/task/sys_task_feedback/sysTaskFeedback.do?method=add&fdTaskId=${param.fdId}'">${lfn:message('sys-task:button.feedback')}</li>
		  				</kmss:auth>
		  				</c:if>
		  				<%-- 任务评价 --%>
				  		<kmss:auth
							requestURL="/sys/task/sys_task_evaluate/sysTaskEvaluate.do?method=add&flag=${param.flag}&fdTaskId=${param.fdId}"
							requestMethod="GET">
			  				<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtn muiBtnComplete" 
			  					data-dojo-props="href:'/sys/task/sys_task_evaluate/sysTaskEvaluate.do?method=add&fdTaskId=${param.fdId}'">${lfn:message('sys-task:button.evaluate')}</li>
			  			</kmss:auth>
		  				<%-- 分解任务 --%>
		  				<c:if test="${sysTaskMainForm.fdStatus != '4' && sysTaskMainForm.fdStatus != '3' }">
							<c:if test="${sysTaskMainForm.fdResolveFlag != 'true' }">
								<kmss:auth
									requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=addChildTask&fdTaskId=${param.fdId}&flag=${param.flag}"
									requestMethod="GET">
			  							<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtn muiBtnFeedback" 
		  									data-dojo-props="href:'javascript:addChild();'">${lfn:message('sys-task:button.sub.task')}</li>
				  				</kmss:auth>	
				  			</c:if>
				  		</c:if>
				  		<!-- 重启任务 -->
				  		<kmss:auth
							requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=updateStop&fdTaskId=${param.fdId}"
							requestMethod="GET">
							<c:if test="${sysTaskMainForm.fdStatus == '4'}">
								<li onclick="updateCancelStop();" data-dojo-type="mui/tabbar/TabBarButton" class="muiBtn muiBtnFeedback" 
		  									data-dojo-props="">${lfn:message('sys-task:button.cancel.terminate')}</li>
							</c:if>
						</kmss:auth>
				  		<!-- 任务结项 -->
				  		<c:if test="${sysTaskMainForm.fdStatus != '6'}">
				  			<c:if test="${sysTaskMainForm.fdStatus == '4'|| sysTaskMainForm.fdStatus == '3'}">
								<kmss:auth
									requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=closeTask&flag=${param.flag}&fdId=${param.fdId}"
									requestMethod="GET">
									<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtn muiBtnFeedback" 
												data-dojo-mixins="sys/task/mobile/resource/js/CloseTaskTabBarMixins"
			  									data-dojo-props="fhref:'${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=closeTask&flag=${param.flag}&fdId=${param.fdId}'">${lfn:message('sys-task:button.closeTask')}</li>
								</kmss:auth>
							</c:if>
						</c:if>
				  		<!-- 其他 -->
				  		<c:if test="${sysTaskMainForm.fdStatus != '4' && sysTaskMainForm.fdStatus != '6'}">
		  					<kmss:auth
								requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=addChildTask&fdTaskId=${param.fdId}&flag=${param.flag}"
								requestMethod="GET">
		  							 <li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtn muiBtnFeedback" 
		  							  id="otherListBtn"
	  									data-dojo-props="">${lfn:message('sys-task:button.other')}</li> 
			  				</kmss:auth>
					  	</c:if>
	  				</c:if>
	  				<!-- 关注 -->
	  				<c:if test="${sysTaskMainForm.fdStatus == '6' ||sysTaskMainForm.fdStatus=='4'}">
						<li data-dojo-type="mui/tabbar/TabBarButton"
							data-dojo-mixins="sys/task/mobile/resource/js/_AttentionTabBarButtonMixin"
							data-dojo-props="label:'${lfn:message('sys-task:mui.sysTaskMain.join.attention')}',fdId:'${param.fdId}',hasAttention:${isAttention}"></li>
					</c:if>
					<li id="attentionShow" style="display:none;" data-dojo-type="mui/tabbar/TabBarButton"
						data-dojo-mixins="sys/task/mobile/resource/js/_AttentionTabBarButtonMixin"
						data-dojo-props="label:'${lfn:message('sys-task:mui.sysTaskMain.join.attention')}',fdId:'${param.fdId}',hasAttention:${isAttention}"></li>
					
			</ul>
		</div>
	<!-- 底部弹出窗 -->
	<div id="sysTaskMian_otherBox" style="display:none;" >
  		<div id="sysTaskMain_other" class="sysTaskMain_other">
			<ul>
				<!-- 标记完成  -->				  				
 				<c:if test="${sysTaskMainForm.fdStatus != '4' }">
	  				<c:if test="${sysTaskMainForm.fdStatus != '3' && childSize == 0  }">
		  				<kmss:auth
								requestURL="/sys/task/sys_task_feedback/sysTaskFeedback.do?method=updateFinish&flag=${param.flag}&fdTaskId=${param.fdId}"
								requestMethod="GET" >
		  					<li data-dojo-type="mui/tabbar/TabBarButton" onclick="window.complete()" id="completeNode">	
				  					<span >${lfn:message('sys-task:mui.sysTaskMain.mark.completed')}</span>		
		  					</li>
		  				</kmss:auth>
	  				</c:if>
  				</c:if>
  				<!-- 任务结项 -->
  				<c:if test="${sysTaskMainForm.fdStatus != '3' }">
						<kmss:auth
							requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=closeTask&flag=${param.flag}&fdId=${param.fdId}"
							requestMethod="GET">
							<li data-dojo-type="mui/tabbar/TabBarButton" onclick="closeTask(true);">
								${lfn:message('sys-task:button.closeTask')}
							</li>
						</kmss:auth>
				</c:if>
					<%--暂停任务--%>
				<kmss:auth
							requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=updateStop&fdTaskId=${param.fdId}"
							requestMethod="GET">
					<c:if test="${sysTaskMainForm.fdStatus != '4' && sysTaskMainForm.fdStatus != '1' && sysTaskMainForm.fdStatus == '2'}">
						<li data-dojo-type="mui/tabbar/TabBarButton" onclick="updateStop();">${lfn:message('sys-task:button.terminate')}</li>
					</c:if>
					<%--取消暂停--%>
					<c:if test="${sysTaskMainForm.fdStatus == '4'}">
						<li onclick="updateCancelStop();">${lfn:message('sys-task:button.cancel.terminate')}</li>
					</c:if>
				</kmss:auth>	
				<%--驳回任务(不存在子任务的任务才可以进行驳回)--%>
				<c:if test="${sysTaskMainForm.fdStatus == '3' && childSize == 0 }">
					<kmss:auth
						requestURL="/sys/task/sys_task_overrule/sysTaskOverrule.do?method=add&fdTaskId=${param.fdId}"
						requestMethod="GET">
  							<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnFeedback" 
 									data-dojo-props="href:'/sys/task/sys_task_overrule/sysTaskOverrule.do?method=add&fdTaskId=${param.fdId}'">${lfn:message('sys-task:table.sysTaskOverrule')}</li>
	  				</kmss:auth>
				</c:if>
  				<!-- 关注 -->	
 				<c:if test="${sysTaskMainForm.fdStatus != '6' }">
					<li data-dojo-type="mui/tabbar/TabBarButton"
						data-dojo-mixins="sys/task/mobile/resource/js/_AttentionTabBarButtonMixin"
						data-dojo-props="label:'${lfn:message('sys-task:mui.sysTaskMain.join.attention')}',fdId:'${param.fdId}',hasAttention:${isAttention}">
					</li>
				</c:if>

			</ul>
			<div class="otherDialogCancel">
				${lfn:message('sys-task:sysTaskMain.cancel')}
			</div>
		</div>
	</div>	
	</template:replace>
</template:include>
<script>
	require(["dojo/dom",
	         'dojo/_base/array',
	         'dojo/query',
	         'dojo/date/locale',
	         'dojo/date',
	         'dojo/ready',
	         'dojo/topic',
	         'dijit/registry',
	         'dojo/dom-geometry',
	         'dojo/request',
	         'mui/dialog/Tip',
	         'dojox/mobile/TransitionEvent',
	         'mui/rtf/RtfResizeUtil',
	         "mui/dialog/Dialog",
	         "mui/dialog/Tip",
	         "mui/dialog/Confirm",
	  		 "mui/device/adapter",
	         "dojo/dom-construct",
	         "dojo/dom-style",
	         "dojo/dom-class"
	         ],function(dom,array,query,locale,date,ready,topic,registry,domGeometry,request,Tip,TransitionEvent,RtfResizeUtil,Dialog,Tip,confirm,adapter,domCtr,domStyle,domClass){
			
			
			//获取权限按钮dom
			var otherChildren = $('#sysTaskMain_other ul');
			var otherNode = $('#sysTaskMain_other');
			console.log((otherChildren.children().length+$('#toobarGrops').children().length));
			if((otherChildren.children().length+$('#toobarGrops').children().length)<=6){
				if($("#otherListBtn").length>0){
					otherChildren.children().appendTo($('#toobarGrops'));
					$('#otherListBtn').css("display","none");
				}
				
			}else{
				if($('#toobarGrops').children().length<5&&$("#otherListBtn").length>0){
					var len = 5-$('#toobarGrops').children().length;
					for(var i = 0;i<len;i++){
						otherChildren.children().eq(0).appendTo($('#toobarGrops'));
					}
					$("#otherListBtn").appendTo($('#toobarGrops'));
				}
			}
			
			
			 
			/* 关注的权限 */
			//没有‘其他’按钮
			if($("#otherListBtn").length==0){
				if('${sysTaskMainForm.fdStatus}'!='4'&&'${sysTaskMainForm.fdStatus}'!='6'){
					$("#attentionShow").show();
				}else{
					$("#attentionShow").hide();
				}
			}
			
			
			/*圆形进度条  */
			var statusArr = [
			                 {text:'未启动',className:'muiTaskInactive'},
			                 {text:'进行中',className:'muiTaskProgress'},
			                 {text:'完成',className:'muiTaskComplete'},
			                 {text:'暂停',className:'muiTaskTerminate'},
			                 {text:'已驳回',className:'muiTaskOverrule'},
			                 {text:'结项',className:'muiTaskClose'}
			                 ];
			
			var progressLeft = query(".progressLeft")[0];
			var progressRight = query(".progressRight")[0];
			var progressClip = query(".progressClip")[0];
			var statusNode = query(".progressValue")[0];
			var progress = ${sysTaskMainForm.fdProgress};
			var taskStatus = ${ sysTaskMainForm.fdStatus};
			
 			if(progress<=50&&progress>=0){
				domStyle.set(progressLeft,"transform",'rotate('+ 3.6*progress + 'deg)');
				domClass.add(progressLeft,statusArr[taskStatus-1].className);
			}
			if(progress>50){
			/* 	domClass.add(progressLeft,statusArr[taskStatus-1].className);
				domClass.add(progressRight,statusArr[taskStatus-1].className); */
				domStyle.set(progressLeft,"transform",'rotate('+ 3.6*50 + 'deg)');
				domClass.remove(progressRight,"rightHidden");
				domClass.add(progressClip,"progressshow");
				domStyle.set(progressRight,"transform",'rotate('+ 3.6*(progress-50) + 'deg)');
			}
			
			statusNode.innerHTML="<p class='statustop'>"+progress+"%</p><p class='statusbottom'>"+statusArr[taskStatus-1].text+"</p>";
		
			 /* 其他更多操作 */
			  var otherListBtn = dom.byId("otherListBtn");
			 if(otherListBtn){
				 var OtherList = dom.byId("sysTaskMain_other");
				 dom.byId("otherListBtn").onclick= function (){
						var DialogObj = new Dialog.claz({
							element:OtherList,
							title:"更多操作",
							scrollable:false,
							parseable:false,
							position:"bottom",
							canClose:false
						});
						DialogObj.show();
					    var dialogCancel =  query(".muiDialogElementContainer_bottom .otherDialogCancel");
						dialogCancel[0].onclick=function(){
							DialogObj.hide();
						}; 					
				  } 
			 }
			 

			 	/* 任务结项函数 */
			
				window.closeTask=function(){
						var msg="${lfn:message('sys-task:button.closeTask.confirm.message')}";
						confirm("此操作后将无法编辑，是否继续？","",function(value,dialog){
						 	if(value==true){
						 		Tip.processing();
								$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=closeTask&fdId=${JsParam.fdId}"/>',
									function(data){
										if(data!=null && data.status==true){
											 Tip.success();
											 window.location.reload();
										}else{
											 Tip.fail();
										}
									},'json');
							} 
							
							
						});
						
					
				}
	
				 /* 任务暂停 */
				window.updateStop = function(){
					Tip.processing();
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=isClose&fdTaskId=${JsParam.fdId}"/>',
							function(data){
								if(data!=null && data.isClose =="false"){
									$.get('sysTaskMain.do?method=updateStop&fdTaskId=${JsParam.fdId}',function(data){
										
										Tip.success({text: "${lfn:message('sys-mobile:mui.return.success')}", callback:function(){
						            		location.reload();
						            	} });
									});
								}else{
									Tip.fail();
								}
							},'json');
				};
				/* 任务重启函数 */
				window.updateCancelStop = function(){
					Tip.processing();
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=isClose&fdTaskId=${JsParam.fdId}"/>',
							function(data){
								if(data!=null && data.isClose =="false"){
									$.get('sysTaskMain.do?method=updateCancelStop&fdTaskId=${JsParam.fdId}',function(data){
										//Tip.success();
										//window.location.reload();
						            	Tip.success({text: "${lfn:message('sys-mobile:mui.return.success')}", callback:function(){
						            		location.reload();
						            	} });
									});
									
								}else{
									Tip.fail();
								}
							},'json');
				};
				/* 驳回任务函数 */
				window.overrule = function(){
					$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=isClose&fdTaskId=${JsParam.fdId}"/>',
							function(data){
								if(data!=null && data.isClose =="false"){
									
								}else{
									
									
								}
							},'json');
				};
				
		//切换标签重新计算高度
		var _position=domGeometry.position(query('#fixed')[0]),
			_scrollTop=0;
		topic.subscribe("/mui/list/_runSlideAnimation",function(srcObj, evt) {
			_scrollTop= Math.abs(evt.to.y);
		});
		topic.subscribe("/mui/navitem/_selected",function(){
			var view=registry.byId("scrollView"),
				evt={ y: 0 - _scrollTop };
			if(_scrollTop > _position.y){
				evt={y: 0 -  _position.y };
			}
			view.handleToTopTopic(null,evt);
		});
		
		topic.subscribe("/mui/navitem/_selected",function(evt){
			if(evt.moveTo=='picView' ){
				var readFrame = document.getElementById("readFrame");
				if(readFrame.src == ""){
					var url = Com_Parameter.ContextPath +'sys/task/import/taskChart4m.jsp?fdId=${param.fdId}';
					readFrame.src = url;
				}
			}
		});
		
		//切换标签时resize rtf中的表格
		var hasResize=false;
		topic.subscribe("/mui/navitem/_selected",function(widget,args){
			var feedbackView=registry.byId("feedbackView");
			if(!hasResize  && widget.moveTo=='feedbackView'  ){
				hasResize=true;
				setTimeout(function(){
					var arr=query('#feedbackView .content');
					array.forEach(arr,function(item){
						new RtfResizeUtil({
							channel:item.id,
							containerNode:item
						});
					});
				},1);
			}
		});
		
		var docCreateTime='${sysTaskMainForm.docCreateTime}',//创建时间
			fdPlanComplete='${sysTaskMainForm.fdPlanCompleteDate}'+' '+'${sysTaskMainForm.fdPlanCompleteTime}';//截止时间
		docCreateTime=parseDate(docCreateTime);
		fdPlanComplete=parseDate(fdPlanComplete);
		
		
		//截止日期倒计时
		var Timer=setInterval(_setInterval,1000*60);
		function _setInterval(){
			//已完成不显示
			if('${sysTaskMainForm.fdStatus}'== '3' || '${sysTaskMainForm.fdStatus}'== '6'){
				
				query('.deadLineunit')[0].innerHTML='';
				Timer=null;
			}else{
				var now=new Date(),
				duration=date.difference(now,fdPlanComplete,'millisecond'),
				description='${lfn:message('sys-task:mui.sysTaskMain.remaining')}';
				
				if(duration < 0){
					description="${lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime.descript.over')}"
					duration= 0 - duration;
				}
				if(dojoConfig.locale == 'en-us'){
					description += ' ';
				}
				//X天(大于1天)
				if(duration >= 1000*60*60*24){
					var day=parseInt( duration/(24*60*60*1000) );
				
					query('.deadLineunit')[0].innerHTML=description+day+"${lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime.descript.day')}";
				}
				//X小时(不足一天)
				if(duration<1000*60*60*24 && duration>=1000*60*60){
					var hour=parseInt( duration % (24*60*60*1000) /(60*60*1000) );
					if(hour<1){
						hout=1;
					}
					
					query('.deadLineunit')[0].innerHTML=description+hour+"${lfn:message('sys-task:mui.sysTaskMain.hours')}";
				}
				//X分钟(不足一小时)
				if(duration <1000*60*60 && duration>=0 ){ 
					var minute=parseInt(duration/(60*1000)) ;
					if(minute<1){
						minute=1;
					}
				
					query('.deadLineunit')[0].innerHTML=description+minute+"${lfn:message('sys-task:mui.sysTaskMain.minutes')}";
				}
				
			}
		}
		_setInterval();
		
		//分解子任务
		window.addChild=function(){
			var lever = ${currentLevel};
			var fdMaxLevel = "${fdLevel}";
			if(lever >= fdMaxLevel){
				Tip.tip({
					text: "${ lfn:message('sys-task:sysTaskMain.lever.message1')}"+fdMaxLevel+"${ lfn:message('sys-task:sysTaskMain.lever.message2')}"
				});
				return false;
			}else{
				window.open('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=addChildTask&fdTaskId=${param.fdId}&flag=${param.flag}','_self');
			}
		};
		
		//标记完成
		window.complete=function(){
			
			var processing=Tip.processing();//加载中...
			
			processing.show();
			
			var url='${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=updateFinish&fdTaskId=${param.fdId}';
			var promise = request.post(url, {
                timeout: 5000
            }).then(function(result) {
            	//success	
            	processing.hide(false);
            	Tip.success({text: "${lfn:message('sys-mobile:mui.return.success')}", callback:function(){
            		location.reload();
            	} });
            	
            }, function(result) {
            	//fail
            });
			
		};
		
		//返回
		window.doBack=function(){
			window.open('${LUI_ContextPath}/sys/task/mobile/index.jsp','_self');
		};
		
		
		//String类型转化为Date类型
		function parseDate(/*String*/ date){
			return locale.parse(date,{
				selector : 'time',
				timePattern : "${ lfn:message('date.format.datetime') }"
			});
		}
		
		//初始化页面
		function resziePage(){
			var scrollView=registry.byId('scrollView').domNode,
				dateView=registry.byId('dateView').domNode,
				labelView=registry.byId('labelView').domNode,
				notifyView=registry.byId('notifyView').domNode,
				minHeight=scrollView.offsetHeight - dateView.offsetTop;
			domStyle.set(dateView,'min-height',minHeight+'px');
			domStyle.set(labelView,'min-height',minHeight+'px');
			domStyle.set(notifyView,'min-height',minHeight+'px');
		}
		
		window.initKKIM = function(){
			var fdSourceType = "${sysTaskMainForm.fdSourceType}";
			var fdMessageIndex = "${sysTaskMainForm.fdMessageIndex}";
	
			if(fdSourceType !='KK_IM'){
				return ;
			}
			var fdSessionType = '${sysTaskMainForm.fdSessionType}';
			if(!fdSessionType || !adapter.isSessionMemberByMsg){
				return;
			}
			var options ={
					msgSenderID:'${sysTaskMainForm.fdMessageSenderId}',
					msgReceiverID:'${sysTaskMainForm.fdMessageReceiverId}',
					sessionType:fdSessionType
			}
			adapter.isSessionMemberByMsg(options,function(res){
				domStyle.set(query('.muiTaskLink')[0],'display','flex');
			},function(){
			});
		};
		window.onSourceClick = function(){
			var fdSourceType = "${sysTaskMainForm.fdSourceType}";
			var fdMessageIndex = "${sysTaskMainForm.fdMessageIndex}";
	
			if(fdSourceType !='KK_IM'){
				window.location.href='<c:url value="${sysTaskMainForm.fdSourceUrl}"/>';
				return ;
			}
			var fdSessionType = '${sysTaskMainForm.fdSessionType}';
			if(!fdSessionType || !adapter.isSessionMemberByMsg){
				return;
			}
			var options ={
					msgSenderID:'${sysTaskMainForm.fdMessageSenderId}',
					msgReceiverID:'${sysTaskMainForm.fdMessageReceiverId}',
					sessionType:fdSessionType
			}
			console.log("kk任务来源跳转相关参数:"+JSON.stringify(options));
			adapter.isSessionMemberByMsg(options,function(res){
				var _options ={
					msgIndex:fdMessageIndex
				};
				if(fdSessionType==0){
					_options.userId=res.chatID;
					console.log("调用p2p聊天窗口参数:"+JSON.stringify(_options));
					adapter.openChat(_options,function(){
						console.log("调用p2p聊天窗口成功");
					},function(){
						console.log("调用p2p聊天窗口失败");
					});
					return;
				}
				if(fdSessionType==1 || fdSessionType==2){
					_options.groupID=res.chatID;
					console.log("调用群聊窗口参数:"+JSON.stringify(_options));
					adapter.sendGroup(_options,function(){
						console.log("调用群聊窗口成功:");
					},function(err){
						console.log("调用群聊窗口失败:"+err);
					});
					return;
				}
			},function(){
			});
			
		};
		ready(function(){
			//KK转任务
			initKKIM();
		});
		
	});

</script>
