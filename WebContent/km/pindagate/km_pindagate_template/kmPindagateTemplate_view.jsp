<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<%--
<c:import
	url="/sys/right/right_batch_change_button.jsp"
	charEncoding="UTF-8">
	<c:param
		name="modelName"
		value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
	<c:param
		name="type"
		value="tmpdoc" />
</c:import>
 --%>
<script>
function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>

<div id="optBarDiv">

<kmss:auth
	requestURL="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=edit&fdId=${param.fdId}"
	requestMethod="GET">
	<input type="button" value="<bean:message key="button.edit"/>"
		onclick="Com_OpenWindow('kmPindagateTemplate.do?method=edit&fdId=${JsParam.fdId}','_self');">
</kmss:auth> 

<kmss:auth
	requestURL="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=save"
	requestMethod="GET">
<input type="button" value="<kmss:message key="button.copy"/>"
		onclick="Com_OpenWindow('kmPindagateTemplate.do?method=clone&cloneModelId=${JsParam.fdId}','_blank');">
</kmss:auth>

<kmss:auth
	requestURL="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=delete&fdId=${param.fdId}"
	requestMethod="GET">
	<input type="button" value="<bean:message key="button.delete"/>"
		onclick="if(!confirmDelete())return;Com_OpenWindow('kmPindagateTemplate.do?method=delete&fdId=${JsParam.fdId}','_self');">
</kmss:auth> <input type="button" value="<bean:message key="button.close"/>"
	onclick="Com_CloseWindow();"></div>
<p class="txttitle"><bean:message bundle="km-pindagate"
	key="table.kmPindagateTemplate" /></p>
<center>
<table id="Label_Tabel" width=95%>
	<tr
		LKS_LabelName="<bean:message bundle='km-pindagate' key='kmPindagateTemplateLableName.templateInfo'/>">
		<td><html:hidden name="kmPindagateTemplateForm" property="fdId" />
		<table class="tb_normal" width=100%>
			<!-- 模板名称 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="kmPindagateTemplate.fdName" /></td>
				<td width=85% colspan="3"><bean:write name="kmPindagateTemplateForm"
					property="fdName" /></td>
			</tr>
			<!-- 适用类别 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="kmPindagateTemplate.fdCatoryName" /></td>
				<td width=85% colspan="3"><bean:write name="kmPindagateTemplateForm"
					property="fdCategoryName" /></td>
			</tr>
			<%---辅助类 modify by zhouchao ---%>
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="table.sysCategoryProperty" /></td>
				<td width=85% colspan="3"><bean:write name="kmPindagateTemplateForm"
					property="docPropertyNames" /></td>
			</tr>
			<!-- 排序号 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="kmPindagateTemplate.fdOrder" /></td>
				<td width=35%><bean:write name="kmPindagateTemplateForm"
					property="fdOrder" /></td>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="kmPindagateTemplate.fdIsAvailable" /></td>
				<td width=35%>
					<label class="weui_switch">
						<input type="checkbox" style="display:none;" ${'true' eq kmPindagateTemplateForm.fdIsAvailable ? 'checked' : '' } disabled />
						<span style="cursor:default;"></span>
						<small style="cursor:default;"></small>
						<span id="fdIsAvailableText"></span>
					</label>
					<script type="text/javascript">
						function setText(status) {
							if(status) {
								$("#fdIsAvailableText").text('<bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdIsAvailable.true" />');
							} else {
								$("#fdIsAvailableText").text('<bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdIsAvailable.false" />');
							}
						}
						setText(${kmPindagateTemplateForm.fdIsAvailable});
					</script>
				</td>
			</tr>
			<%-- 所属场所 --%>
			<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                 <c:param name="id" value="${kmPindagateTemplateForm.authAreaId}"/>
            </c:import> 
			<!-- 可使用者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="table.kmPindagateTemplateUser" /></td>
				<td width=85% colspan="3"><bean:write name="kmPindagateTemplateForm"
					property="authReaderNames" /></td>
			</tr>
			<!-- 可维护者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="table.kmPindagateTemplateEditor" /></td>
				<td width=85% colspan="3"><bean:write name="kmPindagateTemplateForm"
					property="authEditorNames" /></td>
			</tr>
			<tr>
				<!-- 创建人 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="kmPindagateTemplate.docCreatorId" /></td>
				<td width=35%><bean:write name="kmPindagateTemplateForm"
					property="docCreatorName" /></td>
			<!-- 创建时间 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-pindagate" key="kmPindagateTemplate.docCreateTime" /></td>
				<td width=35%><bean:write name="kmPindagateTemplateForm"
					property="docCreateTime" /></td>
			</tr>
			
		</table>
		</td>
	</tr>
	
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmPindagateTemplateForm" />
		<c:param name="fdKey" value="pindagateMain" />
	</c:import>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_view.jsp" charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmPindagateTemplateForm" />
					<c:param
						name="moduleModelName"
						value="com.landray.kmss.km.pindagate.model.KmPindagateTemplate" />
				</c:import>
			</table>
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>

<%--参数
<c:set var="formName" value="kmPindagateTemplateForm" />
<c:set var="requestURL" value="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do" />
<c:set var="fdId" value="${kmDocTemplateForm.fdId}" />
<c:set var="fdModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateTemplate" />
<script language="JavaScript">
	Com_IncludeFile("dialog.js");
</script>--%>
	<%--按钮 
	<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_view_button.jsp"
				charEncoding="UTF-8">
		<c:param name="formName" value="${formName}" />
		<c:param name="requestURL" value="${requestURL}" />
		<c:param name="fdId" value="${fdId}" />
		<c:param name="fdModelName" value="${fdModelName}" />
	</c:import>

	<center>
	<table
		id="Label_Tabel"
		width="95%">---%>
		<%--模板信息	
		<c:import url="/sys/simplecategory/include/sysCategoryMain_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="${formName}" />
			<c:param name="fdModelName" value="${fdModelName}" />
		</c:import>	
	</table>
	</center>
<%@ include file="/resource/jsp/view_down.jsp"%>---%>	