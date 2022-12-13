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
		<kmss:auth requestURL="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmCarmngUserFeeInfo.do?method=edit&fdId=${param.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmCarmngUserFeeInfo.do?method=delete&fdId=${param.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngUserFeeInfo"/></p>
<center>
<table class="tb_normal" width=95%>
		<html:hidden name="kmCarmngUserFeeInfoForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUserId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdUserId}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdFee"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdFee}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdVehiclesId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdVehiclesId}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdMileageNumber"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdMileageNumber}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdStopFee"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdStopFee}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdTurnpikeFee"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdTurnpikeFee}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdFuelFee"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdFuelFee}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdOtherFee"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdOtherFee}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdCarwashFee"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdCarwashFee}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseStartTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdUseStartTime}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseEndTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngUserFeeInfoForm.fdUseEndTime}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>