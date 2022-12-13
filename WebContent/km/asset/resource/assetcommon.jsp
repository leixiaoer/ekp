<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("dialog.js|xform.js|doclist.js|jquery.js");
</script>
 <script>
function addByApplyTemplate(){
	var tempId = "";
	if("${JsParam.categoryId}" !=""&&"${JsParam.nodeType}"=='TEMPLATE'){
		  tempId = "${JsParam.categoryId}";
		  addTemplate(tempId);
	}else{
	  var url = Dialog_Template('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','',false,true,'02',function(rtn){
		  if(rtn[0].id!=null&&rtn[0].id!=''){
			  addTemplate(rtn[0].id);
	     }
	 });
  }
}
function addTemplate(id){
	 var data = new KMSSData();
		var CreatUrl = Com_Parameter.ContextPath+"km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="+id;
		data.SendToUrl(CreatUrl,function(data) {
		var results=data.responseText;
		window.setTimeout(function(){
			window.open(Com_Parameter.ContextPath+results);	
    }, 100);
 });
}
</script>

