<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>

<template:replace name="content"> 
	<script type="text/javascript">
		Com_IncludeFile("calendar.js");
		//提交表单
		function commitMethod(commitType, saveDraft){
			var formObj = document.kmInstitutionKnowledgeForm;
			var docStatus = document.getElementsByName("docStatus")[0];
			if(saveDraft=="true"){
				docStatus.value="10";
			}else{
				docStatus.value="20";
			}
			if('save'==commitType){
				Com_Submit(formObj, commitType,'fdId');
		    }else{
		    	Com_Submit(formObj, commitType); 
		    }
		}

		function confirmChgCate(modeName,url,canClose){
			seajs.use(['sys/ui/js/dialog'],	function(dialog) {
				dialog.confirm("${lfn:message('km-institution:kmInstitution.changeCate.confirmMsg')}",function(flag){
				if(flag==true){
					window.changeDocCate(modeName,url,canClose);
				}},"warn");
			});
		};
		function changeDocCate(modeName,url,canClose,flag) {
			if(modeName==null || modeName=='' || url==null || url=='')
				return;
			seajs.use(['sys/ui/js/dialog'],	function(dialog) {
				dialog.simpleCategoryForNewFile(modeName,url,false,	function(rtn) {
					// 无分类状态下（一般于门户快捷操作）创建文档，取消操作同时关闭当前窗口
					if (!rtn && flag == "portlet")
						window.close();
				},null,null,"_self",canClose);
			});
		};
		//设置文档默认标题
		function onFinishPostCustom(id){
			var docSubject = document.getElementsByName("docSubject")[0];
			if(!docSubject.value || !$.trim(docSubject.value)){
				var fileList = attachmentObject_attachment.fileList;
				for(var i = 0 ; i < fileList.length;i++ ){
					var file = fileList[i];
					if(file.fileStatus==1){
						var fileName = file.fileName;
						var index = fileName.lastIndexOf(".");
						if(index !=-1){
							fileName =fileName.substring(0,index);
						}
						docSubject.value=fileName;
						_validator.validateElement(docSubject);
						return;
					}
				}
			}	
		};
		
		seajs.use(['lui/jquery','lui/dialog'], function($, dialog){
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
	<%--新建时如果没有选择分类,打开分类选择框--%>
	<c:if test="${kmInstitutionKnowledgeForm.method_GET=='add'}">
		<script language="JavaScript">
		    var _doc_create_url='/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}';
		    if('${JsParam.fdModelId}'!=''){
			   	_doc_create_url += "&fdModelId=${JsParam.fdModelId}&fdModelName=${JsParam.fdModelName}&fdWorkId=${JsParam.fdWorkId}&fdPhaseId=${JsParam.fdPhaseId}";
			}   
		    if('${JsParam.fdTemplateId}'==''&&'${JsParam.originId}'==''){
		   		changeDocCate('com.landray.kmss.km.institution.model.KmInstitutionTemplate',_doc_create_url,true,"portlet");
		    }
		</script>
	</c:if>
	<c:if test="${ param.approveModel ne 'right' }">
		<form name="kmInstitutionKnowledgeForm" method="post" action="${KMSS_Parameter_ContextPath}km/institution/km_institution_knowledge/kmInstitutionKnowledge.do">
	</c:if>
	<html:hidden property="fdImportInfo" />
	<html:hidden property="fdId" />
	<html:hidden property="docStatus" />
	<html:hidden property="method_GET" />
	<html:hidden property="docCreateTime"/>
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_editContent.jsp" charEncoding="UTF-8">
 		 		<c:param name="contentType" value="xform" />
  			</c:import>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'
				var-supportExpand="true" var-expand="true">
				<%---发布机制---%>
				<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="fdKey" value="mainDoc" />	 
					<c:param name="isShow" value="true" />
				</c:import>
				
				<%---版本机制---%>
				<c:import url="/sys/edition/import/sysEditionMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				</c:import>
				
				<%--权限机制 --%>
				<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
				</c:import>
			
				<%--流程机制 --%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="fdKey" value="mainDoc" />
					<%-- <c:param name="isExpand" value="true" /> --%>
					<c:param name="approveType" value="right" />
				</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" >
				<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
				<%---发布机制---%>
				<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="fdKey" value="mainDoc" />	 
					<c:param name="isShow" value="true" />
				</c:import>
				
				<%---版本机制---%>
				<c:import url="/sys/edition/import/sysEditionMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				</c:import>
				
				<%--权限机制 --%>
				<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
				</c:import>
			
				<%--流程机制 --%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="fdKey" value="mainDoc" />
				</c:import>
			</ui:tabpage>
			</form>
		</c:otherwise>
	</c:choose>
	
	<script language="JavaScript">
		var _validator = $KMSSValidation(document.forms['kmInstitutionKnowledgeForm']);
	</script>
</template:replace>

<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
		<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
			<c:choose>
				<c:when test="${kmInstitutionKnowledgeForm.docStatus>='30' || kmInstitutionKnowledgeForm.docStatus=='00'}">
					<c:import url="/km/institution/km_institution_ui/kmInstitutionKnowledge_viewBaseInfo.jsp" charEncoding="UTF-8"></c:import>
			 	</c:when>
			 	<c:otherwise>
					<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmInstitutionKnowledgeForm" />
						<c:param name="fdKey" value="mainDoc" />
						<%-- <c:param name="showHistoryOpers" value="true" / >--%>
						<%-- <c:param name="isExpand" value="true" /> --%>
						<c:param name="approveType" value="right" />
						<c:param name="approvePosition" value="right" />
					</c:import>
				</c:otherwise>
			</c:choose>	
			<%--关联机制--%>
			<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				<c:param name="approveType" value="right" />
				<c:param name="needTitle" value="true" />
			</c:import>
		</ui:tabpanel>
	</template:replace>
	</c:when>
	<c:otherwise>
		<%--右侧导航信息--%>
		<template:replace name="nav">
			<div style="min-width:200px;"></div>
			<ui:accordionpanel style="min-width:200px;">
				<%--文档信息--%>
				<ui:content title="${lfn:message('km-institution:kmInstitution.kmInstitutionKnowledge.docInfo') }">
					<ul class='lui_form_info'>
						<li><bean:message bundle="sys-doc" key="sysDocBaseInfo.docCreator" />：
							<xform:address propertyId="docCreatorId" propertyName="docCreatorName" showLink="true" showStatus="view"></xform:address>
						</li>
						<li><bean:message bundle="sys-doc" key="sysDocBaseInfo.docStatus" />：
							<sunbor:enumsShow value="${(kmInstitutionKnowledgeForm.docStatus==null)?10:(kmInstitutionKnowledgeForm.docStatus)}" enumsType="kmInstitutionKnowledge_docStaus" />
						</li>
						<li><bean:message bundle="sys-edition" key="sysEditionMain.tab.label" />：${kmInstitutionKnowledgeForm.editionForm.currentVersion}</li>
						<li><bean:message bundle="sys-doc" key="sysDocBaseInfo.docCreateTime" />：${ kmInstitutionKnowledgeForm.docCreateTime}</li>				
					</ul>
				</ui:content>
			</ui:accordionpanel> 
			<%--关联机制--%>
			<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmInstitutionKnowledgeForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>