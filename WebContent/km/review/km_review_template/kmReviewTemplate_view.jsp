<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsWebOfficeUtil"%>
<%@page import="com.landray.kmss.sys.xform.util.LangUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>

<script src="./resource/weui_switch.js"></script>

<kmss:windowTitle 
	moduleKey="km-review:table.kmReviewMain" 
	subjectKey="km-review:table.kmReviewTemplate" 
	subject="${kmReviewTemplateForm.fdName}" />
<div id="optBarDiv">

<kmss:auth
	requestURL="/km/review/km_review_template/kmReviewTemplate.do?method=edit&fdId=${param.fdId}"
	requestMethod="GET">
	<input type="button" value="<bean:message key="button.edit"/>"
		onclick="Com_OpenWindow('kmReviewTemplate.do?method=edit&fdId=${param.fdId}','_self');">
</kmss:auth> 
<!-- 非外部流程 -->
	<kmss:auth
		requestURL="/km/review/km_review_template/kmReviewTemplate.do?method=clone&cloneModelId=${param.fdId}"
		requestMethod="GET">
	<input type="button" value="<kmss:message key="km-review:button.copy"/>"
			onclick="Com_OpenWindow('kmReviewTemplate.do?method=clone&cloneModelId=${param.fdId}','_blank');">
	</kmss:auth>

<kmss:auth
	requestURL="/km/review/km_review_template/kmReviewTemplate.do?method=delete&fdId=${param.fdId}"
	requestMethod="GET">
	<input type="button" value="<bean:message key="button.delete"/>"
		onclick="if(!confirmDelete())return;Com_OpenWindow('kmReviewTemplate.do?method=delete&fdId=${param.fdId}','_self');">
</kmss:auth> <input type="button" value="<bean:message key="button.close"/>"
	onclick="Com_CloseWindow();">
	</div>
<p class="txttitle"><bean:message bundle="km-review"
	key="table.kmReviewTemplate" /></p>
