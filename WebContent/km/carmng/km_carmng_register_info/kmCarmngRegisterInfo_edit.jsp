<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="auto">
	<template:replace name="head">
		<script type="text/javascript">
			function Com_OpenDriverInfoWindow(){
				Com_OpenWindow('<c:url value="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do"/>?method=view&fdId=${kmCarmngRegisterInfoForm.fdDriverId}');
			}
			Com_IncludeFile("dialog.js|calendar.js", null, "js");

			seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
				

				/**
				 * 保存
				 * @param method
				 */
				window.saveSubmit = function (method){
					//保存前进行提示
					dialog.confirm('${lfn:message('km-carmng:kmCarmngRegisterInfo.confirm.tip')}',function (value) {
						if (value){
							if(method == 'add')
								Com_Submit(document.kmCarmngRegisterInfoForm,'save');
							else
								Com_Submit(document.kmCarmngRegisterInfoForm,'update');
						}
					});
				}
				
				window.calculate = function(obj){
					var totalFee = 0;	
					var fdOtherFee =  document.getElementsByName("fdOtherFee")[0].value ;
					var fdCarwashFee = document.getElementsByName("fdCarwashFee")[0].value ;
					var fdStopFee = document.getElementsByName("fdStopFee")[0].value ;
					var fdFuelFee = document.getElementsByName("fdFuelFee")[0].value ;
					var fdTurnpikeFee = document.getElementsByName("fdTurnpikeFee")[0].value ;	
					if(fdOtherFee == "" || isNaN(fdOtherFee)){
						fdOtherFee = 0;
					}
					if(fdCarwashFee == "" || isNaN(fdCarwashFee)){
						fdCarwashFee = 0;
					}
					if(fdStopFee == "" || isNaN(fdStopFee)){
						fdStopFee = 0;
					}
					if(fdFuelFee == "" || isNaN(fdFuelFee)){
						fdFuelFee = 0;
					}
					if(fdTurnpikeFee == "" || isNaN(fdTurnpikeFee)){
						fdTurnpikeFee = 0;
					}	
					totalFee = parseFloat(fdOtherFee)+parseFloat(fdCarwashFee)+parseFloat(fdStopFee)+parseFloat(fdFuelFee)+parseFloat(fdTurnpikeFee);
					document.getElementsByName("fdTotalFee")[0].value = totalFee.toFixed(2);
				};	
			});
			
			</script>
	</template:replace>
	<template:replace name="title">
		<c:out value="${lfn:message('km-carmng:table.kmCarmngRegisterInfo')} - ${lfn:message('km-carmng:module.km.carmng')}"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:if test="${kmCarmngRegisterInfoForm.method_GET=='add'}">
				<ui:button text="${lfn:message('button.save') }"
						onclick="saveSubmit('add')">
				</ui:button>
			</c:if>
			<c:if test="${kmCarmngRegisterInfoForm.method_GET=='edit'}">
				<ui:button text="${lfn:message('button.save') }"
						onclick="saveSubmit('update')">
				</ui:button>
			</c:if>
			<ui:button text="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav">
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:table.kmCarmngRegisterInfo') }">
			</ui:menu-item>
		</ui:menu>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngRegisterInfo"/></p>
		
		<html:form action="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do">
			<html:hidden property="fdId"/>
			<html:hidden property="fdDispatchInfoListId"/>
			<html:hidden property="fdRegisterId"/>
			<html:hidden property="method_GET"/>
			<html:hidden property="fdRegisterTime"/>
			
			<div class="lui_form_content_frame" style="padding-top: 20px;">
			 	<table class="tb_normal" width=100%>
			 		<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStartTime"/>
						</td>
						<td width=35% >
							<xform:datetime property="fdStartTime" required="true" validators="compareTime"></xform:datetime>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdEndTime"/>
						</td>
						<td width=35% >
							<xform:datetime property="fdEndTime" required="true" validators="compareTime"></xform:datetime>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId"/>
						</td><td width=35%>
							<xform:text showStatus="readOnly" property="fdCarInfoNo" style="border:0;color:#333"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdMotorcadeId"/>
						</td><td width=35%>
							<xform:text showStatus="readOnly" property="fdMotorcadeName" style="border:0;color:#333"/>
							<input type="button" title="<bean:message  bundle="km-carmng" key="kmCarmng.tree.base.intro"/>" style= "background:url(userinfo_icon.gif);width: 20px" onclick="Com_OpenWindow('<c:url value="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do" />?method=view&fdId=${kmCarmngRegisterInfoForm.fdMotorcadeId}');"/>
						</td>
						
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdDriverId"/>
						</td><td width=85% colspan="3">
							<xform:text showStatus="readOnly" property="fdDriversName" style="border:0;color:#333"/>
							<input type="button" title="<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.driverInfoIntro"/>" style= "background:url(userinfo_icon.gif);width: 20px" onclick="Com_OpenDriverInfoWindow();"/>
						</td>
					</tr>	
					<tr>
						<td class="td_normal_title" width="15%">
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdMileageStartNumber"/>
						</td><td width="35%" >
							<xform:text required="true" validators="number min(0) maxLength(10) compareNumber" property="fdMileageStartNumber" onValueChange="countMileage();"/>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.mileage.unit"/>
						</td>
						<td class="td_normal_title" width="15%">
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdMileageEndNumber"/>
						</td><td width="35%" >
							<xform:text required="true" validators="number min(0) maxLength(10) compareNumber" property="fdMileageEndNumber" onValueChange="countMileage();"/>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.mileage.unit"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRealPath"/>
						</td><td width="35%">
							<xform:text property="fdRealPath" style="width:95%;"/>
						</td>
						<td class="td_normal_title" width="15%">
							<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdMileageNumber"/>
						</td><td width="35%" >
							<xform:text required="true" validators="number min(0) maxLength(10)" property="fdMileageNumber"/>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.mileage.unit"/>
						</td>
					</tr>
					
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdTurnpikeFee"/>
						</td><td width=35%>
							<xform:text property="fdTurnpikeFee" validators="number min(0) maxLength(10)" onValueChange="calculate"/>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdFuelFee"/>
						</td><td width=35%>
							<xform:text property="fdFuelFee" validators="number min(0) maxLength(10)" onValueChange="calculate"/>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStopFee"/>
						</td><td width=35%>
							<xform:text property="fdStopFee" validators="number min(0) maxLength(10)" onValueChange="calculate"/>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdCarwashFee"/>
						</td><td width=35%>
							<xform:text property="fdCarwashFee" validators="number min(0) maxLength(10)" onValueChange="calculate"/>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdOtherFee"/>
						</td><td width=35%>
							<xform:text property="fdOtherFee" validators="number min(0) maxLength(10)" onValueChange="calculate"/>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdTotalFee"/>
						</td><td width=35%>
							<xform:text property="fdTotalFee" showStatus="true"/>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRemark"/>
						</td><td width=35% colspan="3">
							<xform:textarea style="width:100%" htmlElementProperties="data-actor-expand='true'" property="fdRemark"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRegisterId"/>
						</td><td width=35%>
							<c:out value="${kmCarmngRegisterInfoForm.fdRegisterName}"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRegisterTime"/>
						</td><td width=35%>
							<c:out value="${kmCarmngRegisterInfoForm.fdRegisterTime}"/>
						</td>
					</tr>
			 	</table>
			 </div>
		</html:form>
		<script language="JavaScript">
		seajs.use(['km/carmng/resource/js/dateUtil'], function(dateUtil) {
			
			var validation = $KMSSValidation(document.forms['kmCarmngRegisterInfoForm']);
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
			
			//自定义校验器:校验结束行驶里程不能小于开始行驶里程
			validation.addValidator('compareNumber','${lfn:message("km-carmng:kmCarmng.error.message14")}',function(v, e, o){
				 var result=true;
				 var fdMileageEndNumber = document.getElementsByName('fdMileageEndNumber')[0];
				 if(e.name=="fdMileageStartNumber"){
					 validation.validateElement(fdMileageEndNumber);
				 }else{
				    var fdMileageStartNumber=$('[name="fdMileageStartNumber"]').val();
				    var fdMileageEndNumber=$('[name="fdMileageEndNumber"]').val();
				    if(fdMileageStartNumber && fdMileageEndNumber){
				    	if(parseFloat(fdMileageEndNumber) < parseFloat(fdMileageStartNumber)){
							result = false;
					 	}
				    }
				 }
				return result;
			});
			
			
			window.countMileage = function(){
				var fdMileageStartNumber=$('[name="fdMileageStartNumber"]').val();
				var fdMileageEndNumber=$('[name="fdMileageEndNumber"]').val();
				if(fdMileageStartNumber && fdMileageEndNumber){
					$('[name="fdMileageNumber"]').val((parseFloat(fdMileageEndNumber) - parseFloat(fdMileageStartNumber)).toFixed(2));
				}
			}
			
		});
		
		</script>
	</template:replace>
</template:include> 
