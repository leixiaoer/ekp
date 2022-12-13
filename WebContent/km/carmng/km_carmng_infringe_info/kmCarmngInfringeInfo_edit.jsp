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
	//违章人
	var fdDriver = Com_GetUrlParameter(oldUrl,'fdDriver');
	if(fdDriver != null &&  fdDriver != ''){
		document.getElementsByName("fdInfringePersonName")[0].value=fdDriver;
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
<html:form action="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do" onsubmit="return validateKmCarmngInfringeInfoForm(this);">
<div id="optBarDiv">
	<c:if test="${kmCarmngInfringeInfoForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmCarmngInfringeInfoForm, 'update');">
	</c:if>
	<c:if test="${kmCarmngInfringeInfoForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmCarmngInfringeInfoForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmCarmngInfringeInfoForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInfringeInfo"/></p>

<center>
<table class="tb_normal" width=95%>
		<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdVehiclesInfoId"/>
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
		<td class="td_normal_title" width=15%><bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/></td>
		<td><html:text readonly="true" property="fdVehiclesInfoName"/></td>
	</tr>
	<tr>		
		<td class="td_normal_title" width=15%><bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdCategoryName"/></td>
		<td><html:text  readonly="true"  property="fdVehiclesCategoryName"/></td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeTime"/>
		</td><td width=35%>
			<html:text styleClass="inputsgl" readonly="true" property="fdInfringeTime"/>
			<a href="#" onclick="selectDateTime('fdInfringeTime');"> <bean:message
				key="dialog.selectTime" /></a>
			<span class="txtstrong">*</span>			
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringePerson"/>
		</td><td width=35%>
			<html:hidden property="fdInfringePersonId"/>
			<html:text   property="fdInfringePersonName" readonly="true"  styleClass="inputsgl" />
			<a href="#"
						onclick="Dialog_TreeList(false, 
				 'fdInfringePersonId', 
				 'fdInfringePersonName', 
				 ';', 
				 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
				 '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>',
				  'kmCarmngDriverInfoTreeService&motorcadeId=!{value}', null,
				   null, null, null,
				   '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>')"><bean:message
						key="dialog.selectOther" /> </a>
			
			<span class="txtstrong">*</span>
			
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeFee"/>
		</td><td width=35%>
			<html:text property="fdInfringeFee"/>
			<span class="txtstrong">*</span><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>		
		</td>
		
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeSite"/>
		</td><td width=35% colspan="3">
			<html:text size="100" property="fdInfringeSite"/>
			<span class="txtstrong">*</span>		
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdRemark"/>
		</td><td width=35% colspan="3">
			<html:textarea style="width:100%" property="fdRemark"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.docCreatorId"/>
		</td><td width=35%>
			<html:hidden property="docCreatorId"/>
			<html:text readonly="true" property="docCreatorName"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.docCreateTime"/>
		</td><td width=35%>
			<html:text readonly="true" property="docCreateTime"/>
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="kmCarmngInfringeInfoForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>