seajs.use(['lui/jquery','lui/dialog','lui/util/env','lui/topic','lang!fssc-ledger'], function($, dialog,env,topic,lang){
	//下载模板
	window.downloadTemp = function(){
		var url=env.fn.formatUrl(listOption.basePath+'?method=downloadTemp');
		window.open(url);
	}
	//导出
	window.exportMaterial = function(){
		var url=env.fn.formatUrl(listOption.basePath+'?method=exportMaterial');
		window.open(url);
	}
	//导入
	window.importMaterial = function(){
		var formName = listOption.modelName.split(".");
		formName = formName[formName.length-1];
		formName = formName.substring(0,1).toLowerCase()+formName.substring(1);
		window.dia = dialog.iframe(
			'/fssc/ledger/fssc_ledger_material/fsscLedgerMaterialImport.jsp?modelName='+listOption.modelName+"&tempate="+formName,
			lang['message.import.title'],
			function(data){
				topic.publish("list.refresh");
			},{height:600,width:800}
		);
	}
	//选择物资
	window.selectMateriak=function(){
		dialogSelect(false,'fssc_base_material_info_selectMaterial','fdMaterialId','fdMaterialName',null,{fdStatus:'1'},afterSelectMateriak);
	}
	//选择完物资信息，给其他物资相关属性赋值
	window.afterSelectMateriak=function(data,index){
		$("[name='fdIsInventory']").removeAttr("checked");
		$("[name='fdCode']").val(data[0]["fdCode"]);
		$("[name='fdTypeId']").val(data[0]["fdType.id"]);
		$("[name='fdTypeName']").val(data[0]["fdType.name"]);
		$("[name='fdStatus']").val(data[0]["fdStatus"]);
		$("[name='fdIsInventory'][value='"+data[0]["fdIsInventory"]+"']").prop("checked",true);
		$("[name='fdUnit']").val(data[0]["fdUnit"]);
	}
});
