<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body" >
		<script>
			LUI.ready(function(){
				//翻页
				seajs.use('lui/topic',function(topic){
					var evt = {page: {currentPage:"${doneMap['currentPage']}", pageSize:"${doneMap['rowPerPage']}", totalSize:"${doneMap['total']}"}};
				    topic.publish('list.changed',evt);
			        topic.subscribe('paging.changed',function(evt){
					    var  arr = evt.page;
					    var pageno=arr[0].value;
					    var rowsize=arr[1].value;
					    var url = 'kmPindagateMain.do?method=viewIndagatePersonInfo&fdId=${JsParam.fdId}&flag=already&alreadyRowPerPage='+rowsize+'&alreadyGoto='+pageno;
						Com_OpenWindow(url,'_self');
						parent.document.getElementById("participateImg").style.display ="";
		         	});
				});
			});
		</script>
		<input type="hidden" name="fdMainId" value="${fdMainId}">
		<div style="height: 100px;margin-top: 0px;">
			${doneMap['personInfo']}
		</div>
		<div style="float: left;">
			<list:paging></list:paging>	 
		</div>
	</template:replace>
</template:include>