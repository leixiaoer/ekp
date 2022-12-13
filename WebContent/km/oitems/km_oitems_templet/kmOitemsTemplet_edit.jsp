<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<script type="text/javascript">
Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
<html:form action="/km/oitems/km_oitems_templet/kmOitemsTemplet.do" onsubmit="return validateKmOitemsTempletForm(this);">

<div id="optBarDiv">
	<c:if test="${kmOitemsTempletForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmOitemsTempletForm, 'update');">
	</c:if>
	<c:if test="${kmOitemsTempletForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmOitemsTempletForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmOitemsTempletForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<c:if test="${kmOitemsTempletForm.fdTempletType eq '2' }">
<p class="txttitle"><bean:message  bundle="km-oitems" key="kmOitemsTemplet.fdTempletType.person"/></p>
</c:if>
<c:if test="${kmOitemsTempletForm.fdTempletType eq '1' }">
<p class="txttitle"><bean:message  bundle="km-oitems" key="kmOitemsTemplet.fdTempletType.dept"/></p>
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
	Formula_Dialog(fieldId, fieldName, Formula_GetVarInfoByModelName("com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication"), 'String', null, null, "com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication");
}

</script>
<table id="Label_Tabel" width=95%>
	<html:hidden property="fdId"/>
	<input name="fdType" type="hidden" value="${fdTempletType }"/>
	<tr   LKS_LabelName="<bean:message bundle="km-oitems" key="table.kmOitemsInfomation" />">
		<td>
			<table class="tb_normal" width=100%>
				<html:hidden property="fdTempletType" />
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsTemplet.fdName"/>
					<td colspan="3">
						<%-- <html:text property="fdName" size="90"/> --%>
						<xform:text property="fdName" showStatus="edit" style="width:90%;" required="true"/>
					</td>
				</tr>
				<!-- 标题自动生成规则 -->
				<tr id="number">
					<td class="td_normal_title" width=17%>
					   <bean:message  bundle="km-oitems" key="kmOitemsTemplet.titleRegulation"/>
					</td>
					<td width=83% colspan="3">
						<html:hidden property="titleRegulation" />
						<html:text property="titleRegulationName" style="width:50%" readonly="true"
						styleClass="inputsgl" /> <a href="#"
						onclick="genTitleRegByFormula('titleRegulation','titleRegulationName')"><bean:message  bundle="km-oitems" key="kmOitemsTemplet.titleRegulation.formula"/></a>
						<br/> 
						<bean:message  bundle="km-oitems" key="kmOitemsTemplet.titleRegulation.help"/>
					</td>
				</tr>
				
				<% if(ISysAuthConstant.IS_AREA_ENABLED){ %>
				<%-- 所属场所 --%>
				<td class="td_normal_title" width="15%">
					<bean:message key="sysAuthArea.authArea" bundle="sys-authorization" />
				</td>
				<td colspan="3">
				    <html:hidden property="authAreaId" /> 
				    <c:out value="${kmOitemsTempletForm.authAreaName}" />
				</td>
				<%} %>
				<tr>
					<td class="td_normal_title" width=15%>
					  <bean:message key="model.tempReaderName" />
					</td>
					<td colspan="3">
					<input type="checkbox" name="authNotReaderFlag" value="${kmOitemsTempletForm.authNotReaderFlag}" onclick="Cate_CheckNotReaderFlag(this);" 
					<c:if test="${kmOitemsTempletForm.authNotReaderFlag eq 'true'}">checked</c:if>>
					<bean:message bundle="sys-simplecategory" key="description.main.tempReader.notUse" />
					<div id="Cate_AllUserId">
					<xform:address textarea="true" mulSelect="true" propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
					</div>
					<div id="Cate_AllUserNote">
					 <bean:message  bundle="km-oitems" key="kmOitemsTemplet.authReaderIds.desc"/>
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
					  <bean:message  bundle="km-oitems" key="kmOitemsTemplet.authEditorIds.desc"/>
					</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsTemplet.docCreatorId"/>
					<td>
						<html:hidden property="docCreatorId" />
						<html:text property="docCreatorName" readonly="true"/>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsTemplet.docCreateTime"/>
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
		<c:param name="formName" value="kmOitemsTempletForm" />
		<c:param name="fdKey" value="kmOitemsTemplet" />
	</c:import>
	<!-- 编号规则 -->
	<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
        <c:param name="formName" value="kmOitemsTempletForm" />
        <c:param name="modelName" value="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication" />
    </c:import>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="kmOitemsTempletForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>