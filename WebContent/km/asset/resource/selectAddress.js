/***********************************************
功能：选择地点资源的函数
参数：
	fdAddressId：
		必选，选择地址id绑定的域值
	fdAddressName：
	    必选，选择地址name绑定的域值
***********************************************/
function selectResource(fdAddressId,fdAddressName,validate)
{
    if(true){
		 seajs.use(['lui/dialog'], function(dialog){
			 var  path= Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/asset/km_asset_address/kmAssetAddress.do?method=showAddress';
			 dialog.iframe(path,Data_GetResourceString("km-asset:kmAssetAddress.selectAddress"),function(rtn){
			 if(jQuery.isArray(rtn)){
					var obj = document.getElementsByName(fdAddressId);
					obj[0].value = "";
					obj[0].value = rtn[0];
					obj = document.getElementsByName(fdAddressName);
					obj[0].value = "";
					obj[0].value = rtn[1];
				}else {
				 	if(rtn == "cancelselect"){
						obj = document.getElementsByName(fdAddressId)[0].value="";
						obj = document.getElementsByName(fdAddressName)[0].value="";
					}
				}
			 if(validate){
				 document.getElementsByName(fdAddressName)[0].focus();
				 document.getElementsByName(fdAddressName)[0].blur();
			 }
		 },{width:650,height:550});
	  });
	}
}

function selectResourceNew(fdAddressId,fdAddressName,validate,isMul)
{
    if(true){
		 seajs.use(['lui/dialog'], function(dialog){
			 var  path= Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/asset/km_asset_address/kmAssetAddress.do?method=showAddress&isMul='+isMul;
			 dialog.iframe(path,Data_GetResourceString("km-asset:kmAssetAddress.selectAddress"),function(rtn){
			 if(jQuery.isArray(rtn)){
					var obj = document.getElementsByName(fdAddressId);
					obj[0].value = "";
					obj[0].value = rtn[0];
					obj = document.getElementsByName(fdAddressName);
					obj[0].value = "";
					obj[0].value = rtn[1];
				}else {
				 	if(rtn == "cancelselect"){
						obj = document.getElementsByName(fdAddressId)[0].value="";
						obj = document.getElementsByName(fdAddressName)[0].value="";
					}
				}
			 if(validate){
				 document.getElementsByName(fdAddressName)[0].focus();
				 document.getElementsByName(fdAddressName)[0].blur();
			 }
		 },{width:650,height:550});
	  });
	}
}
