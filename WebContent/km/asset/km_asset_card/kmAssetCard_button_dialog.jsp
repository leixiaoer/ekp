<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple"   sidebar="no">
<template:replace name="body">
<script type="text/javascript">
seajs.use(['theme!form']);
</script>
<script type="text/javascript">
	window.returnValue='';
	Com_IncludeFile("dialog.js", "style/"+Com_Parameter.Style+"/dialog/");
	function getReturnValue()
	{

		 var optFDocument=parent.window.frames["optFrame"].document;
		 var checks=optFDocument.getElementsByName("List_Selected");
		 var checksValue="";
		 for(var i=0;i<checks.length;i++)
		 {
			 if(checks[i].checked)
			 {
				checksValue+=checks[i].value+";";
			}
		 }
		//parent.window.returnValue = checksValue;
		//alert(window.returnValue);
		//Com_CloseWindow();
		parent.$dialog.hide(checksValue);
	}
</script>

	<center>
		<input name="btnOk" id="btnOk"  class="lui_form_button" type="button" value="<bean:message key="button.ok"/>"
					onclick="getReturnValue();">
		<input name="btnCancel" id="btnCancel"  class="lui_form_button" type="button" value="<bean:message key="button.cancel"/>"
					onclick="parent.$dialog.hide();">
	</center>
</template:replace>
</template:include>