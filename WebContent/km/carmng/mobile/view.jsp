<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.km.carmng.forms.KmCarmngDispatchersInfoListForm"%>
<%@page import="com.landray.kmss.km.carmng.service.IKmCarmngInfomationService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<template:include ref="mobile.view" compatibleMode="true">
    <template:replace name="head">
		<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/km/carmng/mobile/css/view.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" href="${LUI_ContextPath}/km/carmng/mobile/css/carlist.css?s_cache=${MUI_Cache}" />
		<script type="text/javascript">
		require(["dojo/store/Memory","dojo/topic"],function(Memory, topic){
	   		window._narStore = new Memory({data:[{'text':'<bean:message bundle="sys-mobile" key="mui.mobile.info" />',
	   			'moveTo':'_contentView','selected':true},{'text':'<bean:message bundle="sys-mobile" key="mui.mobile.review.record" />',
	   			'moveTo':'_noteView'}]});
	   		topic.subscribe("/mui/navitem/_selected",function(evtObj){
	   			setTimeout(function(){topic.publish("/mui/list/resize");},150);
	   		});
	   	});
	</script>
	</template:replace>
	<template:replace name="loading">
			<c:import url="/km/carmng/mobile/view_banner.jsp"
				charEncoding="UTF-8">
				<c:param name="_formName" value="kmCarmngApplicationForm"></c:param>
				<c:param name="loading" value="true"></c:param>
			</c:import>
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmCarmngApplicationForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
		<div id="scrollView" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
			<c:import url="/km/carmng/mobile/view_banner.jsp" charEncoding="UTF-8">
				<c:param name="_formName" value="kmCarmngApplicationForm"></c:param>
			</c:import>
			<input type="hidden" name="fdStartTime" value="${kmCarmngApplicationForm.fdStartTime}"/>
			<input type="hidden" name="fdEndTime" value="${kmCarmngApplicationForm.fdEndTime}"/>
						
			<div data-dojo-type="mui/fixed/Fixed" id="fixed">
				<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowFixedItem">
					<div data-dojo-type="mui/nav/NavBarStore"
						data-dojo-props="store:_narStore"></div>
				</div>
			</div>
				<div data-dojo-type="dojox/mobile/View" id="_contentView">
				<!-- 用车申请行程单 Starts -->
						<div class="muiTravelSheet">
							<div class="travelSheetTime">
								<div class="travelSheetTimeItem">
									<p class="title"><bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseStartTime" /></p>
									<p class="time" name="startTime"></p>
									<p class="date" name="startDate"></p>
								</div>
								<div class="travelSheetIcon"><i class="mui mui-down mui-rotate-270"></i></div>
								<div class="travelSheetTimeItem">
									<p class="title"><bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseEndTime" /></p>
									<p class="time" name="endTime"></p>
									<p class="date" name="endDate"></p>
								</div>
							</div>
							<div class="muiTravelWay">
								<c:set var="hasSysAttend" value="false"></c:set>
								<kmss:ifModuleExist path="/sys/attend">
									<c:set var="hasSysAttend" value="true"></c:set>
								</kmss:ifModuleExist>
								<c:choose>
								 	<c:when test="${not empty kmCarmngApplicationForm.fdDeparture and not empty kmCarmngApplicationForm.fdDestination}">
									<ul>
										<li>
											<div class="dest">
											<span>
											<c:if test="${hasSysAttend == true }">
											<c:import url="/km/carmng/mobile/import/map_tag.jsp" charEncoding="UTF-8">
												<c:param name="propertyName" value="fdDeparture"></c:param>
												<c:param name="propertyCoordinate" value="fdDepartureCoordinate"></c:param>
												<c:param name="propertyDetail" value="fdDepartureDetail"></c:param>
												<c:param name="nameValue" value="${kmCarmngApplicationForm.fdDeparture}"></c:param>
												<c:param name="coordinateValue" value="${kmCarmngApplicationForm.fdDepartureCoordinate}"></c:param>
												<c:param name="detailValue" value="${kmCarmngApplicationForm.fdDepartureDetail}"></c:param>
												<c:param name="mobile" value="true"></c:param>
											</c:import>
											</c:if>
											<c:if test="${hasSysAttend == false }">
												<c:out value="${kmCarmngApplicationForm.fdDeparture}"></c:out>
											</c:if>
											（<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDeparture" />）
											</span>
											</div>
											<div class="detail"><span><c:out value="${kmCarmngApplicationForm.fdDepartureDetail}"></c:out></span></div>
										</li>
										<li>
											<div class="dest">
											<span>
											<c:if test="${hasSysAttend == true }">
											<c:import url="/km/carmng/mobile/import/map_tag.jsp" charEncoding="UTF-8">
												<c:param name="propertyName" value="fdDestination"></c:param>
												<c:param name="propertyCoordinate" value="fdDestinationCoordinate"></c:param>
												<c:param name="propertyDetail" value="fdDestinationDetail"></c:param>
												<c:param name="nameValue" value="${kmCarmngApplicationForm.fdDestination}"></c:param>
												<c:param name="coordinateValue" value="${kmCarmngApplicationForm.fdDestinationCoordinate}"></c:param>
												<c:param name="detailValue" value="${kmCarmngApplicationForm.fdDestinationDetail}"></c:param>
												<c:param name="mobile" value="true"></c:param>
											</c:import>
											</c:if>
											<c:if test="${hasSysAttend == false }">
												<c:out value="${kmCarmngApplicationForm.fdDestination}"></c:out>
											</c:if>
											<c:choose>
											<c:when test="${fn:length(kmCarmngApplicationForm.fdPathForms)>0}">
												（<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDestination" />1）
											</c:when>
											<c:otherwise>
												（<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDestination" />）
											</c:otherwise>
											</c:choose>
											</span>
											</div>
											<div class="detail"><span><c:out value="${kmCarmngApplicationForm.fdDestinationDetail}"></c:out></span></div>
										</li>
										<c:forEach items="${kmCarmngApplicationForm.fdPathForms}"  var="kmCarmngPathForm" varStatus="vstatus">
											<li>
												<div class="dest">
												<span>
												<c:if test="${hasSysAttend == true }">
												<c:import url="/km/carmng/mobile/import/map_tag.jsp" charEncoding="UTF-8">
													<c:param name="propertyName" value="fdDestination"></c:param>
													<c:param name="propertyCoordinate" value="fdDestinationCoordinate"></c:param>
													<c:param name="propertyDetail" value="fdDestinationDetail"></c:param>
													<c:param name="nameValue" value="${kmCarmngPathForm.fdDestination}"></c:param>
													<c:param name="coordinateValue" value="${kmCarmngPathForm.fdDestinationCoordinate}"></c:param>
													<c:param name="detailValue" value="${kmCarmngPathForm.fdDestinationDetail}"></c:param>
													<c:param name="mobile" value="true"></c:param>
												</c:import>
												</c:if>
												<c:if test="${hasSysAttend == false }">
													<c:out value="${kmCarmngPathForm.fdDestination}"></c:out>
												</c:if>
												（<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDestination" />${vstatus.index+2}）
												</span>
												</div>
												<div class="detail"><span><c:out value="${kmCarmngPathForm.fdDestinationDetail}"></c:out></span></div>
											</li>
										</c:forEach>
									</ul>
									</c:when>
									<c:otherwise>
										<ul>
											<li>
												<div class="dest"><span><c:out value="${kmCarmngApplicationForm.fdApplicationPath}"></c:out></span></div>
											</li>
										</ul>
								 	</c:otherwise>
								 </c:choose>
							</div>
						</div>
						<!-- 用车申请行程单 Ends -->
					<div class="muiFormContent  muiCarEditWrap">
						<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.fdMotorcadeId" />
								</td><td>
									<xform:text property="fdMotorcadeName" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.fdUserPersons" />
								</td><td>
									<c:out value="${kmCarmngApplicationForm.fdUserPersonNames}"></c:out>
									<c:if test="${not empty kmCarmngApplicationForm.fdOtherUsers}">
									  &nbsp;<c:out value="${kmCarmngApplicationForm.fdOtherUsers}"></c:out>
									</c:if>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.fdUserNumber" />
								</td><td>
									<xform:text property="fdUserNumber" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationReason" />
								</td><td>
									<xform:text property="fdApplicationReason" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="attKmCarmngApplication" />
										<c:param name="formName" value="kmCarmngApplicationForm" />
									</c:import> 
								</td>
							</tr>
						</table>
						<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationPerson" />
								</td><td>
									<xform:text property="fdApplicationPersonName" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationPersonPhone" />
								</td><td>
									<xform:text property="fdApplicationPersonPhone" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationDept" />
								</td><td>
									<xform:text property="fdApplicationDeptName" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.docCreatorId" />
								</td><td>
									<xform:text property="docCreatorName" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.docCreateTime" />
								</td><td>
									<xform:text property="docCreateTime" mobile="true"/>
								</td>
							</tr>
						</table>
					</div>
						<div class="detailInfo_wrapper">
					<div class="detailInfo">
						<c:if test="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm != null }">
							<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
		 					  data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"cardDispatchInfoView",transitionDir:1,transition:"slide"'>
		 					  ${ lfn:message('km-carmng:kmCarmngDispatchersInfo.view.info') }
		 					</div>
						 </c:if>
					 </div>
					 <c:if test="${kmCarmngApplicationForm.kmCarmngEvaluationForm != null }">
						 <div class="detailInfo">
								<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
				 					data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"evaluationInfoView",transitionDir:1,transition:"slide"'>评价信息</div>
						 </div>
					 </c:if>
