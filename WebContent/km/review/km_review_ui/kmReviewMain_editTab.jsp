<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsWebOfficeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<%
	 pageContext.setAttribute("_isJGEnabled", new Boolean(
			com.landray.kmss.sys.attachment.util.JgWebOffice
					.isJGEnabled()));
     pageContext.setAttribute("_isWpsWebOfficeEnable", new Boolean(SysAttWpsWebOfficeUtil.isEnable()));
%>


<template:replace name="content"> 
	<script>
	seajs.use(['lui/jquery','lui/dialog'], function($, dialog){
		<c:if test="${kmReviewMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSign =='true' && yqqFlag=='true'  && kmReviewMainForm.fdSignEnable=='true'}">
		 Com_Parameter.event["submit"].push(function(){
			//操作类型为通过类型 ，才判断是否已经签署
			if(lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
				 var flag = true;
				 var url = Com_Parameter.ContextPath+"km/review/km_review_main/kmReviewOutSign.do?method=queryFinish&signId=${param.fdId}";
				 $.ajax({
						url : url,
						type : 'post',
						data : {},
						dataType : 'text',
						async : false,     
						error : function(){
							dialog.alert('请求出错');
						} ,   
						success:function(data){
							if(data == "true"){
								flag = true;
							}else{
								dialog.alert("当前签署任务未完成，无法提交！！");
								flag = false;
							}
						}
					});
				 return flag;
			}else{
				return true;
			}
			
		 });
	</c:if>
	});
	</script>
	<c:import url="/sys/recycle/import/redirect.jsp">
		<c:param name="formBeanName" value="kmReviewMainForm"></c:param>
	</c:import>
	<c:if test="${kmReviewMainForm.method_GET=='add'}">
		<script type="text/javascript">
			Com_IncludeFile("calendar.js");
			
			window.changeDocTemp = function(modelName,url,canClose){
				if(modelName==null || modelName=='' || url==null || url=='')
					return;
		 		seajs.use(['sys/ui/js/dialog'],function(dialog) {
		 			// 创建文档只需要模板ID即可，额外的参数反而会引起其它问题
		 			//业务活动需要其它参数：#109818
		 			if(url.indexOf('com.landray.kmss.km.bam2.model.KmBam2Project') == -1)
		 			{
		 				url = '/km/review/km_review_main/kmReviewMain.do?method=add&fdTemplateId=!{id}';
		 			}
				 	dialog.categoryForNewFile(modelName,url,false,null,function(rtn) {
						// 无分类状态下（一般于门户快捷操作）创建文档，取消操作同时关闭当前窗口
						if (!rtn){
							window.opener = null;
							window.open("", "_self");
							window.close();
						}
					},'${JsParam.categoryId}','_self',canClose);
			 	});
		 	};
		 	
			if('${JsParam.fdTemplateId}'==''){
				//window.changeDocTemp('com.landray.kmss.km.review.model.KmReviewTemplate','/km/review/km_review_main/kmReviewMain.do?method=add&fdTemplateId=!{id}',true);
				window.changeDocTemp('com.landray.kmss.km.review.model.KmReviewTemplate','/km/review/km_review_main/kmReviewMain.do?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}&fdWorkId=${JsParam.fdWorkId}&fdPhaseId=${JsParam.fdPhaseId}&fdModelId=${JsParam.fdModelId}&fdModelName=${JsParam.fdModelName}',true);
			}
		</script>
	</c:if>
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmReviewMainForm" method="post" action ="${KMSS_Parameter_ContextPath}km/review/km_review_main/kmReviewMain.do">
	</c:if>	
	<html:hidden property="fdId" value="${kmReviewMainForm.fdId}"/>
	<html:hidden property="fdUseWord" value="${kmReviewMainForm.fdUseWord}"/>
	<html:hidden property="fdWorkId" />
	<html:hidden property="fdPhaseId" />
	<html:hidden property="fdModelId" />
	<html:hidden property="fdModelName" />
	<html:hidden property="docStatus" />
	<html:hidden property="fdUseForm" />
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpage collapsed="true" id="reviewTabPage">
				<ui:event event="layoutDone">
					this.element.find(".lui_tabpage_float_collapse").hide();
					this.element.find(".lui_tabpage_float_navs_mark").hide();
			    </ui:event>
				<c:import url="/km/review/km_review_ui/kmReviewMain_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
			</ui:tabpage>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-average='false' var-useMaxWidth='true'>
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmReviewMainForm" />
					<c:param name="fdKey" value="reviewMainDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
				<c:import url="/km/review/km_review_ui/kmReviewMain_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="baseInfo"></c:param>
	  			</c:import>
				<c:import url="/km/review/km_review_ui/kmReviewMain_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%" >
				<c:import url="/km/review/km_review_ui/kmReviewMain_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
				<c:import url="/km/review/km_review_ui/kmReviewMain_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="baseInfo"></c:param>
	  			</c:import>
				<c:import url="/km/review/km_review_ui/kmReviewMain_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	  			</c:import>
			</ui:tabpage>
			</form>
		</c:otherwise>
	</c:choose>
	
	<!-- 表单模式为word模式下，右侧审批模式 伸缩切换，word宽度也需调整-->
	<c:if test="${param.approveModel eq 'right' && kmReviewMainForm.fdUseForm ne 'true' && kmReviewMainForm.fdUseWord eq 'true'}">
		<script>
			$(document).bind("slideSpread",function(){
				 setTimeout(function(){
					var wordFloat = $("#wordEditFloat");
					var reviewButtonDiv = $("#reviewButtonDiv");
					var xw = $("#wordEditWrapper").width();
					wordFloat.css('width',xw+'px');
					reviewButtonDiv.css('width',xw+'px');
				 },300);
		    });
		</script>
	</c:if>
	
	<script language="JavaScript">
		var _reviewValdate = $KMSSValidation(document.forms['kmReviewMainForm']);
		function _changeAttValidate(remove){
			var winObj;
			var top = Com_Parameter.top || window.top;
			try {
				if(top.window){
					winObj = top.window;
				}
			} catch (e) {
				winObj = window;
			}
			if(winObj.Attachment_ObjectInfo){
				for(var tmpKey in winObj.Attachment_ObjectInfo){
					if(winObj.Attachment_ObjectInfo[tmpKey]){
						if(remove){
							winObj.Attachment_ObjectInfo[tmpKey]._reqired = winObj.Attachment_ObjectInfo[tmpKey].required;
							winObj.Attachment_ObjectInfo[tmpKey].required = false;
						}else{
							if(winObj.Attachment_ObjectInfo[tmpKey]._reqired!=null){
								winObj.Attachment_ObjectInfo[tmpKey].required = winObj.Attachment_ObjectInfo[tmpKey]._reqired;
							}
						}
					}
				}
			}
		}
		function _saveDoc(){ 
			_reviewValdate.removeElements($('#kmReviewXform')[0],'required');
			// 移除流程必填校验
			_reviewValdate.removeElements($('#nextNodeRow')[0],'required');
			_changeAttValidate(true);
			Com_Submit(document.kmReviewMainForm, 'saveDraft');
		}
		function _submitDoc(){
			_reviewValdate.resetElementsValidate($('#kmReviewXform')[0]);
			_reviewValdate.resetElementsValidate($('#nextNodeRow')[0]);
			_changeAttValidate(false);
			Com_Submit(document.kmReviewMainForm, 'save');
		}
		function _updateDoc(){ 
			_reviewValdate.removeElements($('#kmReviewXform')[0],'required');
			// 移除流程必填校验
			_reviewValdate.removeElements($('#nextNodeRow')[0],'required');
			_changeAttValidate(true);
			Com_Submit(document.kmReviewMainForm, 'update');
		}
		function _updateDraft(){ 
			_reviewValdate.removeElements($('#kmReviewXform')[0],'required');
			// 移除流程必填校验
			_reviewValdate.removeElements($('#nextNodeRow')[0],'required');
			_changeAttValidate(true);
			Com_Submit(document.kmReviewMainForm, 'updateDraft');
		}
		function _publishDraft(){
			_reviewValdate.resetElementsValidate($('#kmReviewXform')[0]);
			_reviewValdate.resetElementsValidate($('#nextNodeRow')[0]);
			_changeAttValidate(false);
			Com_Submit(document.kmReviewMainForm, 'publishDraft');
		}
		
		// ADD BY WUZB 20171102
		function checkEditType(useForm,useWord){
			if('true' == useWord && 'true' != useForm){
				var _wordEdit = $('#wordEdit');
				var wordFloat = $("#wordEditFloat");
				var reviewButtonDiv = $("#reviewButtonDiv");
				_wordEdit.css({'display':"block",'width':"100%",'height':"600px"});
				var xw = $("#wordEditWrapper").width();
				wordFloat.css({'width':xw+'px','height':'600px','filter':'alpha(opacity=100)','opacity':'1'});
				reviewButtonDiv.css({'width':xw+'px','height':'25px','filter':'alpha(opacity=100)','opacity':'1'});
				
				if ("${pageScope._isWpsWebOfficeEnable}" == "true" ){
					wps_mainContent.load();
				}else{
					var obj_JG = document.getElementById("JGWebOffice_mainContent");
					if ("${pageScope._isJGEnabled}" == "true"&& obj_JG) {
						
						setTimeout(function(){
							var winObj;
							var top = Com_Parameter.top || window.top;
							try {
								if(top.window){
									winObj = top.window;
								}
							} catch (e) {
								winObj = window;
							}
							 if(winObj.Attachment_ObjectInfo['mainContent']){
								jg_attachmentObject_mainContent.load();
								jg_attachmentObject_mainContent.show();
								jg_attachmentObject_mainContent.ocxObj.Active(true);
							 }
							},1500);
						
						seajs.use(['lui/topic'],function(topic){
							topic.subscribe("Sidebar",function(data){
								var xw = $("#wordEditWrapper").width();
								wordFloat.css({'width':xw+'px','height':'600px','filter':'alpha(opacity=100)','opacity':'1','overflow':'hidden'});
								reviewButtonDiv.css({'width':xw+'px','height':'25px','filter':'alpha(opacity=100)','opacity':'1','overflow':'hidden'});
							});
						});
						
						$("#JGWebOffice_mainContent").height("600px");
						
					}
					
				}
				
			}
		}

		// ADD BY WUZB 20171102
		LUI.ready(function(){
			checkEditType('${kmReviewMainForm.fdUseForm}','${kmReviewMainForm.fdUseWord}');
		});

		// ADD BY WUZB 20171102
		Com_Parameter.event["submit"].push(function(){
			var useWord = document.getElementsByName('fdUseWord')[0];
			var winObj;
			var top = Com_Parameter.top || window.top;
			try {
				if(top.window){
					winObj = top.window;
				}
			} catch (e) {
				winObj = window;
			}
			if ("true" == useWord.value) {
				if ("${pageScope._isWpsWebOfficeEnable}" != "true" && "${pageScope._isJGEnabled}" == "true") {
					
					var obj_JG = document.getElementById("JGWebOffice_mainContent");
					if(obj_JG&&winObj.Attachment_ObjectInfo['mainContent']&&jg_attachmentObject_mainContent.hasLoad){
						jg_attachmentObject_mainContent.ocxObj.Active(true);
						jg_attachmentObject_mainContent._submit();
						return true;
			    	 }
				} else {
					if ("${pageScope._isWpsWebOfficeEnable}" == "true" ){
						wps_mainContent.submit();
					}
				}
			}else{
				if ("${pageScope._isWpsWebOfficeEnable}" != "true" && "${pageScope._isJGEnabled}" == "true") {
					if("${kmReviewMainForm.method_GET}"=="add"){
			       		 if(winObj.Attachment_ObjectInfo['mainContent']){
			       			jg_attachmentObject_mainContent.unLoad();
			       		 }
			       	 }
				}
			}
			return true;
		});
	</script>
	<c:if test="${kmReviewMainForm.docStatus=='10' && kmReviewMainForm.fdIsImportXFormData == 'true'}">
		<script language="JavaScript">
			Com_IncludeFile("sysFormMainImport.js",Com_Parameter.ContextPath + "sys/xform/impt/js/","js",true);
			$(function(){
				getImportXFormDataSetting('com.landray.kmss.km.review.model.KmReviewTemplate');
			});
		</script>
	</c:if>
</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmReviewMainForm" />
					<c:param name="fdKey" value="reviewMainDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmReviewMainForm" />
					<c:param name="approveType" value="right" />
					<c:param name="needTitle" value="true" />
				</c:import>
			</ui:tabpanel>
		</template:replace>
	</c:when>
	<c:otherwise>
		<template:replace name="nav">
			<%--关联机制(与原有机制有差异)--%>
			<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmReviewMainForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>