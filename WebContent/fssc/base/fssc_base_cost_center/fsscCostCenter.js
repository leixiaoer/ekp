function afterSelect(){
	$("[name=fdParentId]").val("");
	$("[name=fdParentName]").val("");
	getTypeData();
};

function getTypeData(){
	var data = new KMSSData();
	data.UseCache = false;
	var fdCompanyId=$("input[name='fdCompanyId']").val();
	var rtn = data.AddBeanData("fsscBaseCostCenterService&authCurrent=true&flag=costCenterType&fdCompanyId="+fdCompanyId).GetHashMapArray();
	if(rtn&&rtn.length > 0){
		var innerHtml="";
		for(var i=0;i<rtn.length;i++){
			innerHtml+='<label><input type="radio" name="fdTypeId" validate="required" value="'
				+rtn[i]["id"]+'" subject="'+messageInfo['fsscBaseCostCenter.fdType']+'">'+rtn[i]["name"]+'</label>';
		}
		innerHtml+='<span class="txtstrong">*</span>';
		$("#_xform_fdTypeId").html(innerHtml);
	}
}
function changeSystem(value,dom){
	if(value=='U8'){
		$("#systemParam").show();
		$("#systemTitle").html(messageInfo['fsscBaseCostCenter.fdSystemParam.U8']);
		$("input[name='fdSystemParam']").val("");
	}else if(value=='K3'){
		$("#systemParam").show();
		$("#systemTitle").html(messageInfo['fsscBaseCostCenter.fdSystemParam.K3']);
		$("input[name='fdSystemParam']").val("");
	}else{
		$("#systemParam").hide();
		$("#systemTitle").html('');
		$("input[name='fdSystemParam']").val("");
	}
};
$(document).ready(function(){
	if($("[name='method_GET']").val()=='edit'){
		getTypeData();
		setTimeout(function(){
			$(":radio[name='fdTypeId'][value='" + $("[name='fdType']").val() + "']").prop("checked", "checked");
		},500);
	}
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
