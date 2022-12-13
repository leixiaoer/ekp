<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="mobile.edit" compatibleMode="true" newMui="true">
	<template:replace name="title">
		<c:choose>
			<c:when test="${kmCarmngApplicationForm.method_GET=='add'}">
				<c:out
					value="${ lfn:message('km-carmng:table.kmCarmngApplication') } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
			</c:when>
			<c:when test="${kmCarmngApplicationForm.method_GET=='edit'}">
				<c:out
					value="${kmCarmngApplicationForm.docSubject} - ${lfn:message('km-carmng:module.km.carmng')}"></c:out>
			</c:when>
		</c:choose>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet"
			href="${LUI_ContextPath}/km/carmng/mobile/css/carlist.css?s_cache=${MUI_Cache}" />
		<script type="text/javascript">
		   	require(["dojo/store/Memory","dojo/topic","dijit/registry"],function(Memory,topic,registry){
		   		var navData = [{'text':'01  /  <bean:message bundle="sys-mobile" key="mui.mobile.info" />',
		   			'moveTo':'scrollView','selected':true},{'text':'02  /  <bean:message bundle="sys-mobile" key="mui.mobile.review" />',
			   		'moveTo':'lbpmView'}]
		   		window._narStore = new Memory({data:navData});
		   		var changeNav = function(view){
		   			var wgt = registry.byId("_flowNav");
		   			for(var i=0;i<wgt.getChildren().length;i++){
		   				var tmpChild = wgt.getChildren()[i];
		   				if(view.id == tmpChild.moveTo){
		   					tmpChild.beingSelected(tmpChild.domNode);
		   					return;
		   				}
		   			}
		   		}
		   		topic.subscribe("mui/form/validateFail",function(view){
		   			changeNav(view);
		   		});
				topic.subscribe("mui/view/currentView",function(view){
					changeNav(view);
		   		});
		   	});
	   </script>
	   
	   <script type="text/javascript">
	require([ "mui/form/ajax-form!kmCarmngApplicationForm" ]);
	Com_IncludeFile("doclist.js");
	window.afterAddress = function(rtn) {
		var fdUserPersonIds = document
				.getElementsByName("fdUserPersonIds")[0];
		if (fdUserPersonIds != null) {
			fdUserPersonIds.value = rtn;
		}
		calculateUserNum();
	}
	window.calculateUserNum = function() {
		var fdUserPersonLength = getUserSize();
		var fdOtherUsersLength = getOtherUserSize();
		//重计算用车人数
		var fdUserNumber = document
				.getElementsByName("fdUserNumber")[0];
		if (fdUserNumber != null) {
			fdUserNumber.value = fdUserPersonLength
					+ fdOtherUsersLength;
		}
	}
	window.getUserSize = function() {
		//重计算用车人
		var fdUserSize = 0;
		var fdUsers = document
				.getElementsByName("fdUserPersonIds")[0];
		if (fdUsers) {
			var fdUserPersonIdsList = fdUsers.value
					.split(';');
			for (var i = 0; i < fdUserPersonIdsList.length; i++) {
				if (fdUserPersonIdsList[i] != ""
						&& fdUserPersonIdsList[i] != null) {
					fdUserSize++;
				}
			}
		}
		return fdUserSize;
	}
	window.getOtherUserSize = function() {
		//重计算外部用车人
		var fdOtherUserSize = 0;
		var fdOtherUsers = document
				.getElementsByName("fdOtherUsers")[0];
		if (fdOtherUsers) {
			var fdOtherUsersList = fdOtherUsers.value
					.split(/;|；/);
			for (var i = 0; i < fdOtherUsersList.length; i++) {
				if (fdOtherUsersList[i] != ""
						&& fdOtherUsersList[i] != null) {
					fdOtherUserSize++;
				}
			}
		}
		return fdOtherUserSize;
	}
	
	window.selectDept = function(dom){
		require(
			[ 'dijit/registry','dojo/request' ],
			function(registry, request) {
						
				var url = "${KMSS_Parameter_ContextPath}km/carmng/km_carmng_application/kmCarmngApplication.do?method=getApplicantDept";
				var fdApplicationPersonId = dom.value;
				var data = {fdApplicationId:fdApplicationPersonId};   
				request.post(url, {
					data : data,
					handleAs : 'json',
					sync: false
				}).then(function(data){
					var results =  data;
					if(results['deptId']!=""&&results['deptName']!=""){
						registry.byId('fdApplicationPerson')._setCurIdsAttr(results['deptId']);
						registry.byId('fdApplicationPerson')._setCurNamesAttr(results['deptName']);
						if(null != results['fdMobileNo'] && results['fdMobileNo'] != ""){
							$("input[name='fdApplicationPersonPhone']").val(results['fdMobileNo']);
						}
					}else{
						registry.byId('fdApplicationPerson')._setCurIdsAttr("");
						registry.byId('fdApplicationPerson')._setCurNamesAttr("");
						$("input[name='fdApplicationPersonPhone']").val("");
					}
				},function(data){
				});
		})
	}
	//视图切换
	require(
			[ "dojo/parser", 'dojo/ready', 'dijit/registry',
					'mui/dialog/Confirm', 'dojo/dom', 'dojo/dom-attr',
					'dojo/query', 'dojo/topic', "dojo/store/Memory",
					"mui/dialog/Tip", "mui/util",
					'km/carmng/resource/js/dateUtil','dojo/request' ],
			function(parser, ready, registry, Confirm, dom, domAttr, query,
					topic, Memory, Tip, util, dateUtil, request) {
				
				window.validate = function() {
					validatorObj = registry.byId("scrollView");
					var rs = validatorObj.validate();
					return rs;
				}

				window.deleteVoteItem = function() {
					DocList_DeleteRow();
				}

				//添加记录
				window.AddPathItem = function() {
					var newRow = DocList_AddRow("TABLE_DocList");
					parser.parse(newRow);
				}
				window.changeDateTime = function(rtn) {
					var fdEndTime = registry.byId('fdEndTime');
					//选择了开始时间后，结束时间默认带出
					if (rtn && fdEndTime != null) {
						fdEndTime.set('value', rtn);
					}
				}
				window.kmCarmngCategorySelecta = function(rtn) {
					 if(rtn == '') return; //不允许选择为空的信息
					var url = Com_CopyParameter(document.kmCarmngApplicationForm.action);
					url = Com_SetUrlParameter(url, "method", "change");
					url = Com_SetUrlParameter(url, "_referer",
							"${LUI_ContextPath}/km/carmng/mobile/index.jsp?moduleName=${param.moduleName}");
					document.kmCarmngApplicationForm.action = url;
					$("input[name='fdMotorcadeId']").val(rtn);
					document.kmCarmngApplicationForm.submit();
				}

				window.afterPutOther = function() {
					calculateUserNum();
				}

				window.app_submit = function(commitType, saveDraft) {
					var flag = false;
					var docStatus = document.getElementsByName("docStatus")[0];
					if(docStatus.value != "30"){
						if (saveDraft == "true") {
							docStatus.value = "10";
							flag = true;
						} else {
							docStatus.value = "20";
						}
						document.getElementsByName("fdOutStatus")[0].value = "0";
					}
					Com_Submit(document.kmCarmngApplicationForm, commitType, null, {'saveDraft' : flag});
					//window.location.href='${LUI_ContextPath}/km/carmng/mobile/index.jsp?moduleName=${param.moduleName}';
				}

				ready(function() {
					validorObj = registry.byId('scrollView');
					validorObj._validation
							.addValidator(
									"validateusers",
									'${lfn:message("km-carmng:kmCarmngApplication.fdUsers.notNull")}',
									function(v, e, o) {
										var fdUserPersonIds = query('[name="fdUserPersonIds"]')[0];
										var fdOtherUsers = query('[name="fdOtherUsers"]')[0];
										var result = true;
										if (fdUserPersonIds.value == ""
												&& fdOtherUsers.value == "") {
											result = false;
										}
										if (result == true) {
											var fdUserPersonvalidate = registry
													.byId('fdUserPersonvalidate');
											var fdOtherUservalidate = registry
													.byId('fdOtherUservalidate');
											validorObj._validation
													.hideWarnHint(fdUserPersonvalidate);
											validorObj._validation
													.hideWarnHint(fdOtherUservalidate);
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
							if (start.getTime() >= end.getTime()) {
								result = false;
							}
						}
						return result;
					};

					//自定义校验器:校验召开时间不能晚于结束时间
					validorObj._validation
							.addValidator(
									'compareTime',
									'${lfn:message("km-carmng:kmCarmng.error.message10")}',
									function(v, e, o) {
										var fdEndTime = document
												.getElementsByName('fdEndTime')[0];
										var result = true;
										if (e.name == "fdStartTime") {//fdFinishDate的这个校验与fdHoldDate的相同，直接执行fdHoldDate的
											validorObj._validation
													.validateElement(fdEndTime);
										} else {
											result = _compareTime();
										}
										return result;
									});

				});
			});
</script>
	   
	</template:replace>
	<template:replace name="content">
		<xform:config orient="vertical">
			<html:form
				action="/km/carmng/km_carmng_application/kmCarmngApplication.do">
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
				<c:if test="${kmCarmngApplicationForm.fdMotorcadeId != null}">
					<div data-dojo-type="mui/fixed/Fixed" class="muiFlowEditFixed">
						<div data-dojo-type="mui/fixed/FixedItem"
							class="muiFlowEditFixedItem">
							<div data-dojo-type="mui/nav/NavBarStore" id="_flowNav"
								data-dojo-props="store:_narStore"></div>
						</div>
					</div>
				</c:if>
				<div data-dojo-type="mui/view/DocScrollableView"
					data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView"
					class="gray">
					<div class="muiFormContent muiCarEditWrap">
						<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td><c:if
										test="${kmCarmngApplicationForm.method_GET=='add'}">
										<xform:select className="fdMotorcadeId"
											property="fdMotorcadeId" mobile="true"
											showPleaseSelect="true" showStatus="edit" required="true"
											onValueChange="kmCarmngCategorySelecta"
											subject="${ lfn:message('km-carmng:kmCarmngApplication.fdMotorcadeId') }">
											<xform:beanDataSource
												serviceBean="kmCarmngMotorcadeSetService"
												whereBlock="kmCarmngMotorcadeSet.isEffective = 'true' or kmCarmngMotorcadeSet.isEffective is null"
												orderBy="kmCarmngMotorcadeSet.fdId desc" />
										</xform:select>
									</c:if> <c:if test="${kmCarmngApplicationForm.method_GET=='edit'}">
										<xform:select className="fdMotorcadeId"
											property="fdMotorcadeId" mobile="true"
											showPleaseSelect="false" showStatus="readOnly" required="true"
											onValueChange="kmCarmngCategorySelecta"
											subject="${ lfn:message('km-carmng:kmCarmngApplication.fdMotorcadeId') }">
											<xform:beanDataSource
												serviceBean="kmCarmngMotorcadeSetService"
												whereBlock="kmCarmngMotorcadeSet.isEffective = 'true' or kmCarmngMotorcadeSet.isEffective is null"
												orderBy="kmCarmngMotorcadeSet.fdId desc" />
										</xform:select>
									</c:if></td>
							</tr>
						</table>
						<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td><xform:text property="docSubject" mobile="true"
										required="true" htmlElementProperties="placeholder=''"
										subject="${ lfn:message('km-carmng:kmCarmngApplication.docSubject') }" />
								</td>
							</tr>
						</table>
						<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<!-- 用车开始时间  -->
								<td><xform:datetime property="fdStartTime" mobile="true"
										required="true" onValueChange="changeDateTime"
										subject="${ lfn:message('km-carmng:kmCarmngUserFeeInfo.fdUseStartTime') }" />
								</td>
							</tr>
							<tr>
								<!--用车结束时间  -->
								<td><xform:datetime property="fdEndTime" mobile="true"
										validators="compareTime" required="true"
										htmlElementProperties="id='fdEndTime' "
										subject="${ lfn:message('km-carmng:kmCarmngUserFeeInfo.fdUseEndTime') }" />
								</td>
							</tr>
						</table>
						<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
							<tr style="height: 3.5rem">
								<td class="muiTitle" colspan="2"><bean:message
										bundle="km-carmng" key="kmCarmngApplication.fdApplicationPath" />
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="muiTravelWay">
										<c:set var="hasSysAttend" value="false"></c:set>
										<kmss:ifModuleExist path="/sys/attend">
											<c:set var="hasSysAttend" value="true"></c:set>
										</kmss:ifModuleExist>
										<table cellpadding="0" cellspacing="0" id="TABLE_DocList"
											tbdraggable="true">
											<tr>
												<td>
													<div class="dest">
														<span> <c:if test="${hasSysAttend == true }">
																<c:import url="/sys/attend/import/map_tag.jsp"
																	charEncoding="UTF-8">
																	<c:param name="propertyName" value="fdDeparture"></c:param>
																	<c:param name="propertyCoordinate"
																		value="fdDepartureCoordinate"></c:param>
																	<c:param name="propertyDetail"
																		value="fdDepartureDetail"></c:param>
																	<c:param name="mobile" value="true"></c:param>
																	<c:param name="required" value="true"></c:param>
																	<c:param name="placeholder"
																		value="km-carmng:kmCarmngApplication.fdDeparture.pleaseInput"></c:param>
																	<c:param name="subject"
																		value="km-carmng:kmCarmngApplication.fdDeparture"></c:param>
																	<c:param name="style" value="width:90%"></c:param>
																</c:import>
															</c:if> <c:if test="${hasSysAttend == false }">
																<xform:text property="fdDeparture" required="true"
																	subject="${ lfn:message('km-carmng:kmCarmngApplication.fdDeparture')}"
																	htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngApplication.fdDeparture.pleaseInput') }'"
																	style="width:90%" />
															</c:if>
														</span>
													</div>
												</td>
											</tr>
											<tr>
												<td>
													<div class="dest">
														<span> <c:if test="${hasSysAttend == true }">
																<c:import url="/sys/attend/import/map_tag.jsp"
																	charEncoding="UTF-8">
																	<c:param name="propertyName" value="fdDestination"></c:param>
																	<c:param name="propertyCoordinate"
																		value="fdDestinationCoordinate"></c:param>
																	<c:param name="propertyDetail"
																		value="fdDestinationDetail"></c:param>
																	<c:param name="mobile" value="true"></c:param>
																	<c:param name="required" value="true"></c:param>
																	<c:param name="placeholder"
																		value="km-carmng:kmCarmngApplication.fdDestination.pleaseInput"></c:param>
																	<c:param name="subject"
																		value="km-carmng:kmCarmngApplication.fdDestination"></c:param>
																	<c:param name="style" value="width:90%"></c:param>
																</c:import>
															</c:if> <c:if test="${hasSysAttend == false }">
																<xform:text property="fdDestination" required="true"
																	subject="${ lfn:message('km-carmng:kmCarmngApplication.fdDestination')}"
																	htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngApplication.fdDestination.pleaseInput') }'"
																	style="width:90%" />
															</c:if>
														</span>
													</div>
												</td>
											</tr>
											<tr data-dojo-type="mui/form/Template" KMSS_IsReferRow="1"
												style="display: none;">
												<td>
													<div class="dest">
														<span> <c:if test="${hasSysAttend == true }">
																<c:import url="/sys/attend/import/map_tag.jsp"
																	charEncoding="UTF-8">
																	<c:param name="propertyName"
																		value="fdPathForms[!{index}].fdDestination"></c:param>
																	<c:param name="propertyCoordinate"
																		value="fdPathForms[!{index}].fdDestinationCoordinate"></c:param>
																	<c:param name="propertyDetail"
																		value="fdPathForms[!{index}].fdDestinationDetail"></c:param>
																	<c:param name="mobile" value="true"></c:param>
																	<c:param name="required" value="true"></c:param>
																	<c:param name="placeholder"
																		value="km-carmng:kmCarmngApplication.fdDestination.pleaseInput"></c:param>
																	<c:param name="subject"
																		value="km-carmng:kmCarmngApplication.fdDestination"></c:param>
																	<c:param name="style" value="width:90%"></c:param>
																</c:import>
															</c:if> <c:if test="${hasSysAttend == false }">
																<xform:text
																	property="fdPathForms[!{index}].fdDestination"
																	required="true"
																	subject="${ lfn:message('km-carmng:kmCarmngApplication.fdDestination')}"
																	htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngApplication.fdDestination.pleaseInput') }'"
																	style="width:90%" />
															</c:if>
														</span>
													</div> <span class="optBtn delBtn" onclick="deleteVoteItem();"><i
														class="mui mui-addIco mui-rotate-45"></i></span>
												</td>
											</tr>
											<c:forEach items="${kmCarmngApplicationForm.fdPathForms}"
												var="kmCarmngPathForm" varStatus="vstatus">
												<tr KMSS_IsContentRow="1">
													<td width="15%">
														<div class="dest">
															<input type="hidden"
																name="fdPathForms[${vstatus.index}].fdId"
																value="${kmCarmngPathForm.fdId}" /> <input
																type="hidden"
																name="fdPathForms[${vstatus.index}].fdApplicationId"
																value="${kmCarmngApplicationForm.fdId}" /> <span>
																<c:if test="${hasSysAttend == true }">
																	<c:import url="/sys/attend/import/map_tag.jsp"
																		charEncoding="UTF-8">
																		<c:param name="propertyName"
																			value="fdPathForms[${vstatus.index}].fdDestination"></c:param>
																		<c:param name="propertyCoordinate"
																			value="fdPathForms[${vstatus.index}].fdDestinationCoordinate"></c:param>
																		<c:param name="propertyDetail"
																			value="fdPathForms[${vstatus.index}].fdDestinationDetail"></c:param>
																		<c:param name="mobile" value="true"></c:param>
																		<c:param name="required" value="true"></c:param>
																		<c:param name="placeholder"
																			value="km-carmng:kmCarmngApplication.fdDestination.pleaseInput"></c:param>
																		<c:param name="subject"
																			value="km-carmng:kmCarmngApplication.fdDestination"></c:param>
																		<c:param name="style" value="width:90%"></c:param>
																	</c:import>
																</c:if> <c:if test="${hasSysAttend == false }">
																	<xform:text
																		property="fdPathForms[${vstatus.index}].fdDestination"
																		required="true"
																		subject="${ lfn:message('km-carmng:kmCarmngApplication.fdDestination')}"
																		htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngApplication.fdDestination.pleaseInput') }'"
																		style="width:90%" />
																</c:if>
															</span>
														</div> <span class="optBtn delBtn" onclick="deleteVoteItem();"><i
															class="mui mui-addIco mui-rotate-45"></i></span>
													</td>
												</tr>
											</c:forEach>
										</table>
										<div class="vot_p">
											<div class="path_addopt" onclick="AddPathItem();">
												+
												<bean:message key="kmCarmngApplication.addPathItem"
													bundle="km-carmng" />
											</div>
										</div>
									</div>
								</td>
							<tr>
						</table>
						<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
							<!-- 用车人  -->
							<tr>
								<td>
									<%--用车人--%> <xform:address mobile="true" textarea="true"
										showStatus="edit" propertyId="fdUserPersonIds"
										propertyName="fdUserPersonNames" onValueChange="afterAddress"
										htmlElementProperties="id='fdUserPersonvalidate'"
										orgType="ORG_TYPE_PERSON" mulSelect="true"
										validators="validateusers"
										subject="${ lfn:message('km-carmng:kmCarmngApplication.fdUserPersons') }">
									</xform:address>
								</td>
							</tr>
							<tr>
								<td>
									<xform:checkbox property="fdNotifyPerson" mobile="true">
										<xform:enumsDataSource enumsType="kmCarmngDispatchersInfo_fdNotifyPerson"></xform:enumsDataSource>
									</xform:checkbox>
								</td>
							</tr>
							<tr>
								<td><xform:text style="width:95%" mobile="true"
										property="fdOtherUsers" showStatus="edit"
										onValueChange="afterPutOther();"
										htmlElementProperties="id='fdOtherUservalidate'  placeholder='${lfn:message('km-carmng:kmCarmngApplication.fdOtherUsers') } (${lfn:message('km-carmng:kmCarmngApplication.fdUserPersons.outer') })'"
										validators="validateusers maxLength(200)"
										subject="${ lfn:message('km-carmng:kmCarmngApplication.fdUserPersons') }" />
								</td>
							</tr>
							<!-- 随车人数  -->
							<tr>
								<td><xform:text showStatus="edit" mobile="true"
										property="fdUserNumber" required="true"
										validators="digits min(1)"
										htmlElementProperties="placeholder=''"
										subject="${ lfn:message('km-carmng:kmCarmngApplication.fdUserNumber') }" />
								</td>
							</tr>
						</table>
						<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<!-- 申请人  -->
								<td colspan="2"><xform:address isLoadDataDict="false" mobile="true"
										propertyId="fdApplicationPersonId"
										propertyName="fdApplicationPersonName"
										subject="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationPerson') }" onValueChange="selectDept(this);"  required="true"></xform:address>
								</td>
							</tr>
							<tr>
								<!-- 申请人电话  -->
								<td colspan="2"><xform:text property="fdApplicationPersonPhone"
										mobile="true" required="true" validators="phoneNumber"
										htmlElementProperties="placeholder=''"
										subject="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationPersonPhone') }" />
								</td>
							</tr>
							<tr>
								<td colspan="2"><xform:address isLoadDataDict="false"
										orgType="ORG_TYPE_DEPT" mobile="true"
										propertyId="fdApplicationDeptId"
										propertyName="fdApplicationDeptName"
										subject="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationDept') }" htmlElementProperties="id='fdApplicationPerson'"></xform:address>
								</td>
							</tr>
							<!-- 用车事由  -->
							<tr>
								<td colspan="2"><xform:text style="width:95%" mobile="true"
										property="fdApplicationReason"
										htmlElementProperties="placeholder=''"
										subject="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationReason') }" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									附件
								</td>
								<td>
									<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="attKmCarmngApplication"></c:param>
										<c:param name="fdModelName" value="com.landray.kmss.km.carmng.model.KmCarmngApplication" />
										<c:param name="formBeanName" value="kmCarmngApplicationForm" />
									</c:import> 
								</td>
							</tr>			
							<tr>
								<!-- 申请单编号  -->
								<td colspan="2"><xform:text property="fdNo" showStatus="readOnly"
										mobile="true"  
										htmlElementProperties="placeholder=''"
										subject="${ lfn:message('km-carmng:kmCarmngApplication.autoCreApplicationNum') }" />
								</td>
							</tr>
						</table>
					</div>
					<div data-dojo-type="mui/tabbar/TabBar" fixed="bottom"
						data-dojo-props='fill:"grid"'>
						<c:if test="${kmCarmngApplicationForm.method_GET=='add'}">
							<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit muiBarSaveDraftButton " 
							  	data-dojo-props='colSize:1,href:"javascript:if(validate())app_submit(\"save\",\"true\");",transition:"slide"'>
							  		<bean:message  key="button.savedraft"/>
							</li>
							<c:if test="${param.method=='add' }">
								<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext "
									data-dojo-props='colSize:2,href:"javascript:validate();",moveTo:"lbpmView",transition:"slide"'><bean:message
										key="kmCarmngApplication.create.button.next" bundle="km-carmng" /></li>
							</c:if>
							<c:if test="${param.method=='change' }">
								<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext "
									data-dojo-props='colSize:2,moveTo:"lbpmView",transition:"slide"'><bean:message
										key="kmCarmngApplication.create.button.next" bundle="km-carmng" /></li>
							</c:if>
						</c:if>
						<c:if test="${kmCarmngApplicationForm.method_GET=='edit'}">
							<c:if test="${kmCarmngApplicationForm.docStatus eq '10' or kmCarmngApplicationForm.docStatus eq '11'}">
								<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit muiBarSaveDraftButton " 
								  	data-dojo-props='colSize:1,href:"javascript:if(validate())app_submit(\"update\",\"true\");",transition:"slide"'>
								  		<bean:message  key="button.savedraft"/>
								</li>
							</c:if>
							<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext "
								data-dojo-props='colSize:2,moveTo:"lbpmView",transition:"slide"'><bean:message
									key="kmCarmngApplication.create.button.next" bundle="km-carmng" /></li>
						</c:if>
					</div>
				</div>
				<c:import url="/sys/lbpmservice/mobile/import/edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmCarmngApplicationForm" />
					<c:param name="fdKey" value="KmCarmngApplicationDoc" />
					<c:param name="viewName" value="lbpmView" />
					<c:param name="backTo" value="scrollView" />
					<c:param name="onClickSubmitButton" value="app_submit('save','false');" />
				</c:import>
			</html:form>
		</xform:config>
	</template:replace>
</template:include>
