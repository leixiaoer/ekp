<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="mdeia_${JsParam.modelId}"></div>
<script>
		seajs.use(["lui/jquery", "sys/attachment/player/mediaPlayer"], function($, player) {
			$(function() {
				if(typeof(attachmentObject_${JsParam.fdKey}) !== "undefined") {
					var m = new player({
						element : "#mdeia_${JsParam.modelId}",
						modelId : "${JsParam.modelId}",
						modelName : "${JsParam.modelName}",
						attObj : attachmentObject_${JsParam.fdKey},
						isSupportDirect : "${JsParam.isSupportDirect}"
					});
					m.startup();
				}
			});
		});
</script>