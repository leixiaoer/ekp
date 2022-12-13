<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="auto">
<template:replace name="body"> 
<script type="text/javascript">
	Com_IncludeFile("dialog.js|jquery.js");
	Com_IncludeFile("selectAddress.js", Com_Parameter.ContextPath+ "km/asset/resource/", "js", true);
	Com_IncludeFile("docutil.js|optbar.js|validator.jsp|validation.js|plugin.js|validation.jsp|eventbus.js|xform.js", null, "js");
</script>
<script>
	seajs.use(['theme!form']);
</script>
<p class="txttitle"><bean:message bundle="km-asset" key="kmAssetCard.batchEdit.title"/></p>

<html:form action="/km/asset/km_asset_card/kmAssetCard.do" method="post">
<center>
<table id="List_ViewTable" style="line-height: 25px;">
	<tr>
		<td width="20px">&nbsp;</td>
		<td width="100px"><b><bean:message bundle="km-asset" key="kmAssetCard.batchEdit.colName"/></b></td>
		<td width="500px"><b><bean:message bundle="km-asset" key="kmAssetCard.batchEdit.colValue"/></b></td>
	</tr>
	<tr>
		<td><input name="List_Selected" type="checkbox" value="0"/></td>
		<td><bean:message bundle="km-asset" key="kmAssetCard.fdName"/></td>
		<td style="text-align: left"><xform:text property="fdName" style="width:85%" showStatus="edit" subject="${lfn:message('km-asset:kmAssetCard.fdName')}"/></td>
	</tr>
	<tr>
		<td><input name="List_Selected" type="checkbox" value="1"/></td>
		<td><bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/></td>
		<td style="text-align: left">
			<xform:text property="fdStandard" style="width:85%" showStatus="edit" subject="${lfn:message('km-asset:kmAssetCard.fdStandard')}"/>
		</td>
	</tr>
	<tr>
		<td><input name="List_Selected" type="checkbox" value="2"/></td>
		<td><bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/></td>
		<td style="text-align: left">
				<xform:dialog  propertyId="fdAssetCategoryId" propertyName="fdAssetCategoryName" 
					style="width:85%" showStatus="edit"  subject="${lfn:message('km-asset:kmAssetCard.fdAssetCategory')}"
					dialogJs="Dialog_SimpleCategory('com.landray.kmss.km.asset.model.KmAssetCategory','fdAssetCategoryId','fdAssetCategoryName',false,null,'01',null,null,null);"/> 
		</td>
	</tr>
	<tr>
		<td><input name="List_Selected" type="checkbox" value="3"/></td>
		<td><bean:message bundle="km-asset" key="kmAssetCard.docDept"/></td>
		<td style="text-align: left">
			<xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_DEPT" style="width:85%" showStatus="edit" subject="${lfn:message('km-asset:kmAssetCard.docDept')}"/>
		</td>
	</tr>
	<tr>
		<td><input name="List_Selected" type="checkbox" value="4"/></td>
		<td><bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/></td>
		<td style="text-align: left">
		<xform:address propertyId="fdResponsiblePersonId" propertyName="fdResponsiblePersonName" orgType="ORG_TYPE_PERSON" style="width:85%"  showStatus="edit" subject="${lfn:message('km-asset:kmAssetCard.fdResponsiblePerson')}"/>
		</td>
	</tr>
	<tr>
		<td><input name="List_Selected" type="checkbox" value="5"/></td>
		<td><bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/></td>
		<td style="text-align: left">
			<xform:dialog  propertyId="fdAssetAddressId" propertyName="fdAssetAddressName" style="width:85%" showStatus="edit" subject="${lfn:message('km-asset:kmAssetCard.fdAssetAddress')}" dialogJs="selectResource('fdAssetAddressId','fdAssetAddressName',true);"/>
		</td>
	</tr>
	<tr>
		<td><input name="List_Selected" type="checkbox" value="6"/></td>
		<td><bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus"/></td>
		<td style="text-align: left">
			<xform:radio property="fdAssetStatus"  showStatus="edit" subject="${lfn:message('km-asset:kmAssetCard.fdAssetStatus')}">
				<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
			</xform:radio>
		</td>
	</tr>
	<html:hidden property="fdIds" value="${fdIds }"></html:hidden>
</table>
<br>
<div>
  <ui:button text="${lfn:message('button.update') }" order="2" 
      onclick="commitMethod();">
	</ui:button>&nbsp;&nbsp;
	<ui:button text="${lfn:message('button.close') }" order="2" 
	  onclick="Com_CloseWindow();">
	</ui:button>
</div>
<script>
	$KMSSValidation();
