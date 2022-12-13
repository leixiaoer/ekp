<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.institution.forms.KmInstitutionKnowledgeForm"%>
<%@ page import="com.landray.kmss.km.institution.util.AbolishUtil"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>	
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${kmInstitutionKnowledgeForm.docSubject} - ${ lfn:message('km-institution:table.kmInstitutionKnowledge') }"></c:out>
	</template:replace>
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<link href="${LUI_ContextPath}/km/institution/resource/style/default/expire.css" rel="stylesheet" type="text/css"/>
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<%--编辑--%>
			<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit > '0' }">
				<kmss:auth
					requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=edit&fdId=${param.fdId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('button.edit')}" 
						onclick="Com_OpenWindow('kmInstitutionKnowledge.do?method=edit&fdId=${param.fdId}','_self');" order="2">
					</ui:button>
				</kmss:auth> 
			</c:if>
			<%--失效--%>
			<c:if test="${kmInstitutionKnowledgeForm.docStatus == '30' && kmInstitutionKnowledgeForm.docIsNewVersion==true}">
				<kmss:auth
					requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=abolish&fdId=${param.fdId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('km-institution:kmInstitution.button.abolish')}" order="4"
						onclick="abolishDoc('${LUI_ContextPath }/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=abolish&fdAbolishDocId=${param.fdId}');">
					</ui:button>
				</kmss:auth>
			</c:if>
			<%--删除--%>
			<kmss:auth
				requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=delete&fdId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}" order="4"
						onclick="deleteDoc('kmInstitutionKnowledge.do?method=delete&fdId=${param.fdId}');">
				</ui:button>
			</kmss:auth>
			<ui:button text="${lfn:message('km-institution:kmInstitution.button.copyLink')}" order="4" onclick="copyLink();">
			</ui:button>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<%--导航路径--%>
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
					dialog.iframe("/km/institution/km_institution_ui/kmInstitutionKnowledge_setDescription.jsp?docPublishTime=${kmInstitutionKnowledgeForm.docPublishTime}","${lfn:message('km-institution:kmInstitutionKnowledge.setTimeDialog')}",function(abolishData){
						if(abolishData && abolishData.abolishDescription && abolishData.abolishTime) {
							doPost(abolishUrl, {"fdAbolishDescription":abolishData.abolishDescription, "fdAbolishTime":abolishData.abolishTime});
						}
					},{width:550,height:400});
				};
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
		</script>
		<div class='lui_form_title_frame'>
			<%--文档标题--%>
			<div class='lui_form_subject' >
				<bean:write name="kmInstitutionKnowledgeForm" property="docSubject" />
				<c:if test="${isHasNewVersion=='true'}">
					<span style="color:red;cursor:pointer" onclick="Com_OpenWindow('kmInstitutionKnowledge.do?method=view&fdId=${kmInstitutionKnowledgeForm.docOriginDocId}','_self');"><bean:message bundle="km-institution" key="kmInstitution.kmInstitutionKnowledge.hasNewVersion" /></span>
				</c:if>
			</div>
		</div>
		<div style="height: 15px;"></div>
		<%--文档内容 --%>
		<div class="lui_form_content_frame">
			<%-- 文档失效 --%>
			<c:if test="${'50' == kmInstitutionKnowledgeForm.docStatus}">
			<div class="status_expire"></div>
			</c:if>
			<c:if test="${not empty kmInstitutionKnowledgeForm.docContent}">
				<div style="min-height: 200px;">
					<xform:rtf property="docContent"></xform:rtf>
				</div>			
			</c:if>
			<c:if test="${'50' == kmInstitutionKnowledgeForm.docStatus}">
				<div style="height: 15px;"></div>
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%><bean:message bundle="km-institution" key="kmInstitution.fdAbolishDescription" /></td>
						<td width=85%>
							<p class="tips_expire">
							<c:out value="${kmInstitutionKnowledgeForm.fdAbolishDescription} " escapeXml="true"></c:out>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message bundle="km-institution" key="kmInstitution.fdAbolishTime" /></td>
						<td width=85%>
							<p class="tips_expire">
							${ kmInstitutionKnowledgeForm.fdAbolishTime }
							</p>
						</td>
					</tr>
				</table>
			</c:if>
			<%--附件--%>
			<c:if test="${not empty kmInstitutionKnowledgeForm.attachmentForms['attachment'].attachments}">
				<div id="imgInfo">
					<c:import url="/sys/attachment/sys_att_main/sysAttaMain_media.jsp" charEncoding="UTF-8">
						<c:param name="modelId" value="${param.fdId}" />
						<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />	
						<c:param name="fdKey" value="attachment" />
					</c:import>
			    </div>
				<div class="lui_form_spacing"></div>
				<div style="clear: both;">			
					<div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png"> ${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }(${fn:length(kmInstitutionKnowledgeForm.attachmentForms['attachment'].attachments)})</div>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formBeanName" value="kmInstitutionKnowledgeForm" />
							<c:param name="fdKey" value="attachment" />
					</c:import>
				</div>
			</c:if>
		</div>
		
		<div style="height: 15px;"></div>
		<c:set var="collapsed" value="false"></c:set>
		<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit>='3'}">
			<c:set var="collapsed" value="true"></c:set>
		</c:if>
		<ui:tabpage expand="false" collapsed="${collapsed}">
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
		
	</template:replace>
	
	<%--右侧导航信息--%>
	<template:replace name="nav">
		<div style="min-width:200px;"></div>
		<ui:accordionpanel style="min-width:200px;"> 
			<ui:content title="${lfn:message('km-institution:kmInstitution.kmInstitutionKnowledge.docInfo')}">
				<ul class='lui_form_info'>
					<li><bean:message bundle="km-institution" key="kmInstitution.fdNumber" />：<bean:write name="kmInstitutionKnowledgeForm" property="fdNumber" /></li>
					<c:if test="${not empty kmInstitutionKnowledgeForm.docPublishTime }">
						<li><bean:message bundle="km-institution" key="kmInstitution.docPublishTime" />：<bean:write name="kmInstitutionKnowledgeForm" property="docPublishTime" /></li>
					</c:if>
					<!-- 过期时间 -->
					<c:if test="${not empty kmInstitutionKnowledgeForm.fdOverdue }">
						<li><bean:message bundle="km-institution" key="kmInstitution.fdOverdue" />：<bean:write name="kmInstitutionKnowledgeForm" property="fdOverdue" /></li>
					</c:if>
					<li><bean:message bundle="sys-doc" key="sysDocBaseInfo.docStatus" />：<sunbor:enumsShow value="${kmInstitutionKnowledgeForm.docStatus}"	enumsType="kmInstitutionKnowledge_docStaus" /></li>
					<li>
						<bean:message bundle="km-institution" key="kmInstitution.kmInstitutionKnowledgeForm.docAuthor" />：
						<ui:person personId="${kmInstitutionKnowledgeForm.docCreatorId}" personName="${kmInstitutionKnowledgeForm.docCreatorName}" layer="true"></ui:person>
					</li>
					<li><bean:message bundle="sys-doc" key="sysDocBaseInfo.docDept" />：<bean:write	name="kmInstitutionKnowledgeForm" property="docDeptName" /></li>
					<%if(ISysAuthConstant.IS_AREA_ENABLED) { %> 
						<li><bean:message bundle="sys-authorization" key="sysAuthArea.authArea" />：${ kmInstitutionKnowledgeForm.authAreaName }</li>
					<%} %>
					<c:if test="${not empty kmInstitutionKnowledgeForm.docPropertiesNames }">
						<li><bean:message bundle="km-institution" key="kmInstitution.docProperties" />：<bean:write name="kmInstitutionKnowledgeForm" property="docPropertiesNames" /></li>
					</c:if>
					<li><bean:message bundle="sys-edition" key="sysEditionMain.tab.label" />：${kmInstitutionKnowledgeForm.editionForm.mainVersion}.${kmInstitutionKnowledgeForm.editionForm.auxiVersion}</li>
					<c:if test="${not empty kmInstitutionKnowledgeForm.fdAbolishTime }">
						<li><bean:message bundle="km-institution" key="kmInstitution.fdAbolisher" />：
							<ui:person personId="${ kmInstitutionKnowledgeForm.fdAbolisherId }" personName="${ kmInstitutionKnowledgeForm.fdAbolisherName}" layer="true"></ui:person>
						</li>
						<li><bean:message bundle="km-institution" key="kmInstitution.fdAbolishTime" />：${ kmInstitutionKnowledgeForm.fdAbolishTime }</li>
						<%
							String abolishId = null;
							KmInstitutionKnowledgeForm knowledge = (KmInstitutionKnowledgeForm)request.getAttribute("kmInstitutionKnowledgeForm");
							if("50".equals(knowledge.getDocStatus())) {
								abolishId = AbolishUtil.getAbolishId(knowledge);
							}
						%>
						<li><bean:message bundle="km-institution" key="kmInstitution.fdAbolishLink" />：
						<% if(abolishId != null) { %>
						<a class="btn_txt" href="javascript:void(0);" onclick="window.open('${LUI_ContextPath}/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=view&fdId=<%=abolishId%>')">${ lfn:message('km-institution:tree.abolish.kmdoc') }</a>
						<% } else { %>
						<a class="btn_txt" href="javascript:void(0);" onclick="alert('${ lfn:message('km-institution:kmInstitution.fdAbolish.noExisted') }');">${ lfn:message('km-institution:tree.abolish.kmdoc') }</a>
						<% } %>
						</li>
					</c:if>
				</ul>
				<%--标签--%>
			<c:if test="${not empty kmInstitutionKnowledgeForm.sysTagMainForm.fdTagNames}">	
				<div style='margin-left:-8px;margin-right:-8px;margin-bottom:8px;border-bottom: 1px #bbb dashed;height:8px'></div>
			</c:if>	
				<c:import url="/sys/tag/import/sysTagMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					<c:param name="useTab" value="false"></c:param>
				</c:import>
			</ui:content>
		</ui:accordionpanel>
		<%--关联机制 --%>
		<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionKnowledgeForm" />
		</c:import>
	</template:replace>
</template:include>