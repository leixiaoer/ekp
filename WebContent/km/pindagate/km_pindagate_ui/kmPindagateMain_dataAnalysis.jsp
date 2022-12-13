<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view"  sidebar="no" width="980px" showQrcode="false">
	<!--网上调查CSS-->
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/km/pindagate/vote.css">
	</template:replace>
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${kmPindagateMainForm.docSubject}-${lfn:message('km-pindagate:kmPindagate.tree.analyze')}-${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
	</template:replace>
	<%--路径导航--%>
	<template:replace name="path">
		<ui:combin ref="menu.path.category">
			<ui:varParams moduleTitle="${ lfn:message('km-pindagate:module.km.pindagate') }" 
			    modulePath="/km/pindagate/" 
				modelName="com.landray.kmss.km.pindagate.model.KmPindagateTemplate" 
				autoFetch="false"	
				href="/km/pindagate/"
				categoryId="${kmPindagateMainForm.fdTemplateId}" />
		</ui:combin>
	</template:replace>	
	<%--分析结果--%>
	<template:replace name="content">
		<%--提示信息--%>
		<div id="dialog"> <div id="dialog_content"></div></div> 
		<script type="text/javascript" src='<c:url value="/km/pindagate/km_pindagate_statistic_ui/js/dataAnalysis/init.js"/>'></script>
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
			var dialogContent = "<div style='text-align:center;vertical-align: middle'><img src='${KMSS_Parameter_StylePath}icons/loading.gif' border='0'><bean:message bundle='km-pindagate' key='kmPindagateResponse.loading'/></div>";
			showMaskLayer('dialog','dialog_content',dialogContent);//显示遮罩层
			
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
			LUI.ready(function (){
				changePage();
				showMaskLayer('dialog','dialog_content','',false);
			});
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
			<%--分页--%>
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
			<%-- 分析结果--%>
			<div id="dataAnalysis"></div>
			<%--分页--%>
			<div class="page pageborder">
				<div class="left">
					<bean:message key="page.the"/><font class="com_number" name="currentPage">1</font><bean:message key="page.page"/>
					<bean:message key="page.total"/><font class="com_number" name="totalPage">1</font><bean:message key="page.page"/>
				</div>
				<div style="float: right;">
					<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.pre')}" onclick="changePage('prev');" id="prev2"></ui:button>&nbsp;
					<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.next')}" onclick="changePage('next');" id="next2"></ui:button>
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
		<DIV id="dHTMLToolTip" style="Z-INDEX: 1000; LEFT: 0px; VISIBILITY: hidden; WIDTH: 10px; POSITION: absolute; TOP: 0px; HEIGHT: 10px"></DIV>
	</template:replace>
</template:include>