</script>
</center>
<html:hidden property="fdIds"/>
</html:form>
<script type="text/javascript">
function commitMethod(){
	seajs.use(['lui/dialog'], function(dialog) {
		var count = 0;
		$('input[name="List_Selected"]').each(function(){
			if($(this).prop("checked")){
				count++;
			}
		});
		if(count>0){
			Com_Submit(document.kmAssetCardForm, 'batchEdit','fdIds');
		}else{
			dialog.alert('<bean:message bundle="km-asset" key="kmAssetCard.batchEdit.notNull"/>');
		}
	})
}
</script>
<script type="text/javascript">

$('input[name="fdName"]').prop("validate","");
$('span[class="txtstrong"]').hide();
$('input[name="fdName"]').prop("disabled", true);
$('input[name="fdStandard"]').prop("disabled", true);
$('input[name="fdAssetCategoryName"]').prop("disabled", true);
$('input[name="docDeptName"]').prop("disabled", true);
$('input[name="fdResponsiblePersonName"]').prop("disabled", true);
$('input[name="fdAssetAddressName"]').prop("disabled", true);
$('input[name="fdAssetStatus"]').prop("disabled", true);

$('input[name="List_Selected"]').click(function(){
	var v=$(this).val();
	var checked=$(this).prop("checked");
	
		if (checked) {
			if (v == 0) {
				$('input[name="fdName"]').removeAttr("disabled");
				$('input[name="fdName"]').prop("validate","required");
			} else if (v == 1) {
				$('input[name="fdStandard"]').removeAttr("disabled");
				$('input[name="fdStandard"]').prop("validate","required");
			} else if (v == 2) {
				$('input[name="fdAssetCategoryName"]').removeAttr("disabled");
				$('input[name="fdAssetCategoryName"]').prop("validate","required");
			} else if (v == 3) {
				$('input[name="docDeptName"]').removeAttr("disabled");
				$('input[name="docDeptName"]').prop("validate","required");
			} else if (v == 4) {
				$('input[name="fdResponsiblePersonName"]').removeAttr("disabled");
				$('input[name="fdResponsiblePersonName"]').prop("validate","required");
			} else if (v == 5) {
				$('input[name="fdAssetAddressName"]').removeAttr("disabled");
				$('input[name="fdAssetAddressName"]').prop("validate","required");
			} else if (v == 6) {
				$('input[name="fdAssetStatus"]').removeAttr("disabled");
				$('input[name="fdAssetStatus"]').prop("validate","required");
			}
		} else {
			if (v == 0) {
				$('input[name="fdName"]').val("1");
				$('input[name="fdName"]').focus();
				$('input[name="fdName"]').blur();
				$('input[name="fdName"]').val("");
				$('input[name="fdName"]').prop("validate","");
				$('input[name="fdName"]').prop("disabled", true);
			} else if (v == 1) {
				$('input[name="fdStandard"]').val("1");
				$('input[name="fdStandard"]').focus();
				$('input[name="fdStandard"]').blur();
				$('input[name="fdStandard"]').val("");
				$('input[name="fdStandard"]').prop("validate","");
				$('input[name="fdStandard"]').prop("disabled", true);
			} else if (v == 2) {
				$('input[name="fdAssetCategoryName"]').val("1");
				$('input[name="fdAssetCategoryName"]').focus();
				$('input[name="fdAssetCategoryName"]').blur();
				$('input[name="fdAssetCategoryName"]').val("");
				$('input[name="fdAssetCategoryName"]').prop("validate","");
				$('input[name="fdAssetCategoryName"]').prop("disabled", true);
			} else if (v == 3) {
				$('input[name="docDeptName"]').val("1");
				$('input[name="docDeptName"]').focus();
				$('input[name="docDeptName"]').blur();
				$('input[name="docDeptName"]').val("");
				$('input[name="docDeptName"]').prop("validate","");
				$('input[name="docDeptName"]').prop("disabled", true);
			} else if (v == 4) {
				$('input[name="fdResponsiblePersonName"]').val("1");
				$('input[name="fdResponsiblePersonName"]').focus();
				$('input[name="fdResponsiblePersonName"]').blur();
				$('input[name="fdResponsiblePersonName"]').val("");
				$('input[name="fdResponsiblePersonName"]').prop("validate","");
				$('input[name="fdResponsiblePersonName"]').prop("disabled", true);
			} else if (v == 5) {
				$('input[name="fdAssetAddressName"]').val("1");
				$('input[name="fdAssetAddressName"]').focus();
				$('input[name="fdAssetAddressName"]').blur();
				$('input[name="fdAssetAddressName"]').val("");
				$('input[name="fdAssetAddressName"]').prop("validate","");
				$('input[name="fdAssetAddressName"]').prop("disabled", true);
			} else if (v == 6) {
				$('input[name="fdAssetStatus"]').val("1");
				$('input[name="fdAssetStatus"]').focus();
				$('input[name="fdAssetStatus"]').blur();
				$('input[name="fdAssetStatus"]').val("");
				$('input[name="fdAssetStatus"]').prop("validate","");
				$('input[name="fdAssetStatus"]').prop("disabled", true);
			}
		}
	});
</script>
	</template:replace>
</template:include>