<center>
<table id="Label_Tabel" width=95%>
	<tr
		LKS_LabelName="<bean:message bundle='km-review' key='kmReviewTemplateLableName.templateInfo'/>">
		<td><html:hidden name="kmReviewTemplateForm" property="fdId" />
		<table class="tb_normal" width=100%>
			<!-- 模板名称 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewTemplate.fdName" /></td>
				<td width=85% colspan="3"><bean:write name="kmReviewTemplateForm"
					property="fdName" /> 
					<c:if test="${kmReviewTemplateForm.fdIsExternal == 'true'}">	
					     <span style="padding-left: 20px">
					         <xform:checkbox property="fdIsExternal" htmlElementProperties="id=fdIsExternal">
								   	<xform:simpleDataSource value="true"><bean:message bundle="km-review" key="kmReviewMain.fdIsExternal"/></xform:simpleDataSource>
							 </xform:checkbox>
						 </span>
				    </c:if>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%><bean:message bundle="km-review" key="kmReviewTemplate.fdIsMobileCreate" /></td>
				<td width=35% ${kmReviewTemplateForm.fdIsExternal == 'true' ? 'colspan=3' : ''}>
					<c:choose>
						<c:when test="${'false' eq kmReviewTemplateForm.fdIsMobileCreate}">
							<bean:message key="message.no" />
						</c:when>
						<c:otherwise>
							<bean:message key="message.yes" />
						</c:otherwise>
					</c:choose>
				</td>
				<!-- 非外部流程 -->
				<c:if test="${kmReviewTemplateForm.fdIsExternal != 'true'}">
				<td class="td_normal_title" width=15%><bean:message bundle="km-review" key="kmReviewTemplate.fdIsMobileApprove" /></td>
				<td width=35%>
					<c:choose>
						<c:when test="${'false' eq kmReviewTemplateForm.fdIsMobileApprove}">
							<bean:message key="message.no" />
						</c:when>
						<c:otherwise>
							<bean:message key="message.yes" />
						</c:otherwise>
					</c:choose>
				</td>
				</c:if>
			</tr>
			<c:if test="${kmReviewTemplateForm.fdIsExternal != 'true'}">
			<tr>
				<td class="td_normal_title" width=15%><bean:message bundle="km-review" key="kmReviewTemplate.fdIsMobileView" /></td>
				<td width=35%>
					<c:choose>
						<c:when test="${'false' eq kmReviewTemplateForm.fdIsMobileView}">
							<bean:message key="message.no" />
						</c:when>
						<c:otherwise>
							<bean:message key="message.yes" />
						</c:otherwise>
					</c:choose>
				</td>
				<td class="td_normal_title" width=15%><bean:message bundle="km-review" key="kmReviewMain.fdCanCircularize" /></td>
				<td width=35%>
					<c:choose>
						<c:when test="${'false' eq kmReviewTemplateForm.fdCanCircularize}">
							<bean:message key="message.no" />
						</c:when>
						<c:otherwise>
							<bean:message key="message.yes" />
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:if>
			<!-- 外部流程 -->
		     <c:if test="${kmReviewTemplateForm.fdIsExternal == 'true'}">	
		            <%--外部URL--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-review" key="kmReviewMain.fdExternalUrl" />
						</td>
						<td width=85% colspan="3">
							<bean:write name="kmReviewTemplateForm"
								property="fdExternalUrl" />
						</td>
					</tr>
			 </c:if>
			<!-- 适用类别 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewMain.fdCatoryName" /></td>
				<td width=85% colspan="3"><bean:write name="kmReviewTemplateForm"
					property="fdCategoryName" /></td>
			</tr>
			<%---是否可用 ---%>
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewTemplate.fdIsAvailable" /></td>
				<td width=35%>
					<label class="weui_switch">
						<input type="checkbox" style="display:none;" ${'true' eq kmReviewTemplateForm.fdIsAvailable ? 'checked' : '' } disabled />
						<span style="cursor:default;"></span>
						<small style="cursor:default;"></small>
						<span id="fdIsAvailableText"></span>
					</label>
					<script type="text/javascript">
						function setText(status) {
							if(status) {
								$("#fdIsAvailableText").text('<bean:message bundle="km-review" key="kmReviewTemplate.fdIsAvailable.true" />');
							} else {
								$("#fdIsAvailableText").text('<bean:message bundle="km-review" key="kmReviewTemplate.fdIsAvailable.false" />');
							}
						}
						setText(${kmReviewTemplateForm.fdIsAvailable});
					</script>
				</td>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewTemplate.fdIsCopyDoc" /></td>
				<td width=35%>
					<c:choose>
						<c:when test="${'false' eq kmReviewTemplateForm.fdIsCopyDoc}">
							<bean:message key="message.no" />
						</c:when>
						<c:otherwise>
							<bean:message key="message.yes" />
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<!-- 表单数据导入 -->
			<c:if test="${kmReviewTemplateForm.sysFormTemplateForms['reviewMainDoc'].fdMode == 3}">
				<tr id="xformMainImportTD">
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-review" key="kmReviewTemplate.fdIsImport"/>
					</td>
					<td width=85% colspan="3">
						<%-- <ui:switch property="fdIsImport" onValueChange="importSwitchChange(this.checked)" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch> --%>
						<label class="weui_switch">
							<input type="checkbox" style="display:none;" ${'true' eq kmReviewTemplateForm.fdIsImport ? 'checked' : '' } disabled />
							<span style="cursor:default;"></span>
							<small style="cursor:default;"></small>
							<span id="fdIsImport"></span>
						</label>
						<script type="text/javascript">
							function setText(status) {
								if(status) {
									$("#fdIsImport").text('<bean:message bundle="km-review" key="kmReviewTemplate.fdIsImport.true" />');
								} else {
									$("#fdIsImport").text('<bean:message bundle="km-review" key="kmReviewTemplate.fdIsImport.false" />');
								}
							}
							setText(${kmReviewTemplateForm.fdIsImport});
						</script>
						<c:if test="${kmReviewTemplateForm.fdIsImport == 'true'}">
							<br/>
							<label style="display: inline-block;line-height: 22px;vertical-align: middle;">
								<span style="margin-left:5px;"><bean:message bundle="km-review" key="kmReviewTemplate.umImportFormField"/>:	</span>
								<span id="selectUnImportWrap" style="display:${kmReviewTemplateForm.fdIsImport eq 'true' ? '' : 'none'};">
								 	<bean:write name="kmReviewTemplateForm" property="fdUnImportFieldNames"/>
								</span>
							</label>
					</c:if>
					</td>
				</tr>
			</c:if>
			
			<%---模板描述 ---%>
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewTemplate.fdDesc" /></td>
				<td width=85% colspan="3"><bean:write name="kmReviewTemplateForm"
					property="fdDesc" /></td>
			</tr>
			<%---辅助类 modify by zhouchao ---%>
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="table.sysCategoryProperty" /></td>
				<td width=85% colspan="3"><bean:write name="kmReviewTemplateForm"
					property="docPropertyNames" /></td>
			</tr>
			<tr>
				<!-- 前缀 -->
				<% if(!com.landray.kmss.sys.number.util.NumberResourceUtil.isModuleNumberEnable("com.landray.kmss.km.review.model.KmReviewMain")){ %>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewTemplate.fdNumberPrefix" /></td>
				<td width=35%><bean:write name="kmReviewTemplateForm"
					property="fdNumberPrefix" /></td>
				<%} %>
				<!-- 排序号 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewMain.fdOrder" /></td>
				<td width=35%
					<% if(com.landray.kmss.sys.number.util.NumberResourceUtil.isModuleNumberEnable("com.landray.kmss.km.review.model.KmReviewMain")){ %>
						colspan="3"
						<%} %>
					><bean:write name="kmReviewTemplateForm"
					property="fdOrder" /></td>
			</tr>
     <!-- 非外部流程 -->	
     <c:if test="${kmReviewTemplateForm.fdIsExternal != 'true'}">			
			<!-- 实施反馈人 -->
			<tr>
				<td class="td_normal_title" width=12%><bean:message
					bundle="km-review" key="table.kmReviewFeedback" /></td>
				<td width="33%"><bean:write name="kmReviewTemplateForm"
					property="fdFeedbackNames" /></td>
				<td class="td_normal_title" width=12%><bean:message
					bundle="km-review" key="kmReviewTemplate.fdFeedbackModify" /></td>
				<td width="33%"><c:if
					test="${kmReviewTemplateForm.fdFeedbackModify=='true'}">
					<bean:message key="message.yes" />
				</c:if> <c:if test="${kmReviewTemplateForm.fdFeedbackModify=='false'}">
					<bean:message key="message.no" />
				</c:if></td>

			</tr>
			<!-- 标题规则 -->
			<tr>
				<td class="td_normal_title" width=12%><bean:message
					bundle="km-review" key="kmReviewTemplate.titleRegulation" /></td>
				<td colspan=3><bean:write name="kmReviewTemplateForm"
					property="titleRegulationName" /></td>
			</tr>
			<!-- 关键字 -->
			<tr>
				<td class="td_normal_title" width=12%><bean:message
					bundle="km-review" key="kmReviewKeyword.fdKeyword" /></td>
				<td colspan=3><bean:write name="kmReviewTemplateForm"
					property="fdKeywordNames" /></td>
			</tr>
	</c:if>		
			<%-- 所属场所 --%>
			<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                <c:param name="id" value="${kmReviewTemplateForm.authAreaId}"/>
            </c:import>			
			<!-- 可使用者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="table.kmReviewTemplateUser" /></td>
				<td width=85% colspan="3"><bean:write name="kmReviewTemplateForm"
					property="authReaderNames" /></td>
			</tr>
			<!-- 可维护者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="table.kmReviewTemplateEditor" /></td>
				<td width=85% colspan="3"><bean:write name="kmReviewTemplateForm"
					property="authEditorNames" /></td>
			</tr>
			<tr>
				<!-- 创建人 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewTemplate.docCreatorId" /></td>
				<td width=35%><bean:write name="kmReviewTemplateForm"
					property="docCreatorName" /></td>
			<!-- 创建时间 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewTemplate.docCreateTime" /></td>
				<td width=35%><bean:write name="kmReviewTemplateForm"
					property="docCreateTime" /></td>
			</tr>
			<c:if test="${not empty kmReviewTemplateForm.docAlterorName}">
			<tr>
				<!-- 修改人 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewTemplate.docAlteror" /></td>
				<td width=35%><bean:write name="kmReviewTemplateForm"
					property="docAlterorName" /></td>
				<!-- 修改时间 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-review" key="kmReviewTemplate.docAlterTime" /></td>
				<td width=35%><bean:write name="kmReviewTemplateForm"
					property="docAlterTime" /></td>
			</tr>
			</c:if>
		</table>
		</td>
	</tr>
