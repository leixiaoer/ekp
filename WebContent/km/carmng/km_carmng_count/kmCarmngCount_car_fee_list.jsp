<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use([ 'theme!form' ]);
		</script>
		<script type="text/javascript" src="../js/tableSort.js"></script>

		<center>
			<html:form action="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do">
				<ui:tabpanel id="kmCarmngUserFeeInfoCountPanel" layout="sys.ui.tabpanel.list">
					<ui:content id="kmCarmngUserFeeInfoCountContent" title="${ lfn:message('km-carmng:kmCarmng.excel.exportQueryCarFeeExcel') }">
						<div style="padding-top: 20px">
							<c:import
								url="/km/carmng/km_carmng_count/kmCarmngCount_common_query.jsp"
								charEncoding="UTF-8">
								<c:param name="type" value="${param.type }" />
							</c:import>
						</div>
						<div style="text-align: center; margin-top: 10px; margin-bottom: 10px">
							<ui:button text="${lfn:message('km-carmng:kmCarmng.button4') }"
								order="1" onclick="loadList();">
							</ui:button>
							&nbsp;&nbsp;
							<ui:button text="${lfn:message('km-carmng:kmCarmng.button3') }"
								order="2" onclick="clear_data();">
							</ui:button>
							&nbsp;&nbsp;
							<ui:button text="${lfn:message('km-carmng:kmCarmng.button1') }"
								order="3" onclick="exportExcel();">
							</ui:button>
						</div>
					</ui:content>
				</ui:tabpanel>
			</html:form>
			<div style="height: 800px;">
				<!-- 列表 -->
				<list:listview id="listview">
					<ui:source type="AjaxJson">
		            {url:''}
		        </ui:source>
					<!-- 列表视图 -->
					<list:colTable isDefault="true" layout="sys.ui.listview.listtable" name="columntable">
						<list:col-serial />
						<list:col-auto />
					</list:colTable>
					<ui:event topic="list.loaded">  
					   seajs.use(['lui/jquery'], function($) {
							if(window.frameElement != null && window.frameElement.tagName=="IFRAME") {
								window.frameElement.style.height = ($(document.body).height() + 10) + "px";
							}
						});
					</ui:event>
				</list:listview>
				<!-- 翻页 -->
				<list:paging />
			</div>
		</center>
		
		<script type="text/javascript">
			Com_IncludeFile("dialog.js|calendar.js", null, "js");
			seajs.use([ 'lui/jquery', 'lui/dialog', 'lui/topic' ], function($, dialog, topic) {
				//设置初始化时间区间显示并显示当前时间区间
				Com_AddEventListener(window, 'load', function() {
					window.chgTimeSelect();
				});
				window.loadList = function() {
					window.chgTimeSelect();
					var fdCarInfoId = $("input[name='fdCarInfoId']").val();
					var timeType = $("input[name='fdTimeType']:checked").val();
					var fdStartDate = $("*[name='fdStartDate_" + timeType + "']").val();
					var fdEndDate = $("*[name='fdEndDate_" + timeType + "']").val();
					if (null == fdCarInfoId || fdCarInfoId == '') {
						dialog.alert("请选择车辆！");
						return;
					}
					// 动态传参调用统计（并使用POST传参请求）
					var url = '/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=queryCarFeeCount';
					var source = LUI("listview").source;
					source.params = {
							'fdCarInfoId': fdCarInfoId,
							'timeType': timeType,
							'fdStartDate': fdStartDate,
							'fdEndDate': fdEndDate
					};
					source.url = url;
					source.ajaxConfig.url = url;
					source._url = url;
					source.get();
				}
				window.exportExcel = function() {
					var fdCarInfoId = $("input[name='fdCarInfoId']").val();
					var timeType = $("input[name='fdTimeType']:checked").val();
					var fdStartDate = $("*[name='fdStartDate_" + timeType + "']").val();
					var fdEndDate = $("*[name='fdEndDate_" + timeType + "']").val();
					if (null == fdCarInfoId || fdCarInfoId == '') {
						dialog.alert("请选择车辆！");
						return;
					}
					if (fdStartDate && fdEndDate) {
						// 创建下载表单
						var exportForm = $('<form action="${KMSS_Parameter_ContextPath}km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=exportQueryCarFeeExcel" method="post"/>');
						exportForm.appendTo("body");
						exportForm.append($("<input type='hidden' name='fdCarInfoId' />").val(fdCarInfoId));
						exportForm.append($("<input type='hidden' name='timeType' />").val(timeType));
						exportForm.append($("<input type='hidden' name='fdStartDate' />").val(fdStartDate));
						exportForm.append($("<input type='hidden' name='fdEndDate' />").val(fdEndDate));
						// 执行下载
						exportForm.submit();
						// 移除表单
						exportForm.remove();
					}
				}
			});
		</script>
	</template:replace>
</template:include>
