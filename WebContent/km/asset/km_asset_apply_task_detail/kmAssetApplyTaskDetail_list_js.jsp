<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<script src="${KMSS_Parameter_ResPath }js/common.js" type="text/javascript"/>	
	<script src="${KMSS_Parameter_ResPath }js/data.js" type="text/javascript"/>
	<script type="text/javascript">
	
	//新建
 	window.addDoc = function(fdTaskId,fdCardId,fdDetailId){
 		var tempId = "";
 		seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic){
 			dialog.category('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','fdTemplateId','fdTemplateName',false,function(rtn){
	 			if(rtn != false&&rtn != null){
	 				tempId = document.getElementsByName("fdTemplateId")[0].value;
	 				addByApplyTemplate(tempId,fdTaskId,fdCardId,fdDetailId);
	 			}
	 	   });
 		});
 	};
 	
 	window.addByApplyTemplate = function(tempId,fdTaskId,fdCardId,fdDetailId){
 		 if(tempId!=null&&tempId!=''){
 				var data = new KMSSData();
 	    		var url = Com_Parameter.ContextPath+"km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="+tempId;
 	    		var results;
 	    		data.SendToUrl(url,function(data) {
 	    			results=data.responseText;
 	        		
 	    		},false);
 	    		document.getElementsByName("fdTemplateId")[0].value = "";
 	    		document.getElementsByName("fdTemplateName")[0].value = "";
 	    		window.open(Com_Parameter.ContextPath+results+"&fdTaskId="+fdTaskId+"&fdCardId="+fdCardId+"&fdDetailId="+fdDetailId,'_blank');
 	      }
	 };
	
	// 创建新的卡片
	window.openCreateCard = function(fdTaskId,fdAssetCategoryId,fdAssetAddressId){
		window.open('<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=add&fdTaskId='+fdTaskId+"&fdTemplateId="+fdAssetCategoryId+"&fdAssetAddressId="+fdAssetAddressId,"_blank");
	}
	
	</script>
