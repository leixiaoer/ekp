<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("dialog.js|data.js|jquery.js");
	
	Com_AddEventListener(window, "load", function() {
		var table = document.getElementById("Label_Tabel");
		if(table != null && window.Doc_AddLabelSwitchEvent){
			Doc_AddLabelSwitchEvent(table, "switchTabShow");
		}
	});
	
	window.initMode = false;
	function switchTabShow(tableName, index) {
		if(window.initMode) {
			return;
		}
		if(index == 2) {
			//默认选中表单模式
			var method = "${kmAssetCategoryForm.method_GET}";
			if(method == "add") {
				if($('select[name="sysFormTemplateForms.assetMainDoc.fdMode"]')) {
					$('select[name="sysFormTemplateForms.assetMainDoc.fdMode"]').val("3");
					Form_ChgDisplay('assetMainDoc', "3");
					window.initMode = true;
				}
			}
		}
	}

	function refreshDisplay() {
		var fields = document.getElementsByName("fdLableVisiable");
		var tableRows = document.getElementById("Table_Info").rows;
		if(fields[0].checked) {
			tableRows[2].style.display="none";
		}
		if(fields[1].checked) {
			tableRows[2].style.display="";
		}
	}
	function XForm_Mode_Listener(key,value) {
		if (value == '1') {
			ShowRtfView(true);
		} else {
			ShowRtfView(false);
			//隐藏“从模板加载”文字
			document.getElementById("A_FormTemplate_assetMainDoc").style.display="none"
		}
	}
	function ShowRtfView(b) {
		var rtfView = document.getElementById('rtfView');
		var display = b ? '' : 'none';
		rtfView.style.display = display;
		var fdUseForm = document.getElementsByName('fdUseForm')[0];
		fdUseForm.value = (!b);
	}
</script>
<html:form action="/km/asset/km_asset_category/kmAssetCategory.do">
<div id="optBarDiv">
	<script language="JavaScript">
	function kmAsset_submitForm(method) {
	    // 判断描述字符长度
	    var fdDesc = document.getElementsByName("fdDesc");
	    if(fdDesc.length > 0) {
		    var newvalue = fdDesc[0].value.replace(/[^\x00-\xff]/g, "***");
			if(newvalue.length > 1500) {
				var msg = '<bean:message key="errors.maxLength"/>'.replace("{0}", '<bean:message bundle="sys-simplecategory" key="sysSimpleCategory.fdDesc"/>').replace("{1}", 1500);
				alert(msg);
				return;
			}
	    }
	    
		Com_Submit(document.kmAssetCategoryForm, method);
	}
	
	function submitForm(method) {
		if(typeof XForm_BeforeSubmitForm != 'undefined' && XForm_BeforeSubmitForm instanceof Function){
			XForm_BeforeSubmitForm(function(){
				kmAsset_submitForm(method);
			});
		}else{
			kmAsset_submitForm(method);
	    }
	}
</script>
	<div id="optBarDiv">
	<c:if test="${kmAssetCategoryForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="submitForm('update');" />
	</c:if> 
	<c:if test="${kmAssetCategoryForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="submitForm('save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="submitForm('saveadd');">
	</c:if> 
		<input type="button" value="<bean:message key="button.close"/>"
			onclick="Com_CloseWindow();">
	</div>
</div>

<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetCategory"/></p>

<center>
<table id="Label_Tabel"	width=95%>
	
	<c:import url="/sys/simplecategory/include/sysCategoryMain_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetCategoryForm" />
			<c:param name="requestURL" value="/km/asset/km_asset_category/kmAssetCategory.do?method=add" />
			<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetCategory" />
			<c:param name="fdKey" value="fdAssetCategory" />
	</c:import>
	
	<!-- 表单 -->
	<tr LKS_LabelName="<kmss:message bundle="km-asset" key="kmAssetCategory.extend" />" style="display:none">
	<td>
	  <c:import url="/sys/xform/include/sysFormTemplate_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetCategoryForm" />
		<c:param name="fdKey" value="assetMainDoc" />
		<c:param name="fdMainModelName"
				value="com.landray.kmss.km.asset.model.KmAssetCard"/>
	    <c:param name="useLabel" value="false" />
	  </c:import>
	  		<table id="rtfView" class="tb_normal" width=100% style="border-top:0;">
			<tr>
				<td colspan="4" style="border-top:0;">
					<html:hidden property="fdUseForm" />
					<xform:rtf property="docContent" toolbarSet="Default" height="500"></xform:rtf>
				</td>
			</tr>
			</table>
	</td>
	</tr>
	<c:if test="${ kmAssetCategoryForm.codeRule=='2' }">
		<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
		    <c:param name="formName" value="kmAssetCategoryForm" />
		    <c:param name="modelName" value="com.landray.kmss.km.asset.model.KmAssetCard"/>
	    </c:import>
	</c:if> 
	<%-- 以下代码为嵌入默认权限模板标签的代码 --%>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />"><td>
		<table class="tb_normal" width=100%>
			<c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetCategoryForm" />
				<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetCategory" />
			</c:import>
		</table>
	</td></tr>
	<%-- 以上代码为嵌入默认权限模板标签的代码 --%>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script language="JavaScript">Com_IncludeFile("calendar.js");</script>
<script>
	$KMSSValidation();
	$('#Label_Tabel tr:eq(6)').after('<tr><td class="td_normal_title" width=15%><bean:message bundle="km-asset" key="kmAssetCategory.fdMeasure"/></td><td colspan=3 width="85%"><xform:text property="fdMeasure" />	</td></tr>');
	$('#Label_Tabel tr:eq(7)').after('<tr><td colspan=4>&nbsp;</td></tr>');
	$('input[name="fdName"]').attr("subject","<bean:message bundle='sys-simplecategory' key='sysSimpleCategory.fdName' />");
	$('input[name="fdName"]').attr("validate","required");
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>