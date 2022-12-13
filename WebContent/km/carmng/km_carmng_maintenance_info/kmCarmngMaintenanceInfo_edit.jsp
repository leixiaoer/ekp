<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("dialog.js|calendar.js", null, "js");
</script>
<script type="text/javascript">
window.onload = function(){
	var oldUrl = location.href;
	//车牌号码
	var fdId = Com_GetUrlParameter(oldUrl,'fdCarId');
	if(fdId != null &&  fdId != ''){
		document.getElementsByName("fdVehiclesInfoId")[0].value=fdId;
	}
	var fdNo = Com_GetUrlParameter(oldUrl,'fdNo');
	if(fdNo != null &&  fdNo != ''){
		document.getElementsByName("fdVehiclesInfoNo")[0].value=fdNo;
	}
	//车辆类型
	var fdVehichesType = Com_GetUrlParameter(oldUrl,'fdVehichesType');
	if(fdVehichesType != null &&  fdVehichesType != ''){
		document.getElementsByName("fdVehiclesCategoryName")[0].value=fdVehichesType;
	}
	//车辆名称
	var docSubject = Com_GetUrlParameter(oldUrl,'docSubject');
	if(docSubject != null &&  docSubject != ''){
		document.getElementsByName("fdVehiclesInfoName")[0].value=docSubject;
	}
}
function afterSelectVehicles(rtnVal){
	if(rtnVal == undefined){
		return;
	}
	var data = rtnVal.GetHashMapArray();
	var docSubject = "";	
	var categoryName = "";	
	var text="";
	if( data.length > 0){
		docSubject  = data[0]["docSubject"];	
		categoryName = data[0]["categoryName"];	
		text=data[0]["text"];
		document.getElementsByName("fdVehiclesInfoName")[0].value=docSubject;			
		document.getElementsByName("fdVehiclesCategoryName")[0].value=categoryName;	
		document.getElementsByName("fdVehiclesInfoNo")[0].value=text;	
	}
}
</script>
<html:form action="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do" onsubmit="return validateKmCarmngMaintenanceInfoForm(this);">
<div id="optBarDiv">
	<c:if test="${kmCarmngMaintenanceInfoForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmCarmngMaintenanceInfoForm, 'update');">
	</c:if>
	<c:if test="${kmCarmngMaintenanceInfoForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmCarmngMaintenanceInfoForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmCarmngMaintenanceInfoForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngMaintenanceInfo"/></p>

<center>
<table class="tb_normal" width=95%>
		<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdVehiclesInfoId"/>
		</td><td width=35%>
			<html:hidden property="fdVehiclesInfoId"/>
			<html:text styleClass="inputsgl" readonly="true" property="fdVehiclesInfoNo"/>
			<a href="#"
						onclick="Dialog_TreeList(false, 
				 'fdVehiclesInfoId', 
				 'fdVehiclesInfoNo', 
				 ';', 
				 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
				 '<bean:message key="table.kmCarmngInfomation" bundle="km-carmng"/>',
				  'kmCarmngInfomationTreeService&fdMotorcadeId=!{value}', afterSelectVehicles,
				   null, null, null,
				   '<bean:message key="table.kmCarmngInfomation" bundle="km-carmng"/>')"><bean:message
						key="dialog.selectOther" /> </a>
			<span class="txtstrong">*</span>
		</td>
		<td class="td_normal_title" width=15%>
		<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/>
		</td>
		<td>
		<html:text readonly="true" property="fdVehiclesInfoName"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
		<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdCategoryName"/>
		</td>
		<td>
		<html:text  readonly="true"  property="fdVehiclesCategoryName"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdMaintenanceTime"/>
		</td><td width=35%>
			<html:text styleClass="inputsgl" readonly="true" property="fdMaintenanceTime"/>
			<a href="#" onclick="selectDateTime('fdMaintenanceTime');"> <bean:message
				key="dialog.selectTime" /></a>
			<span class="txtstrong">*</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdMaintenanceFee"/>
		</td><td width=35%>
			<html:text property="fdMaintenanceFee"/><span class="txtstrong">*</span><bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdPersonId"/>
		</td><td width=35%>
			<html:hidden property="fdPersonId"/>
			<html:text property="fdPersonName" styleClass="inputsgl" readonly="true"/>
			<a href="#"
						onclick="Dialog_TreeList(false, 
				 'fdPersonId', 
				 'fdPersonName', 
				 ';', 
				 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
				 '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>',
				  'kmCarmngDriverInfoTreeService&motorcadeId=!{value}', null,
				   null, null, null,
				   '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>')"><bean:message
						key="dialog.selectOther" /> </a>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdRepairFee"/>
		</td><td width=35% colspan="3">
			<html:text property="fdRepairFee"/><span class="txtstrong">*</span><bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdRemark"/>
		</td><td width=35% colspan="3">
			<html:textarea style="width:100%" property="fdRemark"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.docCreatorId"/>
		</td><td width=35%>
			<html:hidden property="docCreatorId"/>
			<html:text readonly="true" property="docCreatorName"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.docCreateTime"/>
		</td><td width=35%>
			<html:text readonly="true" property="docCreateTime"/>
		</td>
		
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="kmCarmngMaintenanceInfoForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>