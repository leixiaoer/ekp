<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.util.ResourceUtil" %>
<%
pageContext.setAttribute("currDnsHost", ResourceUtil.getKmssConfigString("kmss.urlPrefix")) ;
%>
<center>
<div>
	<div class="detailQrCode">

	</div>
</div>
</center>
<script type="text/javascript">
$(document).ready(function(){
	seajs.use(['lui/qrcode'], function(qrcode) {
		var ele = $(".detailQrCode")[${param.index}];
		var url = '${currDnsHost}/km/asset/km_asset_card/kmAssetCard.do?method=view&fdId=${param.fdId}'
		qrcode.Qrcode({
			text :url,
			element : ele,
			render :  'canvas',
			width:120,
			height:120
		});
	});
});
</script>

