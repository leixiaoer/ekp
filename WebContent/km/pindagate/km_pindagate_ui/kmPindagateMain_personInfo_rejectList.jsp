<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body" >
		<script>
			LUI.ready(function(){
				//翻页
				seajs.use(['lui/topic','lui/jquery'],function(topic,$){
					var evt = {page: {currentPage:"${rejectMap['currentPage']}", pageSize:"${rejectMap['rowPerPage']}", totalSize:"${rejectMap['total']}"}};
				    topic.publish('list.changed',evt);
			        topic.subscribe('paging.changed',function(evt){
					    var  arr = evt.page;
					    var pageno=arr[0].value;
					    var rowsize=arr[1].value;
					    var url = 'kmPindagateMain.do?method=viewIndagatePersonInfo&fdId=${JsParam.fdId}&flag=reject&rejectRowPerPage='+rowsize+'&rejectGoto='+pageno;
						Com_OpenWindow(url,'_self');
						parent.document.getElementById("participateImg").style.display ="";
		         	});
			        
			        function resizeIframe(){
			        	var height = $('#personInfo').height() > 100 ? $('#personInfo').height():100;
			        	$('#personInfo').height(height);
			        	if(parent.document.all("participateIframe")){
			        		parent.document.all("participateIframe").style.height=(height+60)+'px';
			        	}
			        }
			        resizeIframe();
			        
				});
			});
		</script>
		<input type="hidden" name="fdMainId" value="${fdMainId}">
		<div id="personInfo" style="margin-top: 0px;word-break: break-all;">
			${rejectMap['personInfo']}
		</div>
		<c:if test="${rejectMap['personInfo'].length()>0}">
			<a target="_blank" href="${LUI_ContextPath}/km/pindagate/km_pindagate_reject/kmPindagateRejectPerson.do?method=viewRejectInfo&kmPindagateId=${kmPindagateMainForm.fdId}" style="color:#4285f4;position:relative;top:20px;left:20px;"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.viewReasons"/></a>
		</c:if>
		<div style="float: left;">
			<list:paging></list:paging>	 
		</div>
	</template:replace>
</template:include>