<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
		<style>
		.pindagateQrCode {
			position: fixed;
			background-color: #fff;
			border-radius: 10px;
		}
		.qrcode_body {
			padding: 50px;
			position: relative;
		}
		.close_button {
			position: absolute;
			top: -10px;
			right: -10px;
			width: 26px;
			height: 26px;
			border-radius: 50%;
			cursor: pointer;
			background-image: url(./images/close.png);
			background-repeat: no-repeat;
		}
		.qrcode_canvas {
			display: inline-block;
			padding-bottom: 20px;
		}
		.qrcode_text {
			display: block;
			text-align: center;
			color: #999;
		}
		</style>
		<div class="pindagateQrCode">
			<div class="qrcode_body">
				<div class="qrcode_canvas"></div>
				<span class="qrcode_text">${lfn:message("km-pindagate:kmPindagate.phone.answer")}</span>
			</div>
		</div>
		<script type="text/javascript">
			seajs.use([ 'lui/jquery', 'lui/qrcode' ], function($, qrcode) {
				window.qrcodeShow = function(Id) {
					var url = Com_GetCurDnsHost()
							+ "${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=add&pindageteId="
							+ Id + "&addFrom=code";
					qrcode.Qrcode({
						text : url,
						element : $(".qrcode_canvas")[0],
						render : 'canvas',
						width : 150,
						height : 150
					});
				};

				$(function() {
					qrcodeShow("${JsParam.Id}");
				});
			});
		</script>
	</template:replace>
</template:include>