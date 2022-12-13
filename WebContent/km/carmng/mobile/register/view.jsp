<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
			<c:out value="${lfn:message('km-carmng:table.kmCarmngRegisterInfo')} - ${lfn:message('km-carmng:module.km.carmng')}"></c:out>
	</template:replace>
	<template:replace name="head">
	<link rel="stylesheet" href="${LUI_ContextPath}/km/carmng/mobile/css/carlist.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
			<div data-dojo-type="mui/view/DocScrollableView"  id="scrollView">
				<div data-dojo-type="mui/panel/AccordionPanel">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<c:out value="${lfn:message('km-carmng:table.kmCarmngRegisterInfo')}"></c:out>',icon:'mui-ul'">
						<div class="muiFormContent">
								<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td class="muiTitle">
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStartTime"/>
									</td>
									<td>
										<c:out value="${kmCarmngRegisterInfoForm.fdStartTime}"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdEndTime"/>
									</td><td>
										<c:out value="${ kmCarmngRegisterInfoForm.fdEndTime}"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId"/>
									</td><td>
										<c:out value="${ kmCarmngRegisterInfoForm.fdCarInfoNo}"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdMotorcadeId"/>
									</td><td>
									    <c:out value="${ kmCarmngRegisterInfoForm.fdMotorcadeName}"/>
									</td>
								</tr>	
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdDriverId"/>
									</td>
									<td>
									    <c:out value="${ kmCarmngRegisterInfoForm.fdDriversName}"/>
									</td>
								</tr>	
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRealPath"/>
									</td>
									<td>
										<c:out value="${ kmCarmngRegisterInfoForm.fdRealPath}"/>
									</td>
								</tr>	
								</table>
								<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
								
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdMileageStartNumber"/>
									</td>
									<td>
										<c:if test="${not empty kmCarmngRegisterInfoForm.fdMileageStartNumber}">
										<c:out value="${ kmCarmngRegisterInfoForm.fdMileageStartNumber}"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.mileage.unit"/>）
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdMileageEndNumber"/>
									</td>
									<td>
										<c:if test="${not empty kmCarmngRegisterInfoForm.fdMileageEndNumber}">
										<c:out value="${ kmCarmngRegisterInfoForm.fdMileageEndNumber}"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.mileage.unit"/>）
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdMileageNumber"/>
									</td>
									<td>
										<c:if test="${not empty kmCarmngRegisterInfoForm.fdMileageNumber}">
										<c:out value="${ kmCarmngRegisterInfoForm.fdMileageNumber}"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.mileage.unit"/>）
										</c:if>
									</td>
								</tr>
								</table>
								<table class="viewTb muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td class="muiTitle">
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdTurnpikeFee"/>
									</td>
									<td>
										<c:if test="${not empty kmCarmngRegisterInfoForm.fdTurnpikeFee}">
											<c:out value="${ kmCarmngRegisterInfoForm.fdTurnpikeFee}"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdFuelFee"/>
									</td>
									<td>
										<c:if test="${not empty kmCarmngRegisterInfoForm.fdFuelFee}">
											<c:out value="${ kmCarmngRegisterInfoForm.fdFuelFee}"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStopFee"/>
									</td>
									<td>
										<c:if test="${not empty kmCarmngRegisterInfoForm.fdStopFee}">
											<c:out value="${ kmCarmngRegisterInfoForm.fdStopFee}"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdCarwashFee"/>
									</td>
									<td>
										<c:if test="${not empty kmCarmngRegisterInfoForm.fdCarwashFee}">
											<c:out value="${ kmCarmngRegisterInfoForm.fdCarwashFee}"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdOtherFee"/>
									</td>
									<td>
										<c:if test="${not empty kmCarmngRegisterInfoForm.fdOtherFee}">
											<c:out value="${ kmCarmngRegisterInfoForm.fdOtherFee}"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdTotalFee"/>
									</td>
									<td>
									    <span id="fdTotalFee"><c:out value="${kmCarmngRegisterInfoForm.fdTotalFee}"/></span>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRemark"/>
									</td>
									<td>
										<c:out value="${ kmCarmngRegisterInfoForm.fdRemark}"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRegisterId"/>
									</td>
									<td>
										<c:out value="${ kmCarmngRegisterInfoForm.fdRegisterName}"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRegisterTime"/>
									</td>
									<td>
										<c:out value="${ kmCarmngRegisterInfoForm.fdRegisterTime}"/>
									</td>
								</tr>
							</table>					
						</div>
					</div>
				</div>
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom"  data-dojo-props='fill:"grid"'>
				<kmss:auth
					requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=edit&fdId=${param.fdId}"
					requestMethod="GET">
					<div data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext"
						data-dojo-props='colSize:2,icon1:"",align:"center"'
						onclick="registerInfoEdit();">
						<bean:message bundle="km-carmng" key="kmCarmng.button6" />
					</div>
				</kmss:auth>
				<%
					pageContext.setAttribute("_colSize", 1);
				%>
			</ul>
			</div>
	</template:replace>
</template:include>
<script>
window.registerInfoEdit = function(){
	setTimeout(function(){
		location.href = "${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=edit&fdId=${param.fdId}";
	},500);
}
</script>