<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.km.carmng.forms.KmCarmngDispatchersInfoListForm"%>
<%@page import="com.landray.kmss.km.carmng.forms.KmCarmngDispatchersInfoForm"%>
<%@page import="com.landray.kmss.km.carmng.service.IKmCarmngInfomationService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-carmng:module.km.carmng') }"/>
	</template:replace>
	 <template:replace name="head">
		<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/km/carmng/mobile/css/view.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" href="${LUI_ContextPath}/km/carmng/mobile/css/carlist.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
		<div id="scrollView"  data-dojo-type="mui/view/DocScrollableView" class="gray">
			<div data-dojo-type="mui/panel/AccordionPanel">
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${ lfn:message('km-carmng:table.kmCarmngDispatchersInfo') }',icon:'mui-ul'">
					<div class="muiFormContent">
					<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
						<tr style="height: 3.5rem">
							<td class="muiTitle" colspan="2">
								<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.detail"/>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="muiCar">
								<c:choose>
								<c:when test="${kmCarmngDispatchersInfoForm.fdDispatchersType == '1' }">
									<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
										<tr>
											<td class="muiTitle">
												<bean:message  bundle="km-carmng" key="kmCarmngDispatchers.type"/>
											</td>
											<td>
												<bean:message  bundle="km-carmng" key="kmCarmngDispatchers.type.1"/>
											</td>
										</tr>
										<tr>
											<td class="muiTitle">
												<bean:message  bundle="km-carmng" key="kmCarmngDispatchersLog.fdRemark"/>
											</td>
											<td>
												<c:out value="${kmCarmngDispatchersInfoForm.fdRemark}" />
											</td>
										</tr>
									</table>
								</c:when>
								<c:otherwise>
								<!-- 车辆信息  Starts -->
								<div class="muiCarInfoCard">
									<ul>	
										<%
											IKmCarmngInfomationService kmCarmngInfomationService= (IKmCarmngInfomationService)SpringBeanUtil.getBean("kmCarmngInfomationService");
										%>
										<c:forEach items="${kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm}"  var="dispatchersInfoListForm" varStatus="vstatus">
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
													<kmss:auth requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=viewRegister&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}&fdAppId=${kmCarmngDispatchersInfoForm.fdApplicationIds}" requestMethod="GET">
													<div onclick="openRegisterInfo('${dispatchersInfoListForm.kmCarmngRegisterInfoForm.fdId}');" style="padding:0 10px">
										                <div style="background-color:#46a1ff;line-height:3rem;text-align: center;border-top:1px solid #e2e2e2;color:#fff"><i class="mui mui-bookViewDetail"></i><bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.view.info"/></div>
										            </div>
										            </kmss:auth>
									            </c:if>
											</li>
										</c:forEach>
									</ul>
								</div>
								</c:otherwise>
								</c:choose>
							</td>
						</tr>
						</table>
						<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-carmng" key="kmCarmngApplication.docSubject"/>
								</td><td>
									<c:out value="${kmCarmngDispatchersInfoForm.fdApplicationNames}" />
								</td>
							</tr>
							<c:if test="${kmCarmngDispatchersInfoForm.fdDispatchersType != '1' }">
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime" />
									</td><td>
										<xform:datetime	property="fdStartTime" mobile="true"/>
									</td>
								</tr>			
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime" />
									</td><td>
										<xform:datetime	property="fdEndTime" mobile="true"/>
									</td>
								</tr>
							</c:if>			
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRegisterId"/>
								</td><td>
									<c:out value="${kmCarmngDispatchersInfoForm.fdRegisterName}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator"/>
								</td><td>
									<c:out value="${kmCarmngDispatchersInfoForm.docCreatorName}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime" />
								</td><td>
									<xform:datetime	property="docCreateTime" mobile="true"/>
								</td>
							</tr>
						</table>
						 <c:if test="${appSize == 1 }">
						 <table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
						 	<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationPerson" />
								</td>
								<td>
									<div class="muiFieldItem edit">
										<div class="muiFieldValue" onclick="dialPhone('${kmCarmngApplicationForm.fdApplicationPersonPhone}')">
											<i class="mui mui-tel"></i>
											<span>${kmCarmngApplicationForm.fdApplicationPersonName}</span>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngApplication.fdUserNumber" />
								</td>
								<td><div class="muiFieldItem edit">
										<div class="muiFieldValue">
											<span>${kmCarmngApplicationForm.fdUserNumber}</span>
										</div>
									</div>
								</td>
							</tr>
							<tr>
									<td class="muiTitle" colspan="2" style="text-align:center">  
									 	<h3  style="font-weight: normal;font-size: 1.8rem;  ">
    										${kmCarmngApplicationForm.docSubject}</h3> 
									</td>
								</tr> 
							<tr>
								<td class="muiTitle" >
								<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationReason" />
								</td>
								<td> 
								<div class="muiFieldValue">
									<span>
										${kmCarmngApplicationForm.fdApplicationReason}
									</span>
								</div>
								</td>
							</tr> 
								<tr>
									<td class="muiCar" colspan="2">
									<!-- 用车申请行程单 Starts -->
									<div class="muiTravelSheet">
										<input type="hidden" name="fdStartTime" value="${kmCarmngApplicationForm.fdStartTime}"/>
										<input type="hidden" name="fdEndTime" value="${kmCarmngApplicationForm.fdEndTime}"/>  
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
										<ul class="travelSheetList">
											<c:set var="hasSysAttend" value="false"></c:set>
											<kmss:ifModuleExist path="/sys/attend">
												<c:set var="hasSysAttend" value="true"></c:set>
											</kmss:ifModuleExist>
											<c:choose>
											 	<c:when test="${not empty kmCarmngApplicationForm.fdDeparture and not empty kmCarmngApplicationForm.fdDestination}">
													<li>
														<div class="dest"><span>
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
														（<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDeparture" />）</span></div>
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
															（<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDestination" />${vstatus.index+2}）</span></div>
															<div class="detail"><span><c:out value="${kmCarmngPathForm.fdDestinationDetail}"></c:out></span></div>
														</li>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<li>
														<div class="dest"><span><c:out value="${kmCarmngApplicationForm.fdApplicationPath}"></c:out></span></div>
													</li>
											 	</c:otherwise>
											 </c:choose>
										</ul>
									</div>
									<!-- 用车申请行程单 Ends -->
								</td>
							</tr>
							</table>
						</c:if>
						 <c:if test="${appSize > 1 }">
							 <div>
								  <ul  data-dojo-type="mui/list/JsonStoreList"
							    	data-dojo-mixins="km/carmng/mobile/js/list/CarmngItemListMixin"
							    	data-dojo-props="url:'/km/carmng/km_carmng_application/kmCarmngApplication.do?method=listApplicationByIds&mobile=true&fdApplicationIds=${kmCarmngDispatchersInfoForm.fdApplicationIds}', lazy:false">
								  </ul>
							</div>
						 </c:if>
					</div>
				</div>
			</div>
			<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom"  data-dojo-props='fill:"grid"'>
				<%
					pageContext.setAttribute("_colSize",3);
				%>
				 <c:if test="${kmCarmngDispatchersInfoForm.fdFlag != '1' }">
				 	  <c:if test="${fn:length(authArr) > 1}">
				 	  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext"
					 		data-dojo-props='colSize:2,icon1:"",align:"center",moveTo:"carInfoView",transition:"slide"'>
							<bean:message bundle="km-carmng" key="kmCarmng.button5"/>
						</li>
						 <%
						    pageContext.setAttribute("_colSize",1);
						  %>
				 	  </c:if>
				 	  <c:if test="${fn:length(authArr)  == 1}">
					 	   	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext" onclick="recordCar();"
						 		data-dojo-props='colSize:2,icon1:"",align:"center"'>
								<bean:message bundle="km-carmng" key="kmCarmng.button5"/>
							</li>
							 <%
							    pageContext.setAttribute("_colSize",1);
							  %>
					 </c:if>
				 </c:if>
			    	 <c:if test="${kmCarmngDispatchersInfoForm.fdFlag != '1' }">
				    	<kmss:auth requestURL="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
							<div data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext"  data-dojo-props='colSize:2,icon1:"",align:"center"'
						 		onclick="dispatchersInfoEdit();">
								<bean:message bundle="km-carmng" key="kmCarmng.button7"/>
							</div>
						</kmss:auth>
					<%
						pageContext.setAttribute("_colSize",1);
					%>
					</c:if>	
			</ul>
		</div>
		<c:if test="${fn:length(authArr) > 1}">
		 <div id='carInfoView' data-dojo-type="dojox/mobile/View">
		    <div class="basicInfoHeader" data-dojo-type="mui/header/Header" data-dojo-props="height:'4rem'">
				<div class="basicInfoHeaderBack" onclick="backToDocView(this)">
					<i class="mui mui-back"></i>
					<span class="personHeaderReturnTxt"><bean:message  bundle="km-carmng" key="kmCarmng.back"/></span>
				</div>
				<div class="basicInfoHeaderTitle"><bean:message bundle="km-carmng" key="kmCarmng.select"/></div>
				<div></div>
			</div>
			<div class="muiAccordionPanelContainer">
				<div class="muiAccordionPanelContent" style="display: block;opacity: 1;" 
					<!-- 车辆选择列表  Starts -->
					<div class="muiCarSelectList">
						<ul>
							<c:forEach items="${kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm}"  var="dispatchersInfoListForm" varStatus="vstatus">
							   <c:if test="${fn:contains(authArr, dispatchersInfoListForm.fdId)}">
								<li onclick="recordCar('${dispatchersInfoListForm.fdId}');">
									<a href="javascript:void(0)">
										<span class="carName">${vstatus.index+1}.<c:out value="${dispatchersInfoListForm.fdCarInfoName}"/>（<c:out value="${dispatchersInfoListForm.fdCarInfoNo}"/>）</span>
										<span class="carOpt">
										    <c:if test="${dispatchersInfoListForm.fdFlag == 1 }">
												<em class="carStatus">已填写</em>
											</c:if>
											<i class="mui mui-forward"></i>
										</span>
									</a>
								</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<!-- 车辆选择列表  Ends -->
				</div>
			</div>
		 </div>
		</c:if>
	</template:replace>
