<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("calendar.js|jquery.js");
</script>
<script>
$(document).ready(function(){ 	
	$("#docFinishedTime").val(window.dialogArguments);
	window.returnValue = null;
})
function btn_ok(){
	//调查完成时间
	var val=Date.parse( $("#docFinishedTime").val().replace(/\-/g,'/') );		
	var fdFinishDate = new Date(val);
	//当前时间
	var currentTime = new Date();
	if(currentTime > fdFinishDate){
		alert("<bean:message bundle="km-pindagate" key="kmPindagateMain.endDate.no.lt.currentDate"/>");
		return;
	}
	
	window.returnValue = $("#docFinishedTime").val();
	window.close();
}
function btn_cancel(){
	window.returnValue = null;
	window.close();	
}
</script>
<kmss:windowTitle
			subjectKey=""
			moduleKey="km-pindagate:table.kmPindagateMain" />
<div id="a1" style="display:none;position:absolute; top:100px; right:80px;"></div>
<center>
<table class="tb_normal" width=90%>
<tr>
	<td class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateMain.docFinishedTime"/></td>
	<td><input type="text" id="docFinishedTime" name="docFinishedTime" value="" class="inputsgl" subject="<bean:message bundle="km-pindagate" key="kmPindagateMain.docFinishedTime"/>" readOnly /> <a href="#" onclick="return (selectDateTime('docFinishedTime')==true);"><bean:message bundle="km-pindagate" key="kmPindagateMain.select"/></a> <br>
					<font color="red"><bean:message bundle="km-pindagate" key="kmPindagateMain.tip.null.not.limit.time"/></font></td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="button" class="btnopt" value="<bean:message key="button.ok"/>" onclick="btn_ok();">
		<input type="button" class="btnopt" value="<bean:message key="button.cancel"/>" onclick="btn_cancel();">
	</td>
</tr>
</table>
</center>

<%@ include file="/resource/jsp/view_down.jsp"%>