<%-- 					 <div class="detailInfo">
							<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
			 					data-dojo-props='icon:"mui mui-flowRecord",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"workFlowView",transitionDir:1,transition:"slide"'><bean:message  bundle="km-carmng" key="mui.process.records"/></div>
					</div> --%>
				</div>
				</div>
		<div data-dojo-type="dojox/mobile/View" id="_noteView">
				<div class="muiFormContent muiFlowInfoW">
				    <c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
						<c:param name="fdModelId" value="${kmCarmngApplicationForm.fdId }"/>
						<c:param name="fdModelName" value="com.landray.kmss.km.carmng.model.KmCarmngApplication"/>
						<c:param name="formBeanName" value="kmCarmngApplicationForm"/>
					</c:import>
			   </div>
			</div>
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
							editUrl="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=edit&fdId=${param.fdId}"
							formName="kmCarmngApplicationForm"
							viewName="lbpmView"
							allowReview="true">
				<template:replace name="publishArea">
					<% pageContext.setAttribute("_colSize",3); %>
					<c:if test="${kmCarmngApplicationForm.docStatus == '30' &&  kmCarmngApplicationForm.fdIsDispatcher==1}">
						<kmss:auth requestURL="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=add&fdAppId=${param.fdId}" requestMethod="GET">
							<li class="muiBtnNext" data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props='colSize:2,transition:"slide",icon1:""' onclick="onDispatcherPost()">
								<bean:message  bundle="km-carmng" key="kmCarmng.button8"/>		
							</li>
						<% pageContext.setAttribute("_colSize",1); %>
						</kmss:auth>
					</c:if>
					<c:if test="${kmCarmngApplicationForm.docStatus == '30' &&  kmCarmngApplicationForm.fdIsDispatcher==4}">
						 <c:import url="/km/carmng/mobile/evaluation/evaluation.jsp" charEncoding="UTF-8">
						 	<c:param name="fdApplicationId" value="${kmCarmngApplicationForm.fdId}"></c:param>
						 </c:import>
						 <% pageContext.setAttribute("_colSize",1); %>
					</c:if>
				</template:replace>			
			</template:include>
		</div>
		
		<!-- 钉钉图标 -->
		<kmss:ifModuleExist path="/third/ding">
			<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmCarmngApplicationForm" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/lding">
			<c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmCarmngApplicationForm" />
			</c:import>
		</kmss:ifModuleExist>
		<!-- 钉钉图标 end -->
		
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmCarmngApplicationForm" />
			<c:param name="fdKey" value="mainDoc" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
		</c:import>
	    <div id='cardDispatchInfoView' data-dojo-type="dojox/mobile/View">
		  <div class="muiHeaderBasicInfo" data-dojo-type="mui/header/Header" fixed="top" data-dojo-props="height:'4rem'" style="background: #46a1ff;">
			<div class="muiHeaderBasicInfoTitle">${ lfn:message('km-carmng:kmCarmng.tree.dispatcher2') }</div>
			<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this)">
				<i class="mui mui-close"></i>
			</div>
		  </div>
		  <c:choose>
			<c:when test="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersType == '1' }">
				<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
					<tr>
						<td class="muiTitle"><bean:message  bundle="km-carmng" key="kmCarmngDispatchersLog.fdRemark"/></td>
						<td>${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRemark }</td>
					</tr>
				</table>
			</c:when>
			<c:otherwise>
		  <div style="margin-left:1rem;"  data-dojo-type="dojox/mobile/ScrollableView">
			<div class="muiFormContent">
				<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
					<tr>
							<td colspan="2" class="muiCar">
								<!-- 车辆信息  Starts -->
								<div class="muiCarInfoCard">
									<ul>	
										<%
											IKmCarmngInfomationService kmCarmngInfomationService= (IKmCarmngInfomationService)SpringBeanUtil.getBean("kmCarmngInfomationService");
										%>
										<c:forEach items="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm}"  var="dispatchersInfoListForm" varStatus="vstatus">
											<%  Object basedocObj = pageContext.getAttribute("dispatchersInfoListForm");
											   if(basedocObj != null) { 
												   KmCarmngDispatchersInfoListForm kmCarmngDispatchersInfoListForm = (KmCarmngDispatchersInfoListForm)basedocObj;
													String ids = kmCarmngInfomationService.getCarPicIdsByCarId(kmCarmngDispatchersInfoListForm.getFdCarInfoId());
													String attPath = request.getContextPath()+"/km/carmng/mobile/js/list/item/defaulthead.jpg";
													if(StringUtil.isNotNull(ids)){
														attPath = request.getContextPath()+"/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId="+ids.split(";")[0];
													}
													request.setAttribute("attPath", attPath);
												}
									        %>
											<li>
												<a href="javascript:void(0;)">
													<div class="muiCarInfoDetail">
														<div class="muiCarInfoImg"><img src="${attPath}" alt="" /></div>
														<div class="muiCarInfoList">
															<dl>
																<dt><span><c:out value="${dispatchersInfoListForm.fdCarInfoName}"/></span><em>(<c:out value="${dispatchersInfoListForm.fdCarInfoSeatNumber}"/><bean:message  bundle="km-carmng" key="kmCarmngInfomation.seat"/>)</em></dt>
																<dd><em><bean:message  bundle="km-carmng" key="kmCarmngInfomation.carNo"/>：</em><span><c:out value="${dispatchersInfoListForm.fdCarInfoNo}"/></span></dd>
																<dd><em><bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdMotorcade"/>：</em><span><c:out value="${dispatchersInfoListForm.fdMotorcadeName}"/></span></dd>
															</dl>
														</div>
													</div>
													<span class="muiCarInfoContact" onclick="dialPhone('${dispatchersInfoListForm.fdRelationPhone}')">
														<span class="muiCarInfoContactIco"><i class="mui mui-tel"></i></span>
														<p><span><c:out value="${dispatchersInfoListForm.fdDriverName}"/></span></p>
													</span>
												</a>
												<c:if test="${dispatchersInfoListForm.kmCarmngRegisterInfoForm != null}">
											 	<kmss:auth requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=viewRegister&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}&fdAppId=${kmCarmngApplicationForm.fdId }" requestMethod="GET">
													<div onclick="openRegisterInfo('${dispatchersInfoListForm.kmCarmngRegisterInfoForm.fdId}');" style="padding:0 10px">
										                <div style="background-color:#46a1ff;line-height:3rem;text-align: center;border-top:1px solid #e2e2e2;color:#fff"><i class="mui mui-bookViewDetail"></i><bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.view.info"/></div>
										            </div>
										         </kmss:auth>
									            </c:if>
											</li>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
					<tr>
					<td class="muiTitle">
						<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdApplicationIds" />
					</td>
					<td>
						<c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdApplicationNames}" />
					</td>
				</tr>
				<tr>
					<td class="muiTitle">
						<bean:message 	bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime" />
					</td>
					<td>
						<c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdStartTime}" />
					</td>
				</tr>
				<tr>
					<td class="muiTitle">
						<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime" />
					</td>
					<td>
						<c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdEndTime}" />
					</td>
				</tr>
				<tr>
					<td class="muiTitle">
						<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator" />
					</td>
					<td>
						<c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreatorName}" />
					</td>
				</tr>
				<tr>
					<td class="muiTitle">
						<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime" />
					</td>
					<td>
						<c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreateTime}" />
					</td>
				</tr>
			</table>
			</div>
		 </div>
		 </c:otherwise>
		 </c:choose>
   	 </div>
	 <c:if test="${kmCarmngApplicationForm.kmCarmngEvaluationForm != null }">
	 <div id='evaluationInfoView' data-dojo-type="dojox/mobile/View">
	    <div class="muiHeaderBasicInfo" data-dojo-type="mui/header/Header" fixed="top" data-dojo-props="height:'4rem'">
			<div class="muiHeaderBasicInfoTitle">${ lfn:message('km-carmng:table.kmCarmngEvaluation') }</div>
			<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this)">
				<i class="mui mui-close"></i>
			</div>
		</div>
		
		<div style="margin-left:1rem;"  data-dojo-type="dojox/mobile/ScrollableView">
			<div class="muiFormContent">
				<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
					<tr>
						<td class="muiTitle">
							<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdAppNames"/>
						</td><td>
							<c:out value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdApplicationName}" />
						</td>
					</tr>
					<tr>
						<td class="muiTitle">
							<bean:message bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationScore" />
						</td><td>
							<div class="muiFieldItem edit">
								<div class="muiFieldValue">
									<!-- 满意度 -->
									<div class="muiCarRateInfo">
										<em class="muiCarRateTitle">
											<sunbor:enumsShow value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluationScore}" bundle="km-carmng" enumsType="kmCarmngEvaluation_score" />	
										</em>
										<div class="muiRating" style="position: relative;">
											<div class="muiRatingArea">
												<i class="mui mui-star-off mui-2 muiRatingOff" score="1"></i>
												<i class="mui mui-star-off mui-2 muiRatingOff" score="2"></i>
												<i class="mui mui-star-off mui-2 muiRatingOff" score="3"></i>
												<i class="mui mui-star-off mui-2 muiRatingOff" score="4"></i>
												<i class="mui mui-star-off mui-2 muiRatingOff" score="5"></i>
											</div>
											<div class="muiRatingValue" style="width: ${(kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluationScore)*2}0%;">
												<i class="mui mui-star-on mui-2 muiRatingOn" score="1"></i>
												<i class="mui mui-star-on mui-2 muiRatingOn" score="2"></i>
												<i class="mui mui-star-on mui-2 muiRatingOn" score="3"></i>
												<i class="mui mui-star-on mui-2 muiRatingOn" score="4"></i>
												<i class="mui mui-star-on mui-2 muiRatingOn" score="5"></i>
											</div>
										</div>
									</div>
								</div>
							</div>
						</td>
					</tr>			
					<tr>
						<td class="muiTitle">
							<bean:message bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationContent" />
						</td><td>
							<c:out value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluationContent}" />
						</td>
					</tr>			
					<tr>
						<td class="muiTitle">
							<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluator"/>
						</td><td>
							<c:out value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluatorName}" />
						</td>
					</tr>
					<tr>
						<td class="muiTitle">
							<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationTime"/>
						</td><td>
							<c:out value="${kmCarmngApplicationForm.kmCarmngEvaluationForm.fdEvaluationTime}" />
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	</c:if>
	</template:replace>
