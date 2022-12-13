<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.view" width="98%" sidebar="no" showQrcode="false">
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${lfn:message('km-pindagate:kmPindagateMain.toolControl.analysisResponses')}-${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
	</template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="2">
			<%--调查结果导出--%>
			<ui:button text="${lfn:message('km-pindagate:kmPindagateQuestion.statistic.export')}" 
				onclick="exportResult();" order="2">
			</ui:button>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	 	<script>
	 	seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/toolbar'], function($, strutil, dialog , topic ,toolbar) {

			window.exportResult = function(){
				var url = Com_SetUrlParameter(window.location.href,"method","exportResultExcel");
				window.location.href = url;
			};
			
	 	});
		</script>
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
		<style>
			.tb_normal td{
				padding: 8px;
				border: 1px #d2d2d2 solid;
				word-break: break-all;
			}
			.lui_form_content{
				    overflow: auto;
			}
			/* .tb_normal{
				width:150%;
			} */
		</style>
		<%-- 标题--%>
		<p class="txttitle">
			<bean:message key="kmPindagateMain.toolControl.analysisResponses" bundle="km-pindagate"/>
		</p>
		<table class="tb_normal" width="100%" id="mainTable" >
			<c:out value="${titleHtml}" escapeXml="false"></c:out>
			<c:forEach items="${queryPage.list}" var="detail" varStatus="vstatus">
				<c:if test="${'true' == param.dev}">
				<%-- 该页面样子经常出现问题，增加一个调试信息，方便定位问题 --%>
				<c:set var="dev_count" value="0"/>
				<c:forEach items="${detail.items}" var="item" varStatus="vstatus">
					<c:set var="dev_count" value="${dev_count + fn:length(item.answers)}"/>
				</c:forEach>
				<tr>
					<td>
						<div ><c:out value="${detail.name}"></c:out></div>
					</td>
					<td colspan="${dev_count + 3}">
						${detail}
					</td>
				</tr>
				</c:if>
				
				<c:set var="rowspan" value=""/>
				<c:if test="${detail.hasReason}">
				<c:set var="rowspan" value="rowspan='2'"/>
				</c:if>
				<tr height="30">
					<!-- 姓名 -->
					<td style="width: 100px;min-width:50px;" ${rowspan}>
						<div ><c:out value="${detail.name}"></c:out></div>
					</td>
					<!-- 工号 -->
					<td style="width: 100px;min-width:50px;" ${rowspan}>
						<div ><c:out value="${detail.no}"></c:out></div>
					</td>
					<!-- 部门 -->
					<td style="width: 100px;min-width:50px;" ${rowspan}>
						<div ><c:out value="${detail.dept}"></c:out></div>
					</td>
					<!-- 提交时间 -->
					<td ${rowspan}>
						<div style="word-wrap: break-word;word-break: break-all;">${detail.time}</div>
					</td>
					<c:forEach items="${detail.items}" var="item" varStatus="vstatus">
						<!-- 整行有原因，但本题没有原因，需要合并行 -->
						<c:set var="rowspan" value=""/>
						<c:if test="${detail.hasReason && empty item.reason}">
						<c:set var="rowspan" value="rowspan='2'"/>
						</c:if>
						<c:forEach items="${item.answers}" var="answer" varStatus="vstatus">
							<td ${rowspan}>
								<div style="word-wrap: break-word;word-break: break-all;">${answer}</div>
							</td>
						</c:forEach>
					</c:forEach>
				</tr>
				<!-- 有原因，需要增加行 -->
				<c:if test="${detail.hasReason}">
					<tr>
						<c:forEach items="${detail.items}" var="item" varStatus="vstatus">
							<!-- 本题有多列答案，需要合并列 -->
							<c:set var="colspan" value=""/>
							<c:if test="${fn:length(item.answers) > 1}">
							<c:set var="colspan" value="colspan='${fn:length(item.answers)}'"/>
							</c:if>
							<c:if test="${not empty item.reason}">
								<td ${colspan}>
									<c:out value="${item.reason}"/>
								</td>
							</c:if>
						</c:forEach>
					</tr>
				</c:if>
			</c:forEach>
			<c:if test="${not empty averageList}">
			<tr height="30" bgcolor="#E0F3FE">
				<c:forEach items="${averageList}" var="average" varStatus="vstatus">
				     <td style="max-width: 100px;min-width:50px;">
						<div ><c:out value="${average}"></c:out></div>
					</td>
				</c:forEach>
			</tr>
			</c:if>
		</table>
		<list:paging></list:paging>	 
	</template:replace>

</template:include>