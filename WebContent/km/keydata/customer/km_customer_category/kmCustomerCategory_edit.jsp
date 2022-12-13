<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/km/keydata/customer/km_customer_category/kmCustomerCategory.do">
<div id="optBarDiv">
	<c:if test="${kmCustomerCategoryForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmCustomerCategoryForm, 'update');">
	</c:if>
	<c:if test="${kmCustomerCategoryForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmCustomerCategoryForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmCustomerCategoryForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message bundle="km-keydata-customer" key="table.kmCustomerCategory"/></p>

<center>


<table
		id="Label_Tabel"
		width="95%" >
		
		<tr LKS_LabelName="<bean:message bundle="sys-simplecategory"
		key="table.sysSimpleCategory" />" >
		<td>
			<table class="tb_normal" width="100%" ${HtmlParam.styleValue}>
		
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="sys-simplecategory" key="sysSimpleCategory.fdParentName" /></td>
			<td colspan="3"><html:hidden property="fdParentId" /> <html:text
				property="fdParentName" readonly="true" styleClass="inputsgl"
				style="width:90%" /> <a href="#"
				onclick="Dialog_SimpleCategory('${JsParam.fdModelName}','fdParentId','fdParentName',false,null,'01',null,false,'${JsParam.fdId}');">
			<bean:message key="dialog.selectOther" /> </a></td>
		</tr>
		<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-keydata-customer" key="kmCustomerCategory.fdName"/>
		</td><td width="35%">
			<xform:text property="fdName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-keydata-customer" key="kmCustomerCategory.fdOrder"/>
		</td><td width="35%">
			<xform:text property="fdOrder" style="width:85%" />
		</td>
	</tr>
	
	
		
		
			</table>
		</td>
	</tr>
	
		
		
		<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table
				class="tb_normal"
				width=100%>
				<c:import
					url="/sys/right/tmp_right_edit.jsp"
					charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmCustomerCategoryForm" />
					<c:param
						name="moduleModelName"
						value="com.landray.kmss.km.keydata.customer.model.KmCustomerCategory" />
				</c:import>
			</table>
			</td>
		</tr>
		
	</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();

	Com_IncludeFile("jquery.js|dialog.js");
	

	
	function checkParentId(){
		//debugger;
		var formObj = document.forms['kmCustomerCategoryForm'];
		if(formObj.fdParentId.value!="" && formObj.fdParentId.value==formObj.fdId.value){
			alert('<bean:message bundle="sys-simplecategory" key="error.illegalSelected" />');
			return false;
		}else
			return true;	
	}
	Com_Parameter.event["submit"][Com_Parameter.event["submit"].length] = checkParentId;
	<%-- 
	function Cate_getParentMaintainer(){
		var parameters ="parentId="+document.getElementsByName("fdParentId")[0].value;
		var s_url = Com_Parameter.ContextPath+"km/keydata/km_customer_category/kmCustomerCategory.do?method=add?method=getParentMaintainer";
		$.ajax({
				url: s_url,
				type: "GET",
				data: parameters,
				dataType:"text",
				async: false,
				success: function(text){
					$(document.getElementById("parentMaintainerId")).text(text);
				}});
	}
--%>
	

</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>