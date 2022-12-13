<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
			<c:out value="${lfn:message('km-carmng:table.kmCarmngRegisterInfo')} - ${lfn:message('km-carmng:module.km.carmng')}"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet" href="${LUI_ContextPath}/km/carmng/mobile/css/carlist.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do">
			<html:hidden property="fdId" />
			<html:hidden property="fdDispatchInfoListId" />
			<html:hidden property="fdRegisterId" />
			<html:hidden property="method_GET" />
			<html:hidden property="fdRegisterTime" />
			<html:hidden property="fdTotalFee" />
			
			<div data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
				<div data-dojo-type="mui/panel/AccordionPanel">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<c:out value="${lfn:message('km-carmng:table.kmCarmngRegisterInfo')}"></c:out>',icon:'mui-ul'">
						<div class="muiFormContent">
							<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td class="muiTitle"  >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStartTime"/>
									</td>
									<td>
										<xform:datetime property="fdStartTime" required="true" mobile="true"></xform:datetime>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdEndTime"/>
									</td><td>
										<xform:datetime property="fdEndTime" required="true" mobile="true"></xform:datetime>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"  >
										<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId"/>
									</td><td>
									    <html:hidden property="fdCarInfoNo" />
										<c:out value="${kmCarmngRegisterInfoForm.fdCarInfoNo}"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdMotorcadeId"/>
									</td><td>
									    <html:hidden property="fdMotorcadeName" />
									    <c:out value="${kmCarmngRegisterInfoForm.fdMotorcadeName}"/>
									</td>
								</tr>	
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdDriverId"/>
									</td>
									<td>
									    <html:hidden property="fdDriversName" />
									    <c:out value="${kmCarmngRegisterInfoForm.fdDriversName}"/>
									</td>
								</tr>	
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRealPath"/>
									</td>
									<td>
										<xform:textarea property="fdRealPath" mobile="true"/>
									</td>
								</tr>
							</table>
							<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">	
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdMileageStartNumber"/>
									</td>
									<td>
										<xform:text required="true" validators="number min(0) maxLength(10)" onValueChange="countMileage();" property="fdMileageStartNumber" mobile="true" htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngRegisterInfo.input') }（${lfn:message('km-carmng:kmCarmngRegisterInfo.unit') }${lfn:message('km-carmng:kmCarmngRegisterInfo.mileage.unit') }）'"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdMileageEndNumber" />
									</td>
									<td>
										<xform:text required="true" validators="number min(0) maxLength(10)" onValueChange="countMileage();" property="fdMileageEndNumber" mobile="true" htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngRegisterInfo.input') }（${lfn:message('km-carmng:kmCarmngRegisterInfo.unit') }${lfn:message('km-carmng:kmCarmngRegisterInfo.mileage.unit') }）'"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdMileageNumber"/>
									</td>
									<td>
										<xform:text required="true" validators="min(0) maxLength(10)" property="fdMileageNumber" mobile="true" htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngRegisterInfo.input') }（${lfn:message('km-carmng:kmCarmngRegisterInfo.unit') }${lfn:message('km-carmng:kmCarmngRegisterInfo.mileage.unit') }）'"/>
									</td>
								</tr>
							</table>
							<table class="viewTb  muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td class="muiTitle"  >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdTurnpikeFee"/>
									</td>
									<td>
										<xform:text property="fdTurnpikeFee" validators="number min(0) maxLength(10)" onValueChange="calculate" mobile="true" htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngRegisterInfo.input') }（${lfn:message('km-carmng:kmCarmngRegisterInfo.unit') }${lfn:message('km-carmng:kmCarmngRegisterInfo.fee.unit') }）'"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"  >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdFuelFee"/>
									</td>
									<td>
										<xform:text property="fdFuelFee" validators="number min(0) maxLength(10)" onValueChange="calculate" mobile="true" htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngRegisterInfo.input') }（${lfn:message('km-carmng:kmCarmngRegisterInfo.unit') }${lfn:message('km-carmng:kmCarmngRegisterInfo.fee.unit') }）'"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStopFee"/>
									</td>
									<td>
										<xform:text property="fdStopFee" validators="number min(0) maxLength(10)" onValueChange="calculate"  mobile="true" htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngRegisterInfo.input') }（${lfn:message('km-carmng:kmCarmngRegisterInfo.unit') }${lfn:message('km-carmng:kmCarmngRegisterInfo.fee.unit') }）'"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdCarwashFee"/>
									</td>
									<td>
										<xform:text property="fdCarwashFee" validators="number min(0) maxLength(10)" onValueChange="calculate"  mobile="true" htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngRegisterInfo.input') }（${lfn:message('km-carmng:kmCarmngRegisterInfo.unit') }${lfn:message('km-carmng:kmCarmngRegisterInfo.fee.unit') }）'"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdOtherFee"/>
									</td>
									<td>
										<xform:text property="fdOtherFee" validators="number min(0) maxLength(10)" onValueChange="calculate"  mobile="true" htmlElementProperties="placeholder='${lfn:message('km-carmng:kmCarmngRegisterInfo.input') }（${lfn:message('km-carmng:kmCarmngRegisterInfo.unit') }${lfn:message('km-carmng:kmCarmngRegisterInfo.fee.unit') }）'"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdTotalFee"/>
									</td>
									<td>
									    <span id="fdTotalFee"><c:out value="${kmCarmngRegisterInfoForm.fdTotalFee}"/></span>
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRemark"/>
									</td>
									<td>
										<xform:textarea property="fdRemark" mobile="true"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRegisterId"/>
									</td>
									<td>
										<c:out value="${kmCarmngRegisterInfoForm.fdRegisterName}"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"   >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRegisterTime"/>
									</td>
									<td>
										<c:out value="${kmCarmngRegisterInfoForm.fdRegisterTime}"/>
									</td>
								</tr>
							</table>						
						</div>
					</div>
				</div>
				<div data-dojo-type="mui/tabbar/TabBar" fixed="bottom"  data-dojo-props='fill:"grid"'>	
					
					<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" 
						 onclick="javascript:commitMethod();" data-dojo-props='colSize:2,icon1:"",align:"center"'>
						<bean:message key="button.submit"/>
					</li>	
								
				</div>
			</div>
		</html:form>
	</template:replace>
