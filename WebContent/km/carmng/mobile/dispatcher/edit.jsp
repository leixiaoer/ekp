<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.km.carmng.forms.KmCarmngDispatchersInfoListForm"%>
<%@page import="com.landray.kmss.km.carmng.service.IKmCarmngInfomationService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
			<c:out value="${ lfn:message('km-carmng:kmCarmng.tree.dispatcher') } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<script type="text/javascript" src='<c:url value="/sys/mobile/js/lib/zepto.js?s_cache=${MUI_Cache}"/>'></script> 
		<link rel="stylesheet" href="${LUI_ContextPath}/km/carmng/mobile/css/carlist.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do">
			<script>
				var trCarIds = "";
				var trIndex = 0;
			</script>
			<html:hidden property="fdId" />
			<html:hidden property="method_GET" />
			<html:hidden property="fdFlag" />
			<html:hidden property="fdApplicationIds" /> 
			<html:hidden property="fdApplicationNames" />
			<html:hidden property="docCreatorId" />
			<html:hidden property="docCreateTime" />
			<html:hidden  property="fdRegisterId" value="${kmCarmngDispatchersInfoForm.fdRegisterId}"/>
			<div data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView" class="gray">
				<div data-dojo-type="mui/panel/AccordionPanel">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message bundle="km-carmng" key="table.kmCarmngDispatchersInfo" />',icon:'mui-ul'">
						<div class="muiFormContent">
						    <table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
						    	<tr>
									<td colspan="2">
										<div class="muiTravelWay">
											<c:choose>
												<c:when test="${not empty kmCarmngApplicationForm.fdDeparture and not empty kmCarmngApplicationForm.fdDestination}">
													<ul>
														<li>
															<div class="dest">
																<span>
																	<c:out value="${kmCarmngApplicationForm.fdDeparture}"></c:out>
																	（<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDeparture" />）
																</span>
															</div>
															<div class="detail"><span><c:out value="${kmCarmngApplicationForm.fdDepartureDetail}"></c:out></span></div>
														</li>
														<li>
															<div class="dest">
																<span>
																	<c:out value="${kmCarmngApplicationForm.fdDestination}"></c:out>
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
																		<c:out value="${kmCarmngPathForm.fdDestination}"></c:out>
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
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationReason" />
									</td>
									<td>
										<c:out value="${kmCarmngApplicationForm.fdApplicationReason}"></c:out>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-carmng" key="kmCarmngApplication.fdUserNumber" />
									</td>
									<td>
										<c:out value="${kmCarmngApplicationForm.fdUserNumber}"></c:out>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-carmng" key="kmCarmngApplication.fdUserPersons" />
									</td>
									<td>
										<c:out value="${kmCarmngApplicationForm.fdUserPersonNames}"></c:out>
										<c:if test="${not empty kmCarmngApplicationForm.fdOtherUsers}">
											&nbsp;<c:out value="${kmCarmngApplicationForm.fdOtherUsers}"></c:out>
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationPerson" />
									</td>
									<td>
										<c:out value="${kmCarmngApplicationForm.fdApplicationPersonName}"></c:out>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationPersonPhone" />
									</td>
									<td>
										<c:out value="${kmCarmngApplicationForm.fdApplicationPersonPhone}"></c:out>
									</td>
								</tr>
						    	<tr id="fdStartTimeTR">
									<td class="muiTitle" >
										<bean:message	bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime" />
									</td>
									<td>
										<xform:datetime property="fdStartTime" mobile="true" required="true" htmlElementProperties="id='fdStartTimeId'"></xform:datetime>
									</td>
								</tr>
								<tr id="fdEndTimeTR">
									<td class="muiTitle" >
										<bean:message	bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime" />
									</td>
									<td>
										<xform:datetime property="fdEndTime" mobile="true" required="true" htmlElementProperties="id='fdEndTimeId'"></xform:datetime>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRegisterId" />
									</td>
									<td>
										<xform:address propertyId="fdRegisterId" propertyName="fdRegisterName"  subject="${lfn:message('km-carmng:kmCarmngDispatchersInfo.fdRegisterId')}" 
											orgType="ORG_TYPE_POSTORPERSON" style="width:100%" required="true" showStatus="edit" mobile="true" >
							            </xform:address>
										
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message	bundle="km-carmng" key="kmCarmngDispatchers.type" />
									</td>
									<td>
										<xform:radio property="fdDispatchersType" onValueChange="changeDispatchersType();" mobile="true">
											<xform:enumsDataSource enumsType="kmCarmngDispatchersInfo_fdType"></xform:enumsDataSource>
										</xform:radio>
									</td>
								</tr>
						    </table>
							<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="2" class="muiCar">
										<!-- 车辆信息  Starts -->
										<div class="muiCarInfoCard">
											<table class="muiCarInfoCardTb" id="carlistTB">
												<%
													IKmCarmngInfomationService kmCarmngInfomationService= (IKmCarmngInfomationService)SpringBeanUtil.getBean("kmCarmngInfomationService");
												%>
												<c:forEach items="${kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm}"  var="dispatchersInfoListForm" varStatus="vstatus">
														<tr>
															<td>
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdDispatchersInfoId" value="${kmCarmngDispatchersInfoForm.fdId}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoId" value="${dispatchersInfoListForm.fdCarInfoId}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoNo" value="${dispatchersInfoListForm.fdCarInfoNo}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoName" value="${dispatchersInfoListForm.fdCarInfoName}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoSeatNumber" value="${dispatchersInfoListForm.fdCarInfoSeatNumber}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdMotorcadeId" value="${dispatchersInfoListForm.fdMotorcadeId}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdMotorcadeName" value="${dispatchersInfoListForm.fdMotorcadeName}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdDriverId" value="${dispatchersInfoListForm.fdDriverId}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdDriverName" value="${dispatchersInfoListForm.fdDriverName}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdRelationPhone" value="${dispatchersInfoListForm.fdRelationPhone}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdSysDriverId" value="${dispatchersInfoListForm.fdSysDriverId}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdVehichesTypeId" value="${dispatchersInfoListForm.fdVehichesTypeId}" />
																<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdVehichesTypeName" value="${dispatchersInfoListForm.fdVehichesTypeName}" />
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
																<a href="javascript:void(0)">
																	<span class="muiCarInfoBtn delBtn" onclick="DocList_DeleteRow(${vstatus.index})"><i class="mui mui-addIco mui-rotate-45"></i></span>
																	<div class="muiCarInfoDetail">
																		<div class="muiCarInfoImg"><img src="${attPath}" alt="" /></div>
																		<div class="muiCarInfoList">
																			<dl>
																				<dt><span><c:out value="${dispatchersInfoListForm.fdCarInfoName}"/></span><em>(<c:out value="${dispatchersInfoListForm.fdCarInfoSeatNumber}"/><bean:message bundle="km-carmng" key="kmCarmngInfomation.seat" />)</em></dt>
																				<dd><em><bean:message bundle="km-carmng" key="kmCarmngInfomation.carNo" />：</em><span><c:out value="${dispatchersInfoListForm.fdCarInfoNo}"/></span></dd>
																				<dd><em><bean:message bundle="km-carmng" key="kmCarmngInfomation.fdMotorcade" />：</em><span><c:out value="${dispatchersInfoListForm.fdMotorcadeName}"/></span></dd>
																			</dl>
																		</div>
																	</div>
																	<div class="muiCarInfoContact" onclick="SelectDriver(${vstatus.index});">
																		<span class="muiCarInfoContactIco"><i class="mui mui-each_person"></i></span>
																		<p><span id = "driverDiv${vstatus.index}"><c:out value="${dispatchersInfoListForm.fdDriverName}"/></span></p>
																	</div>
																</a>
															</td>
															<script>
															    trIndex ++ ;
															    trCarIds += "${dispatchersInfoListForm.fdCarInfoId},";
															</script>
														</tr>
													</c:forEach>
											</table>
											<div data-dojo-type='km/carmng/mobile/js/list/CarSelectDialog'
										    	 data-dojo-props='"afterSelect":function(evt){afterSelectVehicles(evt);},"key":"fdCarInfoId","title":"${lfn:message('km-carmng:kmCarmngInfomation.motorcade.classify')}","fieldParam":"startTime:fdStartTime,endTime:fdEndTime","showStatus":"edit","isMul":"true","validate":"required","required":true,
										   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmCarmngInfomationTreeService&amp;method=dataList&amp;fdMotorcadeId=!{parentId}&amp;kind=dispatcher&amp;userNumber=${userNumber}&amp;mobile=true",
										    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmCarmngInfomationTreeService&amp;method=dataList&amp;keyword=!{keyword}&amp;mobile=true",
										    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmCarmngInfomationTreeService&amp;method=detailList&amp;fdId=!{curIds}"'
										     	class="muiCarInfoCardBar" id="carAddBtn" widgetid="mui_selectdialog_Dialog_1" style="text-align: left;">
												<i class="mui addBtn"></i>
												<span><bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.carInfo.add" /></span>
											</div>
											<div data-dojo-type='km/carmng/mobile/js/list/CarSelectDialog'
												 data-dojo-props='"afterSelect":function(evt){afterSelectDrivers(evt);},"key":"fdDriverId","title":"${lfn:message('km-carmng:kmCarmngInfomation.motorcade.classify')}","showStatus":"edit","validate":"required","required":true,
												"listDataUrl":"/sys/common/datajson.jsp?s_bean=kmCarmngDriverInfoTreeService&amp;method=dataList&amp;motorcadeId=!{parentId}&amp;kind=dispatcher&amp;mobile=true",
												"searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmCarmngDriverInfoTreeService&amp;method=dataList&amp;keyword=!{keyword}&amp;kind=dispatcher&amp;mobile=true",
												"detailUrl":"/sys/common/datajson.jsp?s_bean=kmCarmngMotorcadeSetTreeService&amp;method=detailList&amp;categoryId=!{curId}"' 
											     id="driverChangeBtn" widgetid="mui_selectdialog_Dialog_0" style="display:none">
											</div>
										</div>
										<!-- 车辆信息  Ends -->
										<div id="noCarDIV">
											<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
												<tr>
													<td>
														<xform:textarea property="fdRemark" required="true" style="width:80%" mobile="true" htmlElementProperties="id='fdRemarkId'"></xform:textarea>
													</td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
								</table>
								<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td class="muiTitle" >
										<bean:message	bundle="km-carmng" key="kmCarmngDriversInfo.fdNotifyType" />
									</td>
									<td>
										<kmss:editNotifyType property="fdNotifyType" mobile="true"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message	bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator" />
									</td>
									<td>
										<c:out	value="${kmCarmngDispatchersInfoForm.docCreatorName}" />
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message	bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime" />
									</td>
									<td>
										<c:out	value="${kmCarmngDispatchersInfoForm.docCreateTime}" />
									</td>
								</tr>
							</table>						
						</div>
					</div>
				</div>
				<div data-dojo-type="mui/tabbar/TabBar" fixed="bottom"  data-dojo-props='fill:"grid"'>
						
					<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" 
						 data-dojo-props='colSize:2,href:"javascript:commitMethod();",transition:"slide",icon1:"",align:"center"'>
						<bean:message key="button.submit"/>
					</li>	
										
				</div>
			</div>
		</html:form>
	</template:replace>