</template:include>
<script>
	require(['dojo/ready','dojo/query','mui/dialog/Tip','dijit/registry','dojox/mobile/TransitionEvent',"mui/util",'mui/device/adapter'],
			function(ready,query,Tip,registry,TransitionEvent,util,adapter){

			ready(function(){
				<c:if test="${appSize == 1 }">
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
				</c:if>
			});
			

			window.openRegisterInfo = function(fdId){
				var url =  "/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=view&fdId=" + fdId;
				location.href = util.formatUrl(url,true);
				//adapter.open(util.formatUrl(url,true),"_blank");
			},
			
			window.dispatchersInfoEdit = function(){
				setTimeout(function(){
					location.href = "${KMSS_Parameter_ContextPath}km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=edit&fdId=${param.fdId}";
				},1000);
			},
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
			},
			
			window.recordCar = function(fdId){
				if(fdId){
					window.open('${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId='+fdId,'_self');
				}else{
					window.open('${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId=${fdDispatchersInfoListId}','_self');
				}
			},
			
			window.showCarInfo=function(obj){
				var opts = {
					transition : 'slide',
					transitionDir:1,
					moveTo:'carInfoView'
				};
				new TransitionEvent(obj, opts).dispatch();
			},
			
			//返回主视图
			window.backToDocView=function(obj){
				var opts = {
					transition : 'slide',
					transitionDir:-1,
					moveTo:'scrollView'
				};
				new TransitionEvent(obj, opts).dispatch();
			};
	});
</script>
