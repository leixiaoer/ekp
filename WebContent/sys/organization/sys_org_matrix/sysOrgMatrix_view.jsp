<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.organization.transfer.SysOrgMatrixVersionChecker" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.view" sidebar="no">
	<template:replace name="title">
		<bean:message bundle="sys-organization" key="table.sysOrgMatrix"/>
	</template:replace>
	<template:replace name="head">
		<link charset="utf-8" rel="stylesheet" href="${LUI_ContextPath}/sys/organization/resource/css/matrixData.css">
		<link charset="utf-8" rel="stylesheet" href="${LUI_ContextPath}/sys/organization/resource/css/table.css">
		<script>
			function confirm_invalidated(){
				var msg = confirm("<bean:message bundle="sys-organization" key="organization.invalidated.comfirm"/>");
				return msg;
			}
		</script>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<ui:button text="${lfn:message('sys-organization:sysOrgRoleConf.simulator')}" order="1" onclick="simulator();" />
			<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=edit&fdId=${sysOrgMatrixForm.fdId}" requestMethod="GET">
			<ui:button text="${lfn:message('button.edit')}" order="2" onclick="Com_OpenWindow('sysOrgMatrix.do?method=edit&fdId=${sysOrgMatrixForm.fdId}','_self');" />
			</kmss:auth>
			<c:if test="${sysOrgMatrixForm.fdIsAvailable}">
			<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=invalidated&fdId=${sysOrgMatrixForm.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('sys-organization:organization.invalidated')}" order="3" onclick="if(!confirm_invalidated())return;Com_OpenWindow('sysOrgMatrix.do?method=invalidated&fdId=${sysOrgMatrixForm.fdId}','_self');" />
			</kmss:auth>
			</c:if>
    	 	<ui:button text="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();"/>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<div style="width: 95%; margin: 10px auto;">
		<p class="txttitle">
			<bean:message bundle="sys-organization" key="table.sysOrgMatrix"/> - <c:out value="${sysOrgMatrixForm.fdName}"/>
		</p>
		
		<ui:tabpanel id="MatrixTab">
			<ui:content title="${lfn:message('sys-organization:sysOrgMatrix.base')}">
				<table class="tb_normal" width=100%>
					<tr>
						<td width=15% class="td_normal_title">
						    <bean:message bundle="sys-organization" key="sysOrgMatrix.fdName"/>
						</td><td width=35% colspan="3">
							<bean:write name="sysOrgMatrixForm" property="fdName"/>
						</td>
					</tr>
					<tr>
						<td width=15% class="td_normal_title">
						    <bean:message bundle="sys-organization" key="sysOrgMatrix.fdCategory"/>
						</td><td width=35% colspan="3">
							<bean:write name="sysOrgMatrixForm" property="fdCategoryName"/>
						</td>
					</tr>
					<tr>
						<td width=15% class="td_normal_title">
						    <bean:message bundle="sys-organization" key="sysOrgMatrix.fdOrder"/>
						</td><td width=35% colspan="3">
							<bean:write name="sysOrgMatrixForm" property="fdOrder"/>
						</td>
					</tr>
					<tr>
						<td width=15% class="td_normal_title">
						    <bean:message bundle="sys-organization" key="sysOrgMatrix.fdDesc"/>
						</td><td width=35% colspan="3">
							<bean:write name="sysOrgMatrixForm" property="fdDesc"/>
						</td>
					</tr>
					<tr>
						<td width=15% class="td_normal_title">
						    <bean:message bundle="sys-organization" key="sysOrgMatrix.fdIsAvailable"/>
						</td><td width=35% colspan="3">
							<sunbor:enumsShow value="${sysOrgMatrixForm.fdIsAvailable}" enumsType="sys_org_available_result" />
						</td>
					</tr>
					<!-- ???????????? -->
					<tr>
						<td width=15% class="td_normal_title">
							<bean:message bundle="sys-organization" key="sysOrgMatrix.dataCate"/>
						</td><td width=85% colspan="3">
							<c:if test="${sysOrgMatrixForm.fdIsEnabledCate eq 'true'}">
								<table class="tb_normal" width=100% id="TABLE_DocList_Cates" align="center">
								<tr>
									<td align="center" class="td_normal_title" style="width:50%">
										<bean:message bundle="sys-organization" key="sysOrgMatrix.dataCate.name"/>
									</td>
									<td align="center" class="td_normal_title" style="width:50%">
										<bean:message bundle="sys-organization" key="sysOrgMatrix.dataCate.manager"/>
									</td>
								</tr>
								<c:forEach items="${sysOrgMatrixForm.fdDataCates}" var="item" varStatus="vstatus">
								<tr>
									<td align="center">
										<c:out value="${item.fdName}"/>
									</td>
									<td align="center">
										<c:out value="${item.fdElementName}"/>
									</td>
								</tr>
								</c:forEach> 
							</table>
							</c:if>
							<c:if test="${sysOrgMatrixForm.fdIsEnabledCate eq 'false'}">
								<sunbor:enumsShow value="false" enumsType="sys_org_available_result" />
							</c:if>
						</td>
					</tr>
					<!-- ???????????? -->
					<tr>
						<td class="td_normal_title" width=15%><bean:message bundle="sys-organization" key="sysOrgMatrix.authReaders"/></td>
						<td  width=85% colspan="3">
						  <kmss:showText value="${sysOrgMatrixForm.authReaderNames}"/>
					   </td>
					</tr>
					<!-- ???????????? -->
					<tr>
						<td class="td_normal_title" width=15%><bean:message bundle="sys-organization" key="sysOrgMatrix.authEditors"/></td>
						<td width=85% colspan="3">
						  <kmss:showText value="${sysOrgMatrixForm.authEditorNames}"/>
						</td>
					</tr>
					<!-- ???????????????????????????????????????????????????false???????????????????????????????????? -->
					<%
						Boolean flag = new SysOrgMatrixVersionChecker().isRuned();
						if(!flag){
					%>
					<tr id="transfer_warm">
						<td>
							<p>??????</p>
						</td>
						<td width="100%">
							<p class="txttitle" style="color: red;">??????????????????????????????????????????????????????????????????????????????????????????????????????</p>
						</td>
					</tr>
					<%	
						}
					%>
				</table>
			</ui:content>
			<ui:content title="${lfn:message('sys-organization:sysOrgMatrix.field')}">
				<div class="lui_matrix_div_wrap">
				   <!-- ???????????? - ???????????? Starts  -->
				   <div class="lui_matrix_field_tb_wrap">
				       <!-- ?????? -->
				       <div class="lui_matrix_field_tb_item lui_matrix_field_tb_item_type">
				           <table id="matrix_type_table" class="lui_matrix_tb_normal" style="width: 80px;">
				               <tr>
				                   <td class="lui_matrix_td_normal_title"><bean:message key="sys.common.viewInfo.type"/></td>
				               </tr>
				               <tr>
				                   <td class="lui_matrix_td_normal_title"><bean:message bundle="sys-organization" key="sysOrgMatrixRelation.fdFieldName"/></td>
				               </tr>
				           </table>
				       </div>
				       <!-- ???????????? -->
				       <div class="lui_matrix_field_tb_item lui_matrix_field_tb_item_condition">
				           <table id="matrix_table" class="lui_matrix_tb_normal lui_matrix_tb_view">
								<!-- ????????? -->
								<tr id="matrix_field_type" align="center">
								</tr>
								<!-- ????????? -->
				              	<tr id="matrix_field_value">
								</tr>
				           </table>
				       </div>
				   </div>
				   <kmss:auth requestURL="/sys/organization/sys_org_matrix_relation/sysOrgMatrixRelation.do?method=check&matrixId=${sysOrgMatrixForm.fdId}" requestMethod="GET">
				   <c:if test="${not empty delCountDesc}">
				   <div style="padding-top: 20px;">
				   		<span style="color: red;">
				   			<c:out value="${delCountDesc}"/>
				   			<a href="javascript:;" onclick="fieldCheck();">${lfn:message('sys-organization:sysOrgMatrix.field.check')}</a>
				   		</span>
				   </div>
				   </c:if>
				   </kmss:auth>
				</div>
			</ui:content>
			<ui:content title="${lfn:message('sys-organization:sysOrgMatrix.data')}">
				<div class="lui_matrix_div_wrap">
					<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=importData&fdId=${sysOrgMatrixForm.fdId}">
					<!-- ???????????? -->
					<div class="lui_maxtrix_toolbar">
						<div class="lui_maxtrix_toolbar_r">
							<a class="com_bgcolor_d" href="javascript:;" onclick="importData();"><bean:message key="button.import"/></a>
							<a class="com_bgcolor_d" href="javascript:;" onclick="downloadMatrixRelation();"><bean:message key="button.export"/></a>
							<a class="com_bgcolor_d" href="javascript:;" onclick="deleteMatrixRelation();"><bean:message key="button.deleteall"/></a>
						</div>
					</div>
					<script>
						window.canDel = true;
					</script>
					</kmss:auth>
					
				   <c:choose>
				   		<c:when test="${fn:length(allVersions) > 0}">
				   			<ui:tabpanel id="lui_matrix_panel" layout="sys.ui.tabpanel.sucktop" var-average='false' var-useMaxWidth='true'>
				   				<c:forEach items="${ allVersions }" var="version">
									<ui:content id="lui_matrix_panel_content_${ version.fdName }" title="${ version.fdName }">
										<!-- ????????????????????????  start-->
										<div class="lui_maxtrix_toolbar">
											<div class="lui_maxtrix_toolbar_r matrix_data_cate" style="float: left;margin-top: 10px;">
												
											</div>
										</div>
										<!-- ????????????????????????  end-->
										<div id="lui_matrix_data_tb_wrap_nodata_${ version.fdName }" class="lui_matrix_data_tb_wrap_nodata" style="display: none;">
											<bean:message bundle="sys-organization" key="sysOrgMatrix.cate.nodata"/>
										</div>
										<!-- ???????????????????????? -->
										<div id="lui_matrix_data_tb_wrap_${ version.fdName }" class="lui_matrix_data_tb_wrap" style="display: none;">
									       <!-- ?????? -->
									       <div class="lui_matrix_data_tb_item lui_matrix_data_tb_item_l">
									           <table id="matrix_seq_table_${ version.fdName }" class="lui_matrix_tb_normal">
									               <tr style="height: 40px;">
									                   <th class="lui_matrix_td_normal_title"><input id="matrix_seq_checkbox_${ version.fdName }" type="checkbox"></th>
									                   <th class="lui_matrix_td_normal_title"><bean:message key="page.serial"/></th>
									               </tr>
									           </table>
									       </div>
									       <!-- ???????????? -->
									       <div class="lui_matrix_data_tb_item lui_matrix_data_tb_item_c">
									           <table id="matrix_data_table_${ version.fdName }" class="lui_matrix_tb_normal">
									               <tr style="height: 40px;">
									               </tr>
									           </table>
									       </div>
									       <!-- ???????????? -->
									       <div class="lui_matrix_data_tb_item lui_matrix_data_tb_item_r">
									           <table id="matrix_opt_table_${ version.fdName }" class="lui_matrix_tb_normal">
									               <tr style="height: 40px;">
									                   <th><bean:message key="list.operation"/></th>
									               </tr>
									           </table>
									       </div>
									   </div>
										<list:listview id="listview_${ version.fdName }" channel="${ version.fdName }">
											<ui:source type="AjaxJson">
												{url:'/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=findMatrixPage&fdId=${sysOrgMatrixForm.fdId}&fdVersion=${version.fdName}'}
											</ui:source>
											<!-- ???????????? -->	
											<div data-lui-type="sys/organization/resource/js/matrixDataView!MatrixDataView" style="display:none;">
												<div data-lui-type="lui/listview/template!Template" style="display:none;"></div>
											</div>
										</list:listview>
										<list:paging id="matrix_data_table_${ version.fdName }_page" channel="${ version.fdName }"></list:paging>
									</ui:content>
								</c:forEach>
							</ui:tabpanel>
				   		</c:when>
				   		<c:otherwise>
				   			<div style="text-align: center;">
				   				${lfn:message('sys-organization:sysOrgMatrix.version.empty')}
				   			</div>
				   		</c:otherwise>
				   </c:choose>
				</div>
			</ui:content>
		</ui:tabpanel>
		
		<!-- ?????????????????? -->
		<form id="downloadMatrixDataForm" action="${LUI_ContextPath}/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=exportMatrixData&fdId=${sysOrgMatrixForm.fdId}" method="post"></form>
		<script language="JavaScript">
			// ????????????
			window.curVersion = undefined;
			window.fdDataCateId = undefined;
			// ????????????????????????????????????????????????????????????????????????
			window.matrixPanelArray = {};
			var con = [], res = [], fdDataCates = [], hasTitle = {}, dataType = {};
			<c:forEach items="${sysOrgMatrixForm.fdRelationConditionals}" var="conditional">
			con.push({"fdType": "${conditional.fdType}", "fdName": "<c:out value="${conditional.fdName}" escapeXml="true"/>", "fdMainDataType": "${conditional.fdMainDataType}", "fdMainDataText": "${conditional.fdMainDataText}", "fdValueCount": parseInt("${conditional.fdValueCount}")});
			</c:forEach>
			<c:forEach items="${sysOrgMatrixForm.fdRelationResults}" var="result">
			res.push({"fdType": "${result.fdType}", "fdName": "<c:out value="${result.fdName}" escapeXml="true"/>", "fdValueCount": parseInt("${result.fdValueCount}")});
			</c:forEach>
			<c:forEach items="${sysOrgMatrixForm.fdDataCates}" var="cate">
			fdDataCates.push({"fdId": "${cate.fdId}","fdName": "<c:out value="${cate.fdName}" escapeXml="true"/>"});
			</c:forEach>
			seajs.use(['lui/jquery','lui/dialog', 'lui/topic'], function($, dialog, topic) {
				// ????????????????????????????????????
				topic.subscribe('successReloadPage', function() {
					topic.channel(window.curVersion).publish("list.refresh");
				});
				
				<c:if test="${fn:length(allVersions) > 0}">
				LUI.ready(function() {
					<c:forEach items="${ allVersions }" var="version">
					window.matrixPanelArray["${version.fdName}"] = {
						"seq": "matrix_seq_table_${version.fdName} tbody",
						"data": "matrix_data_table_${version.fdName} tbody",
						"opt": "matrix_opt_table_${version.fdName} tbody",
						"checkbox": "matrix_seq_checkbox_${version.fdName}",
					}
					// ??????
					$("#matrix_seq_checkbox_${version.fdName}").click(function() {
						$("#matrix_seq_table_${version.fdName} [name=List_Selected]:checkbox").prop("checked", this.checked);
					});
					$("#matrix_seq_table_${version.fdName}").on("change", "[name=List_Selected]:checkbox", function() {
						var isAll = true;
						$("#matrix_seq_table_${version.fdName} [name=List_Selected]:checkbox").each(function(i, n) {
							if(!n.checked) {
								isAll = false;
								return false;
							}
						});
						$("#matrix_seq_checkbox_${version.fdName}").prop("checked", isAll);
					});
					topic.channel("${version.fdName}").subscribe("list.changed", showTable);
					</c:forEach>
					
					/* ?????????????????? */
					window.generateCateData = function (dataCates) {
						if(dataCates && dataCates.length > 0) {
							// ?????????????????????????????????
							_generateCateData(dataCates);
						}
					};
					
					/* ?????????????????? */
					var __to__;
					window._generateCateData = function(dataCates) {
						var panel_content = $("#lui_matrix_panel [data-lui-mark='panel.content']");
						if(panel_content.length > 0) {
							if(__to__) {
								clearTimeout(__to__);
							}
							panel_content.each(function(i, n) {
								var dataCate = $(n).find(".matrix_data_cate");
								if(dataCate.length > 0) {
									var cates = [];
									// ????????????????????????????????????????????????????????????????????????
									if(dataCates.length > 1) {
										cates.push('<a class="com_bgcolor_d" href="javascript:;" style="color: #333;" data-cateid="all" onclick="switchCateData(this, \'all\');"><bean:message bundle="sys-organization" key="sysOrgMatrix.dataCate.all"/></a>');
									}
									for(var i=0; i<dataCates.length; i++) {
										var data = dataCates[i];
										cates.push('<a class="com_bgcolor_d" href="javascript:;" style="color: #333;" data-cateid="' + data.fdId + '" onclick="switchCateData(this, \'' + data.fdId + '\');"><pre>' + data.fdName + '</pre></a>');
									}
									dataCate.html(cates.join(""));
									// ?????????????????????
									dataCate.find("a:eq(0)").click();
								}
							});
						} else {
							__to__ = setTimeout(function() {_generateCateData(dataCates);}, 100);
						}
					};
					
					/* ?????????????????? */
					window.switchCateData = function(elem, dataCateId) {
						var parent = $(elem).parent();
						// ????????????????????????????????????
						if($(elem).hasClass("lui_maxtrix_cate_item_dis")) {
							return false;
						}
						parent.find("a").each(function(i, n) {
							$(n).removeClass("lui_maxtrix_cate_item_dis");
						});
						$(elem).addClass("lui_maxtrix_cate_item_dis");
						if(dataCateId == "all") {
							dataCateId = "";
						}
						// ????????????????????????
						$.ajax({
							url : Com_Parameter.ContextPath + 'sys/organization/sys_org_matrix/sysOrgMatrix.do?method=findMatrixPage&fdId=${sysOrgMatrixForm.fdId}&fdVersion=' + window.curVersion + '&fdDataCateId=' + dataCateId,
							type: 'POST',
							dataType: 'json',
							success: function(res) {
								showTable(res);
							},
							error: function() {
								dialog.failure(Msg_Info.errors_unknown);
							}
						});
						window.fdDataCateId = dataCateId;
					}
					
					LUI("lui_matrix_panel").on("indexChanged", function(evt) {
						// ???????????????????????????
						var cur = evt.panel.contents[evt.index.after];
						var title = cur.config.title;
						if(window.curVersion == title) {
							// ?????????????????????????????????
							evt.cancel = true;
							return false;
						} else {
							window.curVersion = title;
						}
						// ??????????????????????????????
						generateCateData(fdDataCates);
					});
				});
				</c:if>
				
				// ????????????
				window.showTable = function(rtnData) {
					var panel = window.matrixPanelArray[window.curVersion];
					var seqTab = $("#" + panel.seq), dataTab = $("#" + panel.data), optTab = $("#" + panel.opt);
					// ??????????????????
					seqTab.find("tr:gt(0)").remove();
					dataTab.find("tr:gt(0)").remove();
					optTab.find("tr:gt(0)").remove();
					// ????????????
					showPage(rtnData.page.currentPage, rtnData.page.pageSize, rtnData.page.totalSize);
					// ?????????
					if(rtnData.datas.length == 0) {
						$("#lui_matrix_data_tb_wrap_" + window.curVersion).hide();
						$("#listview_" + window.curVersion).show();
						$("#lui_matrix_data_tb_wrap_nodata_" + window.curVersion).show();
						return;
					}
					// ????????????
					$("#lui_matrix_data_tb_wrap_" + window.curVersion).show();
					$("#listview_" + window.curVersion).hide();
					$("#lui_matrix_data_tb_wrap_nodata_" + window.curVersion).hide();
					// ????????????
					if(!hasTitle[window.curVersion]) {
						for(var i=0; i<rtnData.columns.length; i++) {
							var obj = rtnData.columns[i];
							var tr = dataTab.find("tr:eq(0)");
							if(obj.headerClass == "conditional") {
								dataType[obj.property] = "conditional";
								tr.append("<th class=\"lui_matrix_td_normal_title lui_maxtrix_condition_th\"><xmp>"+obj.title+"</xmp></th>");
							} else if(obj.headerClass == "result") {
								dataType[obj.property] = "result";
								tr.append("<th class=\"lui_matrix_td_normal_title lui_maxtrix_result_th\"><xmp>"+obj.title+"</xmp></th>");
							}
						}
						<c:if test="${!empty sysOrgMatrixForm.fdDataCates}">
						tr.prepend("<th style=\"width:70px;\"><bean:message bundle="sys-organization" key="sysOrgMatrix.dataCate.note"/></th>");
		               	</c:if>
						hasTitle[window.curVersion] = true;
					}
					// ????????????
					for(var i=0; i<rtnData.datas.length; i++) {
						var datas = rtnData.datas[i];
						var seqTr = [], dataTr = [], optTr = [], dataTmp = [];
						seqTr.push("<tr style=\"height: 40px;\">");
						dataTr.push("<tr style=\"height: 40px;\">");
						
						for(var j=0; j<datas.length; j++) {
							var data = datas[j];
							if(data.col == "fdId") {
								// ??????ID?????????
					            seqTr.push("<td><input type=\"checkbox\" name=\"List_Selected\" value=\"" + data.value + "\"></td>");
					            seqTr.push("<td name=\"matrix_data_seq\">" + (i + 1) + "</td>");
							} else if(data.col == 'cate') {
								cate = data.value;
								if(cate) {
									dataTr.push("<td style=\"text-align: center;\">");
									dataTr.push(cate);
									dataTr.push("</td>");
								}
							} else {
								var temp = data.value.split("|||||");
								var val = temp.length > 1 ? temp[1] : "";
								// ????????????
								var cls = dataType[data.col] == "conditional" ? "lui_maxtrix_condition_td" : "lui_maxtrix_result_td";
								dataTmp.push("<td class=\"" + cls + "\"><xmp>");
								dataTmp.push(val);
								dataTmp.push("</xmp></td>");
							}
						}
						seqTr.push("</tr>");
						seqTab.append(seqTr.join(""));
						dataTr.push(dataTmp.join(""));
						dataTr.push("</tr>");
						dataTab.append(dataTr.join(""));
						// ????????????
						optTr.push("<tr style=\"height: 40px;\">");
						optTr.push("<td>");
						if(window.canDel) {
							optTr.push("<span class=\"lui_text_primary\"><a href=\"javascript:;\" onclick=\"delData(this);\">${lfn:message('button.delete')}</a></span>");
						}
						optTr.push("</td>");
						optTr.push("</tr>");
						optTab.append(optTr.join(""));
					}
					
					// ????????????
					var seqTr = seqTab.find("tr"), dataTr = dataTab.find("tr"), optTr = optTab.find("tr");
					dataTr.each(function(i, n) {
						var height = $(n).height();
						$(seqTr[i]).height(height);
						$(optTr[i]).height(height);
					});
				}
				
				window.showPage = function(page, pageSize, totalSize) {
					window.dataTablePage = LUI("matrix_data_table_" + window.curVersion + "_page");
					if(window.dataTablePage) {
						dataTablePage.config.totalSize = totalSize;
						dataTablePage.config.currentPage = page;
						dataTablePage.config.pageSize = pageSize;
						dataTablePage.totalSize = parseInt(totalSize);
						dataTablePage.currentPage = parseInt(page);
						dataTablePage.pageSize = parseInt(pageSize);
						dataTablePage.draw();
					} else {
						setTimeout(function() {showPage(page, pageSize, totalSize);}, 100);
					}
				}

				// ?????????
				window.simulator = function() {
					var matrixName = encodeURIComponent("<c:out value="${sysOrgMatrixForm.fdName}"/>");
					window.open("${LUI_ContextPath}/sys/organization/sys_org_matrix/sysOrgMatrix_simulator.jsp?matrixId=${sysOrgMatrixForm.fdId}&matrixName=" + matrixName, "_blank");
				}
				
				// ????????????
				window.downloadMatrixRelation = function() {
					$("#downloadMatrixDataForm").submit();
				}
				
				// ????????????
				window.importData = function() {
					window.open("${LUI_ContextPath}/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=importData&fdId=${sysOrgMatrixForm.fdId}", "_blank");
				}
				
				// ????????????
				window.delData = function(elem) {
					var panel = window.matrixPanelArray[window.curVersion];
					var seqTab = $("#" + panel.seq), dataTab = $("#" +  + panel.data), optTab = $("#" +  + panel.opt);
					var idx = $(elem.parentNode).parent().parent().prevAll().length;
					var tr = seqTab.find("tr:eq(" + idx + ")");
					var id = tr.find("[type=checkbox]").val();
					deleteMatrixRelation(id);
				}
				
				// ????????????
				window.deleteMatrixRelation = function(id) {
					var values = [];
		 			if(id) {
		 				values.push(id);
			 		} else {
						$("#matrix_seq_table_" + window.curVersion + " input[name='List_Selected']:checked").each(function() {
							values.push($(this).val());
						});
			 		}
					if(values.length==0) {
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					var url  = '<c:url value="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=deleteData"/>';
					dialog.confirm('<bean:message key="page.comfirmDelete"/>', function(value) {
						if(value == true) {
							window.del_load = dialog.loading();
							$.ajax({
								url : url,
								type : 'POST',
								data : $.param({"fdId": "${sysOrgMatrixForm.fdId}", "List_Selected": values}, true),
								dataType : 'json',
								success: function(data) {
									if(window.del_load != null){
										window.del_load.hide(); 
										topic.channel(window.curVersion).publish("list.refresh");
									}
									dialog.result(data);
								}
						   });
						}
					});
					// ????????????
					$("#matrix_seq_checkbox_" + window.curVersion).prop("checked", false);
				}
				
				// ??????????????????
				window.showField = function() {
					var typeTr = $("#matrix_field_type"), valuetTr = $("#matrix_field_value");
					for(var i=0; i<con.length; i++) {
						var type = con[i].fdType == 'constant' ? '<bean:message bundle="sys-organization" key="sysOrgMatrix.conditional.type.constant"/>' : 
									con[i].fdType == 'org' ? '<bean:message bundle="sys-organization" key="sysOrgMatrix.conditional.type.org"/>' : 
									con[i].fdType == 'dept' ? '<bean:message bundle="sys-organization" key="sysOrgMatrix.conditional.type.dept"/>' : 
									con[i].fdType == 'post' ? '<bean:message bundle="sys-organization" key="sysOrgMatrix.conditional.type.post"/>' : 
									con[i].fdType == 'person' ? '<bean:message bundle="sys-organization" key="sysOrgMatrix.conditional.type.person"/>' : 
									con[i].fdType == 'group' ? '<bean:message bundle="sys-organization" key="sysOrgMatrix.conditional.type.group"/>' : 
									con[i].fdType == 'sys' ? '<bean:message bundle="sys-organization" key="sysOrgMatrix.conditional.type.sys"/>' : 
									con[i].fdType == 'cust' ? '<bean:message bundle="sys-organization" key="sysOrgMatrix.conditional.type.cust"/>' : '';
						type = "<select class=\"inputsgl\" disabled><option>" + type + "</option></select>";
						if(con[i].fdType == "sys" || con[i].fdType == "cust") {
							type += "<br><input type=\"text\" class=\"inputsgl\" value=\"" + con[i].fdMainDataText + "\" disabled>";
						}
						typeTr.append("<td class=\"lui_maxtrix_condition_th\">" + type + "</td>");
						valuetTr.append("<td class=\"lui_maxtrix_condition_td\">" + con[i].fdName + "</td>");
					}
					for(var i=0; i<res.length; i++) {
						var type = '<bean:message bundle="sys-organization" key="sysOrgMatrix.result.type.person_post"/>';
						if(res[i].fdType == 'post') {
							type = '<bean:message bundle="sys-organization" key="sysOrgMatrix.conditional.type.post"/>';
						} else if(res[i].fdType == 'person') {
							type = '<bean:message bundle="sys-organization" key="sysOrgMatrix.conditional.type.person"/>';
						}
						typeTr.append("<td class=\"lui_maxtrix_result_th\"><select class=\"inputsgl\" disabled><option>" + type + "</option></select></td>");
						valuetTr.append("<td class=\"lui_maxtrix_result_td\">" + res[i].fdName + "</td>");
					}
				}
				
				// ??????????????????
				window.resetHeight = function() {
					var typeTr = $("#matrix_type_table").find("tr"), valueTr = $("#matrix_table").find("tr");
					valueTr.each(function(i, tr) {
						$(typeTr[i]).height($(tr).height());
					});
				}
				
				// ????????????
				window.fieldCheck = function() {
					Com_OpenWindow('<c:url value="/sys/organization/sys_org_matrix_relation/sysOrgMatrixRelation.do?method=check&matrixId=${sysOrgMatrixForm.fdId}"/>');
				}
				
				LUI.ready(function() {
					showField();
					LUI("MatrixTab").on('indexChanged', function(evt) {
						if(evt.index.after == 1) {
							setTimeout(function(){resetHeight();}, 100);
						}
					});
				});
				
			});
		</script>
	</template:replace>
</template:include>
