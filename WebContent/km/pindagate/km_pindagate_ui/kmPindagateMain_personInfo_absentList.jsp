<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body" >
		<script>
			LUI.ready(function(){
				//翻页
				seajs.use('lui/topic',function(topic){
					var evt = {page: {currentPage:"${absentMap['currentPage']}", pageSize:"${absentMap['rowPerPage']}", totalSize:"${absentMap['total']}"}};
				    topic.publish('list.changed',evt);
			        topic.subscribe('paging.changed',function(evt){
					    var  arr = evt.page;
					    var pageno=arr[0].value;
					    var rowsize=arr[1].value;
					    var url = 'kmPindagateMain.do?method=viewIndagatePersonInfo&fdId=${JsParam.fdId}&flag=absent&absentRowPerPage='+rowsize+'&absentGoto='+pageno;
						Com_OpenWindow(url,'_self');
						if (parent.document.getElementById("notInvolvedImg")) {
							parent.document.getElementById("notInvolvedImg").style.display ="";
						}
		         	});
			        
			        function resizeIframe(){
			        	var height = $('#personInfo').height() > 100 ? $('#personInfo').height():100;
			        	$('#personInfo').height(height);
			        	if(parent.document.all("notInvolvedIframe")){
			        		parent.document.all("notInvolvedIframe").style.height=(height+60)+'px';
			        	}
			        }
			        resizeIframe();
			        
				});
			});
		</script>
		<input type="hidden" name="fdMainId" value="${fdMainId}">
		<div id="personInfo" style="margin-top: 0px;word-break: break-all;">
			${absentMap['personInfo']}
		</div>
		<div style="float: left;">
			<list:paging></list:paging>	 
		</div>
	</template:replace>
</template:include>