</template:include>
<script>
	require(["mui/form/ajax-form!kmCarmngRegisterInfoForm","dojo/request",'dojo/ready','dojo/date/locale','dojo/query','dojo/topic',
	     	'dijit/registry','mui/dialog/Confirm','mui/dialog/Tip','mui/device/adapter','dojo/window'],
		function(form,request,ready,locale,query,topic,registry,Confirm,Tip,adapter,win){

		window.commitMethod = function(){
			if( registry.byId('scrollView').validate()){
				var method = Com_GetUrlParameter(location.href,'method');
				if(method=='add'){
					Com_Submit(document.forms[0],'save');
				}else{
					Com_Submit(document.forms[0],'update');
				}
			}
		};
		Com_Submit.ajaxAfterSubmit=function(){
			setTimeout(function(){adapter.goBack();},2000);
		};
		window.calculate = function(obj){
			var totalFee = 0;		
			var fdTurnpikeFee = query("input[name='fdTurnpikeFee']")[0].value; 			
			var fdOtherFee =    query("input[name='fdOtherFee']")[0].value; 
			var fdCarwashFee =  query("input[name='fdCarwashFee']")[0].value ;
			var fdStopFee =     query("input[name='fdStopFee']")[0].value; 
			var fdFuelFee =     query("input[name='fdFuelFee']")[0].value; 
			
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
			query("input[name='fdTotalFee']")[0].value =  totalFee.toFixed(2);
			query("span[id='fdTotalFee']")[0].innerHTML =  totalFee.toFixed(2);			
		};	
		
		window.countMileage = function(){
			var fdMileageStartNumber=query("input[name='fdMileageStartNumber']")[0].value;
			var fdMileageEndNumber=query("input[name='fdMileageEndNumber']")[0].value;
			if(fdMileageStartNumber && fdMileageEndNumber){
				$('[name="fdMileageNumber"]').val(fdMileageEndNumber - fdMileageStartNumber);
			}
		}
	});
</script>