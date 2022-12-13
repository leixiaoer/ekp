<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="auto">
	<template:replace name="head">
		<link rel="stylesheet" href="${LUI_ContextPath}/km/carmng/resource/css/carmng.css?s_cache=${MUI_Cache}" />
		<script type="text/javascript">
			/* Com_IncludeFile("dialog.js|calendar.js|jquery.js", null, "js");	 */

			seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
				window.Com_OpenDriverInfoWindow = function(){
					if(document.getElementsByName("fdDriverId")[0].value == "undefined" || document.getElementsByName("fdDriverId")[0].value==""){
						dialog.alert('<bean:message key="kmCarmngDispatchersInfo.tips" bundle="km-carmng"/>');
						return;
					}
					Com_OpenWindow('<c:url value="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do"/>?method=view&fdId='+document.getElementsByName("fdDriverId")[0].value);
				};
				window.listByMotorCade = function(fdMotorcadeId){
					dialog.iframe("/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=listByMotorCade&fdMotorcadeId="+fdMotorcadeId,"${lfn:message('km-carmng:kmCarmng.historyForm')}",null,{
						width : 988,
						height : 600
					});
				};
				window.dispatchOrNot = function(){
					var fdCarInfoId=document.getElementsByName("fdCarInfoId")[0].value;
					var fdDriverId=document.getElementsByName("fdDriverId")[0].value;
					var fdStartTime=document.getElementsByName("fdStartTime")[0].value;
					var fdEndTime=document.getElementsByName("fdEndTime")[0].value;
					var parameters="fdCarInfoId="+fdCarInfoId+"&fdDriverId="+fdDriverId+"&fdStartTime="+fdStartTime+"&fdEndTime="+fdEndTime;
					var showConfirm=false;
					var showFlag;
					var s_url = Com_Parameter.ContextPath+"km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=dispatchOrNot";
					$.ajax({
						url: s_url,
						type: "GET",
						data: parameters,
						dataType:"text",
						async: false,
						success: function(text){
							if(text=="1"){showConfirm=true;}
						}});
					if(showConfirm==true) showFlag=confirm('<bean:message key="kmCarmngDispatchersInfo.dispatchtips" bundle="km-carmng"/>');
					return showFlag;
				};
				window.commitMethod = function (method){
					var fdDispatchersType = $('input[name="fdDispatchersType"]:checked').val();
					if(fdDispatchersType == "1"){
						var fdRemark = document.kmCarmngDispatchersInfoForm.fdRemark.value
						if(fdRemark == undefined || fdRemark == ""){
							dialog.alert('不派车原因 不能为空!');
							return false;
						}
						dialog.confirm("您将对本次用车申请进行不派车操作！",function(value){
							if(value){
								Com_Submit(document.kmCarmngDispatchersInfoForm,method);
							}
						});
					}else{
						if($(".lui_carmng_dispatch_carCard").length == 0){
							dialog.alert('<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.carInfo.notNull" />');
							return false;
						}
						var carIds = "";
						$(".lui_carmng_dispatch_carCard").each(function(){
							carIds = carIds == "" ? $(this).attr('id') : carIds + "," + $(this).attr('id');
						});
						checkStartTime(carIds, function(res){
							if(res){
								Com_Submit(document.kmCarmngDispatchersInfoForm,method);
							}
						});
					}
				};
				
				window.checkStartTime = function(carIds, callback){
					var fdStartTime = document.kmCarmngDispatchersInfoForm.fdStartTime.value;
					var fdEndTime = document.kmCarmngDispatchersInfoForm.fdEndTime.value;
					var fdId = document.kmCarmngDispatchersInfoForm.fdId.value;
					var url = Com_Parameter.ContextPath+"km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=selectDispatchersInfoByCarId";
					$.ajax({
						url: url,
		       			type:"post",
		       			data:{"fdId": fdId,"carId":carIds,"startTime":fdStartTime,"fdEndTime":fdEndTime},
		       			dataType:"json",
		       			async:true,
						success: function(data){
							if(null != data && data.length > 0){
								var html = "<div style='overflow:scroll;max-height:500px;'><div><bean:message bundle='km-carmng' key='KmCarmngDispatchersInfo.check.tip1' /></div><br/>";
								for(var i=0;i<data.length;i++){
									html+='<div style="text-align : left;">'+(i+1)+'、<a target= _blank href='+Com_Parameter.ContextPath+'km/carmng/km_carmng_application/kmCarmngApplication.do?method=view&fdId='+data[i].fdId+'> '+ data[i].docSubject + '</a></div><br/>';
								}
								html+="<div><bean:message bundle='km-carmng' key='KmCarmngDispatchersInfo.check.tip2' /></div></div>";
								dialog.confirm(html,function(value){
									if(value==true){
										callback && callback(true);
									}else{
										callback && callback(false);
									}
								});
							}else{
								callback && callback(true);
							}
						}
					});
				}
			});
			
			function Com_OpenCarInfoWindow(){
				Com_OpenWindow('<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do"/>?method=view&fdId='+document.getElementsByName("fdCarInfoId")[0].value);
			}

			window.Com_OpenMotorcadeWindow = function(){
				Com_OpenWindow('<c:url value="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do"/>?method=view&fdId='+document.getElementsByName("fdMotorcadeId")[0].value);
			};
			function openWindow(){
				window.open(Com_Parameter.ContextPath+'km/carmng/km_carmng_application/kmCarmngApplication.do?method=view&fdId=${item.key}&s_css=default');
			}
			
		function selectCar(){
			var fdDispId = $("[name='fdId']").val();
			var fdStartTime = $("[name='fdStartTime']").val();
			var fdEndTime = $("[name='fdEndTime']").val();
			Dialog_TreeList(true, 'fdCarInfoId', 'fdCarInfoNo', ';', 
					 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
					 '<bean:message key="table.kmCarmngInfomation" bundle="km-carmng"/>',
					 'kmCarmngInfomationTreeService&fdMotorcadeId=!{value}&kind=dispatcher&userNumber=${userNumber}&fdDispId='+fdDispId+'&fdStartTime='+fdStartTime+'&fdEndTime='+fdEndTime, hehehe,
					 null, null, null,
					 '<bean:message key="table.kmCarmngInfomation" bundle="km-carmng"/>')
		}
		function SelectDriver(i){
			var idField = "fdDispatchersInfoListForm["+i+"].fdDriverId"
		    var nameField = "fdDispatchersInfoListForm["+i+"].fdDriverName"
			 Dialog_TreeList(false, idField, nameField,';','kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
							'<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>',
							'kmCarmngDriverInfoTreeService&motorcadeId=!{value}',function(rtnVal){
								if(rtnVal == undefined||rtnVal==null){
									return;
								}
								var data = rtnVal.GetHashMapArray();
								if( data.length > 0&&data!=null){
									var fdRelationPhone = data[0]["fdRelationPhone"];
									var fdSysDriverId = "";
									if(data[0]["sysId"]){
										fdSysDriverId = data[0]["sysId"];
									}
									document.getElementsByName("fdDispatchersInfoListForm["+i+"].fdRelationPhone")[0].value=fdRelationPhone;
									document.getElementsByName("fdDispatchersInfoListForm["+i+"].fdSysDriverId")[0].value=fdSysDriverId;
									setTimeout(function(){
										//手动触发校验
										$("input[name='fdDispatchersInfoListForm["+i+"].fdRelationPhone']").focus();
										$("input[name='fdDispatchersInfoListForm["+i+"].fdRelationPhone']").blur();
									},200);
								}
							}, null,null, null, null,'<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>');
			
		}
		var trCarIds = "";
		var trIndex = 0;
		function hehehe(rtnVal){
			document.getElementsByName("fdCarInfoId")[0].value="";
			document.getElementsByName("fdCarInfoNo")[0].value="";
			seajs.use(['lui/util/str'], function(strutil){
				if(rtnVal == undefined){
					return;
				}
				var data = rtnVal.GetHashMapArray();
				//var fdHasOuterDriver = false;
				trHTML = "";
				for(var i = 0 ;i < data.length ; i++){
					if(trCarIds.indexOf(data[i].value, 0) == -1){
						trHTML = '<div class="lui_carmng_dispatch_carCard" id ="'+data[i].value+'">';
						trHTML += '<a href="javascript:void(0)" class="btn_del" onclick="delete_row(\''+data[i].value+'\');"></a>';
						trHTML += '<p class="car_plate">'
						trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdDispatchersInfoId" value="${kmCarmngDispatchersInfoForm.fdId}" />';
						trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdCarInfoId" value="'+data[i].value+'" />';
						trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdVehichesTypeId" value="'+data[i].fdVehichesTypeId+'" />';
						trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdVehichesTypeName" value="'+data[i].fdVehichesTypeName+'" />';
						trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdCarInfoNo" value="'+data[i].text+'" />';
						trHTML += strutil.encodeHTML(data[i].text);
						trHTML += '</p>';
						trHTML += '<ul>';
						trHTML += '<li class="textEllipsis">';
						trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdCarInfoName" value="'+data[i].docSubject+'" />';
						trHTML += strutil.encodeHTML(data[i].docSubject);
						trHTML += '(';
						trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdCarInfoSeatNumber" value="'+data[i].seatNumber+'" />';
						trHTML += strutil.encodeHTML(data[i].seatNumber);
						trHTML += '<bean:message bundle="km-carmng" key="kmCarmngInfomation.seat" />)';
						trHTML += '</li>';
						trHTML += '<li>';
						trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdMotorcadeId" value="'+data[i].fdMotorcadeId+'" />';
						trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdMotorcadeName" value="'+data[i].fdMotorcadeName+'" />';
						trHTML += strutil.encodeHTML(data[i].fdMotorcadeName);
						trHTML += '</li>';
						trHTML += '<li>';
						trHTML += '<p class="driver">';
						trHTML += '<input type="hidden" name="fdDispatchersInfoListForm['+trIndex+'].fdSysDriverId" value="'+data[i].sysId+'" />';
						trHTML += '<div class="inputselectsgl" onclick="SelectDriver(\''+trIndex+'\');" style="width:90%">';
						trHTML += '<input name="fdDispatchersInfoListForm['+trIndex+'].fdDriverId" value="'+data[i].fdDriverId+'" type="hidden">';
						trHTML += '<div class="input">';
						trHTML += '<input subject="【'+data[i].docSubject+'】的驾驶员" name="fdDispatchersInfoListForm['+trIndex+'].fdDriverName" readonly="readonly" value="';
						if(data[i].fdDriversName){
							trHTML += data[i].fdDriversName;
						}
						trHTML += '"  type="text" validate="required">';
						trHTML += '</div>';
						trHTML += '<div class="orgelement"></div>';
						trHTML += '</div><span class="txtstrong">*</span>';
						trHTML += '</p>';
						trHTML += '<p class="phone">';
						if(data[i].fdDriversType == "outer"){
							trHTML += '<input subject="【'+data[i].docSubject+'】驾驶员的联系电话" type="text" class="inputsgl" style="width:88%" name="fdDispatchersInfoListForm['+trIndex+'].fdRelationPhone" value="';
							if(data[i].fdRelationPhone){
								trHTML+=data[i].fdRelationPhone;
							}
							trHTML += '"  validate="required"/><span class="txtstrong">*</span>';
						}else{
							trHTML += '<input subject="【'+data[i].docSubject+'】驾驶员的联系电话" style="color:#212121;border:none;" readonly="readonly" type="text" class="inputsgl" style="width:88%" name="fdDispatchersInfoListForm['+trIndex+'].fdRelationPhone" value="';
							if(data[i].fdRelationPhone){
								trHTML+=data[i].fdRelationPhone;
							}
							trHTML += '" />';
						}
						
						trHTML += '</p>';
						trHTML += '</li>';
						trHTML += '</ul>';
						trHTML += '</div>';
						$("#carlistTB").append(trHTML);
						trIndex++;
						trCarIds +=","+data[i].value;
						//if(!fdHasOuterDriver && data[i].fdDriversType == "outer"){
						//	fdHasOuterDriver = true; 
						//}
					}
				}
				//if(fdHasOuterDriver){
				//	document.getElementById("id_2").style.display="block";
				//}
			});
		}
		function delete_row(value){
			trCarIds = trCarIds.replace(value, "");
			$("#"+value).remove();
	    }
	</script>
	</template:replace>
	<template:replace name="title">
		<c:out value="${ lfn:message('km-carmng:kmCarmng.tree.dispatcher') } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:if test="${not empty fdMotorcadeId}">
				<ui:button text="${lfn:message('km-carmng:kmCarmng.button9') }" 
						onclick="listByMotorCade('${fdMotorcadeId}');">
				</ui:button>
			</c:if>
			<c:if test="${kmCarmngDispatchersInfoForm.method_GET !='edit'}">
				<ui:button text="${lfn:message('button.save') }" 
						onclick="commitMethod('save');">
				</ui:button>
			</c:if>
			<c:if test="${kmCarmngDispatchersInfoForm.method_GET=='edit'}">
				<ui:button text="${lfn:message('button.update') }" 
						onclick= "commitMethod('update');">
				</ui:button>
			</c:if>
			<ui:button text="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:kmCarmng.tree.dispatcher') }">
			</ui:menu-item>
		</ui:menu>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do">
			<html:hidden property="fdId" />
			<html:hidden property="method_GET" />
			<html:hidden property="fdFlag" />
			<html:hidden property="fdApplicationIds" />
			<html:hidden property="fdApplicationNames" />
			<html:hidden property="docCreatorId" />
			<html:hidden property="docCreateTime" />
			
			<p class="txttitle"><bean:message bundle="km-carmng" key="table.kmCarmngDispatchersInfo" /></p>
			
			<div class="lui_form_content_frame" style="padding-top: 20px;">
				<table class="tb_simple" width=100%>
					<tr>
						<td colspan="4">
							<c:import url="/km/carmng/km_carmng_ui/kmCarmngApplication_detail2.jsp" charEncoding="UTF-8">
								<c:param name="fdApplicationIds" value="${kmCarmngDispatchersInfoForm.fdApplicationIds}"></c:param>
							</c:import>
						</td>
					</tr>
					<!-- 调度处理方式 -->
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngDispatchers.type" />
						</td>
						<td width=35%>
							<xform:radio property="fdDispatchersType" onValueChange="changeDispatchersType();" showStatus="edit">
								<xform:enumsDataSource enumsType="kmCarmngDispatchersInfo_fdType"></xform:enumsDataSource>
							</xform:radio>
						</td>
					</tr>
					<%-- 调度开始/结束时间 --%>
						<tr id="dispatchersInfoTimeTR">
							<td class="td_normal_title" width=15%>
								<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime" />
							</td>
							<td width=35%>
								<xform:datetime property="fdStartTime" showStatus="edit" required="true" validators="compareTime">
								</xform:datetime> - 
								<xform:datetime property="fdEndTime" showStatus="edit" required="true" validators="compareTime">
								</xform:datetime>
							</td>
							<td class="td_normal_title" width=15%>
								<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRegisterId" />
							</td>
							<td width=35%>
								<xform:address propertyId="fdRegisterId" propertyName="fdRegisterName" subject="${lfn:message('km-carmng:kmCarmngDispatchersInfo.fdRegisterId')}" 
								orgType="ORG_TYPE_POSTORPERSON" style="width:90%" required="true" showStatus="edit"></xform:address>
							</td>
						</tr>
						<tr id="dispatchersInfoCarTR">
							<td colspan="4">
							<div class="lui_carmng_dispatch_wrap">
								<div class="lui_carmng_dispatch_content" id="carlistTB">
									<!-- 车辆新增 -->
									<input type="hidden" name="fdCarInfoId" />
									 <input type="hidden" name="fdCarInfoNo" />
									<div class="lui_carmng_dispatch_addCar" onclick="selectCar();">
										<span class="carmng_addBtn"></span>
										<p><bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.carInfo.add" /></p>
									</div>
									<c:forEach items="${kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm}"  var="dispatchersInfoListForm" varStatus="vstatus">
										<div class="lui_carmng_dispatch_carCard" id="${dispatchersInfoListForm.fdCarInfoId}"> 
											<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdDispatchersInfoId" value="${kmCarmngDispatchersInfoForm.fdId}" />
											<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoId" value="${dispatchersInfoListForm.fdCarInfoId}" />
											<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoNo" value="${dispatchersInfoListForm.fdCarInfoNo}" />
											<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdVehichesTypeId" value="${dispatchersInfoListForm.fdVehichesTypeId}" />
											<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdVehichesTypeName" value="${dispatchersInfoListForm.fdVehichesTypeName}" />
											<a href="javascript:void(0)" class="btn_del" onclick="delete_row('${dispatchersInfoListForm.fdCarInfoId}')"></a>
											<p class="car_plate"><xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoNo" showStatus="view" value="${dispatchersInfoListForm.fdCarInfoNo}" /> </p>
											<ul>
												<li>
												<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoName" value="${dispatchersInfoListForm.fdCarInfoName}" />
												<xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoName" showStatus="view" value="${dispatchersInfoListForm.fdCarInfoName}" /> 
												（<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoSeatNumber" value="${dispatchersInfoListForm.fdCarInfoSeatNumber}" />
												  <xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoSeatNumber" showStatus="view" value="${dispatchersInfoListForm.fdCarInfoSeatNumber}" /> <bean:message bundle="km-carmng" key="kmCarmngInfomation.seat" />）</li>
												<li>
													<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdMotorcadeId" value="${dispatchersInfoListForm.fdMotorcadeId}" />
													<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdMotorcadeName" value="${dispatchersInfoListForm.fdMotorcadeName}" />
													<xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdMotorcadeName" showStatus="view" value="${dispatchersInfoListForm.fdMotorcadeName}" /> 
												</li>
												<li>
													<p class="driver">
														<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdSysDriverId" value="${dispatchersInfoListForm.fdSysDriverId}" />
														<div class="inputselectsgl" onclick="SelectDriver(${vstatus.index});" style="width:89%">
														<input type="hidden" name="fdDispatchersInfoListForm[${vstatus.index}].fdDriverId" value="${dispatchersInfoListForm.fdDriverId}" >
														<div class="input">
														<input subject="【${dispatchersInfoListForm.fdCarInfoName}】的驾驶员" name="fdDispatchersInfoListForm[${vstatus.index}].fdDriverName" value="${dispatchersInfoListForm.fdDriverName}"  type="text" validate="required"  readonly="">
														</div>
														<div class="selectitem"></div>
														</div>
														<span class="txtstrong">*</span>
													</p>
													<p class="phone"><xform:text  subject="【${dispatchersInfoListForm.fdCarInfoName}】驾驶员的联系电话" property="fdDispatchersInfoListForm[${vstatus.index}].fdRelationPhone" required="true" style="width:90%" value="${dispatchersInfoListForm.fdRelationPhone}" />
													</p>
												</li>
											</ul>
										</div>
										<script>
										    trIndex++;
										    trCarIds += "${dispatchersInfoListForm.fdCarInfoId},";
										</script>
									</c:forEach>
								</div>
							</div>
							</td>
						</tr>
						<!-- 不派车 -->
						<tr id="remarkTR">
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-carmng" key="kmCarmngDispatchersLog.fdRemark" />
							</td>
							<td width="85%" >
								<xform:textarea property="fdRemark" style="width:80%" value="" showStatus="edit"></xform:textarea>
							</td>
						</tr>
					</table>
					<table class="tb_normal" width=100%>
					<!--增加通知方式by张文添 -->
					<tr>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdNotifyType" />
						</td>
						<td width="85%" colspan="3">
								<kmss:editNotifyType property="fdNotifyType" />
								<div id="id_2" style="color: red">
								（<bean:message bundle="km-carmng" key="kmCarmngApplication.dispatcher.notify.sms" />）
								</div>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator" /></td>
						<td width=35%> <c:out
							value="${kmCarmngDispatchersInfoForm.docCreatorName}" /></td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime" /></td>
						<td width=35%> <c:out
							value="${kmCarmngDispatchersInfoForm.docCreateTime}" /></td>
					</tr>
				</table>
			</div>
		</html:form>
		<script language="JavaScript">
		seajs.use(['km/carmng/resource/js/dateUtil'], function(dateUtil) {
		var validation = $KMSSValidation(document.forms['kmCarmngDispatchersInfoForm']);
		
		$(function(){
			changeDispatchersType();
		});
		
		//校验召开时间不能晚于结束时间
		var _compareTime=function(){
			var fdStartTime=$('[name="fdStartTime"]');
			var fdFinishedDate=$('[name="fdEndTime"]');
			var result=true;
			if( fdStartTime.val() && fdFinishedDate.val() ){
				var start=dateUtil.parseDate(fdStartTime.val());
				var end=dateUtil.parseDate(fdFinishedDate.val());
				if( start.getTime()>=end.getTime() ){
					result=false;
				}
			}
			return result;
		};
		
		//自定义校验器:校验召开时间不能晚于结束时间
		validation.addValidator('compareTime','${lfn:message("km-carmng:kmCarmng.error.message10")}',function(v, e, o){
			 var fdEndTime=document.getElementsByName('fdEndTime')[0];
			 var result=true;
			 if(e.name=="fdStartTime"){//fdFinishDate的这个校验与fdHoldDate的相同，直接执行fdHoldDate的
				 validation.validateElement(fdEndTime);
			 }else{
				 result= _compareTime();
			 }
			return result;
		});
		
		function changeDispatchersType(){
			var fdRemark = $("input[name='fdRemark']")[0];
			var fdStartTime = $("input[name='fdStartTime']")[0];
			var fdEndTime = $("input[name='fdEndTime']")[0];
			if($('input[name="fdDispatchersType"]:checked').val() == '0'){
	    		$('#dispatchersInfoTimeTR').show();
	    		$('#dispatchersInfoCarTR').show();
	    		$('#remarkTR').hide();
	    		//移除不派车原因效验器，添加派车效验器
				validation.addElements(fdStartTime,"required");
				validation.addElements(fdEndTime,"required");
	    	}else{
	    		$('#dispatchersInfoTimeTR').hide();
	    		$('#dispatchersInfoCarTR').hide();
	    		$('#remarkTR').show();
	    		validation.removeElements(fdStartTime,"required");
				validation.removeElements(fdEndTime,"required");
	    	}
		}
		window.changeDispatchersType = changeDispatchersType;
	});
		</script>
	</template:replace>
</template:include>
