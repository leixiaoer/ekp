/*******************************************************************************
选择供应商(支持多选) 调用方式: 
 	javascript中加入
  		Com_IncludeFile("providerDialog.js",Com_Parameter.ContextPath+"km/provider/resource/js/","js",true); 
  	html中加入
  		<input type="hidden" name="providerId" />
  		<input type="text" name="providerName" />
  	 	<a href="#" onclick="Dialog_Provider('providerId','providerName')">选择供应商(单选)</a>
  @param id
 		 存放供应商ID标签的name属性值
  @param name
  		存放供应商name标签的name属性值
  @param multi
 		是否多选,true多选,默认单选
  @param split
  	多个供应商分割符,multi为true应选,默认为;
*******************************************************************************/
function Dialog_Provider(id, name,multi,split) {
	    seajs.use(['lui/dialog'], function(dialog){
			if(split==null){
				split=";";
			}
			var path = location.href;
			path = Com_SetUrlParameter(
					Com_Parameter.ContextPath + 'resource/jsp/frame.jsp',
					'url',
					Com_Parameter.ContextPath + 'km/provider/km_provider_main/kmProviderMainSelect.do?method=showProvider&multi='+multi+"&split="+split);
			dialog.iframe(Com_GetCurDnsHost()+path,Data_GetResourceString("km-provider:kmProviderMain.title.selectProvider"),function(returnValue){
				var providerId = document.getElementsByName(id);
				var providerName = document.getElementsByName(name);
				if(jQuery.isArray(returnValue)){
					providerId[0].value = returnValue[0];
					providerName[0].value = returnValue[1];			
				}else{
					if(returnValue == "cancelselect"){
						providerId[0].value="";
						providerName[0].value="";
					}
				}
			},{width:800,height:550});
			return true;
   });
}