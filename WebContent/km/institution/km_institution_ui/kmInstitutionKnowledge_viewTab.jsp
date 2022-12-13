<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.institution.forms.KmInstitutionKnowledgeForm"%>
<%@ page import="com.landray.kmss.km.institution.util.AbolishUtil"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>	
<%@ include file="/sys/ui/jsp/common.jsp"%>

<%--主文档--%>
<template:replace name="content"> 
	<style>
	.btn_txt {
		margin: 0px 2px;
		color: #2574ad;
		border-bottom: 1px solid transparent;
	}
	
	.btn_txt:hover {
		text-decoration: underline;
	}
	.lui_upload_img_box {
		width: 100%!important;
		display: block!important;
	}
	</style>
	<script type="text/javascript">
		Com_IncludeFile("dialog.js|docutil.js");
		seajs.use(['lui/dialog','lui/topic'],function(dialog,topic){
			//删除
			window.deleteDoc = function(delUrl){
            		var delUrl = '<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do"/>?method=delete&fdId=${param.fdId}';
            		dialog.iframe('/sys/edition/import/doc_delete_iframe.jsp?fdModelName=com.landray.kmss.km.institution.model.KmInstitutionKnowledge&fdModelId=${param.fdId}',
            					  "<bean:message key='ui.dialog.operation.title' bundle='sys-ui'/>",function (url){
       		                    if(url) 
       		                    {
       		                 	   Com_OpenWindow(url, '_self');
       		                    }
            					  },{width:400,height:170,params:{url:delUrl,type:'GET'}}
            					 );
				};
			//失效
			window.abolishDoc = function(abolishUrl){
				
				if (checkIsAbolish()) {
					dialog.alert('<bean:message bundle="km-institution" key="kmInstitution.abolishDoc.repeat"/>');
				} else {
					dialog.iframe("/km/institution/km_institution_ui/kmInstitutionKnowledge_setDescription.jsp?docPublishTime=${kmInstitutionKnowledgeForm.docPublishTime}","${lfn:message('km-institution:kmInstitutionKnowledge.setTimeDialog')}",function(abolishData){
						if(abolishData && abolishData.abolishDescription && abolishData.abolishTime) {
							doPost(abolishUrl, {"fdAbolishDescription":abolishData.abolishDescription, "fdAbolishTime":abolishData.abolishTime});
						}
					},{width:550,height:400});
				}
			};
			
			window.checkIsAbolish = function() {
				var fdAbolishDocId = "${param.fdId}";
				var flag = false;
				$.ajax({
					url : "${KMSS_Parameter_ContextPath}km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=checkIsAbolish",
					type: "GET",
					async:false,    //用同步方式 
					data:{
						fdAbolishDocId : fdAbolishDocId
					},
					success: function(data){
						data = eval('(' + data + ')');
						console.log(data);
						if(data.fdIsAbolish == "true"){
							flag = true;
						}
					}
				})
				return flag;
			}
			
			window.copyLink = function(){
				var fdId = '${kmInstitutionKnowledgeForm.fdId}';
				var fdCopyUrl = Com_GetCurDnsHost()+"${LUI_ContextPath}/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&topEdition=true&fdId=" + fdId;
				var result = '';
				if(window.clipboardData){
					result= window.clipboardData.setData('text', fdCopyUrl);
				}
				else
				{
					dialog.alert("<bean:message key="kmInstitution.message.copyLinkError" bundle="km-institution" />");
				}
				if (result) {
					dialog.alert("<bean:message key="kmInstitution.message.copyLinkSucess" bundle="km-institution" />");
				}
			};
			window.doPost = function(toUrl, param){
				var myForm = document.createElement("form");
				myForm.method = "post";
				myForm.action = toUrl;
				for (var input in param) {
					var myInput = document.createElement("input");
					myInput.setAttribute("name", input);
					myInput.setAttribute("value", param[input]);
					myForm.appendChild(myInput);
				}
				document.body.appendChild(myForm);
				myForm.submit();
				document.body.removeChild(myForm);
			}
		});
		
		seajs.use(['lui/jquery','lui/dialog'], function($, dialog){
			 window.yqq=function(){
				 var ajaxUrl = Com_Parameter.ContextPath+"km/institution/km_institution_out_sign/kmInstitutionOutSign.do?method=queryStatus&signId=${param.fdId}";
				 var ajaxUrl2 = Com_Parameter.ContextPath+"km/institution/km_institution_out_sign/kmInstitutionOutSign.do?method=validateOnce&signId=${param.fdId}";
					$.ajax({
						url : ajaxUrl,
						type : 'post',
						data : {},
						dataType : 'text',
						async : true,     
						error : function(){
							dialog.alert('请求出错');
						} ,   
						success : function(data) {
							if(data == "false"){
								$.ajax({
									url : ajaxUrl2,
									type : 'post',
									data : {},
									dataType : 'text',
									async : true,     
									error : function(){
										dialog.alert('请求出错');
									} ,   
									success:function(data){
										if(data == "true"){
											dialog.alert("当前制度信息已经发送过易企签签署，签署事件未完成，请完成后再查看签署！！");
										}else{
											var infoUrl = "/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=openYqqExtendInfo&signId=${param.fdId}";
											var extendIframe=dialog.iframe(infoUrl,"签署平台签署",null,{width:1200, height:600, topWin : window, close: true});
										}
									}
								});
							}else{
								var extendIframe=dialog.iframe(data,"签署平台签署",null,{width:1200, height:600, topWin : window, close: true});
							}
						}
					}); 
				
			 }
			 
			 <c:if test="${kmInstitutionKnowledgeForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSign =='true' && yqqFlag=='true' && kmInstitutionKnowledgeForm.fdSignEnable=='true'}">
			 Com_Parameter.event["submit"].push(function(){
				//操作类型为通过类型 ，才判断是否已经签署
				if(lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
					 var flag = true;
					 var url = Com_Parameter.ContextPath+"km/institution/km_institution_out_sign/kmInstitutionOutSign.do?method=queryFinish&signId=${param.fdId}";
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
	
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_viewContent.jsp" charEncoding="UTF-8">
 		 		<c:param name="contentType" value="xform" />
  			</c:import>
			<br>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'
				var-supportExpand="true" var-expand="true">
				<c:choose>
					<c:when test="${kmInstitutionKnowledgeForm.docStatus>='30' || kmInstitutionKnowledgeForm.docStatus=='00'}">
						<!-- 流程 -->
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmInstitutionKnowledgeForm" />
							<c:param name="fdKey" value="mainDoc" />
							<%-- <c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" /> --%>
							<c:param name="approveType" value="right" />
							<c:param name="needInitLbpm" value="true" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmInstitutionKnowledgeForm" />
							<c:param name="fdKey" value="mainDoc" />
							<%-- <c:param name="showHistoryOpers" value="true" /> --%>
							<c:param name="approveType" value="right" />
							<%-- <c:param name="isExpand" value="true" /> --%>
						</c:import>
					</c:otherwise>
				</c:choose>
				<%--传阅机制 --%>
				<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				</c:import>
				<%--收藏机制 --%>
				<c:import url="/sys/bookmark/import/bookmark_bar.jsp" charEncoding="UTF-8">
					<c:param name="fdSubject" value="${kmInstitutionKnowledgeForm.docSubject}" />
					<c:param name="fdModelId" value="${kmInstitutionKnowledgeForm.fdId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
				</c:import>
				
				<%--阅读机制 --%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				</c:import>
				
				<%--发布机制（文档状态为“发布”时，才能发布文档） --%>
				<c:if test="${kmInstitutionKnowledgeForm.docStatus == '30'}">
				<c:import url="/sys/news/import/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				</c:import> 
				</c:if>
				
				<%--版本机制 --%>
				<c:import url="/sys/edition/import/sysEditionMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				</c:import>
				
				<%--权限机制 --%>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
				</c:import>
	  			
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" collapsed="${collapsed}">
				<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_viewContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform" />
	  			</c:import>
	  			<%--传阅机制 --%>
				<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				</c:import>
				<%--收藏机制 --%>
				<c:import url="/sys/bookmark/import/bookmark_bar.jsp" charEncoding="UTF-8">
					<c:param name="fdSubject" value="${kmInstitutionKnowledgeForm.docSubject}" />
					<c:param name="fdModelId" value="${kmInstitutionKnowledgeForm.fdId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
				</c:import>
				
				<%--阅读机制 --%>
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				</c:import>
				
				<%--发布机制（文档状态为“发布”时，才能发布文档） --%>
				<c:if test="${kmInstitutionKnowledgeForm.docStatus == '30'}">
				<c:import url="/sys/news/import/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				</c:import> 
				</c:if>
				
				<%--版本机制 --%>
				<c:import url="/sys/edition/import/sysEditionMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				</c:import>
				
				<%--权限机制 --%>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
				</c:import>
			
				<%--流程机制 --%>
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="fdKey" value="mainDoc" />
				</c:import>
				
			</ui:tabpage>
		</c:otherwise>
	</c:choose>
	
	<c:set var="collapsed" value="false"></c:set>
	<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit>='3'}">
		<c:set var="collapsed" value="true"></c:set>
	</c:if>
	
</template:replace>

<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<c:choose>
				<c:when test="${kmInstitutionKnowledgeForm.docStatus>='30' || kmInstitutionKnowledgeForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_viewBaseInfo.jsp" charEncoding="UTF-8"></c:import>
						<%--关联机制 --%>
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmInstitutionKnowledgeForm" />
							<c:param name="approveType" value="right" />
						</c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
	               		<%--流程机制 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmInstitutionKnowledgeForm" />
							<c:param name="fdKey" value="mainDoc" />
		                    <c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
	               		</c:import>
	               		<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmInstitutionKnowledgeForm" />
							<c:param name="fdModelId" value="${kmInstitutionKnowledgeForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
						</c:import>
	               		<%--关联机制 --%>
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmInstitutionKnowledgeForm" />
							<c:param name="approveType" value="right" />
							<c:param name="needTitle" value="true" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_viewBaseInfo.jsp" charEncoding="UTF-8"></c:import>
					</ui:tabpanel>
				</c:otherwise>
			</c:choose>
		</template:replace>
	</c:when>
	<c:otherwise>
		<%--右侧导航信息--%>
		<template:replace name="nav">
			<div style="min-width:200px;"></div>
			<ui:accordionpanel style="min-width:200px;"> 
				<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_viewContent.jsp" charEncoding="UTF-8">
		 			<c:param name="contentType" value="info" />
				</c:import>
			</ui:accordionpanel>
			<%--关联机制 --%>
			<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmInstitutionKnowledgeForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>
