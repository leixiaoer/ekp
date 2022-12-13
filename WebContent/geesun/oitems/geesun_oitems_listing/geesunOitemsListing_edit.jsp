<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
<script language="javascript">
	function check(obj){
		var eventObj = Com_GetEventObject();
		if(eventObj.keyCode == 13)
			return true;
		if(eventObj.keyCode < 48 || eventObj.keyCode >57){
			alert('<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice.type"/>');
			return false;
		}else return true;
	}
	function Com_Submit0(form,operation){
		var fdAmount = document.getElementsByName("fdAmount")[0].value;
		if(fdAmount<0){
			alert("库存量 不能为负数");
			return;
		}
		Com_Submit(form,operation);
	}
</script>
<html:form action="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do"
	onsubmit="return validateGeesunOitemsListingForm(this);">
	<div id="optBarDiv"><c:if
		test="${geesunOitemsListingForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit0(document.geesunOitemsListingForm, 'update');">
	</c:if> <c:if test="${geesunOitemsListingForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit0(document.geesunOitemsListingForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit0(document.geesunOitemsListingForm, 'saveadd');">
	</c:if> <input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();"></div>

	<p class="txttitle"><bean:message bundle="geesun-oitems"
		key="table.geesunOitemsListing" /></p>

	<center>
	<table class="tb_normal" width=95%>
		<html:hidden property="fdId" />

		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdName" /></td>
			<td colspan="3"><html:text style="width:80%" property="fdName" /><span
				class="txtstrong">*</span></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdNo" /></td>
			<td width=35%><html:text property="fdNo" style="width:60%" /><span
				class="txtstrong">*</span></td>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId" /></td>
			<td width=35%><html:hidden property="fdCategoryId" /> <html:text
				style="width:60%" styleClass="inputsgl" property="fdCategoryName"
				readonly="true" /> <a href="#"
				onclick="Dialog_Tree(false, 
				 'fdCategoryId', 
				 'fdCategoryName', 
				 ',', 
				 'geesunOitemsManageServiceTree&categoryId=!{value}&nodeType=!{nodeType}', 
				 '<bean:message key="table.geesunOitemsManage" bundle="geesun-oitems"/>',
				  null, null,
				   null, null, null,
				   '<bean:message key="table.geesunOitemsManage" bundle="geesun-oitems"/>')"><bean:message
				key="dialog.selectOther" /> </a><span class="txtstrong">*</span></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification" /></td>
			<td width=35%><html:text property="fdSpecification"
				style="width:60%" /></td>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdBrand" /></td>
			<td width=35%><html:text property="fdBrand" style="width:60%" />
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice" /></td>
			<td width=35%><html:text property="fdReferencePrice"
				style="width:60%" /><span class="txtstrong">*</span></td>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdUnit" /></td>
			<td width=35%><html:text property="fdUnit" style="width:60%" />
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdAmount" /></td>
			<td colspan="3"><c:if
				test="${geesunOitemsListingForm.method_GET=='edit'}">
				<html:text style="width:25%" property="fdAmount" readonly="true" />
			</c:if> <c:if test="${geesunOitemsListingForm.method_GET=='add'}">
				<html:text style="width:25%" property="fdAmount" /><span class="txtstrong">*</span><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.atuoCount" />
			</c:if></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.picture" /></td>
			<td colspan="3"><c:import
				url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
				charEncoding="UTF-8">
				<c:param name="fdKey" value="geesunOitemsListing" />
				<c:param name="fdAttType" value="pic" />
				<c:param name="fdMulti" value="false" />
				<c:param name="fdShowMsg" value="true" />
				<c:param name="fdImgHtmlProperty" value="width=100 height=100" />
			</c:import></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdRemark" /></td>
			<td colspan="3"><html:textarea style="width:100%"
				property="fdRemark" /></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.docCreatorId" /></td>
			<td width=35%><html:hidden property="docCreatorId" /> <html:text
				property="docCreatorName" readonly="true" /></td>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.docCreateTime" /></td>
			<td width=35%><html:text property="docCreateTime"
				readonly="true" /></td>
		</tr>
	</table>
	</center>
	<html:hidden property="method_GET" />
</html:form>
<html:javascript formName="geesunOitemsListingForm" cdata="false"
	dynamicJavascript="true" staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>