</template:include>
<script>


	require(['dojo/topic','dojo/ready','dijit/registry','dojox/mobile/TransitionEvent',"mui/util",'dojo/query','mui/device/adapter'],
			function(topic,ready,registry,TransitionEvent,util,query,adapter){
		ready(function(){	
			var startDateStr = query('[name="fdStartTime"]')[0].value;
			var endDateStr = query('[name="fdEndTime"]')[0].value;
			
			
			
			if(startDateStr){
				//设置开始时间
				var startDateArr = startDateStr.split(" ");
				query('[name="startDate"]')[0].innerHTML = startDateArr[0];
				query('[name="startTime"]')[0].innerHTML = startDateArr[1];
			}
			if(endDateStr){
				//设置结束时间
				var endDateArr = endDateStr.split(" ");
				query('[name="endDate"]')[0].innerHTML = endDateArr[0];
				query('[name="endTime"]')[0].innerHTML = endDateArr[1];
			}
		});
		
			//解决苹果端直接读取页面缓存，导致页面不能最新结果
			window.onpageshow = function(event) {
			　　if (event.persisted) {
			　　　　window.location.reload() 
			　　}
			};
		
			window.openRegisterInfo = function(fdId){
				var url =  "/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=view&fdId=" + fdId;
				adapter.open(util.formatUrl(url,true),"_blank");
			};
			window.register = function(fdId){
				var url =  "/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId=" + fdId;
				adapter.open(util.formatUrl(url,true),"_blank");
			};
			
			window.dialPhone=function(mobileNo){
				if(mobileNo){
					//window.open('tel:'+mobileNo); 
					var url = 'tel://'+mobileNo;
					adapter.open(url,"_blank");
				}else{
					Tip.fail({
						text:'<bean:message bundle="km-carmng"  key="kmCarmng.message.phone.notnull"/>'
					});
				}
			};
		
			//返回主视图
			window.backToDocView=function(obj){
				var opts = {
					transition : 'slide',
					transitionDir:-1,
					moveTo:'scrollView'
				};
				new TransitionEvent(obj, opts).dispatch();
				
			};
			//跳到调度页面
			window.onDispatcherPost = function(){
				var href = "/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=add&fdAppId=${param.fdId}";
				setTimeout(function(){
					location.href = util.formatUrl(href);
				},350);
			};
		    window.doEvaluate = function(){
			  
		    }
	});
</script>