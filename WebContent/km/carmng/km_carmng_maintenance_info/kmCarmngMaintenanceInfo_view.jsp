<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
		<kmss:auth requestURL="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmCarmngMaintenanceInfo.do?method=edit&fdId=${param.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmCarmngMaintenanceInfo.do?method=delete&fdId=${param.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngMaintenanceInfo"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="kmCarmngMaintenanceInfoForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdVehiclesInfoId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngMaintenanceInfoForm.fdVehiclesInfoNo}" />
		</td>
		<td class="td_normal_title" width=15%><bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/></td>
		<td><c:out value="${kmCarmngMaintenanceInfoForm.fdVehiclesInfoName}"/></td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%><bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdCategoryName"/></td>
		<td><c:out value="${kmCarmngMaintenanceInfoForm.fdVehiclesCategoryName}"/></td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdMaintenanceTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngMaintenanceInfoForm.fdMaintenanceTime}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdMaintenanceFee"/>
		</td><td width=35%>
			<c:out value="${kmCarmngMaintenanceInfoForm.fdMaintenanceFee}" /><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdPersonId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngMaintenanceInfoForm.fdPersonName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdRepairFee"/>
		</td><td width=35% colspan="3">
			<c:out value="${kmCarmngMaintenanceInfoForm.fdRepairFee}" /><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdRemark"/>
		</td><td width=35% colspan="3">
			<kmss:showText value="${kmCarmngMaintenanceInfoForm.fdRemark}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.docCreatorId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngMaintenanceInfoForm.docCreatorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.docCreateTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngMaintenanceInfoForm.docCreateTime}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>