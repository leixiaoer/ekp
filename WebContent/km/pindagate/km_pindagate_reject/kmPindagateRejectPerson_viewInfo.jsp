<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit"  sidebar="auto">
	<template:replace name="head"> 
		<style>
			.reasonContent{
				color:#4285f4;
			}
			.info-list{
				border-bottom:1px solid #eee;
			}
			.info-list li{
				list-style:none;
				border-top:1px solid #eee;
				min-height:100px;
			}
			.reason{
				color:#4285f4;
				margin:10px 0;
			}
			.person-info{
				margin-top:10px;
			}
			.person-info span{
				padding-right:10px;
			}
		</style>
	</template:replace>
	<template:replace name="content"> 
		<div id="content">
			<h3 style="margin:10px auto;text-align:center;"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.reasons"/></h3>
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
							    var url = 'kmPindagateRejectPerson.do?method=viewRejectInfo&kmPindagateId=${JsParam.kmPindagateId}&rejectRowPerPage='+rowsize+'&rejectGoto='+pageno;
								Com_OpenWindow(url,'_self');
								parent.document.getElementById("participateImg").style.display ="";
				         	});
					        
					        /* function resizeIframe(){
					        	var height = $('#personInfo').height() > 100 ? $('#personInfo').height():100;
					        	$('#personInfo').height(height);
					        	if(parent.document.all("participateIframe")){
					        		parent.document.all("participateIframe").style.height=(height+60)+'px';
					        	}
					        }
					        resizeIframe(); */
					        
						});
					});
				</script>
				<input type="hidden" name="fdMainId" value="${fdMainId}">
				<div id="personInfo" style="margin-top: 0px;word-break: break-all;">
					<ul class="info-list">
						<c:forEach items="${rejectMap['personInfo']}" var="item">
							<li>
								<div class="reason">原因:</div>
								<p class="reasonContent">
									${item.rejectReason}
								</p>
								<p class="person-info"><span>${item.fdName}</span> <span>${item.rejectTime }</span><span>${item.dept}</span></p>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div style="float: left;">
					<list:paging></list:paging>	 
				</div>
		</div>
	</template:replace>
</template:include>