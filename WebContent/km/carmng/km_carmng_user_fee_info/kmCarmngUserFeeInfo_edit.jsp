<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do" onsubmit="return validateKmCarmngUserFeeInfoForm(this);">
<div id="optBarDiv">
	<c:if test="${kmCarmngUserFeeInfoForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmCarmngUserFeeInfoForm, 'update');">
	</c:if>
	<c:if test="${kmCarmngUserFeeInfoForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmCarmngUserFeeInfoForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmCarmngUserFeeInfoForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngUserFeeInfo"/></p>

<center>
<table class="tb_normal" width=95%>
		<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUserId"/>
		</td><td width=35%>
			<html:text property="fdUserId"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdFee"/>
		</td><td width=35%>
			<html:text property="fdFee"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdVehiclesId"/>
		</td><td width=35%>
			<html:text property="fdVehiclesId"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdMileageNumber"/>
		</td><td width=35%>
			<html:text property="fdMileageNumber"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdStopFee"/>
		</td><td width=35%>
			<html:text property="fdStopFee"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdTurnpikeFee"/>
		</td><td width=35%>
			<html:text property="fdTurnpikeFee"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdFuelFee"/>
		</td><td width=35%>
			<html:text property="fdFuelFee"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdOtherFee"/>
		</td><td width=35%>
			<html:text property="fdOtherFee"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdCarwashFee"/>
		</td><td width=35%>
			<html:text property="fdCarwashFee"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseStartTime"/>
		</td><td width=35%>
			<html:text property="fdUseStartTime"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseEndTime"/>
		</td><td width=35%>
			<html:text property="fdUseEndTime"/>
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="kmCarmngUserFeeInfoForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>