<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.profile.edit" sidebar="no">
<template:replace name="content">
<html:form action="/sys/unit/sys_unit_appconfig/sysUnitAppConfig.do">
<div style="margin-top:25px">
<p class="configtitle"><bean:message key="sysUnit.tree.displayConfig" bundle="sys-unit" /></p>
<center>
<table class="tb_normal" width=95%>
	
	<tr>
	  <td class="td_normal_title" width=20%>
			<bean:message bundle="sys-unit" key="setting.outCategory.default"/>
	  </td>
		<td colspan="3">
			<xform:dialog propertyName="value(outCategoryName)" propertyId="value(outCategoryId)" className="inputsgl" style="width:95%">
				 Dialog_Tree(false, 'value(outCategoryId)', 'value(outCategoryName)', ',', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit"/>', null, null, 'null', null, null, '<bean:message  bundle="sys-unit" key="kmImissiveUnit.fdCategoryId"/>');
			</xform:dialog><br>
			<bean:message bundle="sys-unit" key="setting.outCategory.default.hint"/>
		</td>
	</tr>
	<tr>
	  <td class="td_normal_title" width=20%> 
			<bean:message bundle="sys-unit" key="sysUnit.config.dataChange"/>
	  </td>
		<td colspan="3">
			  <ui:switch property="value(exchange)" checkVal="1" unCheckVal="0" 
			  enabledText="${lfn:message('sys-unit:sysUnit.config.open')}" 
			  disabledText="${lfn:message('sys-unit:sysUnit.config.close')}" 
			  onValueChange="changeExchange();"></ui:switch>
		</td>
	</tr>
	<tr class="decConfig">
	  <td class="td_normal_title" width=20%>
			<bean:message bundle="sys-unit" key="sysUnit.config.sysCode"/>
	  </td>
		<td colspan="3">
			<xform:text property="value(unitCode)" subject="${lfn:message('sys-unit:sysUnit.config.sysCode')}"  style="width:95%" showStatus="edit"/>
			<br>
			<bean:message bundle="sys-unit" key="sysUnit.config.sysCode.desc"/>
		</td>
	</tr>
	<tr class="decConfig">
	  <td class="td_normal_title" width=20% rowspan="3">
			<bean:message bundle="sys-unit" key="sysUnit.config.dataChange.tip1"/>
	  </td>
		<td colspan="3"> 
			<bean:message bundle="sys-unit" key="sysUnit.config.dataChange.tip2"/>:
			<xform:text property="value(fdDecUrl)" subject="${lfn:message('sys-unit:sysUnit.config.dataChange.tip2')}" style="width:84%"  showStatus="edit"/>
		</td>
	</tr>
	<tr class="decConfig">
		<td>
			<bean:message bundle="sys-unit" key="sysUnit.config.dataChange.tip3"/>:
			<xform:text property="value(fdDecUser)" subject="${lfn:message('sys-unit:sysUnit.config.dataChange.tip3')}"  style="width:84%" showStatus="edit"/>
		</td>
	</tr>
	<tr class="decConfig">
		<td> 
			<bean:message bundle="sys-unit" key="sysUnit.config.dataChange.tip4"/>:
			<xform:text property="value(fdDecPassword)" subject="${lfn:message('sys-unit:sysUnit.config.dataChange.tip4')}"  style="width:84%" showStatus="edit"/>
			<br>
			<bean:message bundle="sys-unit" key="sysUnit.config.dataChange.tip5"/> 
		</td>
	</tr>
	<tr class="decConfig">
	  <td class="td_normal_title" width=20%> 
			<bean:message bundle="sys-unit" key="sysUnit.config.sysDocument"/>
	  </td>
		<td colspan="3">
			<xform:address mulSelect="true" orgType="ORG_TYPE_PERSON" propertyName="value(fdSecretaryNames)" 
			propertyId="value(fdSecretaryIds)" subject="${lfn:message('sys-unit:sysUnit.config.sysDocument')}"  style="width:95%" showStatus="edit"></xform:address>
			<br>
			<bean:message bundle="sys-unit" key="sysUnit.config.sysDocument.desc"/>
		</td>
	</tr>
</table>
<div style="margin-bottom: 10px;margin-top:25px">
	   <ui:button text="${lfn:message('button.save')}" suspend="bottom" height="35" width="120" onclick="Com_Submit(document.sysAppConfigForm, 'update');" order="1" ></ui:button>
</div>
</center>
</div>
<script>

LUI.ready(function(){
	changeExchange();
});

function changeExchange(){
	  var showImgDoc=document.getElementsByName("value(exchange)")[0];
	  if(showImgDoc.value == "0"){
			$('.decConfig').hide();
	  }else{
		  $('.decConfig').show();
	  }
	}
</script>
</html:form> 
</template:replace>
</template:include>