<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="title">
		<c:out value="${ kmCarmngMaintenanceInfoForm.fdVehiclesInfoNo } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<script>
			seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
				window.deleteMaintenanceInfo = function(delUrl){
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(isOk){
						if(isOk){
							Com_OpenWindow(delUrl,'_self');
						}	
					});
					return;
				};
			});
		</script>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
			<kmss:auth requestURL="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('kmCarmngMaintenanceInfo.do?method=edit&fdId=${param.fdId}','_self');">
				</ui:button>
			</kmss:auth>
			<kmss:auth requestURL="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}" onclick="deleteMaintenanceInfo('${LUI_ContextPath}/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=delete&fdId=${param.fdId}');">
				</ui:button>
			</kmss:auth>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }" href="/km/carmng/" target="_self">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:kmCarmng.tree.car.information5') }">
			</ui:menu-item>
			<ui:menu-item text="${kmCarmngMaintenanceInfoForm.fdVehiclesInfoNo}">
			</ui:menu-item>
		</ui:menu>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngMaintenanceInfo"/></p>
		<div style="background:#fff; padding:16px;">
			<table class="tb_normal" width=100%>
				<html:hidden name="kmCarmngMaintenanceInfoForm" property="fdId"/>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdVehiclesInfoId"/>
					</td><td width=35%>
						<c:out value="${kmCarmngMaintenanceInfoForm.fdVehiclesInfoNo}" />
					</td>
					<td class="td_normal_title" width=15%><bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/></td>
					<td width="35%"><c:out value="${kmCarmngMaintenanceInfoForm.fdVehiclesInfoName}"/></td>
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
						<input type="text" name="fdMaintenanceFee" value="<kmss:showNumber value="${kmCarmngMaintenanceInfoForm.fdMaintenanceFee}" pattern="0.00#"/>" readonly="readonly" style="border: none">
						<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
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
						<input type="text" name="fdRepairFee" value="<kmss:showNumber value="${kmCarmngMaintenanceInfoForm.fdRepairFee}" pattern="0.00#"/>" readonly="readonly" style="border: none">
						<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
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
					<%-- 文档附件 --%>
					<td width="11%" class="td_normal_title"><bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.attachment"/></td>
					<td width="89%" colspan="3">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment"/>
						<c:param name="formBeanName" value="kmCarmngMaintenanceInfoForm" />
					</c:import>
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
		</div>
	</template:replace>
</template:include>

