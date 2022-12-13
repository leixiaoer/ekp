<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ModelUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.km.pindagate.forms.KmPindagateMainForm"%>
<%
	ISysAttMainCoreInnerService sysAttMainCoreInnerService=(ISysAttMainCoreInnerService)
			SpringBeanUtil.getBean("sysAttMainService");
	KmPindagateMainForm form=(KmPindagateMainForm)request.getAttribute("kmPindagateMainForm");
	List list=sysAttMainCoreInnerService.findByModelKey("com.landray.kmss.km.pindagate.model.KmPindagateMain",form.getFdId(),"pic");
	if(list!=null && list.size()>0){
		SysAttMain att=(SysAttMain)list.get(0);
		request.setAttribute("pictureUrl", ModelUtil.getModelUrl(att));
	}else{
		request.setAttribute("pictureUrl", "/km/pindagate/resource/images/pindagate_bg.jpg");
	}
%>
<c:set var="compatibleMode" value="false"/>
<c:if test="${kmPindagateMainForm.docStatus < '30' }">
	<c:set var="compatibleMode" value="true"/>
</c:if>
<template:include ref="mobile.view" compatibleMode="true">

	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/pindagate/mobile/resource/css/view.css?s_cache=${MUI_Cache}" />
		<mui:min-file name="mui-pindagate.js"/>
		<mui:min-file name="mui-pindagate-question.js"/>
		
	</template:replace>

	<template:replace name="title">
		<c:out value="${lfn:message('km-pindagate:kmPindagateMain.toolControl.quesProperty')}"></c:out>
	</template:replace>

	<template:replace name="content">
		
			<div id="scrollView" data-dojo-type="mui/view/DocScrollableView">
				<%-- 基本信息 --%>
				<div id="basicInfoView">
					<section class="muiPindagateHeader">
						<div class="muiPindagateHeaderImgBox">
							<%-- 标题图片 --%>
							<img alt="" src="${LUI_ContextPath}${pictureUrl}">
							<%-- 标题 --%>
							<h4 class="muiPindagateHeaderTitle">
								<span><c:out value="${kmPindagateMainForm.docSubject}"></c:out></span>
							</h4>
						</div>
						<div class="muiPindagateHeaderTooltip">
							<%--截止日期 --%>
							<div class="muiPindagateTimeCard">
								<c:if test="${kmPindagateMainForm.docStartTime==null }">
									<bean:message key="kmPindagateMain.null.start.time" bundle="km-pindagate" />
								</c:if>
								<c:out value="${kmPindagateMainForm.docStartTime }"></c:out> ~
								<c:if test="${kmPindagateMainForm.docFinishedTime==null }">
									<bean:message key="kmPindagateMain.null.not.limit.time" bundle="km-pindagate" />
								</c:if>
								<c:out value="${kmPindagateMainForm.docFinishedTime }"></c:out>
							</div>
							<%-- 参加人数 --%>
							<p class="muiPindagateHomePeople">
								<i class="mui mui-person"></i>
								<c:out value="${kmPindagateMainForm.fdParticipantNum }"></c:out><bean:message bundle="km-pindagate" key="mobile.kmPindagateMain.person" />
							</p>
						</div>
					</section>
				</div>
			
			
			<div class="contentContainer">
				<table class="muiSimple" cellpadding="0" cellspacing="0">
					<%--调查人员--%>
					<tr>
						<td class="muiTitle">
							<bean:message  bundle="km-pindagate" key="kmPindagateMain.partic.people.mobile"/>
						</td>
						<td>
							<c:out value="${kmPindagateMainForm.indagateParticipantNames }"></c:out>
						</td>
					</tr>
					<%--调查结果人员--%>
					<tr>
						<td class="muiTitle">
							<bean:message  bundle="km-pindagate" key="kmPindagateMain.result.reader.mobile"/>
						</td>
						<td>
							<c:out value="${kmPindagateMainForm.indagateResultReaderNames }"></c:out>
						</td>
					</tr>
					<%--调查结果通知人员--%>
					<tr>
						<td class="muiTitle">
							<bean:message  bundle="km-pindagate" key="kmPindagateMain.over.notify.person.mobile"/>
						</td>
						<td>
							<c:out value="${kmPindagateMainForm.indagateResultNotifierNames }"></c:out>
						</td>
					</tr>
					<%--问卷说明--%>
					<tr>
						<td class="muiTitle">
							<bean:message  bundle="km-pindagate" key="kmPindagateMain.fdQuestionExplain"/>
						</td>
						<td>
							<xform:rtf property="fdQuestionExplain" mobile="true"></xform:rtf>
						</td>
					</tr>
				</table>
			
				<div class="muiReadButton" onclick="sliceTo('previewView');">
      					<bean:message bundle="km-pindagate" key="mobile.kmPindagateMain.preview" />
      			</div>
			
			</div>
			<c:if test="${kmPindagateMainForm.docStatus < '30' }">
				<template:include file="/sys/lbpmservice/mobile/import/bar.jsp" formName="kmPindagateMainForm">
				</template:include>
			</c:if>
			
		</div>
			<div id="previewView" class="gray" data-dojo-type="mui/view/DocScrollableView" data-dojo-props="scrollDir:''">
			<div id="previewList" data-dojo-type="km/pindagate/mobile/resource/js/QuestionPreviewList">
				<%-- 序号、页码 --%>
				<% int serialNum = 0; int pageno=1; %>
				<c:forEach items="${kmPindagateMainForm.fdItems}" var="kmPindagateQuestionForm" varStatus="vstatus">
					<%-- 题型 --%>
					<c:if test="${kmPindagateQuestionForm.fdSplit != 'true'}">
						<% serialNum++; %>
						<div data-dojo-type="km/pindagate/mobile/resource/js/QuestionPreview" class="muiResponse" data-dojo-props="index:${vstatus.index},showStatus:'readOnly'">
							<input type="hidden" class="questionDef" value="${kmPindagateQuestionForm.fdQuestionDefView}" >
							<input type="hidden" class="type" value="${kmPindagateQuestionForm.fdType}">
							<input type="hidden" class="typeName" value="${kmPindagateQuestionForm.fdTypeName}">
							<input type="hidden" class="split" name="fdSplit" value="${kmPindagateQuestionForm.fdSplit}">
							<input type="hidden" class="serialNum" value="<%=serialNum%>">
							<input type="hidden" class="pageno" value="<%=pageno%>">
							<input type="hidden" class="title" value="${kmPindagateQuestionForm.fdName}">
							<input type="hidden" class="subjectImg">
							<input type="hidden" name="fdItems[${vstatus.index}].fdQuetionairResId" value="${kmPindagateResponseForm.fdId}">
							<input type="hidden" name="fdItems[${vstatus.index}].fdQuestionId" value="${kmPindagateQuestionForm.fdId}">
							<input type="hidden" name="fdItems[${vstatus.index}].fdOrder" value="${kmPindagateQuestionForm.fdOrder}">
							<html:hidden property="method_GET"/>
						</div>
					</c:if>
					<%-- 分页符 --%>
					<c:if test="${kmPindagateQuestionForm.fdSplit == 'true'}">
						<% pageno++; %>
						<div class="muiSplit">
							<input type="hidden" class="type" value="${kmPindagateQuestionForm.fdType}">
							<input type="hidden" class="typeName" value="${kmPindagateQuestionForm.fdTypeName}">
							<input type="hidden" class="split" name="fdSplit" value="${kmPindagateQuestionForm.fdSplit}">
							<input type="hidden" name="fdItems[${vstatus.index}].fdQuetionairResId" value="${kmPindagateResponseForm.fdId}">
							<input type="hidden" name="fdItems[${vstatus.index}].fdQuestionId" value="${kmPindagateQuestionForm.fdId}">
							<input type="hidden" name="fdItems[${vstatus.index}].fdOrder" value="${kmPindagateQuestionForm.fdOrder}">
							<html:hidden property="method_GET"/>
						</div>
					</c:if>
				</c:forEach>
				<input type="hidden" id="questionSize" value="<%=serialNum%>">
				   <div class="pindagate_nav" id="pindagateNav"/>
				    <!-- 所有题目 starts -->
			    <div class="pindagate_all">
			    <div class="pindagate_all_shadow"></div>
			      <div class="pindagate_all_panel">
			        <div class="pindagate_all_panel_tit">
			          <p class="pindagate_all_panel_tit_must"><i>*</i><bean:message bundle="km-pindagate" key="kmPindagateMain.MustAnswer"/></p>
			          <p class="pindagate_all_panel_tit_will"><span></span><bean:message bundle="km-pindagate" key="kmPindagateMain.Unanswered"/></p>
			          <p class="pindagate_all_panel_tit_done"><span></span><bean:message bundle="km-pindagate" key="kmPindagateMain.Answer"/></p>
			        </div>
			        <div class="pindagate_all_panel_body" id="allPanelBody"></div>
			      </div>
			      </div>
			</div>
		</div>
		</div>
		
			
		<!-- 钉钉图标 -->
		<kmss:ifModuleExist path="/third/ding">
			<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmPindagateMainForm" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/lding">
			<c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmPindagateMainForm" />
			</c:import>
		</kmss:ifModuleExist>
		<!-- 钉钉图标 end -->
		
	
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmPindagateMainForm" />
			<c:param name="fdKey" value="pindagateMain" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
		</c:import>
		
	</template:replace>
