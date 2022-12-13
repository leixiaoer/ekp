<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<template:replace name="content">
		<p class="txttitle">
			<bean:message bundle="km-carmng" key="table.kmCarmngApplication" />
		</p>
		<c:if test="${param.approveModel ne 'right'}">
			<form name="kmCarmngApplicationForm" method="post" action ="${KMSS_Parameter_ContextPath}km/carmng/km_carmng_application/kmCarmngApplication.do">
		</c:if>	
			<div id="kmCarmngAppForm">
				<html:hidden property="fdId" />
				<html:hidden property="method_GET" />
				<html:hidden property="docStatus" />
				<html:hidden property="fdOutStatus" />
				<html:hidden property="fdIsDispatcher" />
				<html:hidden property="fdMotorcadeId" />
				<html:hidden property="fdApplicationPersonId" />
				<html:hidden property="fdApplicationDeptId" />
				<html:hidden property="fdUserPersonIds" />
				<html:hidden property="docCreatorId" />
				<html:hidden property="docCreateTime" />
				<html:hidden property="authReaderIds" />

				<div class="lui_form_content_frame" style="padding-top: 20px;">
					<table class="tb_normal" width="100%">
						<tr>
							<!-- 车队名称  -->
							<td class="td_normal_title" width="15%"><bean:message
									bundle="km-carmng" key="kmCarmngApplication.fdMotorcadeId" />
							</td>
							<td width="35%"><c:if
									test="${kmCarmngApplicationForm.method_GET=='add'}">
									<xform:select className="fdMotorcadeId"
										property="fdMotorcadeId" showPleaseSelect="true"
										showStatus="edit" required="true"
										onValueChange="kmCarmngCategorySelecta"
										subject="${ lfn:message('km-carmng:kmCarmngApplication.fdMotorcadeId') }">
										<xform:beanDataSource
											serviceBean="kmCarmngMotorcadeSetService"
											whereBlock="kmCarmngMotorcadeSet.isEffective = 'true' or kmCarmngMotorcadeSet.isEffective is null"
											orderBy="kmCarmngMotorcadeSet.fdId desc" />
									</xform:select>
								</c:if> <c:if test="${kmCarmngApplicationForm.method_GET=='edit'}">
									<html:text property="fdMotorcadeName" readonly="true"
										style="width:95%" />
								</c:if></td>
							<!-- 标题  -->
							<td class="td_normal_title" width="15%"><bean:message
									bundle="km-carmng" key="kmCarmngApplication.docSubject" /></td>
							<td width="35%"><xform:text property="docSubject"
									required="true"/></td>
						</tr>
						<tr>
							<!-- 申请人  -->
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng"
									key="kmCarmngApplication.fdApplicationPerson" /></td>
							<td width=35%><xform:address isLoadDataDict="false"
									style="width:85%" propertyId="fdApplicationPersonId"
									propertyName="fdApplicationPersonName"
									orgType="ORG_TYPE_PERSON"  onValueChange="selectDept" subject="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationPerson')}" required="true"></xform:address></td>
							<!-- 申请人电话  -->
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng"
									key="kmCarmngApplication.fdApplicationPersonPhone" /></td>
							<td width=35%><xform:text
									property="fdApplicationPersonPhone" required="true"
									validators="phoneNumber" /></td>
						</tr>
						<tr>
							<!-- 用车部门  -->
							<td class="td_normal_title" width="15%"><bean:message
									bundle="km-carmng" key="kmCarmngUserFeeInfo.fdDeptIds" />
							</td>
							<td width="35%" ><xform:address
									isLoadDataDict="false" orgType="ORG_TYPE_DEPT"
									style="width:97%" propertyId="fdApplicationDeptId"
									propertyName="fdApplicationDeptName"></xform:address></td>
							<%--申请单编号--%>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngApplication.fdNo" /></td>
							<td width="35%">
										<bean:message bundle="km-carmng"
											key="kmCarmngApplication.autoCreate" />
								</td>
						</tr>
						<tr>
							<td class="td_normal_title" width="15%"><bean:message
									bundle="km-carmng" key="kmCarmngApplication.fdApplicationPath" />
							</td>
							<td colspan="3">
								<div class="lui_carnming_rotue_tb">
									<c:set var="hasSysAttend" value="false"></c:set>
									<kmss:ifModuleExist path="/sys/attend">
										<c:set var="hasSysAttend" value="true"></c:set>
									</kmss:ifModuleExist>
									<!-- 行驶路线  -->
									<table style="width: 100%">
										<tr>
											<td class="td_title" width="15%"><bean:message
													bundle="km-carmng" key="kmCarmngApplication.fdDeparture" />
											</td>
											<td><c:if test="${hasSysAttend == true }">
													<%-- 其他模块调用地图组件必须用c:import --%>
													<c:import url="/sys/attend/import/map_tag.jsp"
														charEncoding="UTF-8">
														<c:param name="propertyName" value="fdDeparture"></c:param>
														<c:param name="placeholder"
															value="km-carmng:kmCarmngApplication.fdDeparture.pleaseInput"></c:param>
														<c:param name="propertyCoordinate"
															value="fdDepartureCoordinate"></c:param>
														<c:param name="required" value="true"></c:param>
														<c:param name="propertyDetail" value="fdDepartureDetail"></c:param>
														<c:param name="subject"
															value="km-carmng:kmCarmngApplication.fdDeparture"></c:param>
														<c:param name="style" value="width:97%"></c:param>
													</c:import>
												</c:if> <c:if test="${hasSysAttend == false }">
													<xform:text property="fdDeparture" required="true"
														style="width:97%"
														subject="${ lfn:message('km-carmng:kmCarmngApplication.fdDeparture')}" />
												</c:if></td>
											<td class="td_operate"></td>
										</tr>
										<tr>
											<td class="td_title" width="15%"><bean:message
													bundle="km-carmng" key="kmCarmngApplication.fdDestination" />
											</td>
											<td><c:if test="${hasSysAttend == true }">
													<c:import url="/sys/attend/import/map_tag.jsp"
														charEncoding="UTF-8">
														<c:param name="propertyName" value="fdDestination"></c:param>
														<c:param name="placeholder"
															value="km-carmng:kmCarmngApplication.fdDestination.pleaseInput"></c:param>
														<c:param name="propertyCoordinate"
															value="fdDestinationCoordinate"></c:param>
														<c:param name="required" value="true"></c:param>
														<c:param name="propertyDetail" value="fdDestinationDetail"></c:param>
														<c:param name="subject"
															value="km-carmng:kmCarmngApplication.fdDestination"></c:param>
														<c:param name="style" value="width:97%"></c:param>
													</c:import>
												</c:if> <c:if test="${hasSysAttend == false }">
													<xform:text property="fdDestination" required="true"
														style="width:97%"
														subject="${ lfn:message('km-carmng:kmCarmngApplication.fdDestination')}" />
												</c:if></td>
											<td align="center" class="td_operate">
												<div class="lui_carmng_route_add"
													onclick="DocList_AddRow('TABLE_DocList');"></div>
											</td>
										</tr>
										<tr>
											<td></td>
											<td colspan="2">
												<table id="TABLE_DocList" border="0" width=100%
													align="center">
													<!-- 基准行 -->
													<tr KMSS_IsReferRow="1" style="display: none">
														<td><c:if test="${hasSysAttend == true }">
																<c:import url="/sys/attend/import/map_tag.jsp"
																	charEncoding="UTF-8">
																	<c:param name="propertyName"
																		value="fdPathForms[!{index}].fdDestination"></c:param>
																	<c:param name="placeholder"
																		value="km-carmng:kmCarmngApplication.fdDestination.pleaseInput"></c:param>
																	<c:param name="propertyCoordinate"
																		value="fdPathForms[!{index}].fdDestinationCoordinate"></c:param>
																	<c:param name="required" value="true"></c:param>
																	<c:param name="propertyDetail"
																		value="fdPathForms[!{index}].fdDestinationDetail"></c:param>
																	<c:param name="subject"
																		value="km-carmng:kmCarmngApplication.fdDestination"></c:param>
																	<c:param name="style" value="width:97%"></c:param>
																</c:import>
															</c:if> <c:if test="${hasSysAttend == false }">
																<xform:text
																	property="fdPathForms[!{index}].fdDestination"
																	required="true"
																	subject="${ lfn:message('km-carmng:kmCarmngApplication.fdDestination') }"
																	style="width:97%" />
															</c:if></td>
														<!-- 删除按钮 -->
														<td align="center" class="td_operate">
															<div class="lui_carmng_route_del"
																onclick="DocList_DeleteRow_ClearLast();"></div>
														</td>
													</tr>
													<c:forEach items="${kmCarmngApplicationForm.fdPathForms}"
														var="kmCarmngPathForm" varStatus="vstatus">
														<tr KMSS_IsContentRow="1">
															<td><input type="hidden"
																name="fdPathForms[${vstatus.index}].fdId"
																value="${kmCarmngPathForm.fdId}" /> <input
																type="hidden"
																name="fdPathForms[${vstatus.index}].fdApplicationId"
																value="${kmCarmngApplicationForm.fdId}" /> <c:if
																	test="${hasSysAttend == true }">
																	<c:import url="/sys/attend/import/map_tag.jsp"
																		charEncoding="UTF-8">
																		<c:param name="propertyName"
																			value="fdPathForms[${vstatus.index}].fdDestination"></c:param>
																		<c:param name="placeholder"
																			value="km-carmng:kmCarmngApplication.fdDestination.pleaseInput"></c:param>
																		<c:param name="propertyCoordinate"
																			value="fdPathForms[${vstatus.index}].fdDestinationCoordinate"></c:param>
																		<c:param name="required" value="true"></c:param>
																		<c:param name="propertyDetail"
																			value="fdPathForms[${vstatus.index}].fdDestinationDetail"></c:param>
																		<c:param name="subject"
																			value="km-carmng:kmCarmngApplication.fdDestination"></c:param>
																		<c:param name="style" value="width:97%"></c:param>
																	</c:import>
																</c:if> <c:if test="${hasSysAttend == false }">
																	<xform:text
																		property="fdPathForms[${vstatus.index}].fdDestination"
																		required="true" style="width:97%"
																		subject="${ lfn:message('km-carmng:kmCarmngApplication.fdDestination') }" />
																</c:if></td>
															<!-- 删除按钮 -->
															<td align="center" class="td_operate">
																<div class="lui_carmng_route_del"
																	onclick="DocList_DeleteRow_ClearLast();"></div>
															</td>
														</tr>
													</c:forEach>
												</table>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<!-- 用车开始时间  -->
							<td class="td_normal_title" width="15%"><bean:message
									bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseStartTime" />
							</td>
							<td width="35%"><xform:datetime property="fdStartTime"
									required="true" validators="compareTime"
									onValueChange="changeDateTime" /></td>
							<!-- 用车结束时间  -->
							<td class="td_normal_title" width="15%"><bean:message
									bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseEndTime" /></td>
							<td width="35%"><xform:datetime property="fdEndTime"
									required="true" validators="compareTime" /></td>
						</tr>
						<!-- 用车人  -->
						<tr>
							<td class="td_normal_title" width="15%"><bean:message
									bundle="km-carmng" key="kmCarmngApplication.fdUserPersons" />
							</td>
							<td colspan="3">
								<%--用车人--%> <xform:address style="width:47%;height:80px;"
									textarea="true" showStatus="edit" propertyId="fdUserPersonIds"
									propertyName="fdUserPersonNames" onValueChange="afterAddress"
									isLoadDataDict="false" orgType="ORG_TYPE_PERSON"
									mulSelect="true" validators="validateusers"></xform:address>
								&nbsp;&nbsp;&nbsp;&nbsp; <%--外部用车人 added by weiby --%> <xform:textarea
									style="width:47%;border:1px solid #b4b4b4"
									isLoadDataDict="false" property="fdOtherUsers"
									showStatus="edit" onValueChange="afterFillIn();"
									htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngApplication.fdOtherUsers') } (${lfn:message('km-carmng:kmCarmngApplication.fdOtherUsersWarn') })' data-actor-expand='true'"
									validators="validateusers maxLength(200)" /> <span
								class="txtstrong">*</span>
								<xform:checkbox property="fdNotifyPerson" showStatus="edit">
									<xform:enumsDataSource enumsType="kmCarmngDispatchersInfo_fdNotifyPerson"></xform:enumsDataSource>
								</xform:checkbox>
							</td>
						</tr>
						<!-- 随车人数  -->
						<tr>
							<td class="td_normal_title" width="15%"><bean:message
									bundle="km-carmng" key="kmCarmngApplication.fdUserNumber" /></td>
							<td colspan="3"><xform:text showStatus="edit"
									property="fdUserNumber" required="true"
									validators="digits min(1)" /></td>
						</tr>
						<!-- 用车事由  -->
						<tr>
							<td class="td_normal_title" width="15%"><bean:message
									bundle="km-carmng"
									key="kmCarmngApplication.fdApplicationReason" /></td>
							<td colspan="3"><xform:textarea style="width:95%"
									htmlElementProperties="data-actor-expand='true'"
									property="fdApplicationReason" /></td>
						</tr>
						
						<tr>
						<%--文档附件--%>
						<td width="15%" class="td_normal_title"><bean:message
							bundle="km-carmng" key="kmCarmngApplication.attachment" /></td>
						<td width="85%" bgcolor="#ffffff" colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attKmCarmngApplication" />
								<c:param name="fdModelName" value="com.landray.kmss.km.carmng.model.KmCarmngApplication" />
								<c:param name="formBeanName" value="kmCarmngApplicationForm" />
							</c:import>
						</td>
					</tr>
					</table>
				</div>
				
				
				<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmCarmngApplicationForm" />
					<c:param name="fdKey" value="KmCarmngApplicationDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
				<%--权限机制 --%>
					<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
						<table class="tb_normal" width=100%>
							<td class="td_normal_title" width="15%"><bean:message
									bundle="sys-right" key="right.read.authReaders" /></td>
							<td width="85%"><xform:address textarea="true"
									mulSelect="true" propertyId="authReaderIds"
									propertyName="authReaderNames" style="width:95%;height:90px;"></xform:address>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span
								class="com_help"><bean:message bundle="sys-right"
										key="right.read.authReaders.note1" /></span></td>
						</table>
					</ui:content>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%" >
				<%--流程机制 --%>
					<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="kmCarmngApplicationForm" />
						<c:param name="fdKey" value="KmCarmngApplicationDoc" />
					</c:import>
					<%--权限机制 --%>
					<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
						<table class="tb_normal" width=100%>
							<td class="td_normal_title" width="15%"><bean:message
									bundle="sys-right" key="right.read.authReaders" /></td>
							<td width="85%"><xform:address textarea="true"
									mulSelect="true" propertyId="authReaderIds"
									propertyName="authReaderNames" style="width:95%;height:90px;"></xform:address>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span
								class="com_help"><bean:message bundle="sys-right"
										key="right.read.authReaders.note1" /></span></td>
						</table>
					</ui:content>
			</ui:tabpage>
		</c:otherwise>
	</c:choose>
				
				
			</div>
			<c:if test="${param.approveModel ne 'right'}">
				</form>
			</c:if>	