</template:include>
<script>
require(['mui/form/ajax-form!kmCarmngDispatchersInfoForm','dojo/request','dojo/ready','dojo/date/locale',
         'dojo/query','dojo/topic','dijit/registry','mui/dialog/Confirm','mui/dialog/Tip','mui/device/adapter','mui/util','dojo/_base/lang', 'dojo/dom-class','mui/dialog/Confirm'],
			function(form,request,ready,locale,query,topic,registry,Confirm,Tip,adapter,util,lang,domClass,Confirm){
	
		//校验对象
		var validorObj = null;
	
		ready(function(){
			changeDispatchersType();
			validorObj = registry.byId('scrollView');
		});
		function changeDispatchersType(){
			var fdRemarkId = registry.byId('fdRemarkId');
			var fdStartTime = registry.byId('fdStartTimeId');
			var fdEndTime = registry.byId('fdEndTimeId');
			if($('input[name="_fdDispatchersType_group"]:checked').val() == '1'){
	    		$('.muiCarInfoCard').hide();
	    		$('#fdStartTimeTR').hide();
	    		$('#fdEndTimeTR').hide();
	    		$('#noCarDIV').show();
	    		//删除效验
	    		fdStartTime.validate = 'skip';
	    		fdEndTime.validate = 'skip';
	    		fdRemarkId.validate = 'required';
	    	}else{
	    		$('.muiCarInfoCard').show();
	    		$('#fdStartTimeTR').show();
	    		$('#fdEndTimeTR').show();
	    		$('#noCarDIV').hide();
	    		//删除效验
	    		fdRemarkId.validate = 'skip';
	    		fdStartTime.validate = 'required';
	    		fdEndTime.validate = 'required';
	    	}
		}
		window.changeDispatchersType = changeDispatchersType;
		
		var currentDriverIndex = 0;
		window.SelectDriver = function(index){
			currentDriverIndex = index;
			var driverBtn = registry.byId('driverChangeBtn');
			driverBtn._onClick();
		};
		window.afterSelectDrivers = function (evt){
			request.get("${KMSS_Parameter_ContextPath}sys/common/datajson.jsp?s_bean=kmCarmngDriverInfoTreeService&method=detail&fdId="+evt.curIds,
				{data:null,handleAs:"json"}).then( function(data){
					document.getElementsByName("fdDispatchersInfoListForm["+currentDriverIndex+"].fdDriverId")[0].value = evt.curIds;
					document.getElementsByName("fdDispatchersInfoListForm["+currentDriverIndex+"].fdDriverName")[0].value = evt.curNames;
					document.getElementById("driverDiv"+currentDriverIndex).innerHTML = evt.curNames;
					document.getElementsByName("fdDispatchersInfoListForm["+currentDriverIndex+"].fdRelationPhone")[0].value = data[0]["fdRelationPhone"];
					var fdSysDriverId = "";
					if(data[0]["sysId"]){
						fdSysDriverId = data[0]["sysId"];
					}
					document.getElementsByName("fdDispatchersInfoListForm["+currentDriverIndex+"].fdSysDriverId")[0].value = fdSysDriverId;
				},function(error){
					//错误回调
			});
		};
	
	
		window.commitMethod = function(){
			if(!validorObj.validate()){
				return;
			}
			var tb = document.getElementById("carlistTB");
			var fdDispatchersType = $('input[name="_fdDispatchersType_group"]:checked').val();
			if(fdDispatchersType == "1"){
				Confirm("您将对本次用车申请进行不派车操作！",'',function(value){
					if(value){
						var method = Com_GetUrlParameter(location.href,'method');
						if(method=='add'){
							Com_Submit(document.kmCarmngDispatchersInfoForm,'save');
						}else{
							Com_Submit(document.kmCarmngDispatchersInfoForm,'update');
						}
					}
				});
			}else{
				//调度开始时间，不能早于结束时间
				
				var fdStartTime = registry.byId('fdStartTimeId');
				var fdEndTime = registry.byId('fdEndTimeId');
				if(fdStartTime && fdEndTime){
					var fdEndTimeMis=util.parseDate(fdEndTime.value,'yyyy-MM-dd HH:mm').getTime();
					var fdStartTimeMis=util.parseDate(fdStartTime.value,'yyyy-MM-dd HH:mm').getTime();
					if(fdStartTimeMis > fdEndTimeMis){
						Tip.fail({text:'${lfn:message("km-carmng:kmCarmng.error.message0")}',width:'200',height:'100'});
						return false;
					}
				}else{
					return false;
				}
				
				if(tb.rows.length == 0){
					Tip.fail({text:'${lfn:message("km-carmng:kmCarmngDispatchersInfo.carInfo.notNull")}',width:'200',height:'100'});
					return false;
				}
				var childmsg = '';
				$('[name$=".fdDriverId"]').each(function(index) {
					if(this.value == ""){
						childmsg += '【'+(index+1)+'】';
					}
				 });
				if(childmsg!=''){
					Tip.fail({text:'车辆'+childmsg+'的司机不能为空!',width:'200',height:'60'});
					return false;
				}
				var method = Com_GetUrlParameter(location.href,'method');
				if(method=='add'){
					Com_Submit(document.kmCarmngDispatchersInfoForm,'save');
				}else{
					Com_Submit(document.kmCarmngDispatchersInfoForm,'update');
				}
			}
		};
		
		window.DocList_DeleteRow = function(i){
			var optTR = DocListFunc_GetParentByTagName("TR");
			var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
			var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
			var aa = document.getElementsByName("fdDispatchersInfoListForm["+i+"].fdCarInfoId")[0];
			trCarIds = trCarIds.replace(aa.value, "");
			optTB.deleteRow(rowIndex);
		};
		window.DocListFunc_GetParentByTagName = function(tagName, obj){
			if(obj==null){
				if(Com_Parameter.IE)
					obj = event.srcElement;
				else
					obj = Com_GetEventObject().target;
			}
			for(; obj!=null; obj = obj.parentNode)
				if(obj.tagName == tagName)
					return obj;
		};
		window.afterSelectVehicles = function (evt){
			var fdStartTime = registry.byId('fdStartTimeId');
			var fdEndTime = registry.byId('fdEndTimeId');
			request(util.formatUrl("/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=loadCarByIds"), {
				handleAs : 'json',
				method : 'post',
				data : {
					fdCarIds : evt.curIds,
					fdStartTime : fdStartTime.value,
					fdEndTime : fdEndTime.value,
				}
			}).then(lang.hitch(this, function(data) {
				if (data){
					//var fdHasOuterDriver = false;
						for(var i = 0 ;i < data.length ; i++){
							if(trCarIds.indexOf(data[i].fdCarInfoId, 0) == -1){
								if(null != data[i].info){
									/* Tip.fail({text:data[i].info,width:'400',height:'100'}); */
									Confirm(data[i].info,'','',function(value){
										if(value){
											
										}
									});
								}
								trHTML = '<tr align="center">';
								trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdDispatchersInfoId" value="${kmCarmngDispatchersInfoForm.fdId}" />';
								trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdCarInfoId" value="'+data[i].fdCarInfoId+'" />';
								trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdVehichesTypeId" value="'+data[i].fdVehichesTypeId+'" />';
								trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdVehichesTypeName" value="'+data[i].fdVehichesTypeName+'" />';
								trHTML += '<td>';
								trHTML += '<a href="javascript:void(0)">';
								trHTML += '<span class="muiCarInfoBtn delBtn" onclick="DocList_DeleteRow('+trIndex+')"><i class="mui mui-addIco mui-rotate-45"></i></span>';
								trHTML += '<div class="muiCarInfoDetail">';
								trHTML += '<div class="muiCarInfoImg">';
								trHTML += '<img src="'+util.formatUrl(data[i].attPath)+'" alt="" />';
								trHTML += '</div>'
								trHTML += '<div class="muiCarInfoList"><dl>'
								trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdCarInfoName" value="'+data[i].fdCarInfoName+'" />';
								trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdCarInfoNo" value="'+data[i].fdCarInfoNo+'" />';
								trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdCarInfoSeatNumber" value="'+data[i].fdSeatNumber+'" />';
								trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdMotorcadeId" value="'+data[i].fdMotorcadeId+'" />';
								trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdMotorcadeName" value="'+data[i].fdMotorcadeName+'" />';
								var fdSysDriverId = "";
								if(data[i]["sysId"]){
									fdSysDriverId = data[i]["sysId"];
								}
								trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdSysDriverId" value="'+fdSysDriverId+'" />';
								
								trHTML += '<input name="fdDispatchersInfoListForm['+trIndex+'].fdDriverId" value="';
								if(data[i].fdDriverId){
									trHTML += data[i].fdDriverId
								}
								trHTML +='" type="hidden">';
								trHTML += '<input name="fdDispatchersInfoListForm['+trIndex+'].fdDriverName" subject="<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdDriversName" />" value="';
								if(data[i].fdDriverName){
									trHTML += util.formatText(data[i].fdDriverName)
								}
								trHTML +='" type="hidden" validate="required">';
								trHTML += '<input name="fdDispatchersInfoListForm['+trIndex+'].fdRelationPhone" subject="<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRelationPhone" />" value="';
								if(data[i].fdRelationPhone){
									trHTML += data[i].fdRelationPhone
								}
								trHTML +='" type="hidden" validate="required">';
								
								trHTML += '<dt><span>'+util.formatText(data[i].fdCarInfoName)+'</span><em>('+data[i].fdSeatNumber+'<bean:message bundle="km-carmng" key="kmCarmngInfomation.seat" />)</em></dt>';
								trHTML += '<dd><em><bean:message bundle="km-carmng" key="kmCarmngInfomation.carNo" />：</em><span>'+util.formatText(data[i].fdCarInfoNo)+'</span></dd>';
								trHTML += '<dd><em><bean:message bundle="km-carmng" key="kmCarmngInfomation.fdMotorcade" />：</em><span>'+util.formatText(data[i].fdMotorcadeName)+'</span></dd>';
								trHTML += '</dl></div></div>';
								trHTML += '<div class="muiCarInfoContact" onclick="SelectDriver(\''+trIndex+'\');">';
								trHTML += '<span class="muiCarInfoContactIco"><i class="mui mui-each_person"></i></span>';
								trHTML += '<p><span id = "driverDiv'+trIndex+'">'+util.formatText(data[i].fdDriverName)+'</span></p>';
								trHTML += '</div>';
								trHTML += '</a>';
								trHTML += '</td>';
								trHTML += '</tr>';
								
								$("#carlistTB").append(trHTML);
								trIndex++;
								trCarIds +=","+data[i].fdCarInfoId;
								//if(!fdHasOuterDriver && data[i].fdDriversType == "outer"){
								//	fdHasOuterDriver = true; 
								//}
						}
					}
					//if(fdHasOuterDriver){
					//	document.getElementById("id_2").style.display="block";
					//}
				}
			}));
		};
});

</script>