<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<kmss:windowTitle
	subjectKey="km-institution:button.chengeTemplate"
	moduleKey="km-institution:table.kmdoc" />
<script language="JavaScript">
	Com_IncludeFile("dialog.js");
	function checkTemplate(){
		var templateName = document.getElementsByName("fdDocTemplateName")[0].value;
		if(templateName == '' || templateName == null || templateName.length == 0){
			alert("<bean:message key="kmInstitutionMain.fdDocTemplateName.required" bundle="km-institution"/>");
			return false;
		}
		return true;
	}
	function commitMethod(commitType){
		var formObj = document.kmInstitutionKnowledgeForm;
		if(checkTemplate()){
			Com_Submit(formObj, commitType);
		}
	}
</script>
<html:form action="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do">
	<div id="optBarDiv"><input
		type=button
		value="<bean:message key="button.save"/>"
		onclick="commitMethod('changeTemplate');"> <input
		type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();"></div>
	<p class="txttitle"><bean:message
		bundle="km-institution"
		key="message.transfer.doc" /></p>
	<center>
	<table
		class="tb_normal"
		width=95%>
		<tr>
			<td
				class="td_normal_title"
				width=10%><bean:message
				key="kmInstitutionTemplate.fdName"
				bundle="km-institution" /></td>
			<td><html:hidden property="fdDocTemplateId" /> <html:text
				property="fdDocTemplateName"
				style="width:80%;" /><a
				href="#"
				onclick="Dialog_Template('com.landray.kmss.km.institution.model.KmInstitutionTemplate', 'fdDocTemplateId::fdDocTemplateName',false,true);"> <bean:message key="dialog.selectOther" /> </a><span class="txtstrong">*</span></td>
		</tr>
	</table>
	</center>
	<html:hidden property="method_GET" />
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>
