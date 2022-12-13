<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<script type="text/javascript">
Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
<html:form action="/geesun/oitems/geesun_oitems_templet/geesunOitemsTemplet.do" onsubmit="return validateGeesunOitemsTempletForm(this);">

<div id="optBarDiv">
	<c:if test="${geesunOitemsTempletForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.geesunOitemsTempletForm, 'update');">
	</c:if>
	<c:if test="${geesunOitemsTempletForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.geesunOitemsTempletForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.geesunOitemsTempletForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<c:if test="${geesunOitemsTempletForm.fdTempletType eq '2' }">
<p class="txttitle"><bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.fdTempletType.person"/></p>
</c:if>
<c:if test="${geesunOitemsTempletForm.fdTempletType eq '1' }">
<p class="txttitle"><bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.fdTempletType.dept"/></p>
</c:if>
<center>
<script type="text/javascript">
Com_IncludeFile("jquery.js");
function Cate_CheckNotReaderFlag(el){
	document.getElementById("Cate_AllUserId").style.display=el.checked?"none":"";
	document.getElementById("Cate_AllUserNote").style.display=el.checked?"none":"";
	el.value=el.checked;
}
function Cate_Win_Onload(){
	Cate_CheckNotReaderFlag(document.getElementsByName("authNotReaderFlag")[0]);
}

Com_AddEventListener(window, "load", Cate_Win_Onload);


//公式选择器
function genTitleRegByFormula(fieldId, fieldName){
//	Formula_Dialog(idField,nameField,Formula_GetVarInfoByModelName("com.landray.kmss.km.review.model.KmReviewMain"), "String");
	Formula_Dialog(fieldId, fieldName, Formula_GetVarInfoByModelName("com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication"), 'String');
}

</script>
<table id="Label_Tabel" width=95%>
	<html:hidden property="fdId"/>
	<input name="fdType" type="hidden" value="${fdTempletType }"/>
	<tr   LKS_LabelName="<bean:message bundle="geesun-oitems" key="table.geesunOitemsInfomation" />">
		<td>
			<table class="tb_normal" width=100%>
				<html:hidden property="fdTempletType" />
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.fdName"/>
					<td colspan="3">
						<%-- <html:text property="fdName" size="90"/> --%>
						<xform:text property="fdName" showStatus="edit" style="width:90%;" required="true"/>
					</td>
				</tr>
				<!-- 标题自动生成规则 -->
				<tr id="number">
					<td class="td_normal_title" width=17%>
					   <bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.titleRegulation"/>
					</td>
					<td width=83% colspan="3">
						<html:hidden property="titleRegulation" />
						<html:text property="titleRegulationName" style="width:50%" readonly="true"
						styleClass="inputsgl" /> <a href="#"
						onclick="genTitleRegByFormula('titleRegulation','titleRegulationName')"><bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.titleRegulation.formula"/></a>
						<br/> 
						<bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.titleRegulation.help"/>
					</td>
				</tr>
				
				<% if(ISysAuthConstant.IS_AREA_ENABLED){ %>
				<%-- 所属场所 --%>
				<td class="td_normal_title" width="15%">
					<bean:message key="sysAuthArea.authArea" bundle="sys-authorization" />
				</td>
				<td colspan="3">
				    <html:hidden property="authAreaId" /> 
				    <c:out value="${geesunOitemsTempletForm.authAreaName}" />
				</td>
				<%} %>
				<tr>
					<td class="td_normal_title" width=15%>
					  <bean:message key="model.tempReaderName" />
					</td>
					<td colspan="3">
					<input type="checkbox" name="authNotReaderFlag" value="${geesunOitemsTempletForm.authNotReaderFlag}" onclick="Cate_CheckNotReaderFlag(this);" 
					<c:if test="${geesunOitemsTempletForm.authNotReaderFlag eq 'true'}">checked</c:if>>
					<bean:message bundle="sys-simplecategory" key="description.main.tempReader.notUse" />
					<div id="Cate_AllUserId">
					<xform:address textarea="true" mulSelect="true" propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
					</div>
					<div id="Cate_AllUserNote">
					 <bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.authReaderIds.desc"/>
					</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
					   <bean:message key="model.tempEditorName" />
					</td>
					<td colspan="3">
					<xform:address textarea="true" mulSelect="true" propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
					<div id="">
					  <bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.authEditorIds.desc"/>
					</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.docCreatorId"/>
					<td>
						<html:hidden property="docCreatorId" />
						<html:text property="docCreatorName" readonly="true"/>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.docCreateTime"/>
					<td>
						<html:text property="docCreateTime" readonly="true"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="geesunOitemsTempletForm" />
		<c:param name="fdKey" value="geesunOitemsTemplet" />
	</c:import>
	<!-- 编号规则 -->
	<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
        <c:param name="formName" value="geesunOitemsTempletForm" />
        <c:param name="modelName" value="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" />
    </c:import>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="geesunOitemsTempletForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>
