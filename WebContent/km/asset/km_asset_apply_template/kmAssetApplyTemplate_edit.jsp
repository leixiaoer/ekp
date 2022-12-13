<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<script src="../resource/weui_switch.js"></script>
<html:form action="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do">
<div id="optBarDiv">
	<c:if test="${kmAssetApplyTemplateForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmAssetApplyTemplateForm, 'update');">
	</c:if>
	<c:if test="${kmAssetApplyTemplateForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmAssetApplyTemplateForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmAssetApplyTemplateForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetApplyTemplate"/></p>

<center>
	<table id="Label_Tabel" width=95%>
		<tr LKS_LabelName="<bean:message bundle="km-asset" key="kmAssetApplyTemplate.baseInfo" />">
			<td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyTemplate.fdName" /></td>
					<td width="85%" colspan="3">
						<xform:text property="fdName" style="width:85%" showStatus="edit"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset"
						key="kmAssetApplyTemplate.fdApplyCategory.fdName" /></td>
					<td width=85% colspan="3">
					<xform:dialog propertyId="fdApplyCategoryId" propertyName="fdApplyCategoryName" className="inputsgl" style="width:80%;" required="true" 
				    	subject='<%=ResourceUtil.getString(request,"kmAssetApplyTemplate.fdApplyCategory.fdName","km-asset")%>'>
					   Dialog_Category('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','fdApplyCategoryId','fdApplyCategoryName');
					</xform:dialog>
					<c:if test="${not empty noAccessCategory}">
								<script language="JavaScript">
									function closeWindows(rtnVal){
										if(rtnVal==null){
											window.close();
										}
									}
									if(!confirm("<bean:message arg0="${noAccessCategory}" key="error.noAccessCreateTemplate.alert" />")){
										window.close();
									}else{
										Dialog_Category('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','fdApplyCategoryId','fdApplyCategoryName',null,null,null,null,closeWindows, true);
									}
								</script>
							</c:if>
					</td> 
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyTemplate.fdOrder" />
					</td>
					<td width="35%">
						<xform:text property="fdOrder" style="width:85%" showStatus="edit"/>
					</td>
					<td class="td_normal_title" width=15%>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdIsAvailable" />
						</td>
					<td width=35%>
						<html:hidden property="fdIsAvailable" /> 
						<label class="weui_switch">
							<span class="weui_switch_bd">
								<input type="checkbox" ${'true' eq kmAssetApplyTemplateForm.fdIsAvailable ? 'checked' : '' } />
								<span></span>
								<small></small>
							</span>
							<span id="fdIsAvailableText"></span>
						</label>
						<script type="text/javascript">
							function setText(status) {
								if(status) {
									$("#fdIsAvailableText").text('<bean:message bundle="km-asset" key="kmAssetApplyBase.fdIsAvailable.true" />');
								} else {
									$("#fdIsAvailableText").text('<bean:message bundle="km-asset" key="kmAssetApplyBase.fdIsAvailable.false" />');
								}
							}
							$(".weui_switch :checkbox").on("click", function() {
								var status = $(this).is(':checked');
								$("input[name=fdIsAvailable]").val(status);
								setText(status);
							});
							setText(${kmAssetApplyTemplateForm.fdIsAvailable});
						</script>
					</td>
				</tr>
				
				<!-- 可使用者 -->
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyTemplate.kmAssetApplyTemplateUser" />
					</td>
					<td width=85% colspan="3">
						<xform:address textarea="true" mulSelect="true" propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:80%" ></xform:address><br>
						<bean:message key="kmAssetApplyTemplate.tepmlateUser" bundle="km-asset"/>
					</td>
				</tr>
				<!-- 可维护者 -->
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyTemplate.kmAssetApplyTemplateEdit" /></td>
					<td width=85% colspan="3">
						<xform:address textarea="true" mulSelect="true" propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:80%" ></xform:address><br>
						<bean:message key="kmAssetApplyTemplate.tepmlateManager" bundle="km-asset"/>
					</td>
				</tr>
				<tr>
				<td colspan="4"></br></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyTemplate.fdSubject" /></td>
					<td width="85%" colspan="3">
						<xform:text property="fdSubject" style="width:85%" showStatus="edit"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyTemplate.fdType" />
					</td>
					<td width="85%" colspan="3">
						<html:hidden property="fdType"/>
						<c:out value="${kmAssetApplyTemplateForm.fdType}"/>
					</td>
				</tr>

				<tr>
					<td class="td_normal_title" width=15%>
					<bean:message
						bundle="km-asset" key="kmAssetApplyTemplate.fdSubjectRuler" />
						</td>
					<td width="85%" colspan="3">
						<%-- <xform:text property="fdSubjectRuler" style="width:85%" showStatus="edit"/> --%>
						<html:hidden property="titleRegulation" />
						<html:text property="titleRegulationName" style="width:50%" readonly="true"
						styleClass="inputsgl" />
						<a href="#"
						onclick="genTitleRegByFormula('titleRegulation','titleRegulationName')"><bean:message bundle="km-asset" key="kmAssetApplyTemplate.formula" /></a>
						<br>
						<%-- <span class="txtstrong"> 
							<bean:message bundle="km-asset" key="kmAssetApplyTemplate.fdSubjectRules.info1" /><br>
							<bean:message bundle="km-asset" key="kmAssetApplyTemplate.fdSubjectRules.info2" /> 
						</span> --%>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyTemplate.fdContent" />
					</td>
					<td width="85%" colspan="3">
						<xform:textarea style="width:80%" property="fdContent"/>
					</td>
				</tr>
				<c:if test="${kmAssetApplyTemplateForm.method_GET!='add'}">
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyTemplate.docCreator" />
					</td>
					<td width="35%">
						<html:text property="docCreatorName" readonly="true"/>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyTemplate.docCreateTime" />
					</td>
					<td width="35%">
						<html:text property="docCreateTime" readonly="true"/>
					</td>
				</tr>
             </c:if>
			</table>
			</td>
		</tr>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyTemplateForm" />
			<c:param name="fdKey" value="${kmAssetApplyTemplateForm.fdTempKey}"/>
		</c:import>
		<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
				<table class="tb_normal" width=100%>
					<c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
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
			<!-- 文档关联 -->
		<tr
			LKS_LabelName="<bean:message bundle='km-asset' key='kmAssetApplyTemplateLableName.relationInfo'/>">
			<c:set var="mainModelForm" value="${kmAssetApplyTemplateForm}" scope="request" />
			<c:set var="currModelName" value="${modelName}" scope="request" />
			<td>
				<%@ include file="/sys/relation/include/sysRelationMain_edit.jsp"%>
			</td>
		</tr>
	<% if(com.landray.kmss.sys.number.util.NumberResourceUtil.isModuleNumberEnable("com.landray.kmss.km.asset.model.KmAssetApplyBase")){ %>
		<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyTemplateForm" />
			<c:param name="modelName"
				value="com.landray.kmss.km.asset.model.KmAssetApplyBase" />
		</c:import>
	<%} %>
	</table>
	</center>
