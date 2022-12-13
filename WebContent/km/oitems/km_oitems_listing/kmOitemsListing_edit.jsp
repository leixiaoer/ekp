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
			alert('<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice.type"/>');
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
<html:form action="/km/oitems/km_oitems_listing/kmOitemsListing.do"
	onsubmit="return validateKmOitemsListingForm(this);">
	<div id="optBarDiv"><c:if
		test="${kmOitemsListingForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit0(document.kmOitemsListingForm, 'update');">
	</c:if> <c:if test="${kmOitemsListingForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit0(document.kmOitemsListingForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit0(document.kmOitemsListingForm, 'saveadd');">
	</c:if> <input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();"></div>

	<p class="txttitle"><bean:message bundle="km-oitems"
		key="table.kmOitemsListing" /></p>

	<center>
	<table class="tb_normal" width=95%>
		<html:hidden property="fdId" />

		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.fdName" /></td>
			<td colspan="3"><html:text style="width:80%" property="fdName" /><span
				class="txtstrong">*</span></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.fdNo" /></td>
			<td width=35%><html:text property="fdNo" style="width:60%" /><span
				class="txtstrong">*</span></td>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.fdCategoryId" /></td>
			<td width=35%><html:hidden property="fdCategoryId" /> <html:text
				style="width:60%" styleClass="inputsgl" property="fdCategoryName"
				readonly="true" /> <a href="#"
				onclick="Dialog_Tree(false, 
				 'fdCategoryId', 
				 'fdCategoryName', 
				 ',', 
				 'kmOitemsManageServiceTree&categoryId=!{value}&nodeType=!{nodeType}', 
				 '<bean:message key="table.kmOitemsManage" bundle="km-oitems"/>',
				  null, null,
				   null, null, null,
				   '<bean:message key="table.kmOitemsManage" bundle="km-oitems"/>')"><bean:message
				key="dialog.selectOther" /> </a><span class="txtstrong">*</span></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.fdSpecification" /></td>
			<td width=35%><html:text property="fdSpecification"
				style="width:60%" /></td>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.fdBrand" /></td>
			<td width=35%><html:text property="fdBrand" style="width:60%" />
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.fdReferencePrice" /></td>
			<td width=35%><html:text property="fdReferencePrice"
				style="width:60%" /><span class="txtstrong">*</span></td>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.fdUnit" /></td>
			<td width=35%><html:text property="fdUnit" style="width:60%" />
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.fdAmount" /></td>
			<td colspan="3"><c:if
				test="${kmOitemsListingForm.method_GET=='edit'}">
				<html:text style="width:25%" property="fdAmount" readonly="true" />
			</c:if> <c:if test="${kmOitemsListingForm.method_GET=='add'}">
				<html:text style="width:25%" property="fdAmount" /><span class="txtstrong">*</span><bean:message
				bundle="km-oitems" key="kmOitemsListing.atuoCount" />
			</c:if></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.picture" /></td>
			<td colspan="3"><c:import
				url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
				charEncoding="UTF-8">
				<c:param name="fdKey" value="kmOitemsListing" />
				<c:param name="fdAttType" value="pic" />
				<c:param name="fdMulti" value="false" />
				<c:param name="fdShowMsg" value="true" />
				<c:param name="fdImgHtmlProperty" value="width=100 height=100" />
			</c:import></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.fdRemark" /></td>
			<td colspan="3"><html:textarea style="width:100%"
				property="fdRemark" /></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.docCreatorId" /></td>
			<td width=35%><html:hidden property="docCreatorId" /> <html:text
				property="docCreatorName" readonly="true" /></td>
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-oitems" key="kmOitemsListing.docCreateTime" /></td>
			<td width=35%><html:text property="docCreateTime"
				readonly="true" /></td>
		</tr>
	</table>
	</center>
	<html:hidden property="method_GET" />
</html:form>
<html:javascript formName="kmOitemsListingForm" cdata="false"
	dynamicJavascript="true" staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>