<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="auto">
<template:replace name="content"> 
<html:form action="/km/asset/km_asset_apply_base/kmAssetApplyBase.do">
<input type="hidden" name="fdTemplateId" value=""/>
<input type="hidden" name="fdTemplateName" value=""/>
</html:form>
</template:replace>
</template:include>
<script type="text/javascript">
Com_IncludeFile("data.js");
/**
var url = Dialog_Template('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','',false,true,'02',function(rtn){
	  if(rtn[0].id!=null&&rtn[0].id!=''){
		  addTemplate(rtn[0].id);
   }
});
function addTemplate(id){
	 var data = new KMSSData();
		var CreatUrl = Com_Parameter.ContextPath+"km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="+id;
		data.SendToUrl(CreatUrl,function(data) {
		var results=data.responseText;
		window.setTimeout(function(){
			window.open(Com_Parameter.ContextPath+results,"_self");
   }, 100);
});
}
**/
seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) { 
 	//新建
	var tempId = "";
	dialog.category('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','fdTemplateId','fdTemplateName',false,function(rtn){
		if(rtn != false&&rtn != null){
			tempId = document.getElementsByName("fdTemplateId")[0].value;
			addByApplyTemplate(tempId);
		}else{
			window.close();
		}
    });
 	
 	window.addByApplyTemplate = function(tempId){
 		 if(tempId!=null&&tempId!=''){
 	        	var data = new KMSSData();
 	    		var url = Com_Parameter.ContextPath+"km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="+tempId;
 	    		var results;
 	    		data.SendToUrl(url,function(data) {
 	    			results=data.responseText;
 	        		
 	    		},false);
 	    		document.getElementsByName("fdTemplateId")[0].value = "";
 	    		document.getElementsByName("fdTemplateName")[0].value = "";
 	    	 window.open(Com_Parameter.ContextPath+results,'_self');
 	      }
	 };
});
</script>