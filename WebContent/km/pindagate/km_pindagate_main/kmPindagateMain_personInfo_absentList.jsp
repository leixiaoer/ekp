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
						parent.document.getElementById("notInvolvedImg").style.display ="";
		         	});
				});
			});
		</script>
		<input type="hidden" name="fdMainId" value="${fdMainId}">
		<div style="height: 100px;margin-top: 0px;">
			${absentMap['personInfo']}
		</div>
		<div style="float: left;">
			<list:paging></list:paging>	 
		</div>
	</template:replace>
</template:include>