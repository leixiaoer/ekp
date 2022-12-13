$(document).ready(function(){
	var fdJoinSystem=$("input[name='fdJoinSystem']:checked").val();
	if(fdJoinSystem=='U8'){
		$("#systemParam").show();
		$("#systemTitle").html(messageInfo['fsscBaseCompany.fdSystemParam.U8']);
	}else if(fdJoinSystem=='K3'){
		$("#systemParam").show();
		$("#systemTitle").html(messageInfo['fsscBaseCompany.fdSystemParam.K3']);
	}else{
		$("#systemParam").hide();
		$("#systemTitle").html('');
	}
});
function changeSystem(value,dom){
	if(value=='U8'){
		$("#systemParam").show();
		$("#systemTitle").html(messageInfo['fsscBaseCompany.fdSystemParam.U8']);
		$("input[name='fdSystemParam']").val("");
	}else if(value=='K3'){
		$("#systemParam").show();
		$("#systemTitle").html(messageInfo['fsscBaseCompany.fdSystemParam.K3']);
		$("input[name='fdSystemParam']").val("");
	}else{
		$("#systemParam").hide();
		$("#systemTitle").html('');
		$("input[name='fdSystemParam']").val("");
	}
}