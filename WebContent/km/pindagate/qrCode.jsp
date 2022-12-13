<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/km/pindagate/qrCode.css">
<div class="pindagateQrCode" style="display: none">
	<div class="qrcode_body">
		<span class="close_button" onClick="qrcode_close();"><img
			src='${KMSS_Parameter_ContextPath}km/pindagate/images/close.png'></span>
		<div class="qrcode_canvas"></div>
		<span class="qrcode_text">${lfn:message("km-pindagate:kmPindagate.phone.answer")}</span>
	</div>
</div>
<div class="pindagateQrCode_mask" style="display: none"></div>
<script type="text/javascript">	
			seajs.use(
					[ 'lui/jquery', 'lui/qrcode'],
					function($,  qrcode) {
      		window.qrcodeShow = function(Id) {
				var url = Com_GetCurDnsHost()
						+ "${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=add&pindageteId="
						+ Id + "&addFrom=code";
				$(".pindagateQrCode")[0].style.display = "block";
				$(".pindagateQrCode_mask")[0].style.display = "block";
				qrcode.Qrcode({
					text : url,
					element : $(".qrcode_canvas")[0],
					render : 'canvas',
					width : 150,
					height : 150
				});
			};

			window.qrcode_close = function() {
				$(".pindagateQrCode")[0].style.display = "none";
				$(".pindagateQrCode_mask")[0].style.display = "none";
				$(".qrcode_canvas canvas").remove();
			};
		});	
      	</script>