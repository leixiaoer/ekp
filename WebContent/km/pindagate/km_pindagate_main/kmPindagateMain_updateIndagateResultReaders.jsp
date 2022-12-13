<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("calendar.js|jquery.js|dialog.js");
</script>
<script>
$(document).ready(function(){
	var obj=window.dialogArguments;
	var arr_obj=obj.split(",");
	if(arr_obj.length==3)
	{
		$("#fdId").val(arr_obj[2]);
		if(arr_obj[1]!="")
		{
			$("INPUT[name=indagateResultReaderIds]").val(arr_obj[0]);
		}
		if(arr_obj[2]!="")
		{
			$("textarea[name=indagateResultReaderNames]").val(decodeURI(arr_obj[1]));
		}
	}
	window.returnValue = null;
});
function btn_ok(){
	window.returnValue = $("INPUT[name=indagateResultReaderIds]").val();
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
<html:form action="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=updateIndagateResultReaders">
	<input type="hidden" id="fdId" name="fdId" value=""/>
<table class="tb_normal" width=90%>
	<tr>
		<td width="15%" class="td_normal_title"><bean:message
				bundle="km-pindagate" key="kmPindagateMain.result.reader" /></td>
		<td colspan="3"><xform:address propertyId="indagateResultReaderIds" propertyName="indagateResultReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" showStatus="edit"/></td>
	</tr>	
	<tr>
		<td colspan="4" align="center">
			<input type="button" class="btnopt" value="<bean:message key="button.ok"/>" onclick="btn_ok();">
			<input type="button" class="btnopt" value="<bean:message key="button.cancel"/>" onclick="btn_cancel();">
		</td>
	</tr>
</table>
</html:form>
</center>

<%@ include file="/resource/jsp/edit_down.jsp"%>