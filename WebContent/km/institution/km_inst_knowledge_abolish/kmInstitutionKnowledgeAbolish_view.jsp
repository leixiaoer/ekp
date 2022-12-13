<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${kmInstitutionKnowledgeAbolishForm.docSubject}"></c:out>
	</template:replace>
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<%--编辑--%>
			<c:if test="${kmInstitutionKnowledgeAbolishForm.docStatus != '30'}">
				<kmss:auth
					requestURL="/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=edit&fdId=${param.fdId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('button.edit')}" 
						onclick="Com_OpenWindow('kmInstitutionKnowledgeAbolish.do?method=edit&fdId=${param.fdId}','_self');" order="2">
					</ui:button>
				</kmss:auth>
			</c:if>
			<%--删除--%>
			<%-- <c:if test="${kmInstitutionKnowledgeAbolishForm.docStatus == '30' || kmInstitutionKnowledgeAbolishForm.docStatus == '10' }"> --%>
			<kmss:auth
				requestURL="/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=delete&fdId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}" order="4"
						onclick="deleteDoc('kmInstitutionKnowledgeAbolish.do?method=delete&fdId=${param.fdId}');">
				</ui:button>
			</kmss:auth>
			<%-- </c:if> --%>
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
					href="/km/institution/"
					categoryId="${kmInstitutionKnowledgeForm.fdDocTemplateId}" />
		</ui:combin>
	</template:replace>
	
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
		</style>
		<script type="text/javascript">
			Com_IncludeFile("dialog.js|docutil.js");
			seajs.use(['lui/dialog'],function(dialog){
				//删除
				window.deleteDoc = function(delUrl){
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(isOk){
						if(isOk){
							Com_OpenWindow(delUrl,'_self');
						}	
					});
					return;
				};
			});
		</script>
		
		<div class='lui_form_title_frame'>
			<%--文档标题--%>
			<div class='lui_form_subject' >
				<bean:write name="kmInstitutionKnowledgeAbolishForm" property="docSubject" />
			</div>
		</div>
		
		<div style="height: 15px;"></div>
		
		<%--文档内容 --%>
		<div class="lui_form_content_frame">
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%><bean:message bundle="km-institution" key="kmInstitution.fdAbolishDoc" /></td>
					<td width=85%>
						<a class="btn_txt" onclick="Com_OpenNewWindow(this)" data-href="<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do" />?method=view&fdId=${kmInstitutionKnowledgeAbolishForm.fdAbolishDocId}" target="_blank">
						${kmInstitutionKnowledgeAbolishForm.fdAbolishDocName}
						</a>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message bundle="km-institution" key="kmInstitution.fdAbolishDescription" /></td>
					<td width=85%>
						<c:out value="${kmInstitutionKnowledgeAbolishForm.fdAbolishDescription}" escapeXml="true"></c:out>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message bundle="km-institution" key="kmInstitution.fdAbolisher" /></td>
					<td width=85%>
						<ui:person personId="${ kmInstitutionKnowledgeAbolishForm.docCreatorId }" personName="${ kmInstitutionKnowledgeAbolishForm.docCreatorName}" layer="true"></ui:person>
					</td>
				</tr>
				<c:if test="${kmInstitutionKnowledgeAbolishForm.docStatus == '30'}">
				<tr>
					<td class="td_normal_title" width=15%><bean:message bundle="km-institution" key="kmInstitution.fdAbolishTime" /></td>
					<td width=85%>
						${ kmInstitutionKnowledgeAbolishForm.fdAbolishTime }
					</td>
				</tr>
				</c:if>
			</table>
		</div>
		
		<div style="height: 15px;"></div>
		
		<ui:tabpage expand="false">
			<%--流程机制 --%>
			<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmInstitutionKnowledgeAbolishForm" />
				<c:param name="fdKey" value="mainDoc" />
			</c:import>
		</ui:tabpage>
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