<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	Boolean canUpdate = false;
	if(UserUtil.checkRole("ROLE_KMPINDAGATE_UPDATESTATISTICRESULT")){
		canUpdate = true;
	}
	request.setAttribute("canUpdate", canUpdate);
%>
<template:include ref="default.view"  sidebar="no" width="980px">
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/km/pindagate/vote.css">
	</template:replace>
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${lfn:message('km-pindagate:kmPindagate.tree.result')}-${lfn:message('km-pindagate:module.km.pindagate')}"></c:out>
	</template:replace>
	<%--路径导航--%>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"  id="categoryId"> 
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-pindagate:module.km.pindagate') }" href="/km/pindagate/" target="_self">
			</ui:menu-item>
			  <ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.result') }" href="/km/pindagate/index.jsp?key=result#j_path=%2Findagating&docStatus=31" target="_self">
			   <ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.participate') }" href="/km/pindagate/index.jsp?key=participate" target="_self">
			   </ui:menu-item>
			   <ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.set') }" href="/km/pindagate/index.jsp?key=set#j_path=%2FmydocMine&mydoc=mine" target="_self">
			   </ui:menu-item>
			</ui:menu-item>
			<ui:menu-source autoFetch="true" 
					href="/km/pindagate/index.jsp?key=result#j_path=%2Findagating&docStatus=31&cri.q=categoryId%3A!{value}">
				<ui:source type="AjaxJson">
					{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.pindagate.model.KmPindagateTemplate&categoryId=${kmPindagateMainForm.fdTemplateId}&currId=!{value}&nodeType=!{nodeType}"} 
				</ui:source>
			</ui:menu-source>
		</ui:menu>
	</template:replace>	
	
	<template:replace name="content"> 
		<%--快捷菜单--%>
        <div class="pindagate_menu" style="bottom:216px !important">
            <ul>
            	<%--问卷属性--%>
            	<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=view&fdId=${kmPindagateMainForm.fdId}">
	                <li class="item_1" title="${lfn:message('km-pindagate:kmPindagateMain.toolControl.quesProperty')}"
	                	onclick="window.open('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=view&fdId=${kmPindagateMainForm.fdId}');">
	                </li>
                </kmss:auth> 
                <%--参与人员信息--%>
                <c:if test="${isShow==true }">
	                <li class="item_2" title="${lfn:message('km-pindagate:kmPindagateMain.toolControl.participantsInfo')}"
	                	onclick="window.open('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=viewIndagatePersonInfo&fdId=${kmPindagateMainForm.fdId}');">
	                </li>
                </c:if>
                <%--调查结果数据分析--%>
                <li class="item_3" title="${lfn:message('km-pindagate:kmPindagateMain.toolControl.surveyDataAnalysis') }"
                	onclick="window.open('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=resultsView&fdId=${kmPindagateMainForm.fdId}&forward=dataAnalysis');">
                </li>
                <c:if test="${isShow==true }">
	                <%--参与人员答卷分析--%>
	                <li class="item_4" title="${lfn:message('km-pindagate:kmPindagateMain.toolControl.analysisResponses')}"
	                	onclick="window.resultDetail();">
	                </li>
                </c:if>
                <%--导出EXCEL--%>
                <li class="item_5" title="${lfn:message('km-pindagate:kmPindagateMain.toolControl.export')}"
                	onclick="window.location.href = '<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=exportResultExcel&fdId=${kmPindagateMainForm.fdId}'">
                </li>
                
            </ul>
        </div>
		<%--提示信息--%>
		<div id="dialog"> <div id="dialog_content"></div></div> 
		<%--<script type="text/javascript">Com_IncludeFile("jquery.js|json2.js|vbar.js|circle.js");</script>--%>
		<%--<script type="text/javascript" src='<c:url value="/km/pindagate/resource/progress.js"/>'></script>--%>
		
		<script type="text/javascript" src='<c:url value="/km/pindagate/km_pindagate_statistic_ui/js/resultView/init.js"/>'></script>
		<c:import url="/${kmPindagateStatistic.fdStatisticUrl}" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">
			var _dialog;
			seajs.use(['lui/dialog'], function(dialog) {
				_dialog=dialog;
			});
			/**
			 * 显示遮罩层
			 */
			function showMaskLayer(divDialog,divDialogContent,dialogContent,isDispaly){ 
				if(isDispaly)
					$("#"+divDialog).css({display:"block"});
				else
					$("#"+divDialog).css({display:"none"});
				$("#"+divDialogContent).html(dialogContent); 
			}
		</script>
		<script type="text/javascript">
			var dialogContent = "<div style='text-align:center;vertical-align: middle'><img src='${KMSS_Parameter_ContextPath}km/pindagate/images/alerts.gif' border='0'><bean:message bundle='km-pindagate' key='kmPindagateResponse.loading'/></div>";
			showMaskLayer('dialog','dialog_content',dialogContent);//显示遮罩层
			/**
			 * 初始化
			 */
			LUI.ready(function (){
				initPageButton();
				if("${canViewResult}" == "false"){
					dialogContent = "<div style='text-align:center;vertical-align: middle'><img src='${KMSS_Parameter_ContextPath}km/pindagate/images/alerts.gif' height='14px' width='14px' border='0'>&nbsp;<bean:message bundle='km-pindagate' key='kmPindagateMain.not.participation'/></div>";
					showMaskLayer('dialog','dialog_content',dialogContent,true);//显示遮罩层
					return;
				}
				changePage();
				showMaskLayer('dialog','dialog_content','',false);
				//调查正在进行
				if("${kmPindagateMainForm.docStatus}"=='31' && "${canUpdate}" == 'true'){
					dialogContent = "<div style='text-align:center;vertical-align: middle'>"
							+"<img src='${KMSS_Parameter_ContextPath}km/pindagate/images/alerts.gif' height='14px' width='14px' border='0' />&nbsp;"
							+"<bean:message bundle='km-pindagate' key='kmPindagateQuestion.updateAndView.tip'/>"
							.replace("%link%","<a href='javascript:void(0)' onclick='viewResult();'><span class='view_result_url'><bean:message bundle='km-pindagate' key='kmPindagateQuestion.updateAndView'/></span></a>")
							+"</div>";
					showMaskLayer('dialog','dialog_content',dialogContent,true);//显示遮罩层
				}
			});

			//更新统计结果并查看结果
			function viewResult(){
			 _dialog.confirm('<bean:message bundle="km-pindagate" key="kmPindagateResponse.button.updateAndViewResult.confirm" />',function(isOk){
				if(isOk){
					Com_OpenWindow('${LUI_ContextPath}/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&fdId=${kmPindagateMainForm.fdId}&flag=updateStatisticResult');
					}	
				});
			}
			
			//参与人员问卷分析
			function resultDetail(){
				window.open('<c:url value="/km/pindagate/km_pindagate_response/kmPindagateResponse.do" />?method=resultsDetail&fdMainId=${kmPindagateMainForm.fdId}');
			}

			//初始化按钮
			function initPageButton(){
				var currentPage = $('font[name="currentPage"]').html();
				var totalPage = $('font[name="totalPage"]').html();
				if(currentPage == 1){
					LUI("prev1").setDisabled(true);
					LUI("prev2").setDisabled(true);
				}
				if(currentPage==totalPage){
					LUI("next1").setDisabled(true);
					LUI("next2").setDisabled(true);
				}
				if(totalPage==1){
					$("#prev1,#prev2,#next1,#next2").css("display","none");
				}
			}
			
			/**
			* 换页
			* 	   _method : prev(上一页)、next(下一页)、current(当前页)
			*/
			function changePage(_method){
				var currentPage = $('font[name="currentPage"]').html();
				var totalPage = $('font[name="totalPage"]').html();
				if(_method == "prev")
					currentPage = parseInt(currentPage)-1;
				else if(_method == "next")
					currentPage = parseInt(currentPage)+1;
				else
					currentPage = parseInt(currentPage);
				if(currentPage == 1){
					LUI("prev1").setDisabled(true);
					LUI("prev2").setDisabled(true);
				}else{
					LUI("prev1").setDisabled(false);
					LUI("prev2").setDisabled(false);
				}
				if(currentPage == 0){
					_dialog.alert('<bean:message bundle="km-pindagate" key="kmPindagateResponse.alreadyTheFirstPage"/>');
					return;
				}
				if(currentPage > parseInt(totalPage)){
					_dialog.alert('<bean:message bundle="km-pindagate" key="kmPindagateResponse.alreadyTheEndPage"/>');
					return;
				}
				var divID = "";
				totalPage = 1;
				var index = 0;
				for(var i=0;i<questionArray.length;i++){
					var qs=questionArray[i];
					divID = "questions"+qs.index;
					if(qs.fdSplit=="true"){
						totalPage++;
						$('#'+divID).hide();
					}else{
						if(totalPage == currentPage){
							if(pagesInit.get(qs.index)!=true){
								window.eval(''+qs.fdType+'.init(questionArray['+qs.index+'])');
								pagesInit.put(qs.index,true);
							}
							$('#'+divID).show();
						}else{
							$('#'+divID).hide();
						}
					}
				}
				if (currentPage == parseInt(totalPage)) {
					LUI("next1").setDisabled(true);
					LUI("next2").setDisabled(true);
				}else{
					LUI("next1").setDisabled(false);
					LUI("next2").setDisabled(false);
				}
				if (totalPage == 1) {
					$("#prev1,#prev2,#next1,#next2").css("display","none");
				}
				$('font[name="currentPage"]').html(currentPage);
				$('font[name="totalPage"]').html(totalPage);
			}

			/**
			 * 题型定义数组（每个题型的题型定义的属性名跟questiontype包下面各个题型的QuestionType类里面的属性相对应）
			 * 例如：单选题的fdQuestionDef.willAnswer 对应 SingleSelectType类里面的willAnswer属性
			 */
			var fdQuestionDef = new Array();
			// 统计结果定义数组
			var fdStatistic = new Array();
			function Dictionary(){
			 this.data = new Array();
			 this.put = function(key,value){
			  this.data[key] = value;
			 };
			 this.get = function(key){
			  return this.data[key];
			 };
			 this.remove = function(key){
			  this.data[key] = null;
			 };
			 this.isEmpty = function(){
			  return this.data.length == 0;
			 };
			 this.size = function(){
			  return this.data.length;
			 };
			}
			//存储题目是否被初始化信息
			var pagesInit= new Dictionary();
			//
			function openWin(url){
				var obj = new Object;
				obj.totalNum = $("#fdParticipantNum").val();
				window.showModalDialog(url, obj,"dialogWidth=600px;dialogHeight=500px");
			}
		</script>
		<div class='lui_form_title_frame'>
			<%--问卷主题--%>
			<div class='lui_form_subject'>
				<bean:write name="kmPindagateMainForm" property="docSubject" />
			</div>
			<%--须参与调查的人员--%>
			<div class='lui_form_baseinfo'>
				<bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.participantNum"/>
				<font class="com_number"><c:out value="${kmPindagateMainForm.fdParticipantNum}"></c:out></font>
				<input type="hidden" value="${kmPindagateMainForm.fdParticipantNum}" id="fdParticipantNum">
			</div>
		</div>
		<div class='lui_form_content_frame' style="margin:0px 10px;">
			<%--Page--%>
			<div class="page">
				<div class="left">
					<bean:message key="page.the"/><font class="com_number" name="currentPage">1</font><bean:message key="page.page"/>
					<bean:message key="page.total"/><font class="com_number" name="totalPage">1</font><bean:message key="page.page"/>
				</div>
				<div style="float: right;">
					<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.pre')}" onclick="changePage('prev');" id="prev1"></ui:button>&nbsp;
					<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.next')}" onclick="changePage('next');" id="next1"></ui:button>
				</div>
				<div style="clear: both;"></div>
			</div>
			<c:if test="${canViewResult}" >
			<%-- 统计结果--%>
			<div id="viewResult"></div>
			</c:if>
			<%--Page--%>
			<div class="page pageborder">
				<div class="left">
					<bean:message key="page.the"/><font class="com_number" name="currentPage">1</font><bean:message key="page.page"/>
					<bean:message key="page.total"/><font class="com_number" name="totalPage">1</font><bean:message key="page.page"/>
				</div>
				<div style="float: right;">
					<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.pre')}" onclick="changePage('prev');" id="prev2"></ui:button>&nbsp;
					<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.next')}" onclick="changePage('next');" id="next2"></ui:button>
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>
	</template:replace>

</template:include>