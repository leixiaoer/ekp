<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>
function validateForm() {
	if (document.geesunAnnualMainForm.theFile.value == "") {
		alert("导入文件不能为空!");
	}else{
		Com_Submit(document.geesunAnnualMainForm, 'importExcel');
	}
}
</script>
<html:form  action="/geesun/annual/geesun_annual_main/geesunAnnualMain.do" method="POST"
	enctype="multipart/form-data">
	<div id="optBarDiv"><input type="button"
		value="<bean:message  bundle="geesun-annual" key="geesunAnnualMain.upload"/>"
		onclick="validateForm();">
	<input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();"></div>
	<center>
	<table class="tb_normal" width=95%>
		<tr>
			<td class="td_normal_title" width=15% align="center"><bean:message
				bundle="geesun-annual" key="geesunAnnualMain.import.selectExcel" /></td>
			<td width=35%><html:file property="theFile"  style="width:50%"/></td>
		</tr>
	</table>
	</center>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>