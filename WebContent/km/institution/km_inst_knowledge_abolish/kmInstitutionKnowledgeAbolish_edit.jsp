<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<template:include ref="default.edit" sidebar="auto">
	<%--标签页标题--%>
	<template:replace name="title">
		<c:out value="${kmInstitutionKnowledgeAbolishForm.docSubject}"></c:out>
	</template:replace>
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:if test="${kmInstitutionKnowledgeAbolishForm.docStatusFirstDigit=='1'}">
				<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('update','true');">
				</ui:button>
			</c:if>
			<c:if test="${kmInstitutionKnowledgeAbolishForm.docStatusFirstDigit<'3'}">
				<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('update','false');">
				</ui:button>
			</c:if>
			<c:if test="${kmInstitutionKnowledgeAbolishForm.docStatusFirstDigit>='3'}">
				<ui:button text="${lfn:message('button.submit') }" order="2" onclick="Com_Submit(document.kmInstitutionKnowledgeAbolishForm, 'update');">
				</ui:button>
			</c:if>			
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
				var formObj = document.kmInstitutionKnowledgeAbolishForm;
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
		</script>
		
		<div class='lui_form_title_frame'>
			<%--文档标题--%>
			<div class='lui_form_subject' >
				<bean:write name="kmInstitutionKnowledgeAbolishForm" property="docSubject" />
			</div>
		</div>
		
		<html:form action="/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do">
			<html:hidden property="fdId" />
			<html:hidden property="docStatus" />
			<html:hidden property="docSubject" />
			<html:hidden property="docCreatorId" />
			<html:hidden property="fdAbolishDocId" />
			<html:hidden property="method_GET" />
			<div class="lui_form_content_frame" style="padding-top: 20px;">
			<table class="tb_simple" width=100%>
				<tr>		
					<%--失效原因--%>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-institution" key="kmInstitution.fdAbolishDescription" />
					</td>
					<td colspan="3">
						<xform:textarea property="fdAbolishDescription" style="width:95%;height:100px" required="true"></xform:textarea>
					</td> 
				</tr>
				<tr>
					<%--操作者--%>
					<td width="15%" class="td_normal_title">
						<bean:message bundle="km-institution" key="kmInstitution.fdAbolisher" />
					</td>
					<td colspan="3">
						${kmInstitutionKnowledgeAbolishForm.docCreatorName}
					</td>
				</tr>
			</table>
			</div>
			<ui:tabpage expand="false" >
				<%--流程机制 --%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeAbolishForm" />
					<c:param name="fdKey" value="mainDoc" />
				</c:import>
				
			</ui:tabpage>
		</html:form>
		<script language="JavaScript">
			var _validator = $KMSSValidation(document.forms['kmInstitutionKnowledgeAbolishForm']);
		</script>
	</template:replace>
	
	<%--右侧导航信息--%>
	<template:replace name="nav">
		<div style="min-width:200px;"></div>
		<ui:accordionpanel style="min-width:200px;"> 
			<ui:content title="${lfn:message('km-institution:kmInstitution.kmInstitutionKnowledge.docInfo')}">
				<ul class='lui_form_info'>
					<li><bean:message bundle="sys-doc" key="sysDocBaseInfo.docStatus" />：<sunbor:enumsShow value="${kmInstitutionKnowledgeAbolishForm.docStatus}"	enumsType="kmInstitutionKnowledge_docStaus" /></li>
					<li><bean:message bundle="km-institution" key="kmInstitution.fdAbolisher" />：
						<ui:person personId="${ kmInstitutionKnowledgeAbolishForm.docCreatorId }"
									personName="${ kmInstitutionKnowledgeAbolishForm.docCreatorName}"
									layer="true"></ui:person>
					</li>
				</ul>
			</ui:content>
		</ui:accordionpanel>
	</template:replace>
	
</template:include>