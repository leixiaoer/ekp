<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<template:include ref="default.edit" sidebar="auto">
	<%--标签页标题--%>
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmInstitutionKnowledgeForm.method_GET == 'add' }">
				<c:out value="${ lfn:message('km-institution:kmInstitution.create.title') } - ${ lfn:message('km-institution:table.kmInstitutionKnowledge') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmInstitutionKnowledgeForm.docSubject} - ${ lfn:message('km-institution:table.kmInstitutionKnowledge') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:choose>
				<%--add页面的按钮--%>
				<c:when test="${ kmInstitutionKnowledgeForm.method_GET == 'add' }">
					<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('save','true');">
					</ui:button>
					<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('save','false');">
					</ui:button>
				</c:when>
				<%--edit页面的按钮--%>
				<c:when test="${ kmInstitutionKnowledgeForm.method_GET == 'edit' }">
					<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit=='1'}">
						<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('update','true');">
						</ui:button>
					</c:if>
					<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit<'3'}">
						<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('update','false');">
						</ui:button>
					</c:if>
					<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit>='3'}">
						<ui:button text="${lfn:message('button.submit') }" order="2" onclick="Com_Submit(document.kmInstitutionKnowledgeForm, 'update');">
						</ui:button>
					</c:if>			
				</c:when>
			</c:choose>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<%--路径导航栏--%>
	<template:replace name="path">
		<ui:combin ref="menu.path.simplecategory">
				<ui:varParams 
					moduleTitle="${ lfn:message('km-institution:table.kmInstitutionKnowledge') }" 
					modulePath="/km/institution/" 
					modelName="com.landray.kmss.km.institution.model.KmInstitutionTemplate" 
					autoFetch="false"
					categoryId="${kmInstitutionKnowledgeForm.fdDocTemplateId}" />
		</ui:combin>
	</template:replace>
	<%--左侧主内容--%>
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
		<html:form action="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do">
			<html:hidden property="fdImportInfo" />
			<html:hidden property="fdId" />
			<html:hidden property="docStatus" />
			<html:hidden property="method_GET" />
			<html:hidden property="docCreateTime"/>
			<div class="lui_form_content_frame" style="padding-top: 20px;">
			<table class="tb_simple" width=100%>
				<tr>
					<%--文档标题--%>
					<td width="15%" class="td_normal_title">
						<bean:message bundle="km-institution" key="kmInstitution.docSubject" />
					</td>
					<td colspan="3">
						<xform:text property="docSubject" className="inputsgl" style="width:97%;"  />
					</td>
				</tr>
				<tr>
					<%--文件编号--%>
					<td width="15%" class="td_normal_title">
						<bean:message bundle="km-institution" key="kmInstitution.fdNumber" />
					</td>
					<td colspan="3">
						<c:choose>	
							<c:when test="${sysNumberFlag eq 'unlimited'}">
								<xform:text property="fdNumber" className="inputsgl" style="width:97%;"  />
							<c:if test="${ kmInstitutionKnowledgeForm.method_GET == 'add' }">
							<script type="text/javascript">
								$(function() {
									var noPer = "<bean:message key="kmInstitutionKnowledge.no.per" bundle="km-institution" />";
									if(noPer == $("input[name=fdNumber]").val()) {
										$("input[name=fdNumber]").val("");
									}
								});
							</script>
							</c:if>
							</c:when>
							<c:otherwise>
								<html:text property="fdNumber" readonly="true" style="width:95%"/>
								<c:if test="${ kmInstitutionKnowledgeForm.method_GET == 'add' }">
								<script type="text/javascript">
									$(function() {
										$("input[name=fdNumber]").val("<bean:message key="kmInstitutionKnowledge.no.per" bundle="km-institution" />");
									});
								</script>
								</c:if>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<%--所属分类--%>
					<td class="td_normal_title" width="15%">
						<bean:message key="kmInstitutionKnowledge.fdTemplateName" bundle="km-institution" />
					</td>
					<td <%=ISysAuthConstant.IS_AREA_ENABLED? "width='35%'":"colspan='3'"%>>
						<html:hidden property="fdDocTemplateId" /> 
						<bean:write name="kmInstitutionKnowledgeForm" property="fdDocTemplateName" />
						<c:if test="${kmInstitutionKnowledgeForm.method_GET=='add' and newEdition eq 'false'}">
							&nbsp;&nbsp;
							<a class="com_btn_link" href="javascript:confirmChgCate('com.landray.kmss.km.institution.model.KmInstitutionTemplate',_doc_create_url,true);">
								<bean:message key="kmInstitution.changeCate" bundle="km-institution" />
							</a>
						</c:if>
					</td>
					 <%-- 所属场所 --%>
	               <c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field_single.jsp" charEncoding="UTF-8">
	                   <c:param name="id" value="${kmInstitutionKnowledgeForm.authAreaId}"/>
	               </c:import>  
				</tr>
				<tr>
					<%--所属部门--%>
					<td width="15%" class="td_normal_title">
						<bean:message bundle="sys-doc" key="sysDocBaseInfo.docDept" />
					</td>
					<td colspan="3">
						<xform:address isLoadDataDict="false" required="true" subject="${lfn:message('sys-doc:sysDocBaseInfo.docDept') }" style="width:97%" propertyId="docDeptId" propertyName="docDeptName" orgType='ORG_TYPE_ORGORDEPT'></xform:address>
					</td>    
				</tr>
				<tr>
					<%--发布时间--%>
					<td width="15%" class="td_normal_title">
						<bean:message bundle="km-institution" key="kmInstitution.docPublishTime" />
					</td>
					<td colspan="3" >
						<xform:datetime isLoadDataDict="false"  property="docPublishTime" style="width:40%" dateTimeType="date" />
						<span style="position: relative;top: -10px;"><bean:message bundle="km-institution" key="kmInstitution.docpublishTime.tips" /></span>
					</td>
				</tr>
				<tr>
					<%--过期时间--%>
					<td width="15%" class="td_normal_title">
						<bean:message bundle="km-institution" key="kmInstitution.fdOverdue" />
					</td>
					<td colspan="3" >
						<xform:datetime isLoadDataDict="false"  property="fdOverdue" style="width:40%" dateTimeType="date" />
						<span style="position: relative;top: -10px;"><bean:message bundle="km-institution" key="kmInstitution.fdOverdue.tips" /></span>
					</td>
				</tr>
				<tr>		
					<%--辅类别--%>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-institution" key="kmInstitution.docProperties" />
					</td>
					<td colspan="3">
						<xform:dialog style="width:98%;" propertyId="docPropertiesIds" propertyName="docPropertiesNames">
							Dialog_property(true, 'docPropertiesIds','docPropertiesNames', ';', ORG_TYPE_PERSON);
						</xform:dialog>
					</td> 
				</tr>
				<%-- 标签机制 --%>
				<c:import url="/sys/tag/import/sysTagMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="fdKey" value="mainDoc" /> 
					<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
					<c:param name="fdQueryCondition" value="fdDocTemplateId;docDeptId" /> 
				</c:import>
				<%--内容、附件--%>
				<tr>
					<td width="15%" class="td_normal_title" valign="top">
						<bean:message bundle="km-institution" key="kmInstitution.docContent" />
					</td>
					<td width="85%" colspan="3">
						<kmss:editor property="docContent" toolbarSet="Default" height="300" width="98%"/>
					</td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title" valign="top">
						<bean:message bundle="sys-doc" key="sysDocBaseInfo.docAttachments" />
					</td>
					<td width="85%" colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="attachment" />
							<c:param name="uploadAfterSelect" value="true" />
						</c:import>
					</td>
				</tr>
			</table>
			</div>
			<ui:tabpage expand="false" >
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
		</html:form>
		<script language="JavaScript">
			var _validator = $KMSSValidation(document.forms['kmInstitutionKnowledgeForm']);
		</script>
	</template:replace>
	
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
	
</template:include>