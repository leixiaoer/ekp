<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.dialog" sidebar="auto">
	<template:replace name="content">
		<html:form action="/fssc/base/fssc_base_accounts/fsscBaseAccounts.do">
		<script>
			Com_IncludeFile("plugin.js", "${LUI_ContextPath}/resource/js/", 'js', true);
			Com_IncludeFile("security.js");
		    Com_IncludeFile("domain.js");
		    Com_IncludeFile("form.js");
			Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
			Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_accounts_com/", 'js', true);
		</script>
		<p class="txttitle">${lfn:message('fssc-base:message.table.label.selectCompany') }</p>
		<table class="tb_normal" width="95%">
			<tr>
				<td width="25%" class="td_normal_title">${lfn:message('fssc-base:message.table.label.selectCompany') }</td>
				<td width="75%">
					<xform:dialog textarea="true" showStatus="edit" style="width:85%" propertyName="fdCompanyNames" propertyId="fdCompanyIds" subject="${lfn:message('fssc-base:fsscBaseItemAccount.fdCompany')}">
						dialogSelect(true,'fssc_base_company_fdCompany','fdCompanyIds','fdCompanyNames');
					</xform:dialog>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><ui:button text="${lfn:message('button.submit') }" onclick="submit()"/></td>
			</tr>
		</table>
		<script>
			seajs.use(['lui/dialog'],function(dialog){
				window.submit = function(){
					var fdCompanyIds = $("[name=fdCompanyIds]").val();
					if(!fdCompanyIds){
						dialog.alert("${lfn:message('fssc-base:message.pleaseSelectCompany') }");
						return;
					}
					$dialog.hide({fdCompanyIds:fdCompanyIds});
				}
			});
		</script>
		</html:form>
	</template:replace>
</template:include>