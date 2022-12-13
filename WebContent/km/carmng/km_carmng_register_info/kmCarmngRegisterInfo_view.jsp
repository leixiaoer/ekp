<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="head">
	<link rel="stylesheet" href="${LUI_ContextPath}/km/carmng/resource/css/carmng.css?s_cache=${MUI_Cache}" /> 
		<script>
			function confirmDelete(msg){
			var del = confirm("<bean:message key="page.comfirmDelete"/>");
			return del;
		}
		</script>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
			<kmss:auth
				requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=edit&fdId=${JsParam.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('button.edit')}"
					onclick="Com_OpenWindow('kmCarmngRegisterInfo.do?method=edit&fdId=${JsParam.fdId}','_self');">
				</ui:button>
			</kmss:auth>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngRegisterInfo"/></p>
		<div style="background:#fff; padding:16px;">
		
			<table class="tb_normal" width=100%>
			 		<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStartTime"/>
						</td>
						<td width=35% >
							<xform:datetime property="fdStartTime" required="true"></xform:datetime>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdEndTime"/>
						</td>
						<td width=35% >
							<xform:datetime property="fdEndTime" required="true"></xform:datetime>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId"/>
						</td><td width=35%>
							<xform:text  property="fdCarInfoNo" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.fdMotorcadeId"/>
						</td><td width=35%>
							<xform:text  property="fdMotorcadeName" />
						</td>
						
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdDriverId"/>
						</td><td width=85% colspan="3">
							<xform:text property="fdDriversName" />
						</td>
					</tr>	
					
					<tr>
						<td class="td_normal_title" width="15%">
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdMileageStartNumber"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.mileage.unit"/>）
						</td><td width="35%" >
							<xform:text required="true"  property="fdMileageStartNumber"/>
						</td>
						<td class="td_normal_title" width="15%">
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdMileageEndNumber"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.mileage.unit"/>）
						</td><td width="35%" >
							<xform:text required="true"  property="fdMileageEndNumber"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRealPath"/>
						</td><td width="35%">
							<xform:text property="fdRealPath" style="width:95%;"/>
						</td>
						<td class="td_normal_title" width="15%">
							<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdMileageNumber"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.mileage.unit"/>）
						</td><td width="35%" >
							<xform:text required="true"  property="fdMileageNumber"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdTurnpikeFee"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
						</td><td width=35%>
							<xform:text property="fdTurnpikeFee"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdFuelFee"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
						</td><td width=35%>
							<xform:text property="fdFuelFee"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStopFee"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
						</td><td width=35%>
							<xform:text property="fdStopFee" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdCarwashFee"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
						</td><td width=35%>
							<xform:text property="fdCarwashFee" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdOtherFee"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
						</td><td width=35%>
							<xform:text property="fdOtherFee" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdTotalFee"/>（<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>）
						</td><td width=35%>
							<xform:text property="fdTotalFee" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdRemark"/>
						</td><td width=35% colspan="3">
							<xform:textarea style="width:100%" property="fdRemark"/>
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
	</template:replace>
</template:include>
