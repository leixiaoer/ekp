<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<template:include ref="default.edit"  sidebar="no" width="980px">
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/resource/ckeditor/resource/ckresize.css">
		<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/km/pindagate/vote.css?v=20191129">
		
		<style>
		 .questionTitle{
		 	transform: scale(1,1);
		 	word-break: break-all;
		}
		 .questionTitle img{
		 	max-width: 500px;
		 }
		</style>
	</template:replace>
	<%--标签页标题--%>
	<template:replace name="title">
		<c:out value="${kmPindagateMainForm.docSubject} - ${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>	
	</template:replace>
	
	<%--路径导航--%> 
	<template:replace name="path">
		<%-- 可以答题,此时路径导航不可点击(当做edit页面处理) --%>
		<c:if test="${canResponse}">	
			<ui:menu layout="sys.ui.menu.nav"  id="categoryId"> 
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-pindagate:module.km.pindagate') }">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.participate') }">
				</ui:menu-item>
				<ui:menu-source autoFetch="false" >
					<ui:source type="AjaxJson">
						{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.pindagate.model.KmPindagateTemplate&categoryId=${kmPindagateMainForm.fdTemplateId}&currId=!{value}&nodeType=!{nodeType}"} 
					</ui:source>
				</ui:menu-source>
			</ui:menu>
		</c:if>
		<%-- 不可以答题,此时路径导航可点击(当做view页面处理) --%>
		<c:if test="${canResponse == false}">	
			<ui:menu layout="sys.ui.menu.nav"  id="categoryId"> 
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-pindagate:module.km.pindagate') }" href="/km/pindagate/" target="_self">
				</ui:menu-item>
				<%-- 参与调查 --%>
				<ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.participate') }" href="/km/pindagate/index.jsp?key=participate" target="_self">
				   <%-- 问卷设置 --%>
				   <ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.set') }" href="/km/pindagate/index.jsp?key=set#j_path=%2FmydocMine&mydoc=mine" target="_self">
				   </ui:menu-item>
					<%-- 调查结果 --%>
				   <ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.result') }" href="/km/pindagate/index.jsp?key=result#j_path=%2Findagating&docStatus=31" target="_self">
				   </ui:menu-item>
				</ui:menu-item>
				<ui:menu-source autoFetch="true" 
						target="_self" 
						href="/km/pindagate/index.jsp?key=participate#cri.q=categoryId%3A!{value}">
					<ui:source type="AjaxJson">
						{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.pindagate.model.KmPindagateTemplate&categoryId=${kmPindagateMainForm.fdTemplateId }&currId=!{value}&nodeType=!{nodeType}"} 
					</ui:source>
				</ui:menu-source>
			</ui:menu>
		</c:if>
	</template:replace>	
	
	<%--问卷表单--%>
	<template:replace name="content"> 
		<!--JS-->
		<%@ include file="/km/pindagate/km_pindagate_response_ui/kmPindagateResponse_edit_script.jsp"%>
		<html:form action="/km/pindagate/km_pindagate_response/kmPindagateResponse.do">
			<html:hidden property="fdId"/>
			<html:hidden property="fdQuetionairId"/>
			<input type="hidden" id="fdRelationCheck" value="">
			<xform:text property="docStatus" showStatus="noShow" value="30" />
			<% if(ISysAuthConstant.IS_AREA_ENABLED) { %> 
					<input type="hidden" name="authAreaId" value="kmPindagateResponseForm.authAreaId"> 
					<xform:text property="kmPindagateResponseForm.authAreaName" showStatus="noShow" />	
			<% } %>
			<%--进度条--%>
			<c:if test="${canResponse==true && kmPindagateResponseForm.method_GET=='add'&& isReject!=true}">
				<div class="pindagate_progress">
					<div class="pindagate_progress_complete"></div>
					<div style="position: absolute;top:80px;text-align: center;width: 100%;" class="pindagate_progress_number">0%</div>
					<div class="pindagate_progress_uncomplete"></div>
				</div>
			</c:if>
			<%--快捷菜单--%>
        	<div class="pindagate_menu" style="bottom: 216px !important">
	            <ul>
	            	<%-- 不参与调查 --%>
	            	<c:if test="${canResponse}">
	            	<c:if test="${canReject==true}">
	            	 <c:if test="${isReject!=true}">
	            		<li class="item_0" title="${lfn:message('km-pindagate:kmPindagateMain.notParticipate')}"></li>
	            		<script>
		                seajs.use(['lui/jquery','lui/dialog','lui/dialog_common','lui/util/str'], function($, dialog, dialogCommon,strutil){
		                	$('.pindagate_menu .item_0').on("click",function(){
		                		var iframeUrl = '/km/pindagate/km_pindagate_reject/kmPindagateRejectPerson.do?method=add&pindageteId=${param.pindageteId}';
		                		var _config = {
		                				width:600,
		                				height:420,
	                					buttons:[{
		                					name:"${lfn:message('km-pindagate:kmPindagateMain.toolControl.noParticipation')}",
		                					value:1,
		                					fn:function(value,dialog){
		                						var iframeObj = document.getElementById("dialog_iframe");
		                						$(iframeObj).find("iframe").get(0).contentWindow.commitForm();
		                					}
		                				},{
		                					name:"${lfn:message('button.cancel') }",
		                					value:0,
		                					fn:function(value,dialog){
		                						dialog.hide();
		                					}
		                				}]	
		                		}
		                		dialog.iframe(iframeUrl,"${lfn:message('km-pindagate:kmPindagateMain.notParticipate')}",null,_config)	
		                	})
		              	})
		                </script>
	            	</c:if>
	            	</c:if>
					</c:if>
	                <%--问卷属性--%>
	               <kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=view&fdId=${kmPindagateMainForm.fdId}">
		              <li class="item_1" title="${lfn:message('km-pindagate:kmPindagateMain.toolControl.quesProperty')}"
		                	onclick="Com_OpenWindow('${LUI_ContextPath}/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=view&fdId=${kmPindagateMainForm.fdId}');">
		               </li>
	                </kmss:auth>
	                <%--更新统计数据--%>
					<c:if test="${isShowUpdateAndViewResultButton}">
						<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&flag=updateStatisticResult&fdId=${kmPindagateMainForm.fdId}">
			                <li class="item_3" title="${lfn:message('km-pindagate:kmPindagateResponse.button.updateAndViewResult') }" 
			                onclick="viewResult();">
			                </li>
						</kmss:auth>
					</c:if>
					<%--查看结果--%>
					<c:if test="${isShowResultViewButton}">
						<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&fdId=${kmPindagateMainForm.fdId}">
							<li class="item_4" title="${lfn:message('km-pindagate:kmPindagateResponse.button.viewResult') }"
			                	onclick="Com_OpenWindow('${LUI_ContextPath}/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&fdId=${kmPindagateMainForm.fdId}&flag=updateStatisticResult');">
			                </li>
						</kmss:auth>
					</c:if>
	            </ul>
           </div>
			<!-- 提示信息 -->
			<div id="dialog"> <div id="dialog_content"></div> </div> 
			<div class='lui_form_title_frame'>
				<%--问卷主题--%>
				<div class="lui_form_finishTips" id="docFinishedTips"></div>
				<div class='lui_form_subject'>
					<bean:write name="kmPindagateMainForm" property="docSubject" />
				</div>
				<%-- 调查结束时间 --%>
				<div class="lui_form_finishTime docFinishedTime"></div>
				<div class='lui_form_content_frame' style="margin:0px 10px;clear: both;">
					<%--Page--%>
					<div class="page">
						<div class="left">
							<bean:message bundle="km-pindagate" key="kmPindagateResponse.the"/><font class="com_number" name="currentPage">1</font><bean:message key="page.page"/>
							<bean:message key="page.total"/><font class="com_number" name="totalPage">1</font><bean:message key="page.page"/>
						</div>
						<div style="float: right;">
							<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.pre')}" onclick="changePage('prev');" id="prev1"></ui:button>&nbsp;
							<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.next')}" onclick="changePage('next');" id="next1"></ui:button>
						</div>
						<div style="clear: both;"></div>
					</div>
					<%--问卷说明--%>
					<c:if test="${kmPindagateMainForm.fdQuestionExplain!=null&&kmPindagateMainForm.fdQuestionExplain!='' }">
					<div class="lui_form_summary_frame pi_subjectExplain_content">	
								
						<c:out value="${kmPindagateMainForm.fdQuestionExplain }" escapeXml="false"></c:out>
					</div>
					</c:if>
					<c:forEach items="${kmPindagateResponseForm.fdItems}" var="KmPindagateQuestionResForm" varStatus="vstatus">					
						<div>
							<!-- 修复该问卷还有分页符时，在移动端填报后，题目答案无法显示 #107122 -->
							<input type="hidden" name="fdItems[${KmPindagateQuestionResForm.fdOrder}].fdDraftAnswer" value='${KmPindagateQuestionResForm.fdAnswer}'>
							<input type="hidden" name="fdItems[${KmPindagateQuestionResForm.fdOrder}].fdDraftRelHide" value='${KmPindagateQuestionResForm.fdRelationHide}'>
							<input type="hidden" name="fdItems[${KmPindagateQuestionResForm.fdOrder}].fdDraftOther" value="${KmPindagateQuestionResForm.fdOther}">	
							<input type="hidden" name="fdItems[${KmPindagateQuestionResForm.fdOrder}].fdDraftSelectReason" value="${KmPindagateQuestionResForm.fdSelectReason}">					
						</div>
					</c:forEach>
					<div class="pi_box">
						<div class="pi_content" id="Div_Response_Questions"><%int serialNum = 0; %>
						<c:forEach items="${kmPindagateMainForm.fdItems}" var="kmPindagateQuestionForm" varStatus="vstatus">
							<c:if test="${kmPindagateQuestionForm.fdSplit != 'true'}"><% serialNum++; %></c:if>
							<div id="questions${vstatus.index}" <c:if test="${!canResponse}">disabled</c:if> class="questionTitle">
								<input type="hidden" id="fdQuestionDef${vstatus.index}" value="${kmPindagateQuestionForm.fdQuestionDefView}" >
								<input type="hidden" id="fdRelationDef${vstatus.index}" value="${kmPindagateQuestionForm.fdRelationDefView}" >
								<input type="hidden" id="fdRelationSign${vstatus.index}" value="${kmPindagateQuestionForm.fdRelationSign}" >
								<input type="hidden" id="fdType${vstatus.index}" value="${kmPindagateQuestionForm.fdType}">
								<input type="hidden" id="fdSplit${vstatus.index}" name="fdSplit"  value="${kmPindagateQuestionForm.fdSplit}">
								<input type="hidden" id="serialNum${vstatus.index}" value="<%=serialNum%>">
								<input type="hidden" id="fdTitle${vstatus.index}" value='<c:out value="${kmPindagateQuestionForm.fdName}"/>'>
								<input type="hidden" id="fdSubjectImg${vstatus.index}">
								<input type="hidden" id="quesTypeName${vstatus.index}" value="${kmPindagateQuestionForm.fdTypeName}">
								<input type="hidden" name="fdItems[${vstatus.index}].fdQuetionairResId" value="${kmPindagateResponseForm.fdId}">
								<input type="hidden" name="fdItems[${vstatus.index}].fdQuestionId" value="${kmPindagateQuestionForm.fdId}">
								<input type="hidden" name="fdItems[${vstatus.index}].fdOrder" value="${kmPindagateQuestionForm.fdOrder}">
								<input type="hidden" name="fdPersonMulti" value="${kmPindagateMainForm.fdPersonMulti}">
								<input type="hidden" name="method_GET" value="${kmPindagateResponseForm.method_GET}">
								<input type="hidden" name="fdItems[${vstatus.index}].fdRelationShow" value="">
								<c:if test="${kmPindagateQuestionForm.fdSplit != 'true'}">
									<c:import url="/${kmPindagateQuestionForm.responseUrl}" charEncoding="UTF-8">
										<c:param name="index" value="${vstatus.index}" />
										<c:param name="divId" value="${kmPindagateQuestionForm.fdType}${vstatus.index}" />
									</c:import>
								</c:if>
							</div>
						</c:forEach>
						<script>
			                seajs.use(['lui/jquery','lui/dialog','lui/dialog_common','lui/util/str'], function($, dialog, dialogCommon,strutil){
			                	$(document).ready(function () {
			                		var questionSize=$("#questionSize").val(),
			                		countAllSize=questionSize,
			                		allRelation={};
		                		for (var u = 0; u < questionSize;u++) {
		                			var fdTypeVal=$("input[id='fdType"+u+"']").val();
			                		if (!fdTypeVal) {
			                			countAllSize=parseInt(countAllSize)+parseInt("1");
									}
		                		}
			                	for (var u = 0; u < countAllSize;u++) {
			                		var fdRelationDef=$('#fdRelationDef'+u).val();
			                		if (fdRelationDef&&fdRelationDef!="{}") {
			                			var relationJson=JSON.parse(fdRelationDef),
			                				relationSend={};
			                			for ( var f in relationJson) {
			                				var number=f,
			                					showValue=$("input[name='fdItems["+relationJson[f].topic+"].fdRelationShow']").val();
			                				//showTopic：第几题，relationOp:是否选择
			                				relationSend[number]={showTopic:u,relationItem:relationJson[f].itemVals,relationOpt:relationJson[f].opt,
			                						relationSel:relationJson[f].multiseSel,relationFlag:relationJson[f].flagRelation,
			                						topic:relationJson[f].topic,itemKeyVal:relationJson[f].itemKeyVal,sign:relationJson[f].sign};
			                			}
			                			$("input[name='fdItems["+relationJson[f].topic+"].fdRelationShow']").val(JSON.stringify(relationSend));
			                			var fdTypeVal=$("input[id='fdType"+u+"']").val();
			                			var methodGet=$("input[name='method_GET']").val();
			                			if (methodGet=="add") {
			                				$('#'+fdTypeVal+u).hide();
										}
			                			var showUsed=$("input[name='fdItems["+relationJson[f].topic+"].fdRelationShow']").val();
			                			if (showUsed) {
			                				allRelation[u]=showUsed;
										}
			                			$("input[id='fdRelationCheck']").val(JSON.stringify(allRelation));
			                		}
			                		
								}
			              	})
			                	});
		                </script>
						<input type="hidden" id="questionSize" value="<%=serialNum%>">
						</div>
					</div>
					<%--Page--%>
					<div class="page pageborder">
						<div class="left">
							<bean:message bundle="km-pindagate" key="kmPindagateResponse.the"/><font class="com_number" name="currentPage">1</font><bean:message key="page.page"/>
							<bean:message key="page.total"/><font class="com_number" name="totalPage">1</font><bean:message key="page.page"/>
						</div>
						<div style="float: right;">
							<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.pre')}" onclick="changePage('prev');" id="prev2"></ui:button>&nbsp;
							<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.next')}" onclick="changePage('next');" id="next2"></ui:button>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div id="buttonArea" style="width: 120px;margin:0 auto;padding-bottom: 15px;">
					<%--提交按钮--%>
					<c:if test="${isReject!=true}">
						<c:if test="${canResponse}">	
							<c:if test="${kmPindagateResponseForm.method_GET=='edit' && kmPindagateMainForm.fdPersonMulti=='true' }">
								<ui:button id="submitButton" text="${lfn:message('button.submit') }" order="2"  onclick="commitMethod('update','30');" style="width:150px;">
								</ui:button>
							</c:if> 
							<c:if test="${kmPindagateResponseForm.method_GET=='add'}">
								<ui:button id="submitButton" text="${lfn:message('button.submit') }" order="2"  onclick="commitMethod('save','30');" style="width:150px;">
								</ui:button>
							</c:if> 
						</c:if>
					</c:if>
					<%--结束按钮--%>
					<ui:button id="finishButton" text="已结束" style="width:150px;"></ui:button>
				</div>
				
			</div>
			<!-- 图形预览区域 -->
			<div id="dHTMLToolTip"  style="Z-INDEX: 1000; LEFT: 0px; display:none; WIDTH: 10px; POSITION: absolute; TOP: 0px; HEIGHT: 10px">
			</div>
			
		</html:form>
	</template:replace>
</template:include>