<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" width="90%" sidebar="no">
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${param.docSubject}-${lfn:message('km-pindagate:kmPindagateMain.toolControl.analysisResponses')}-${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
	</template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="2">
			<%--调查结果导出--%>
			<ui:button text="${lfn:message('km-pindagate:kmPindagateQuestion.statistic.export')}" 
				onclick="Com_OpenWindow('kmPindagateResponse.do?method=exportResultExcel&fdMainId=${fdm}','_self');" order="2">
			</ui:button>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	<%--主文档--%>
	<template:replace name="content"> 
		<script>
		  LUI.ready(function(){
				seajs.use('lui/topic',function(topic){
					var evt = {page: {currentPage:"${queryPage.pageno}", pageSize:"${queryPage.rowsize}", totalSize:"${queryPage.totalrows}"}};
				    topic.publish('list.changed',evt);
			        topic.subscribe('paging.changed',function(evt){
					    var  arr = evt.page;
					    var pageno=arr[0].value;
					    var rowsize=arr[1].value;
					    window.open('${LUI_ContextPath}/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=resultsDetail&fdMainId=${fdm}&pageno='+pageno+"&rowsize="+rowsize,"_self");
		         	});
				});
			});
		</script>
		<table class="tb_normal" width="100%" id="mainTable">
			<%-- 标题--%>
			<p class="txttitle">
				<bean:message key="kmPindagateMain.toolControl.analysisResponses" bundle="km-pindagate"/>
			</p>
			<c:out value="${titleHtml}" escapeXml="false"></c:out>
			<c:forEach items="${queryPage.list}" var="detailList" varStatus="vstatus">
				<tr height="30">
					<c:forEach items="${detailList}" var="detail" varStatus="vstatus">
						<td title="${detail}">
							<div style="width: 100px;"><c:out value="${detail }"></c:out></div>
						</td>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
		<list:paging></list:paging>	 
	</template:replace>

</template:include>