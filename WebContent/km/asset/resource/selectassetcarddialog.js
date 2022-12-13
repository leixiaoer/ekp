Com_RegisterFile("selectassetcarddialog.js");
function showAssetCardList(value)
{
	if(value=== undefined )
	{
		value='';
	}
	var url=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/asset/km_asset_card/kmAssetCard_dialog.jsp?status='+value;
	alert(url);
	return dialog.iframe(url,"${lfn:message('km-oitems:kmOitemsBudgerApplication.add') }",function(rtnData){
		alert(rtnData);
	},{width:900,height:550});
}