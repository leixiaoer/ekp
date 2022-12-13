<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
		<p class="txttitle">
			<bean:message bundle="km-carmng" key="table.kmCarmngApplication" />
		</p>
		<div style="background: #fff; padding: 16px;">
			<html:form
				action="/km/carmng/km_carmng_application/kmCarmngApplication.do">
				<html:hidden name="kmCarmngApplicationForm" property="fdId" />
				<html:hidden property="method_GET" />
				<input type="hidden" name="List_Selected"
					value="${kmCarmngApplicationForm.fdId}" />
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngApplication.fdMotorcadeId" /></td>
						<td width=35%><c:out
								value="${kmCarmngApplicationForm.fdMotorcadeName}" /></td>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngApplication.docSubject" /></td>
						<td width=35%><c:out
								value="${kmCarmngApplicationForm.docSubject}" /></td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngApplication.fdApplicationPerson" />
						</td>
						<td width=35%><c:out
								value="${kmCarmngApplicationForm.fdApplicationPersonName}" /></td>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng"
								key="kmCarmngApplication.fdApplicationPersonPhone" /></td>
						<td width=35%><c:out
								value="${kmCarmngApplicationForm.fdApplicationPersonPhone}" /></td>
					</tr>

					<tr>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngUserFeeInfo.fdDeptIds" />
						</td>
						<td width=35%><c:out
								value="${kmCarmngApplicationForm.fdApplicationDeptName}" /></td>
						<%--申请单编号--%>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngApplication.fdNo" /></td>
						<td width="35%"><c:choose>
								<c:when test='${kmCarmngApplicationForm.fdNo!=null}'>
									<xform:text property="fdNo" style="width:85%" />
								</c:when>
								<c:otherwise>
									<bean:message bundle="km-carmng"
										key="kmCarmngApplication.autoCreate" />
								</c:otherwise>
							</c:choose></td>
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
								<c:choose>
									<c:when
										test="${not empty kmCarmngApplicationForm.fdDeparture and not empty kmCarmngApplicationForm.fdDestination}">
										<table style="width: 100%">
											<tr>
												<td class="td_title" width="15%"><bean:message
														bundle="km-carmng" key="kmCarmngApplication.fdDeparture" />
												</td>
												<td><c:if test="${hasSysAttend == true }">
														<c:import url="/sys/attend/import/map_tag.jsp"
															charEncoding="UTF-8">
															<c:param name="propertyName" value="fdDeparture"></c:param>
															<c:param name="propertyCoordinate"
																value="fdDepartureCoordinate"></c:param>
															<c:param name="propertyDetail" value="fdDepartureDetail"></c:param>
														</c:import>
													</c:if> <c:if test="${hasSysAttend == false }">
														<xform:text property="fdDeparture" />
													</c:if></td>
											</tr>
											<tr>
												<td class="td_title" width="15%"><bean:message
														bundle="km-carmng" key="kmCarmngApplication.fdDestination" />
												</td>
												<td><c:if test="${hasSysAttend == true }">
														<c:import url="/sys/attend/import/map_tag.jsp"
															charEncoding="UTF-8">
															<c:param name="propertyName" value="fdDestination"></c:param>
															<c:param name="propertyCoordinate"
																value="fdDestinationCoordinate"></c:param>
															<c:param name="propertyDetail"
																value="fdDestinationDetail"></c:param>
														</c:import>
													</c:if> <c:if test="${hasSysAttend == false }">
														<xform:text property="fdDestination" />
													</c:if></td>
											</tr>
											<c:forEach items="${kmCarmngApplicationForm.fdPathForms}"
												var="kmCarmngPathForm" varStatus="vstatus">
												<tr>
													<td></td>
													<td><c:if test="${hasSysAttend == true }">
															<c:import url="/sys/attend/import/map_tag.jsp"
																charEncoding="UTF-8">
																<c:param name="propertyName"
																	value="fdPathForms[${vstatus.index}].fdDestination"></c:param>
																<c:param name="propertyCoordinate"
																	value="fdPathForms[${vstatus.index}].fdDestinationCoordinate"></c:param>
																<c:param name="propertyDetail"
																	value="fdPathForms[${vstatus.index}].fdDestinationDetail"></c:param>
															</c:import>
														</c:if> <c:if test="${hasSysAttend == false }">
															<xform:text
																property="fdPathForms[${vstatus.index}].fdDestination" />
														</c:if></td>
												</tr>
											</c:forEach>
										</table>
									</c:when>
									<c:otherwise>
										<xform:text property="fdApplicationPath" style="width:99%" />
									</c:otherwise>
								</c:choose>
							</div>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseStartTime" /></td>
						<td width=35%><c:out
								value="${kmCarmngApplicationForm.fdStartTime}" /></td>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseEndTime" /></td>
						<td width=35%><c:out
								value="${kmCarmngApplicationForm.fdEndTime}" /></td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngApplication.fdUserPersons" /></td>
						<td width="85%" colspan="3" style="word-break: break-all">
							<!-- 用车人 --> <c:if
								test="${ not empty kmCarmngApplicationForm.fdUserPersonNames }">
								<div style="padding-bottom: 8px">
									<img
										src="${LUI_ContextPath}/km/carmng/resource/images/inner_person.png" />
									<span style="vertical-align: top;"> <bean:message
											bundle="km-carmng" key="kmCarmngApplication.fdInnerPerson" />
										<c:out value="${kmCarmngApplicationForm.fdUserPersonNames }"></c:out>
									</span>
								</div>
							</c:if> <%-- 外部用车人  --%> <c:if
								test="${ not empty kmCarmngApplicationForm.fdOtherUsers }">
								<div>
									<img
										src="${LUI_ContextPath}/km/carmng/resource/images/other_person.png" />
									<span style="vertical-align: top;"> <bean:message
											bundle="km-carmng" key="kmCarmngApplication.fdOtherPerson" />
										<c:out value="${kmCarmngApplicationForm.fdOtherUsers }"></c:out>
									</span>
								</div>
							</c:if>
							<xform:checkbox property="fdNotifyPerson" showStatus="view">
								<xform:enumsDataSource enumsType="kmCarmngDispatchersInfo_fdNotifyPerson"></xform:enumsDataSource>
							</xform:checkbox>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngApplication.fdUserNumber" /></td>
						<td width=35% colspan="3"><c:out
								value="${kmCarmngApplicationForm.fdUserNumber}" /></td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngApplication.fdApplicationReason" />
						</td>
						<td width=35% colspan="3"><kmss:showText
								value="${kmCarmngApplicationForm.fdApplicationReason}" /></td>
					</tr>
					<tr>
						<%-- 文档附件 --%>
						<td width="11%" class="td_normal_title"><bean:message  bundle="km-carmng" key="kmCarmngApplication.attachment"/></td>
						<td width="89%" colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="attKmCarmngApplication" />
							<c:param name="fdModelName" value="com.landray.kmss.km.carmng.model.KmCarmngApplication" />
							<c:param name="formBeanName" value="kmCarmngApplicationForm" />
						</c:import>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngApplication.docCreatorId" /></td>
						<td width=35%><c:out
								value="${kmCarmngApplicationForm.docCreatorName}" /></td>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngApplication.docCreateTime" /></td>
						<td width=35%><c:out
								value="${kmCarmngApplicationForm.docCreateTime}" /></td>
					</tr>
				</table>
			</html:form>
		</div>
		<c:choose> 
				<c:when test="${param.approveModel eq 'right'}">
					<c:if
				test="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm != null }">
				<ui:content title="${ lfn:message('km-carmng:kmCarmng.config.info') }">
					<c:choose>
						<c:when test="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersType == '1' }">
							<table class="tb_simple" width=100%>
								<tr>
									<td><bean:message bundle="km-carmng" key="kmCarmngDispatchersLog.fdRemark"/></td>
								</tr>
								<tr>
									<td style="background-color: #c7c7c7;">${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRemark }</td>
								</tr>
							</table>
						</c:when>
						<c:otherwise>
						<table class="tb_simple" width=100%>
							<tr>
								<td colspan="4">
									<div class="lui_carmng_dispatch_wrap checkIn_wrap">
										<div class="lui_carmng_dispatch_content" id="carlistTB">
											<c:forEach
												items="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm}"
												var="dispatchersInfoListForm" varStatus="vstatus">
												<div class="lui_carmng_dispatch_carCard"
													id="${dispatchersInfoListForm.fdCarInfoId}">
													<p class="car_plate">
														<xform:text
															property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoNo"
															showStatus="view"
															value="${dispatchersInfoListForm.fdCarInfoNo}" />
													</p>
													<ul>
														<li><xform:text
																property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoName"
																showStatus="view"
																value="${dispatchersInfoListForm.fdCarInfoName}" /> （<xform:text
																property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoSeatNumber"
																showStatus="view"
																value="${dispatchersInfoListForm.fdCarInfoSeatNumber}" />
															<bean:message bundle="km-carmng" key="kmCarmngInfomation.seat"/>）</li>
														<li><xform:text
																property="fdDispatchersInfoListForm[${vstatus.index}].fdMotorcadeName"
																showStatus="view"
																value="${dispatchersInfoListForm.fdMotorcadeName}" /></li>
														<li>
															<p class="driver">
																<xform:text
																	property="fdDispatchersInfoListForm[${vstatus.index}].fdDriverName"
																	value="${dispatchersInfoListForm.fdDriverName}" />
															</p>
															<p class="phone">
																<xform:text
																	property="fdDispatchersInfoListForm[${vstatus.index}].fdRelationPhone"
																	value="${dispatchersInfoListForm.fdRelationPhone}" />
															</p>
														</li>
													</ul>
													<kmss:auth
														requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}"
														requestMethod="GET">
														<c:if test="${dispatchersInfoListForm.fdFlag != '1'}">
															<a href="javascript:void(0)" class="btn_checkIn"
																onclick="Com_OpenWindow('${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}','_self');">${lfn:message('km-carmng:kmCarmng.button5')}</a>
														</c:if>
													</kmss:auth>
													<kmss:auth
														requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=viewRegister&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}&fdAppId=${kmCarmngApplicationForm.fdId}"
														requestMethod="GET">
														<c:if test="${dispatchersInfoListForm.fdFlag == '1'}">
															<a href="javascript:void(0)" class="btn_checkIned"
																onclick="Com_OpenWindow('${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=view&fdId=${dispatchersInfoListForm.fdRegisterId}','_blank');"><bean:message bundle="km-carmng" key="kmCarmngInformation.dispatchersInfo"/></a>
														</c:if>
													</kmss:auth>
												</div>
											</c:forEach>
	
											<c:if
												test="${fn:length(kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm)  < 3}">
												<div class="lui_carmng_dispatch_info">
													<ul>
														<li><bean:message bundle="km-carmng"
																key="kmCarmngDispatchersInfo.fdStartTime" /> : <c:out
																value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdStartTime}" />
														</li>
														<li><bean:message bundle="km-carmng"
																key="kmCarmngDispatchersInfo.fdEndTime" /> : <c:out
																value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdEndTime}" />
														</li>
														<li><bean:message bundle="km-carmng"
																key="kmCarmngDispatchersInfo.fdRegisterId" /> : <c:out
																value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRegisterName}" />
														</li>
														<li><bean:message bundle="km-carmng"
																key="kmCarmngDispatchersInfo.docCreator" /> : <c:out
																value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreatorName}" />
														</li>
														<li><bean:message bundle="km-carmng"
																key="kmCarmngDispatchersInfo.docCreateTime" /> : <c:out
																value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreateTime}" />
														</li>
													</ul>
												</div>
											</c:if>
										</div>
									</div>
								</td>
							</tr>
						</table>
						<c:if
							test="${fn:length(kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm) > 2}">
							<table class="tb_normal" width=100%>
								<tr>
									<td class="td_normal_title" width=15%><bean:message
											bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime" /></td>
									<td width=35%><c:out
											value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdStartTime}" />
									</td>
									<td class="td_normal_title" width=15%><bean:message
											bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime" /></td>
									<td width=35%><c:out
											value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdEndTime}" />
									</td>
								</tr>
								<tr>
									<td class="td_normal_title" width=15%><bean:message
											bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRegisterId" />
									</td>
									<td width=85% colspan="3"><c:out
											value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRegisterName}" />
									</td>
								</tr>
								<tr>
									<td class="td_normal_title" width=15%><bean:message
											bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator" /></td>
									<td width=35%><c:out
											value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreatorName}" />
									</td>
									<td class="td_normal_title" width=15%><bean:message
											bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime" />
									</td>
									<td width=35%><c:out
											value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreateTime}" />
									</td>
								</tr>
							</table>
						</c:if>
						</c:otherwise>
						</c:choose>
				</ui:content>
			</c:if>
			<c:if
				test="${kmCarmngApplicationForm.kmCarmngEvaluationForm != null }">
				<ui:content
					title="${ lfn:message('km-carmng:table.kmCarmngEvaluation') }">
					<table class="tb_normal" width=100%>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngEvaluation.fdAppNames" /></td>
							<td width=85% colspan="3"><c:out
									value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdApplicationName}" />
							</td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationScore" />
							</td>
							<td width=85% colspan="3"><sunbor:enumsShow
									value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluationScore}"
									bundle="km-carmng" enumsType="kmCarmngEvaluation_score" /></td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationContent" />
							</td>
							<td width=85% colspan="3"><c:out
									value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluationContent}" />
							</td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluator" /></td>
							<td width=35%><c:out
									value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluatorName}" />
							</td>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationTime" />
							</td>
							<td width=35%><c:out
									value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluationTime}" />
							</td>
						</tr>
					</table>
				</ui:content>
			</c:if>
				</c:when>
		</c:choose>
			
		<c:choose> 
				<c:when test="${param.approveModel eq 'right'}">
				<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
					<c:choose>
						<c:when test="${kmCarmngApplicationForm.docStatus>='30' || kmCarmngApplicationForm.docStatus=='00'}">
							<!-- 流程 -->
							<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmCarmngApplicationForm" />
								<c:param name="fdKey" value="mainDoc" />
								<c:param name="showHistoryOpers" value="true" />
								<c:param name="isExpand" value="true" />
								<c:param name="approveType" value="right"></c:param>
								<c:param name="needInitLbpm" value="true" />
							</c:import>
						</c:when>
						<c:otherwise>
							<!-- 流程 -->
							<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmCarmngApplicationForm" />
								<c:param name="fdKey" value="mainDoc" />
								<c:param name="showHistoryOpers" value="true" />
								<c:param name="isExpand" value="true" />
								<c:param name="approveType" value="right"></c:param>
							</c:import>
						</c:otherwise>
					</c:choose>
					<%--权限机制 --%>
					<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
						<table class="tb_normal" width=100%>
							<td class="td_normal_title" width="15%"><bean:message
									bundle="sys-right" key="right.read.authReaders" /></td>
							<td width="85%"><c:if
									test="${empty kmCarmngApplicationForm.authReaderNames}">
									<bean:message bundle="sys-right" key="right.other.person" />
								</c:if> <c:if test="${not empty kmCarmngApplicationForm.authReaderNames}">
										${kmCarmngApplicationForm.authReaderNames}
									</c:if></td>
						</table>
					</ui:content>
				</ui:tabpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpage expand="false">
						<c:if
				test="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm != null }">
				<ui:content title="${ lfn:message('km-carmng:kmCarmng.config.info') }">
					<c:choose>
						<c:when test="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersType == '1' }">
							<table class="tb_simple" width=100%>
								<tr>
									<td><bean:message bundle="km-carmng" key="kmCarmngDispatchersLog.fdRemark"/></td>
								</tr>
								<tr>
									<td style="background-color: #c7c7c7;">${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRemark }</td>
								</tr>
							</table>
						</c:when>
						<c:otherwise>
						<table class="tb_simple" width=100%>
							<tr>
								<td colspan="4">
									<div class="lui_carmng_dispatch_wrap checkIn_wrap">
										<div class="lui_carmng_dispatch_content" id="carlistTB">
											<c:forEach
												items="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm}"
												var="dispatchersInfoListForm" varStatus="vstatus">
												<div class="lui_carmng_dispatch_carCard"
													id="${dispatchersInfoListForm.fdCarInfoId}">
													<p class="car_plate">
														<xform:text
															property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoNo"
															showStatus="view"
															value="${dispatchersInfoListForm.fdCarInfoNo}" />
													</p>
													<ul>
														<li><xform:text
																property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoName"
																showStatus="view"
																value="${dispatchersInfoListForm.fdCarInfoName}" /> （<xform:text
																property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoSeatNumber"
																showStatus="view"
																value="${dispatchersInfoListForm.fdCarInfoSeatNumber}" />
															<bean:message bundle="km-carmng" key="kmCarmngInfomation.seat"/>）</li>
														<li><xform:text
																property="fdDispatchersInfoListForm[${vstatus.index}].fdMotorcadeName"
																showStatus="view"
																value="${dispatchersInfoListForm.fdMotorcadeName}" /></li>
														<li>
															<p class="driver">
																<xform:text
																	property="fdDispatchersInfoListForm[${vstatus.index}].fdDriverName"
																	value="${dispatchersInfoListForm.fdDriverName}" />
															</p>
															<p class="phone">
																<xform:text
																	property="fdDispatchersInfoListForm[${vstatus.index}].fdRelationPhone"
																	value="${dispatchersInfoListForm.fdRelationPhone}" />
															</p>
														</li>
													</ul>
													<kmss:auth
														requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}"
														requestMethod="GET">
														<c:if test="${dispatchersInfoListForm.fdFlag != '1'}">
															<a href="javascript:void(0)" class="btn_checkIn"
																onclick="Com_OpenWindow('${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}','_self');">${lfn:message('km-carmng:kmCarmng.button5')}</a>
														</c:if>
													</kmss:auth>
													<kmss:auth
														requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=viewRegister&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}&fdAppId=${kmCarmngApplicationForm.fdId}"
														requestMethod="GET">
														<c:if test="${dispatchersInfoListForm.fdFlag == '1'}">
															<a href="javascript:void(0)" class="btn_checkIned"
																onclick="Com_OpenWindow('${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=view&fdId=${dispatchersInfoListForm.fdRegisterId}','_blank');"><bean:message bundle="km-carmng" key="kmCarmngInformation.dispatchersInfo"/></a>
														</c:if>
													</kmss:auth>
												</div>
											</c:forEach>
	
											<c:if
												test="${fn:length(kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm)  < 3}">
												<div class="lui_carmng_dispatch_info">
													<ul>
														<li><bean:message bundle="km-carmng"
																key="kmCarmngDispatchersInfo.fdStartTime" /> : <c:out
																value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdStartTime}" />
														</li>
														<li><bean:message bundle="km-carmng"
																key="kmCarmngDispatchersInfo.fdEndTime" /> : <c:out
																value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdEndTime}" />
														</li>
														<li><bean:message bundle="km-carmng"
																key="kmCarmngDispatchersInfo.fdRegisterId" /> : <c:out
																value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRegisterName}" />
														</li>
														<li><bean:message bundle="km-carmng"
																key="kmCarmngDispatchersInfo.docCreator" /> : <c:out
																value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreatorName}" />
														</li>
														<li><bean:message bundle="km-carmng"
																key="kmCarmngDispatchersInfo.docCreateTime" /> : <c:out
																value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreateTime}" />
														</li>
													</ul>
												</div>
											</c:if>
										</div>
									</div>
								</td>
							</tr>
						</table>
						<c:if
							test="${fn:length(kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm) > 2}">
							<table class="tb_normal" width=100%>
								<tr>
									<td class="td_normal_title" width=15%><bean:message
											bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime" /></td>
									<td width=35%><c:out
											value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdStartTime}" />
									</td>
									<td class="td_normal_title" width=15%><bean:message
											bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime" /></td>
									<td width=35%><c:out
											value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdEndTime}" />
									</td>
								</tr>
								<tr>
									<td class="td_normal_title" width=15%><bean:message
											bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRegisterId" />
									</td>
									<td width=85% colspan="3"><c:out
											value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRegisterName}" />
									</td>
								</tr>
								<tr>
									<td class="td_normal_title" width=15%><bean:message
											bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator" /></td>
									<td width=35%><c:out
											value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreatorName}" />
									</td>
									<td class="td_normal_title" width=15%><bean:message
											bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime" />
									</td>
									<td width=35%><c:out
											value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreateTime}" />
									</td>
								</tr>
							</table>
						</c:if>
						</c:otherwise>
						</c:choose>
				</ui:content>
			</c:if>
			<c:if
				test="${kmCarmngApplicationForm.kmCarmngEvaluationForm != null }">
				<ui:content
					title="${ lfn:message('km-carmng:table.kmCarmngEvaluation') }">
					<table class="tb_normal" width=100%>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngEvaluation.fdAppNames" /></td>
							<td width=85% colspan="3"><c:out
									value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdApplicationName}" />
							</td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationScore" />
							</td>
							<td width=85% colspan="3"><sunbor:enumsShow
									value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluationScore}"
									bundle="km-carmng" enumsType="kmCarmngEvaluation_score" /></td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationContent" />
							</td>
							<td width=85% colspan="3"><c:out
									value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluationContent}" />
							</td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluator" /></td>
							<td width=35%><c:out
									value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluatorName}" />
							</td>
							<td class="td_normal_title" width=15%><bean:message
									bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationTime" />
							</td>
							<td width=35%><c:out
									value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluationTime}" />
							</td>
						</tr>
					</table>
				</ui:content>
			</c:if>
						<%--流程机制 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp"
							charEncoding="UTF-8">
							<c:param name="formName" value="kmCarmngApplicationForm" />
							<c:param name="fdKey" value="mainDoc" />
						</c:import>
						<%--权限机制 --%>
						<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
							<table class="tb_normal" width=100%>
								<td class="td_normal_title" width="15%"><bean:message
										bundle="sys-right" key="right.read.authReaders" /></td>
								<td width="85%"><c:if
										test="${empty kmCarmngApplicationForm.authReaderNames}">
										<bean:message bundle="sys-right" key="right.other.person" />
									</c:if> <c:if test="${not empty kmCarmngApplicationForm.authReaderNames}">
											${kmCarmngApplicationForm.authReaderNames}
										</c:if></td>
							</table>
						</ui:content>
					</ui:tabpage>
				</c:otherwise>
			</c:choose>
		<script>
			seajs
					.use(
							[ 'lui/dialog' ],
							function(dialog) {
								window.doEvaluate = function() {
									var url = Com_GetCurDnsHost()
											+ Com_Parameter.ContextPath
											+ 'km/carmng/km_carmng_evaluation/kmCarmngEvaluation.do?method=add&fdAppId=${param.fdId}';
									dialog.iframe(url, '<bean:message bundle="km-carmng" key="kmCarmng.evaluate.title" />', function(rtn) {
										if (rtn != "cancel") {
											location.reload();
										}
									}, {
										width : 600,
										height : 350
									});
								};
							});
		</script>
	</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<c:choose>
				<c:when test="${kmCarmngApplicationForm.docStatus>='30' || kmCarmngApplicationForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/km/carmng/km_carmng_ui/kmCarmngMain_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmCarmngApplicationForm" />
							<c:param name="fdKey" value="mainDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmCarmngApplicationForm" />
							<c:param name="fdModelId" value="${kmCarmngApplicationForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.carmng.model.KmCarmngApplication" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/carmng/km_carmng_ui/kmCarmngMain_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
					</ui:tabpanel>
				</c:otherwise>
			</c:choose>
		</template:replace>
	</c:when>
</c:choose>