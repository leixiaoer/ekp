<script type="text/javascript">
function changereason(fdIntroId){
 var newreason=document.getElementsByName("fdIntroduceReason")[0].value;
 var changeURL = Com_Parameter.ContextPath + "sys/introduce/sys_introduce_main/sysIntroduceMain.do?method=changeReason";
 changeURL = Com_SetUrlParameter(changeURL, "fdIntroId", fdIntroId);
 changeURL = Com_SetUrlParameter(changeURL, "fdModelName", '${sysIntroduceMainForm.fdModelName}');
 seajs.use(['lui/jquery','lui/dialog'],function($,dialog){
	 $.ajax({
		 url: changeURL,
			type: 'post',
			dataType: 'json',
			data:{newreason :newreason},
			success: function(data, textStatus, xhr) {
				dialog.alert("${lfn:message('sys-introduce:sysIntroduceMain.changetrue')}");
			   
			},
			error: function(data, textStatus, xhr) {
				dialog.alert("${lfn:message('sys-introduce:sysIntroduceMain.changetruefalse')}");
			}
		 })



	 
 })
	
}

</script>