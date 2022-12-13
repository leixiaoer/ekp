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
		<kmss:auth requestURL="/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmCarmngInsuranceInfo.do?method=edit&fdId=${param.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmCarmngInsuranceInfo.do?method=delete&fdId=${param.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInsuranceInfo"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="kmCarmngInsuranceInfoForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehiclesInfoId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInsuranceInfoForm.fdVehiclesInfoNo}" />
		</td>
		<td class="td_normal_title" width=15%><bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/></td>
		<td><c:out value="${kmCarmngInsuranceInfoForm.fdVehiclesInfoName}"/></td>
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
			<c:out value="${kmCarmngInsuranceInfoForm.fdInsurancePrice}" /><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</td>
		
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceFee"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInsuranceInfoForm.fdInsuranceFee}"/><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
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
				<td width="89%" colspan="3"><c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
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
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>