</template:include>
<script>
	require(['dojox/mobile/TransitionEvent'],function(TransitionEvent){
		//切换页面
		window.sliceTo = function(id){
			var opts = {
				transition : 'slide',
				moveTo:id,
				transitionDir:-1
			};
			new TransitionEvent(document.body,  opts ).dispatch();
		};
		
		window.doBack = function(){
			window.sliceTo('scrollView');
		};
	});

</script>
<script>
	window.allTopics = [];
	require(["mui/form/ajax-form!kmPindagateResponseForm"]);
	require(['dijit/registry',"dojo/dom-construct","dojo/dom-style","dojo/dom-geometry","dojo/dom-class",'dojox/mobile/TransitionEvent',
	         "dojo/ready","dojo/date","mui/calendar/CalendarUtil","dojo/query","mui/dialog/BarTip","dojo/_base/window","dojo/topic","dojo/request",
	         "dojo/on","dojo/dom"],
		function(registry,domConstruct,domStyle,domGeo,domClass,TransitionEvent,ready,date,calendarUtil,query,BarTip,win,topic,request,on,dom){
		
		ready(function(){
			$(document).ready(function(){
				var questionSize = query("#questionSize").val(); 
				 for (var u = 0; u < questionSize; u++) { 
	            	// 增加一个正常的题目（正常显示）
	            	allTopics.push({"isShow": true, "isRel": false, "topic": u}); 
				 } 
				  // 点击可提交按钮时显示蒙板弹窗
				  var submit = $(".pindagate_nav_submit.active a");
				  submit.on("click",function(){
				    $(".pindagate_mask").addClass("active");
				    setTimeout(function(){
				      $(".pindagate_mask_success").addClass("active");
				    },1)
				  })

				  // 点击蒙板确认，回到主界面
				  $(".pindagate_mask_success_confirm").on("click",function(){
				    $(".pindagate_mask_success").removeClass("active");
				    setTimeout(function(){
				      $(".pindagate_mask").removeClass("active");    
				    },300)
				  })

				   // 点击可提交按钮时显示蒙板弹窗
				   var submit = $(".pindagate_nav_submit.active a");
				   submit.on("click",function(){
				     $(".pindagate_mask").addClass("active");
				     setTimeout(function(){
				     $(".pindagate_mask_fail").addClass("active");
				    },1)
				   })
				 
				   // 点击蒙板确认，回到主界面
				   $(".pindagate_mask_fail_confirm").on("click",function(){
				     $(".pindagate_mask_fail").removeClass("active");
				     setTimeout(function(){
				       $(".pindagate_mask").removeClass("active");    
				     },300)
				   })

				  //  点击更多按钮，查看所有题目
				  $(".pindagate_nav_left").on("click",function(){
				    $(".pindagate_nav_see").toggleClass("active");
				    $(".pindagate_all").toggleClass("active");
				    var allFlag = $(".pindagate_all").hasClass("active");
				    var panel = $(".pindagate_all_panel");
				    if(allFlag){
				      setTimeout(function(){
				        panel.addClass("in");
				      },1)
				    }else{
				      panel.removeClass("in");
				      setTimeout(function(){
				        $(".pindagate_all").removeClass("active");
				      },300)
				    }
				  })
				  // 点击蒙版返回主页面
				  $(".pindagate_all_shadow").on("click",function(){
				    $(".pindagate_all").removeClass("active");
				    $(".pindagate_nav_see").removeClass("active");
				  })
				});
		});
	});
</script>
