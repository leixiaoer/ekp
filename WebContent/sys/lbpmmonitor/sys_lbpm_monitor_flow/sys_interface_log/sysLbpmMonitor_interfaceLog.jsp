<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%@ page import="com.landray.kmss.sys.config.design.SysConfigs,com.landray.kmss.sys.simplecategory.model.ISysSimpleCategoryModel"%>
<%@ page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>

<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="head">
		<link type="text/css" rel="stylesheet" href="<c:url value="/sys/lbpmmonitor/sys_lbpm_monitor_flow/css/common.css"/>"/>
	</template:replace>
	<template:replace name="title"></template:replace>
	<template:replace name="content">
		<div id="tbody-view" style="padding: 10px">
			
			<table style="width: 100%">
				<tr>
					<td valign="top">
								<list:criteria channel="channel_interfaceLog" expand="false" multi="false" >
											
										<list:cri-ref key="docSubject" ref="criterion.sys.docSubject"/>
										
										<%--创建时间--%>
										<list:cri-ref ref="criterion.sys.calendar" key="fdCreateTime"
											title="${lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interface.transferInterfaceTime') }" />
									<%--分类导航--%>
									<c:if test="${not empty param.modelName }">
										<%
											String modelName = request.getParameter("modelName");
											String templateModelName = SysConfigs.getInstance().getFlowDefByMain(modelName).getTemplateModelName();
											Class clazz = Class.forName(templateModelName);
											boolean isSimpleCategory = ISysSimpleCategoryModel.class.isAssignableFrom(clazz);
											pageContext.setAttribute("templateModelName", templateModelName);
											pageContext.setAttribute("isSimpleCategory", isSimpleCategory);
										%>
										<c:if test="${isSimpleCategory}">
											<list:cri-ref ref="criterion.sys.simpleCategory"
												key="simpleCategory" multi="false"
												title="${lfn:message('sys-lbpmmonitor:sysLbpmMonitor.flow.categoryNav') }"
												expand="true"
												channel="channel_interfaceLog">
												<list:varParams modelName="${templateModelName}" />
											</list:cri-ref>
										</c:if>
										<c:if test="${!isSimpleCategory}">
											<list:cri-ref ref="criterion.sys.category" key="docCategory"
												multi="false"
												title="${lfn:message('sys-lbpmmonitor:sysLbpmMonitor.flow.categoryNav') }"
												expand="true"
												channel="channel_interfaceLog">
												<list:varParams modelName="${templateModelName}" />
											</list:cri-ref>
										</c:if>
									</c:if>
									<c:if test="${empty param.modelName}">
									<%--模块--%>
									<list:cri-criterion title="${lfn:message('sys-lbpmmonitor:sysLbpmMonitor.flow.order.module')}" key="fdModelName" multi="false"> 
										<list:box-select>
											<list:item-select>
												<ui:source type="AjaxJson">
													{url:'/sys/lbpmmonitor/sys_lbpmmonitor_flow/SysLbpmMonitorFlow.do?method=getModule'}
												</ui:source>
											</list:item-select>
										</list:box-select>
									</list:cri-criterion>
									</c:if>
									<%--对接系统--%>
										<list:cri-criterion
										        title="${lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interfacelog.transferSystem') }"
										        key="transferSystem" expand="true" multi="false" >
										        <list:box-select>
										          <list:item-select cfg-required="false" cfg-defaultValue ="">
										            <ui:source type="Static" >
										              [
										                {text:'SAP',value:'1'},
										                {text:'K3',value:'2'},
										                {text:'EAS',value:'3'},
										                {text:'U8',value:'4'},
										                {text:'${ lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interfacelog.businessIntegration') }',value:'5'},
										                {text:'${ lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interfacelog.otherSystem') }',value:'6'}
										              ]
										            </ui:source>
										          </list:item-select>
										        </list:box-select>
										      </list:cri-criterion>
										      
									<%--执行情况--%>
										<list:cri-criterion
										        title="${lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interfacelog.transferResult') }"
										        key="transferResult" expand="true" multi="false" >
										        <list:box-select>
										          <list:item-select cfg-required="false" cfg-defaultValue ="1">
										            <ui:source type="Static" >
										              [
										                {text:'${lfn:message("sys-lbpmmonitor:sysLbpmMonitor.interface.sucess")}',value:'0'},
										                {text:'${lfn:message("sys-lbpmmonitor:sysLbpmMonitor.interface.error")}',value:'1'},
										                {text:'${lfn:message("sys-lbpmmonitor:sysLbpmMonitor.interface.busError")}',value:'2'}
										              ]
										            </ui:source>
										          </list:item-select>
										        </list:box-select>
										      </list:cri-criterion>
										      
										<%--流程状态--%>
										<list:cri-criterion title="${lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interface.flowStatus') }" key="lbpmStatus" expand="true" multi="false" >
								        <list:box-select>
								          <list:item-select cfg-required="false" cfg-defaultValue ="">
								            <ui:source type="Static" >
								              [
								                {text:'${lfn:message("sys-lbpmmonitor:sysLbpmMonitor.interface.sucess")}',value:'0'},
								                {text:'${lfn:message("sys-lbpmmonitor:sysLbpmMonitor.interface.error")}',value:'21'}
								              ]
								            </ui:source>
								          </list:item-select>
								        </list:box-select>
								      </list:cri-criterion>	      
										           
								</list:criteria>
								<!-- 排序 -->
								<div class="lui_list_operation">
								
								
										<!-- 全选-->
										<div class="lui_list_operation_order_btn">
											<list:selectall channel="channel_interfaceLog"></list:selectall>
										</div> 
										
										<!-- 分割线 -->
										<div class="lui_list_operation_line"></div>

									
									
									<!-- 排序 -->
									<div class="lui_list_operation_sort_btn">
										<div class="lui_list_operation_order_text">
											${ lfn:message('list.orderType') }:
										</div>
										<div class="lui_list_operation_sort_toolbar">
											<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
												<list:sortgroup >
														<list:sort channel="channel_interfaceLog" property="fdCreateTime"
															text="${lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interface.transferInterfaceTime')}" group="sort.list" value="down"></list:sort>
												</list:sortgroup>
											</ui:toolbar>
										</div>
									</div>
									
									
									<!-- 分页 -->
									<div class="lui_list_operation_page_top">	
										<list:paging layout="sys.ui.paging.top" > 		
										</list:paging>
									</div>
									
									<!-- 操作按钮 -->
									<div style="float:right">
											<ui:button id="privilBtn" text="${lfn:message('sys-lbpmmonitor:button.batchPrivi.short')}" onclick="batchPrivil()" order="2"></ui:button>
									</div>
									
								</div>
								<c:if test="${not empty param.modelName}">
									<c:set var="paramModelName" value="&q.fdModelName=${param.modelName}" ></c:set>
								</c:if>
								<ui:fixed elem=".lui_list_operation" id="hack_fix"></ui:fixed>
								
								<list:listview channel="channel_interfaceLog">
									<ui:source type="AjaxJson">
										{url:'/sys/lbpmmonitor/sys_lbpmmonitor_flow/interfacelogAction.do?method=queryInterfaceLogInfo${not empty paramModelName ? paramModelName : ""}'}
									</ui:source>
									<list:colTable isDefault="true"
										layout="sys.ui.listview.columntable"
										rowHref="/sys/lbpmmonitor/sys_lbpmmonitor_flow/interfacelogAction.do?method=view&fdId=!{fdId}">
									
											
											<list:col-checkbox></list:col-checkbox>
										
										
										<list:col-serial></list:col-serial>
										<list:col-auto props=""></list:col-auto>
									</list:colTable>
									<ui:event topic="list.loaded"></ui:event>
								</list:listview>
								<list:paging channel="channel_interfaceLog"></list:paging>
								<script>
								
								//解决多子系统页面显示不全问题
								domain.autoResize();
								
									seajs
											.use(
													[ 'lui/topic' ],
													function(topic) {
														//筛选器变化	
														topic
																.channel("channel_interfaceLog")
																.subscribe(
																		"criteria.spa.changed",
																		function(evt) {
																			if (evt.criterions) {
																				var keyArray = new Array();
																				for (var i = 0; i < evt.criterions.length; i++) {
																					keyArray[i] = evt.criterions[i].key;
																				}
																				var flag = '${empty param.modelName }';
																				/* if (keyArray
																						.contains("docSubject")) {
																					if (!keyArray.contains("fdModelName")&& flag==="true") {
																						alert('<bean:message bundle="sys-lbpmmonitor" key="sysLbpmMonitor.flow.selectModuleFirst"/>');
																						return;
																					}
																				} */
																				
																			}
																		});
														
														topic
														.channel("channel_interfaceLog")
														.subscribe(
																"list.loaded",
																function(evt) {
																	$("input[name='List_Selected']").each( function(index) {
																		
																		if(evt.table.kvData&&evt.table.kvData[index]){
																			//接口日志状态为正常，不能执行批量特权
																			if(evt.table.kvData[index].interfacelogStatus=="0"){
																				$(this).remove();
																			}
																			
																			//流程状态为成功，也不需要批量特权操作
																			if(evt.table.kvData[index].processStatus!="21"){
																				$(this).remove();
																			}
																			
																			//接口日志状态为异常或者业务异常，流程状态不为异常，也不能批量特权
																			if((evt.table.kvData[index].interfacelogStatus=="1"||evt.table.kvData[index].interfacelogStatus=="2")&&evt.table.kvData[index].processStatus!="21"){
																				$(this).remove();
																			}
																			
																			
																		}
													                });
																});
													});
									Array.prototype.contains = function(arr) {
										for (var i = 0; i < this.length; i++) {
											if (this[i] == arr) {
												return true;
											}
										}
										return false;
									};
						
									function getProcessId(processIdTemp){
										var urlGetProcessId="<c:url value="/sys/lbpmmonitor/sys_lbpmmonitor_flow/interfacelogAction.do" />";
										var param = {
										 		method : "queryProcessIds",
										 		processId:processIdTemp
										};
										var processIdTemps=[];
										
										$.ajax({ 
											url: urlGetProcessId,
											cache: false,
											async: false,
											type: "POST",
											data: param,
											dataType:'json',
											success: function (data) {
												if(data.data){
													var datamap = data.data.split(";");
												 	for(var i=0;i<datamap.length;i++){
												 		processIdTemps.push(datamap[i]);
												 	}
												}
											}
										});
										return processIdTemps;
									}
									
									//批量特权操作
									function batchPrivil() {
										var selected;
										var docIds = [];
										var select = document.getElementsByName("List_Selected");
										for ( var i = 0; i < select.length; i++) {
											if (select[i].checked) {
												docIds.push(select[i].value);
												selected = true;
											}
										}
										
										var processIdTemp="";
										for ( var j = 0; j < docIds.length; j++) {
											if (j==0) {
												processIdTemp+=docIds[j];
											}else{
												processIdTemp+=";"+docIds[j];
											}
										}
									
										
										if (selected) {
											var processIdTemps=getProcessId(processIdTemp);
													
											if(processIdTemps.length>0){
												var url = '/sys/lbpmmonitor/sys_lbpm_monitor_flow/batchPirvil_flow.jsp?method=queryInterfaceLogInfo&fdType=error&fdInterface=yes';
												seajs.use([ 'lui/dialog', 'lui/topic' ], function(dialog, topic) {
													//弹窗遮罩全覆盖后为了兼容原有的获取值的模式
													top.selectDocIds = processIdTemps;
													
													dialog.iframe(url,
															"${lfn:message('sys-lbpmmonitor:button.batchPrivi')}",
															function(value) {
																topic.publish('list.refresh');
															}, {
																"width" : 600,
																"height" : 400,
															});
												});
											}
											
											return;
										} else {
											seajs.use([ 'lui/dialog' ], function(dialog) {
												dialog.alert("${lfn:message('page.noSelect')}");
											});
										}
									}
									
									
								
								</script>
					</td>
				</tr>
			</table>
		</div>
		
	</template:replace>
</template:include>