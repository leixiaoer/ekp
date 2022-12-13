<%@ page language="java" pageEncoding="UTF-8"%>

    <script type="text/javascript">
		$(document).ready(function(){
			if('${fdIsAvailable}' == 'false'){
				seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/toolbar'], function($, strutil, dialog , topic,toolbar) {
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
					 	        	window.opener=null;
						    		window.open('','_self');
						    		window.close();
					 	        }
					 	   });
				    	}else{
				    		window.opener=null;
				    		window.open('','_self');
				    		window.close();
					    }
				    },"warn");
				});
			}
	});
	//校验资产领用状态
	function _checkCardIsLocked(){
		var deferred = $.Deferred();
		var values = [];
		$("[name$='.fdAssetCardId']").each(function(){
			values.push($(this).val());
		});
		if(values.length > 0){
			$.ajax({
				url : "${LUI_ContextPath}/km/asset/km_asset_card/kmAssetCard.do?method=checkIsLocked",
				type : "POST",
				dataType : "json",
				data : $.param({"List_Selected":values},true),
				success: function(data, textStatus, xhr) {//操作成功
					if(data.array.length == 0){
						deferred.resolve();
					}else{
						var arr = data.array;
						var msg = "";
						for(var i = 0;i < arr.length;i++){
							msg += "<br>"+(i+1)+"、"+arr[i].fdCode+":"+arr[i].fdName;
						}
						dialog.alert("<bean:message bundle='km-asset' key='kmAssetCard.fdLock.message' arg0='" + msg + "' />");
						deferred.reject();
					}
				}
			});
		}else{
			setTimeout(function(){
				deferred.resolve();
			},1);
		}
		return deferred.promise();
	}	
</script>