<html:hidden property="fdId" />
<html:hidden property="fdTempKey"/>
<html:hidden property="docStatus" value="20"/>
<html:hidden property="method_GET" />
<script>
	Com_IncludeFile("calendar.js|dialog.js|jquery.js|formula.js");
	$KMSSValidation();
</script>
<script language="JavaScript">
$(document).ready( function() {
	
		setTimeout(hiddenRadio,2500);
		setTimeout(setRadio, 2500);

	});

//隐藏流程标签中前两种流程定义方式
function hiddenRadio()
{
	var typeRadio = document.getElementsByName("sysWfTemplateForms.${fdKey}.fdType");
	if(typeRadio.length>0)
	{
		typeRadio[0].style.display = "none";
		typeRadio[1].style.display = "none";
		typeRadio[2].checked = "checked";
	}
	var typeLabel;
	if ($("#TB_LbpmTemplate_${fdKey}").length > 0) {
		typeLabel = $("#TB_LbpmTemplate_${fdKey}").find('label');
		document.getElementById('A_LbpmTemplate_${fdKey}').style.visibility='hidden';
	}
	if ($("#TB_WorkFlowTemplate_${fdKey}").length > 0) {
		typeLabel = $("#TB_WorkFlowTemplate_${fdKey}").find('label');
		document.getElementById('A_WorkFlowTemplate_${fdKey}').style.visibility='hidden';
	}
	if(typeLabel)
	{
		typeLabel[0].style.display = "none";
		typeLabel[1].style.display = "none";
	}
}

function setRadio(){
	var radio = document.getElementsByName("sysWfTemplateForms.${fdKey}.fdType");
	if(radio.length>0)
	{
		if(typeof WorkFlow_ChgDisplay!='undefined'&&typeof WorkFlow_ChgDisplay == "function"){
		    WorkFlow_ChgDisplay('${fdKey}',radio[2].value);
		  }
		if(typeof LBPM_Template_TypeChg!='undefined'&&typeof LBPM_Template_TypeChg == "function"){
		 LBPM_Template_TypeChg(radio[2].value, '${fdKey}', 'sysWfTemplateForms.${JsParam.fdKey}.', true);
		}
		radio[2].click();
	}
}

//公式选择器
function genTitleRegByFormula(fieldId, fieldName){
	var fdKey = "${kmAssetApplyTemplateForm.fdTempKey}";
	if(!fdKey){
		fdKey = "default";
	}
	var modelName = getModeName(fdKey);
	/* console.log(Formula_GetVarInfoByModelName("com.landray.kmss.km.asset.model.KmAssetApplyBase")); */
	window._xform_MainModelName = modelName;
	Formula_Dialog(fieldId, fieldName, Formula_GetVarInfoByModelName(modelName), 'String');
}

function getModeName(key){
	var rtn ="com.landray.kmss.km.asset.model.KmAssetApplyBase";
	var modelMap={"KmAssetApplyStockDoc":"com.landray.kmss.km.asset.model.KmAssetApplyStock"}
	if(modelMap[key]){
		rtn = modelMap[key];
	}
	return rtn;
}
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>