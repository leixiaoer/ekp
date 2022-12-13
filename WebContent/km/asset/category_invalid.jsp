<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<!doctype html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>${lfn:message('return.systemInfo') }</title>
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath }/<%=(JSONObject.fromObject(SysUiPluginUtil.getThemes(request))).getJSONArray("prompt").get(0)%>"/>
		<%@ include file="/sys/ui/jsp/jshead.jsp"%>
		<script type="text/javascript">
			if('${fdIsAvailable}' == 'false'){
				Com_IncludeFile("data.js");
				seajs.use( [ 'lui/jquery'], function($) {
					$(document).ready(function(){
							seajs.use(['lui/jquery', 'lui/dialog'], function($,dialog) {
								dialog.confirm('<bean:message  bundle="km-asset" key="kmAssetApplyTemplate.msg.notAvailable"/>',function(flag){
							    	if(flag==true){
							    		var tempId = "";
							 			dialog.category('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','fdTemplateId','fdTemplateName',false,function(rtn){
								 			if(rtn != false&&rtn != null){
								 				tempId = document.getElementsByName("fdTemplateId")[0].value;
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
								 			}else{
								 				Com_CloseWindow();
								 	        }
								 	   });
							    	}else{
							    		Com_CloseWindow();
								    }
							    },"warn");
							});
					});	
				});
			}
		</script>		
	</head>
	<body>
		<input type="hidden" name="fdTemplateId" />
		<input type="hidden" name="fdTemplateName" />
	</body>
</html>