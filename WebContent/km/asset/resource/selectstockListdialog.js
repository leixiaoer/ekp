Com_RegisterFile("selectstockListdialog.js");
function showStockList()
{	
	var path = location.href;
	path = Com_SetUrlParameter(
			Com_Parameter.ContextPath + 'resource/jsp/frame.jsp',
			'url',
			Com_Parameter.ContextPath + 'km/asset/km_asset_apply_stock_list/kmAssetApplyStockList.do?method=list&isDialog=0');
	var style = "dialogWidth:800px; dialogHeight:500px; status:0; help:0";
	return window.showModalDialog(path, "", style);

}