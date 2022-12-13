<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>

<c:choose>
	<c:when test="${param.contentType eq 'xform'}">
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
					<html:hidden property="fdSignEnable" />
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
			<!-- 盖章文件 -->
		 	<c:if test="${kmInstitutionKnowledgeForm.fdSignEnable}">
		 	<c:if test="${kmInstitutionKnowledgeForm.method_GET=='add'}">
		 		<tr>
			 		<td class="td_normal_title" width=15%>
			 			<bean:message bundle="km-institution" key="kmInstitutionKnowledge.fdSignFile"/>
			 		</td>
			 		<td width="85%" colspan="3" >
			 			<div style="padding:10px 0"><font color="red"><bean:message bundle="km-institution" key="kmInstitutionKnowledge.file.big"/></font></div>
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="fdSignFile" />
							<c:param name="fdModelId" value="${param.fdId }" />
							<c:param name="enabledFileType" value=".pdf;.doc;.xls;.ppt;.docx;.xlsx;.pptx;.jpg;.jpeg;.png;" />
							<c:param name="uploadAfterSelect" value="true" />
							<c:param name="fdModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
							<c:param name="fdRequired" value="true" />
						</c:import>
					</td>
		 		</tr>
		 	</c:if>
		 	<c:if test="${kmInstitutionKnowledgeForm.method_GET=='edit'}">
		 		<tr>
			 		<td class="td_normal_title" width=15%>
			 			<bean:message bundle="km-institution" key="kmInstitutionKnowledge.fdSignFile"/>
			 		</td>
			 		<td width="85%" colspan="3" >
			 			<div style="padding:10px 0"><font color="red"><bean:message bundle="km-institution" key="kmInstitutionKnowledge.file.big"/></font></div>
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="fdSignFile" />
							<c:param name="fdModelId" value="${param.fdId }" />
							<c:param name="uploadAfterSelect" value="true" />
							<c:param name="fdModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
							<c:param name="fdRequired" value="true" />
						</c:import>
					</td>
		 		</tr>
		 	</c:if>
		 	
		 	</c:if>
		</table>
		</div>
	</c:when>
	<c:when test="${param.contentType eq 'lbpm'}">
		<%--流程机制 --%>
		<c:import url="/sys/lbpmservice/import/sysLbpmProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionKnowledgeForm" />
			<c:param name="fdKey" value="mainDoc" />
			<c:param name="isExpand" value="true" />
			<%-- <c:param name="needInitLbpm" value="true" /> --%>
		</c:import>
	</c:when>
	<c:when test="${param.contentType eq 'right'}">
		<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionKnowledgeForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
		</c:import>
	</c:when>
</c:choose>