<!-- 非外部流程 -->	
<c:if test="${kmReviewTemplateForm.fdIsExternal != 'true'}">	
	<c:if test="${kmReviewTemplateForm.fdUseForm == 'false'}">	
	<tr LKS_LabelName="<kmss:message key='km-review:kmReviewDocumentLableName.reviewContent'/>">
		<td>
		<table class="tb_normal" width=100%>	
		<c:choose>
			<c:when test="${kmReviewTemplateForm.fdUseWord == 'true'}">
				<tr>
					<td colspan="4">
						<%
			     			pageContext.setAttribute("_isWpsWebOfficeEnable", new Boolean(SysAttWpsWebOfficeUtil.isEnable()));
			     			pageContext.setAttribute("_isWpsCloudEnable", new Boolean(SysAttWpsCloudUtil.isEnable()));
						%>
						<div style="height:550px;width:100%;">		
							<c:choose>
								<c:when test="${pageScope._isWpsCloudEnable == 'true'}">
									<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="mainContent" />
										<c:param name="load" value="false" />
										<c:param name="bindSubmit" value="false"/>	
										<c:param name="fdModelId" value="${kmReviewTemplateForm.fdId}"/>	
										<c:param name="fdModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate"/>	
										<c:param name="fdTempKey" value="${kmReviewTemplateForm.fdId}" />
									</c:import>
								</c:when>
								<c:when test="${pageScope._isWpsWebOfficeEnable == 'true'}">
									<c:import url="/sys/attachment/sys_att_main/wps/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="mainContent" />
										<c:param name="load" value="false" />
										<c:param name="bindSubmit" value="false"/>	
										<c:param name="fdModelId" value="${kmReviewTemplateForm.fdId}"/>	
										<c:param name="fdModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate"/>	
										<c:param name="fdTempKey" value="${kmReviewTemplateForm.fdId}" />
									</c:import>
								</c:when>
								<c:otherwise>
									<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline_krt" />
										<c:param name="fdAttType" value="office" />
										<c:param name="fdModelId" value="${kmReviewTemplateForm.fdId}" />
										<c:param name="isTemplate" value="true"/>
										<c:param name="fdModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate" />
									</c:import>
								</c:otherwise>
							</c:choose>					
						</div>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<td width="15%" class="td_normal_title" valign="top">
						<bean:message bundle="sys-xform" key="sysFormTemplate.fdMode" />
					</td>
					<td width="85%">
						<bean:message bundle="sys-xform" key="sysFormTemplate.fdTemplateType.nouse" />
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<xform:rtf property="docContent" toolbarSet="Default"/>
					</td>
				</tr>
			</c:otherwise>
		</c:choose>
		</table>
		</td>
	</tr>
	</c:if>
	<c:if test="${kmReviewTemplateForm.fdUseForm == 'true' || empty kmReviewTemplateForm.fdUseForm}">
	<tr LKS_LabelName="<kmss:message key='km-review:kmReviewDocumentLableName.reviewContent'/>">
		<td>
	<!-- 表单 -->
	<c:import url="/sys/xform/include/sysFormTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmReviewTemplateForm" />
		<c:param name="fdKey" value="reviewMainDoc" />
		<c:param name="fdMainModelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
		<c:param name="useLabel" value="false" />
		<c:param name="messageKey" value="km-review:kmReviewDocumentLableName.reviewContent" />
		<c:param name="addOptionType" value="sys-xform:sysFormTemplate.fdTemplateType.subForm|4;km-review:kmReviewDocumentLableName.wordStype|5"></c:param>
	</c:import>
	</td>
	</tr>
	</c:if>
	
	<%----编号机制开始--%>
	<% if(com.landray.kmss.sys.number.util.NumberResourceUtil.isModuleNumberEnable("com.landray.kmss.km.review.model.KmReviewMain")){ %>
		<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmReviewTemplateForm" />
			<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain"/>
		</c:import>
	<%} %>
	<%----编号机制结束--%>
	
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmReviewTemplateForm" />
		<c:param name="fdKey" value="reviewMainDoc" />
	</c:import>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_view.jsp" charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmReviewTemplateForm" />
					<c:param
						name="moduleModelName"
						value="com.landray.kmss.km.review.model.KmReviewTemplate" />
				</c:import>
			</table>
		</td>
	</tr>
	
	<!-- 文档关联 -->
	<tr
		LKS_LabelName="<bean:message bundle='km-review' key='kmReviewTemplateLableName.relationInfo'/>">
		<c:set var="mainModelForm" value="${kmReviewTemplateForm}" scope="request" />
		<c:set
			var="currModelName"
			value="com.landray.kmss.km.review.model.KmReviewTemplate"
			scope="request" />
		<td><%@ include file="/sys/relation/include/sysRelationMain_view.jsp"%></td>
	</tr>
	
	<%--
	<!--提醒机制(分类) 开始-->
	<tr LKS_LabelName="<bean:message bundle="sys-notify" key="sysNotify.remind.calendar" />">
	  <td>
		  <table class="tb_normal" width=100%>
			 <c:import url="/sys/notify/include/sysNotifyRemindCategory_view.jsp"	charEncoding="UTF-8">
				<c:param name="formName" value="kmReviewTemplateForm" />
				<c:param name="fdKey" value="reviewMainDoc" />
				<c:param name="fdPrefix" value="sysNotifyRemindCategory_view" />
			</c:import>
		  </table>
	  </td>
	</tr>
	<!--提醒机制(分类) 结束-->
	--%>
	
	<%--
	<!--日程机制(普通模块) 开始-->
	<tr LKS_LabelName="<bean:message bundle="sys-agenda" key="module.sys.agenda" />">
	  <td>
		  <table class="tb_normal" width=100%>
			 <c:import url="/sys/agenda/include/sysAgendaCategory_general_view.jsp"	charEncoding="UTF-8">
				<c:param name="formName" value="kmReviewTemplateForm" />
				<c:param name="fdKey" value="reviewMainDoc" />
				<c:param name="fdPrefix" value="sysAgendaCategory_general_view" />
			</c:import>
		  </table>
	  </td>
	</tr>
	<!--日程机制(普通模块) 结束-->
	--%>
	<%--多语言 --%>
	<%  if(LangUtil.isEnableMultiLang(request.getParameter("fdMainModelName"), "model") && LangUtil.isEnableAdminDoMultiLang()) {%>
	<c:import url="/sys/xform/lang/include/sysFormMultiLang_view.jsp"	charEncoding="UTF-8">
			<c:param name="formName" value="kmReviewTemplateForm" />
			<c:param name="fdKey" value="reviewMainDoc" />
	</c:import>
	<% } %>	
	<!--日程机制(表单模块) 开始-->
	<tr LKS_LabelName="<bean:message bundle="sys-agenda" key="module.sys.agenda.syn" />">
	  <td>
		  <table class="tb_normal" width=100%>
		  	<tr>
				<td class="td_normal_title" width=15%>
			       <bean:message bundle="sys-agenda" key="module.sys.agenda.syn.time" />
				</td>
			    <td>
			    	<xform:radio property="syncDataToCalendarTime" >
						<xform:enumsDataSource enumsType="kmReviewMain_syncDataToCalendarTime" />
					</xform:radio>
			    </td>
			</tr>
			<tr>
				<td colspan="4" style="padding: 0px;">
					 <c:import url="/sys/agenda/include/sysAgendaCategory_formula_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmReviewTemplateForm" />
						<c:param name="fdKey" value="reviewMainDoc" />
						<c:param name="fdPrefix" value="sysAgendaCategory_formula_view" />
						<%--可选字段 1.syncTimeProperty:同步时机字段； 2.noSyncTimeValues:当syncTimeProperty为此值时，隐藏同步机制 --%>
						<c:param name="syncTimeProperty" value="syncDataToCalendarTime" />
						<c:param name="noSyncTimeValues" value="noSync" />
					</c:import>
				</td>
			</tr>
		  </table>
	  </td>
	</tr>
	<!--日程机制(表单模块) 结束-->
	<!-- 打印机制 -->
	<c:import url="/sys/print/include/sysPrintTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmReviewTemplateForm" />
		<c:param name="fdKey" value="reviewMainDoc" />
		<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain"></c:param>
		<c:param name="templateModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate"></c:param>
		<c:param name="fdModelTemplateId" value="${kmReviewTemplateForm.fdId}"></c:param>
	</c:import>
	<!-- 归档设置 -->
	<c:import url="/km/archives/include/kmArchivesFileSetting_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmReviewTemplateForm" />
		<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
		<c:param name="templateService" value="kmReviewTemplateService" />
		<c:param name="moduleUrl" value="km/review" />
	</c:import>
	<!-- 沉淀设置 -->
	<c:import url="/kms/multidoc/kms_multidoc_subside/include/kmsSubsideFileSetting_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmReviewTemplateForm" />
		<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
		<c:param name="templateService" value="kmReviewTemplateService" />
	</c:import>
	<!-- 规则机制 -->
	<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmReviewTemplateForm" />
		<c:param name="fdKey" value="reviewMainDoc" />
		<c:param name="templateModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate"></c:param>
	</c:import>
	<%-- 提醒中心 --%>
	<kmss:ifModuleExist path="/sys/remind/">
	<c:import url="/sys/remind/include/sysRemindTemplate_view.jsp" charEncoding="UTF-8">
		<%-- 模板Form名称 --%>
		<c:param name="formName" value="kmReviewTemplateForm" />
		<%-- KEY --%>
		<c:param name="fdKey" value="reviewMainDoc" />
		<%-- 模板全名称 --%>
		<c:param name="templateModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate" />
		<%-- 主文档全名称 --%>
		<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
		<%-- 主文档模板属性 --%>
		<c:param name="templateProperty" value="fdTemplate" />
		<%-- 模块路径 --%>
		<c:param name="moduleUrl" value="km/review" />
	</c:import>
	</kmss:ifModuleExist>
</c:if>	
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
