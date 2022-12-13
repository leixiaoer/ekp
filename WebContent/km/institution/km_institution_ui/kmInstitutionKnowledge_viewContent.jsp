<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.institution.forms.KmInstitutionKnowledgeForm"%>
<%@ page import="com.landray.kmss.km.institution.util.AbolishUtil"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>	
<%@page import="com.landray.kmss.util.ResourceUtil"%>	
<%@ include file="/sys/ui/jsp/common.jsp"%>


<c:choose>
	<c:when test="${param.contentType eq 'xform'}">
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
			<div class="status_expire status_expire_<%=ResourceUtil.getLocaleByUser().getCountry() %>"></div>
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
				<%-- 多媒体阅读器 --%>
				<div id="imgInfo">
					<c:import url="/sys/attachment/sys_att_main/sysAttaMain_media_ui.jsp" charEncoding="UTF-8">
						<c:param name="modelId" value="${param.fdId}" />
						<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />	
						<c:param name="fdKey" value="attachment" />
					</c:import>
			     </div>
				<div style="margin-top: 30px">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmInstitutionKnowledgeForm" />
						<c:param name="fdKey" value="attachment" />
						<%-- <c:param name="fdAttType" value="byte_ui"></c:param> --%>
					</c:import>
				</div>
			</c:if>
			<!-- 盖章文件 -->
			 	<c:if test="${kmInstitutionKnowledgeForm.fdSignEnable}">
				 	<c:if test="${not empty kmInstitutionKnowledgeForm.attachmentForms['yqqSigned'].attachments}">
				 		<div class="lui_form_spacing"></div>
					 	<div>
					 		<div class="lui_form_subhead">
								<img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png">
								${ lfn:message('km-institution:kmInstitutionKnowledge.yqqSignFile') }(${fn:length(kmInstitutionKnowledgeForm.attachmentForms['yqqSigned'].attachments)})
							</div>
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
								charEncoding="UTF-8">
								<c:param name="formBeanName" value="kmInstitutionKnowledgeForm" />
								<c:param name="fdKey" value="yqqSigned" />
								<c:param name="fdModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
							</c:import>
						</div>
				 	</c:if>
			 		<c:if test="${not empty kmInstitutionKnowledgeForm.attachmentForms['fdSignFile'].attachments}">
			 			<div class="lui_form_spacing"></div>
					 	<div>
					 		<div class="lui_form_subhead">
								<img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png">
								${ lfn:message('km-institution:kmInstitutionKnowledge.fdSignFile') }(${fn:length(kmInstitutionKnowledgeForm.attachmentForms['fdSignFile'].attachments)})
							</div>
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
								charEncoding="UTF-8">
								<c:param name="formBeanName" value="kmInstitutionKnowledgeForm" />
								<c:param name="fdKey" value="fdSignFile" />
								<c:param name="fdModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
							</c:import>
		
						</div>
			 		</c:if>
			 	</c:if>
		</div>
		
		<div style="height: 15px;"></div>
	</c:when>

	<c:when test="${param.contentType eq 'info'}">
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
			<!-- 标签 -->
		<c:if test="${not empty kmInstitutionKnowledgeForm.sysTagMainForm.fdTagNames}">	
			<div style='margin-left:-8px;margin-right:-8px;margin-bottom:8px;border-bottom: 1px #bbb dashed;height:8px'></div>
		</c:if>	
			<c:import url="/sys/tag/import/sysTagMain_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmInstitutionKnowledgeForm" />
				<c:param name="useTab" value="false" />
			</c:import>
		</ui:content>
	</c:when>

</c:choose>