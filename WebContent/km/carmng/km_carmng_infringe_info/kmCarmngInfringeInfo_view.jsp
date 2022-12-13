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
		<kmss:auth requestURL="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmCarmngInfringeInfo.do?method=edit&fdId=${param.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmCarmngInfringeInfo.do?method=delete&fdId=${param.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInfringeInfo"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="kmCarmngInfringeInfoForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdVehiclesInfoId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfringeInfoForm.fdVehiclesInfoNo}" />
		</td>
		<td class="td_normal_title" width=15%>
		<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/>
		</td>
		<td><c:out value="${kmCarmngInfringeInfoForm.fdVehiclesInfoName}"/>
		</td>
		
	</tr>	
	<tr>
		<td class="td_normal_title" width=15%>
		<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdCategoryName"/>
		</td>
		<td><c:out value="${kmCarmngInfringeInfoForm.fdVehiclesCategoryName}"/></td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfringeInfoForm.fdInfringeTime}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringePerson"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfringeInfoForm.fdInfringePersonName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeFee"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfringeInfoForm.fdInfringeFee}" /><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</td>		
	</tr>
	<tr>		
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeSite"/>
		</td><td width=35% colspan="3">
			<c:out value="${kmCarmngInfringeInfoForm.fdInfringeSite}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdRemark"/>
		</td><td width=35% colspan="3">
			<kmss:showText value="${kmCarmngInfringeInfoForm.fdRemark}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.docCreatorId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfringeInfoForm.docCreatorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.docCreateTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfringeInfoForm.docCreateTime}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>