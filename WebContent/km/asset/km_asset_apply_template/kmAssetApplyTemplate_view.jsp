<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<html:form action="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do">
<div id="optBarDiv">
	<kmss:auth requestURL="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetApplyTemplate.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyTemplate.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetApplyTemplate"/></p>

<center>
<table id="Label_Tabel" width=95%>
<html:hidden property="fdId" />
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="kmAssetApplyTemplate.baseInfo" />">
		<td>
		<table class="tb_normal" width=95%>
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.fdName" /></td>
				<td width="85%" colspan="3"><xform:text property="fdName" /></td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.fdApplyCategory.fdName" /></td>
				<td width=85% colspan="3"><xform:text
					property="fdApplyCategoryName" /></td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.fdOrder" /></td>
				<td width="35%"><xform:text property="fdOrder" /></td>
				<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdIsAvailable" />
						</td>
					<td width=35%>
						 <c:if test="${kmAssetApplyTemplateForm.fdIsAvailable}">
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdIsAvailable.true" />
						</c:if>
						<c:if test="${!kmAssetApplyTemplateForm.fdIsAvailable}">
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdIsAvailable.false" />
						</c:if>
					</td>
			</tr>
			
			<!-- 可使用者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.kmAssetApplyTemplateUser" /></td>
				<td width=85% colspan="3"><xform:text
					property="authReaderNames" style="width:80%" /><br>
				</td>
			</tr>
			<!-- 可维护者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.kmAssetApplyTemplateEdit" /></td>
				<td width=85% colspan="3"><xform:text
					property="authEditorNames" style="width:80%" /><br>
				</td>
			</tr>
			<tr>
				<td colspan="4"></br></td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.fdSubject" /></td>
				<td width="85%" colspan="3"><xform:text property="fdSubject"
					style="width:85%" /></td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.fdType" /></td>
				<td width="85%" colspan="3"><xform:text property="fdType"
					style="width:85%" value="${kmAssetApplyTemplateForm.fdType}" /></td>
			</tr>

			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.fdSubjectRuler" /></td>
				<td width="85%" colspan="3"><xform:text
					property="titleRegulationName" style="width:85%" /> <br>
				<%-- <span class="txtstrong"> <bean:message bundle="km-asset"
					key="kmAssetApplyTemplate.fdSubjectRules.info1" /><br>
				<bean:message bundle="km-asset"
					key="kmAssetApplyTemplate.fdSubjectRules.info2" /> </span> --%></td>
			</tr>
			<tr>

				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.fdContent" /></td>
				<td width="85%" colspan="3">
				    <kmss:showText value="${kmAssetApplyTemplateForm.fdContent}"></kmss:showText> 
				</td>
			</tr>
			<tr>
				<!-- 创建人 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.docCreator" /></td>
				<td width=35%><c:out
					value="${kmAssetApplyTemplateForm.docCreatorName}"></c:out></td>
				<!-- 创建时间 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyTemplate.docCreateTime" /></td>
				<td width=35%><xform:datetime property="docCreateTime" /></td>
			</tr>
			<c:if test="${not empty kmAssetApplyTemplateForm.docAlterorName}">
				<tr>
					<!-- 修改人 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyTemplate.docAlteror" /></td>
					<td width=35%><c:out
						value="${kmAssetApplyTemplateForm.docAlterorName}"></c:out></td>
					<!-- 修改时间 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyTemplate.docAlterTime" /></td>
					<td width=35%><xform:datetime property="docAlterTime" /></td>
				</tr>
			</c:if>
		</table>
		</td>
	</tr>
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyTemplateForm" />
		<c:param name="fdKey" value="${fdKey}" />
	</c:import>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_view.jsp" charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmAssetApplyTemplateForm" />
					<c:param
						name="moduleModelName"
						value="com.landray.kmss.km.asset.model.KmAssetApplyTemplate" />
				</c:import>
			</table>
		</td>
	</tr>
	 <% if(com.landray.kmss.sys.number.util.NumberResourceUtil.isModuleNumberEnable("com.landray.kmss.km.asset.model.KmAssetApplyBase")){ %>
	<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyTemplateForm" />
		<c:param name="modelName"
			value="com.landray.kmss.km.asset.model.KmAssetApplyBase" />
	</c:import>
  <%} %>
</table>
</center>
</html:form>
<%@ include file="/resource/jsp/view_down.jsp"%>