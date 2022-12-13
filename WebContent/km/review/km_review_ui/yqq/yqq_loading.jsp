<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.view">
	<template:replace name="head">
		<script type="text/javascript">
			window.onload=function(){
				seajs.use(['lui/jquery','lui/dialog','lui/dialog_common','lui/util/str'], function($, dialog, dialogCommon,strutil){
					var loading=dialog.loading();
					setTimeout(forwardUrl, 2000);
					function forwardUrl(){
						var ajaxUrl = Com_Parameter.ContextPath+"km/review/km_review_main/kmReviewOutSign.do?method=queryStatus&signId=${JsParam.signId}";
						$.ajax({
							url : ajaxUrl,
							type : 'post',
							data : {},
							dataType : 'text',
							async : true,     
							error : function(){
								dialog.alert('请求出错');
							} ,   
							success : function(data) {
								if(data != 'false'){
									window.location = data;
								}else{
									setTimeout(forwardUrl, 2000);
								}
							}
						});
					}
				});
			};
		</script>
	</template:replace>
	<template:replace name="content">
		正在向签署平台发送签署信息,请稍候...
	</template:replace>
</template:include>
