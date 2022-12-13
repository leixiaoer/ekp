Com_RegisterFile("assetcommon.js");

/******************************************************
 * 申请单新建按钮事件，根据选择的
 * 模板进入打开相应的申请单edit
 * 页面适用于资产管理所有的申请单
 * @return
 ***************/
function addByApplyTemplate(){
	var url = Dialog_Template('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','createUrl?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}',false,true);
    var tempId = Com_GetUrlParameter(url,"fdTemplateId");
    if(tempId!=null&&tempId!=''){
        	var data = new KMSSData();
    		var url = Com_Parameter.ContextPath+"km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="+tempId;
    		data.SendToUrl(url,function(data) {
        		var results=data.responseText;
        		Com_OpenWindow(Com_Parameter.ContextPath+results);			
    		});   
      }
	}

