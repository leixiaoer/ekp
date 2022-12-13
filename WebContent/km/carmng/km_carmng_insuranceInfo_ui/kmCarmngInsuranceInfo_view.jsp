<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="title">
		<c:out value="${ kmCarmngInsuranceInfoForm.fdVehiclesInfoNo } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<script>
		seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
			window.deleteInsuranceInfo = function(delUrl){
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
			<kmss:auth requestURL="/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('kmCarmngInsuranceInfo.do?method=edit&fdId=${param.fdId}','_self');">
				</ui:button>
			</kmss:auth>
			<kmss:auth requestURL="/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}" onclick="deleteInsuranceInfo('${LUI_ContextPath}/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do?method=delete&fdId=${param.fdId}');">
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
			<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }" href="/km/carmng/" target="_self" >
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:kmCarmng.tree.car.information4') }">
			</ui:menu-item>
			<ui:menu-item text="${kmCarmngInsuranceInfoForm.fdVehiclesInfoNo}">
			</ui:menu-item>
		</ui:menu>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInsuranceInfo"/></p>
		<html:hidden name="kmCarmngInsuranceInfoForm" property="fdId"/>
		
		<div style="background:#fff; padding:16px;">
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehiclesInfoId"/>
					</td><td width=35%>
						<c:out value="${kmCarmngInsuranceInfoForm.fdVehiclesInfoNo}" />
					</td>
					<td class="td_normal_title" width=15%><bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/></td>
					<td width="35%"><c:out value="${kmCarmngInsuranceInfoForm.fdVehiclesInfoName}"/></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdCategoryName"/></td>
					<td><c:out value="${kmCarmngInsuranceInfoForm.fdVehiclesCategoryName}"/></td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdProductBrand"/>
					</td><td width=35%>
						<c:out value="${kmCarmngInsuranceInfoForm.fdProductBrand}" />
					</td>		
				</tr>
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdRegisterTime"/>
					</td><td width=35%>
						<c:out value="${kmCarmngInsuranceInfoForm.fdRegisterTime}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceStartTime"/>
					</td><td width=35%>
						<c:out value="${kmCarmngInsuranceInfoForm.fdInsuranceStartTime}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceEndTime"/>
					</td><td width=35%>
						<c:out value="${kmCarmngInsuranceInfoForm.fdInsuranceEndTime}" /><br/><bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.isNotify.tip"/><xform:radio property="fdIsNotify" >
							<xform:enumsDataSource enumsType="common_yesno" />
						</xform:radio>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceNo"/>
					</td><td width=35%>
						<c:out value="${kmCarmngInsuranceInfoForm.fdInsuranceNo}" />
					</td>
				</tr><c:if test="${kmCarmngInsuranceInfoForm.fdIsNotify=='true'}">
					<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.before.day"/>
					</td><td width=35%>
						<c:out value="${kmCarmngInsuranceInfoForm.fdNotifyBeforeDay}" /><bean:message key="kmCarmngInsuranceInfo.notify.day.unit" bundle="km-carmng"/>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.persons"/>
					</td><td width=35%>
						<c:out value="${kmCarmngInsuranceInfoForm.fdNotifyPersonNames}" />
					</td>
				</tr>
				</c:if>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsurancePrice"/>
					</td><td width=35%>
						<input type="text" name="fdInsurancePrice" value="<kmss:showNumber value="${(kmCarmngInsuranceInfoForm.fdInsurancePrice!=null)?(kmCarmngInsuranceInfoForm.fdInsurancePrice):0}" pattern="0.00#"/>" readonly="readonly" style="border: none">
						<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
					</td>
					
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceFee"/>
					</td><td width=35%>
						<input type="text" name="fdInsurancePrice" value="<kmss:showNumber value="${(kmCarmngInsuranceInfoForm.fdInsuranceFee!=null)?(kmCarmngInsuranceInfoForm.fdInsuranceFee):0}" pattern="0.00#"/>" readonly="readonly" style="border: none">
						<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsDamag"/>
					</td><td width=35%>
						<sunbor:enumsShow value="${kmCarmngInsuranceInfoForm.fdIsDamag}"  enumsType="common_yesno_number"/>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsThirdInsurance"/>
					</td><td width=35%>
						<sunbor:enumsShow value="${kmCarmngInsuranceInfoForm.fdIsThirdInsurance}"  enumsType="common_yesno_number"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsRobInsurance"/>
					</td><td width=35%>
						<sunbor:enumsShow value="${kmCarmngInsuranceInfoForm.fdIsRobInsurance}"  enumsType="common_yesno_number"/>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsGlassInsurance"/>
					</td><td width=35%>
						<sunbor:enumsShow value="${kmCarmngInsuranceInfoForm.fdIsGlassInsurance}"  enumsType="common_yesno_number"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsAbatement"/>
					</td><td width=35%>
						<sunbor:enumsShow value="${kmCarmngInsuranceInfoForm.fdIsAbatement}"  enumsType="common_yesno_number"/>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsHeadline"/>
					</td><td width=35%>
						<sunbor:enumsShow value="${kmCarmngInsuranceInfoForm.fdIsHeadline}"  enumsType="common_yesno_number"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsLiability"/>
					</td><td width=35% colspan="3">
						<sunbor:enumsShow value="${kmCarmngInsuranceInfoForm.fdIsLiability}"  enumsType="common_yesno_number"/>
					</td>
					
				</tr>
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdRemark"/>
					</td><td width=35% colspan="3">
						<kmss:showText  value="${kmCarmngInsuranceInfoForm.fdRemark}" />
					</td>
				</tr>
					<tr>
							<%-- 文档附件 --%>
							<td width="11%" class="td_normal_title"><bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.attachment"/></td>
							<td width="89%" colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attachment"/>
								<c:param name="formBeanName" value="kmCarmngInsuranceInfoForm" />
							</c:import>
							</td>
						</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.docCreatorId"/>
					</td><td width=35%>
						<c:out value="${kmCarmngInsuranceInfoForm.docCreatorName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.docCreateTime"/>
					</td><td width=35%>
						<c:out value="${kmCarmngInsuranceInfoForm.docCreateTime}" />
					</td>
				</tr>
				<c:if test="${not empty kmCarmngInsuranceInfoForm.docModifierName}">
						<tr>
							<td class="td_normal_title" width=15%>
								<bean:message  bundle="km-carmng" key="docModifierId"/>
							</td><td width=35%>
								<c:out value="${kmCarmngInsuranceInfoForm.docModifierName}" />
							</td>
							<td class="td_normal_title" width=15%>
								<bean:message  bundle="km-carmng" key="docModifyTime"/>
							</td><td width=35%>
								<c:out value="${kmCarmngInsuranceInfoForm.docModifyTime}" />
							</td>
						</tr>
				</c:if>
			</table>
		</div>
	</template:replace>
</template:include>