<script type="text/javascript">
	Com_IncludeFile("doclist.js|docutil.js|dialog.js|calendar.js|treeview.js");
	var validation = $KMSSValidation(document.forms['kmCarmgnApplicationForm']);

	var emptyRow = function(dtd, row, idx) {
		$(row).find(
				'[data-location-container="fdPathForms[' + idx
						+ '].fdDestination"]').html("");
		if ($(row).find(
				'[data-location-container="fdPathForms[' + idx
						+ '].fdDestination"]').html() == "") {
			dtd.resolve(); // 改变Deferred对象的执行状态
			return dtd.promise(); // 返回promise对象
		}
	};

	$(document)
			.ready(
					function() {
						$(document)
								.on(
										'table-add',
										"table[id$='TABLE_DocList']",
										function(e, row) {
											var idx = row.rowIndex;
											var subject = '<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDestination" />';
											var placeholder = '<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDestination.pleaseInput" />';
											var dtd = $.Deferred();
											seajs
													.use(
															[ 'sys/attend/map/resource/js/LocationInit.js' ],
															function(init) {
																$
																		.when(
																				emptyRow(
																						dtd,
																						row,
																						idx))
																		.done(
																				function() {
																					var options = '{"id":"fdPathForms['
																							+ idx
																							+ '].fdDestination","propertyName":"fdPathForms['
																							+ idx
																							+ '].fdDestination","propertyCoordinate":"fdPathForms['
																							+ idx
																							+ '].fdDestinationCoordinate","propertyDetail":"fdPathForms['
																							+ idx
																							+ '].fdDestinationDetail","nameValue":"","coordinateValue":"","showStatus":"edit","style":"width:97%","required":true,"subject":"'
																							+ subject
																							+ '","placeholder":"'
																							+ placeholder
																							+ '","validators":"required"}';
																					init(JSON
																							.parse(options));
																				})
															});
										});
						$(document)
								.on(
										'table-delete',
										"table[id$='TABLE_DocList']",
										function(evt, data) {
											if (data) {
												var tbInfo = DocList_TableInfo['TABLE_DocList'];
												for (var i = 0; i < tbInfo.lastIndex; i++) {
													var optTR = tbInfo.DOMElement.rows[i];
													var doms = optTR
															.getElementsByTagName('div');
													// 更新input的name属性中的序号
													var inputs = optTR.getElementsByTagName('input');
													for(var j = 0;j<inputs.length; j++){
														var fv = $(inputs[j]).attr("name").replace(/\[\d+\]/g, "[!{index}]").replace(/\.\d+\./g, ".!{index}.");
														fv = fv.replace(/!\{index\}/g, i - tbInfo.firstIndex);
														$(inputs[j]).attr("name", fv);
													}
													// 更新data-location-container属性中的序号
													for (var k = 0; k < doms.length; k++) {
														if ($(doms[k])
																.attr(
																		"data-location-container")) {
															var fieldValue = $(
																	doms[k])
																	.attr(
																			"data-location-container")
																	.replace(
																			/\[\d+\]/g,
																			"[!{index}]")
																	.replace(
																			/\.\d+\./g,
																			".!{index}.");
															fieldValue = fieldValue
																	.replace(
																			/!\{index\}/g,
																			i
																					- tbInfo.firstIndex);
															$(doms[k])
																	.attr(
																			"data-location-container",
																			fieldValue);
														}
													}
												}
											}
										});
					});

	seajs
			.use(
					[ 'km/carmng/resource/js/dateUtil', 'lui/dialog',
							'lui/jquery' ],
					function(dateUtil, dialog, $) {

						window.afterFillIn = function() {
							afterAddress();
						};
						
						window. kmCarmngCategorySelecta = function(rtnVal,
								rtnObj) {
							if (rtnVal == null || rtnVal == "") {
								rtnObj.options[0].selected = true;
								return false;
							}
							validation.removeElements($('#kmCarmngAppForm')[0],
									'required');
							$("#kmCarmngAppForm").attr("flag", "change");
							$("input[name='fdMotorcadeId']").val(rtnVal);
							var url = Com_CopyParameter(document.kmCarmngApplicationForm.action);
							url = Com_SetUrlParameter(url, "isExpand", "true");
							url = Com_SetUrlParameter(url, "method", "change");
							url= Com_SetUrlParameter(url, "fdMotorcadeId", rtnVal);
							document.kmCarmngApplicationForm.action = url;
							document.kmCarmngApplicationForm.submit();
							timeout3();
							timein();				
						};
						$(function timeout3() {
 										setTimeout(function () {
 									$("select[name='fdMotorcadeId']").attr("disabled",true);}, 1);
							});
                                                 $(function timein() {
 										setTimeout(function () {
 									$("select[name='fdMotorcadeId']").attr("disabled",false);}, 3500);
							});

						window.afterAddress = function() {
							//重计算用车人
							var fdUserPersonIds = document
									.getElementsByName("fdUserPersonIds")[0];
							var fdUserPersonLength = 0;
							if (fdUserPersonIds) {
								var fdUserPersonIdsList = fdUserPersonIds.value
										.split(';');
								for (var i = 0; i < fdUserPersonIdsList.length; i++) {
									if (fdUserPersonIdsList[i] != ""
											&& fdUserPersonIdsList[i] != null) {
										fdUserPersonLength++;
									}
								}
							}
							//重计算外部用车人
							var fdOtherUsers = document
									.getElementsByName("fdOtherUsers")[0];
							var fdOtherUsersLength = 0;
							if (fdOtherUsers) {
								var fdOtherUsersList = fdOtherUsers.value
										.split(/;|；/);
								for (var i = 0; i < fdOtherUsersList.length; i++) {
									if (fdOtherUsersList[i] != ""
											&& fdOtherUsersList[i] != null) {
										fdOtherUsersLength++;
									}
								}
							}
							//重计算用车人数
							document.getElementsByName("fdUserNumber")[0].value = parseInt(Number(fdOtherUsersLength)
									+ Number(fdUserPersonLength))
						};

						//添加对时间的判断by张文添
						window.commitMethod = function(commitType, saveDraft) {
							$("#kmCarmngAppForm").attr("flag", "");
							var formObj = document.kmCarmngApplicationForm;
							var pNumber = document
									.getElementsByName("fdApplicationPersonPhone")[0].value;
							//var regex = /^1\d{10}$/;
							var docStatus = document
									.getElementsByName("docStatus")[0];
							if (docStatus.value != "30") {
								if (saveDraft == "true") {
									docStatus.value = "10";
								} else {
									docStatus.value = "20";
								}
								document.getElementsByName("fdOutStatus")[0].value = "0";
							}
							Com_Submit(formObj, commitType);
						};

						window.kmCarmngCategorySelect = function(rtnVal, rtnObj) {
							var fdTempletId = document
									.getElementsByName("fdMotorcadeId")[0];
							var perVal = "";
							if (fdTempletId != null) {
								perVal = fdTempletId.value;
							}
							if (rtnVal == null || rtnVal == "") {
								rtnObj.options[0].selected = true;
								return false;
							}
							dialog
									.confirm(
											'<bean:message bundle="km-carmng" key="description.refreshTemplate" />',
											function(value) {
												if (value == true) {
													window.del_load = dialog
															.loading();
													for (var i = 0; i < rtnObj.length; i++) {
														if (rtnObj.options[i].value == perVal) {
															rtnObj.options[i].selected = true;
															break;
														}
													}
													Com_OpenWindow(
															'<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do" />?method=add&fdTempletId='
																	+ rtnVal,
															'_self');
												} else
													Com_OpenWindow(
															'<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do" />?method=add',
															'_self');
											});
						};
					
						//自定义校验器：检验申请人手机号码：校验规则跟组织机构员工手机号码校验一致 
						validation
								.addValidator(
										'phone',
										'${lfn:message("km-carmng:kmCarmng.message.phone.error")}',
										function(v, e, o) {
											var flag = $("#kmCarmngAppForm")
													.attr("flag");
											if (flag == "change") {
												return true;
											}
											if (v == "") {
												return false;
											}
											if (/^((\+?\d{1,5})|(\(\+?\d{1,5}\)))?-?(\d{6,11})$/
													.test(v)) {
												return true; // 校验通过
											}
											return false;
										});
						//自定义校验器:用车人和外部用车人不能全为空
						validation
								.addValidator(
										'validateusers',
										'${lfn:message("km-carmng:kmCarmngApplication.fdUsers.notNull")}',
										function(v, e, o) {
											var fdUserPersonNames = $('[name="fdUserPersonNames"]')[0];//用车人
											var fdOtherUsers = $('[name="fdOtherUsers"]')[0];//外部用车人
											var result = true;
											if (fdUserPersonNames.value != ""
													|| fdOtherUsers.value != "") {
												result = true;
											} else {
												result = false;
											}
											if (result == false) {
												KMSSValidation_HideWarnHint(fdUserPersonNames);
												KMSSValidation_HideWarnHint(fdOtherUsers);
											}
											return result;
										});

						//校验召开时间不能晚于结束时间
						var _compareTime = function() {
							var fdStartTime = $('[name="fdStartTime"]');
							var fdFinishedDate = $('[name="fdEndTime"]');
							var result = true;
							if (fdStartTime.val() && fdFinishedDate.val()) {
								var start = Com_GetDate(fdStartTime.val());
								var end = Com_GetDate(fdFinishedDate.val());
								if (start >= end) {
									result = false;
								}
							}
							return result;
						};

						//自定义校验器:校验召开时间不能晚于结束时间
						validation
								.addValidator(
										'compareTime',
										'${lfn:message("km-carmng:kmCarmng.error.message10")}',
										function(v, e, o) {
											var fdEndTime = document
													.getElementsByName('fdEndTime')[0];
											var result = true;
											if (e.name == "fdStartTime") {//fdFinishDate的这个校验与fdHoldDate的相同，直接执行fdHoldDate的
												validation
														.validateElement(fdEndTime);
											} else {
												result = _compareTime();
											}
											return result;
										});

						window.changeDateTime = function() {
							var fdTime = $('[name="fdStartTime"]').val();//开始时间
							var fdEndTime = $('[name="fdEndTime"]').val();//结束时间
							//选择了开始时间后，结束时间默认带出
							if (fdTime && !fdEndTime) {
								$('[name="fdEndTime"]').val(fdTime);
							}
						};
					});
	
	 function selectDept(){
     	var url = "${KMSS_Parameter_ContextPath}km/carmng/km_carmng_application/kmCarmngApplication.do?method=getApplicantDept";
     	var fdApplicationPersonId = document.getElementsByName("fdApplicationPersonId")[0];
     	 $.ajax({     
        	     type:"post",   
        	     url:url,     
        	     data:{fdApplicationId:fdApplicationPersonId.value},    
        	     async:false,    //用同步方式 
        	     success:function(data){
        	 	    var results =  eval("("+data+")");
        	 	    if(results['deptId']!=""&&results['deptName']!=""){
        	 	   		var kmssData = new KMSSData();
	   	          		kmssData.AddHashMap({deptId:results['deptId'],deptName:results['deptName']});
	   	          		kmssData.PutToField("deptId:deptName", "fdApplicationDeptId:fdApplicationDeptName", "", false);
	   	          		$("input[name='fdApplicationPersonPhone']").val(results['fdMobileNo']);
        	   	 	}else{
	           	   	 	var address = Address_GetAddressObj("fdApplicationDeptName");
	    				address.emptyAddress(true);
        	   	 	}
        		 }    
          });
     }
</script>
	</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
				<%-- 流程 --%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmCarmngApplicationForm" />
					<c:param name="fdKey" value="KmCarmngApplicationDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
			</ui:tabpanel>
		</template:replace>
	</c:when>
</c:choose>