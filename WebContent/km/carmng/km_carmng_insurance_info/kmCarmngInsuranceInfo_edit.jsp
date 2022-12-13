<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<script type="text/javascript">
Com_IncludeFile("dialog.js|jquery.js|calendar.js", null, "js");
</script>
<script type="text/javascript">
function showNotifyConfig(value,_this){
	if(value=="true"){
		$("#notifyConfig").show();
}else{
	$("#notifyConfig").hide();
}}
//当选择通知时判断提前天数和通知人是否为空
function check(){
	var fdIsNotify = $("input[name='fdIsNotify']:checked").val();
	var startDate = document.getElementsByName("fdInsuranceStartTime")[0].value;
	var endDate = document.getElementsByName("fdInsuranceEndTime")[0].value;
	if(startDate!="" && endDate!=""){
		var sd = new Date(startDate.replace(/-/g,"/"));
	    var ed = new Date(endDate.replace(/-/g,"/"));	
	    if(Date.parse(sd) - Date.parse(ed)>0){
		    alert('<bean:message  bundle="km-carmng" key="kmCarmng.error.message10"/>');
		    return false; 
		}	
	}
	if(fdIsNotify=="true"){
	var fdNotifyBeforeDay=document.getElementsByName("fdNotifyBeforeDay")[0].value;
	if(fdNotifyBeforeDay==null||fdNotifyBeforeDay=="") {alert('<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.tip1"/>');return false;}
	if(fdNotifyBeforeDay<0||fdNotifyBeforeDay!=parseInt(fdNotifyBeforeDay)) {alert('<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.tip3"/>');return false;}
	var fdNotifyPersonIds=document.getElementsByName("fdNotifyPersonIds")[0].value;
	if(fdNotifyPersonIds==null||fdNotifyPersonIds==""){alert('<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.tip2"/>');return false;}}
	return true;
	}
//页面加载后判断是否显示配置通知界面
window.onload=function(){
	var fdIsNotify = $("input[name='fdIsNotify']:checked").val();
	if(fdIsNotify=="false"){$("#notifyConfig").hide();}
	
	//给出默认车牌号码、车辆类型和车辆名称
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
<html:form action="/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do" onsubmit="return validateKmCarmngInsuranceInfoForm(this);">
<div id="optBarDiv">
	<c:if test="${kmCarmngInsuranceInfoForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="if(!check())return;Com_Submit(document.kmCarmngInsuranceInfoForm, 'update');">
	</c:if>
	<c:if test="${kmCarmngInsuranceInfoForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="if(!check())return;Com_Submit(document.kmCarmngInsuranceInfoForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="if(!check())return;Com_Submit(document.kmCarmngInsuranceInfoForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInsuranceInfo"/></p>

<center>
<table class="tb_normal" width=95%>
		<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehiclesInfoId"/>
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
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdProductBrand"/>
		</td><td width=35%>
			<html:text property="fdProductBrand"/>
			<span class="txtstrong">*</span>
		</td>		
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdRegisterTime"/>
		</td><td width=35%>
			<html:text styleClass="inputsgl" readonly="true" property="fdRegisterTime"/>
			<a href="#" onclick="selectDateTime('fdRegisterTime');"> <bean:message
				key="dialog.selectTime" /></a>
			<span class="txtstrong">*</span>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceStartTime"/>
		</td><td width=35%>
			<html:text styleClass="inputSgl" readonly="true" property="fdInsuranceStartTime"/>
			<a href="#" onclick="selectDate('fdInsuranceStartTime');"> <bean:message
				key="dialog.selectTime" /></a>
			<span class="txtstrong">*</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceEndTime"/>
		</td><td width=35%>
			<html:text styleClass="inputSgl" readonly="true" property="fdInsuranceEndTime"/>
			<a href="#" onclick="selectDate('fdInsuranceEndTime');"> <bean:message
				key="dialog.selectTime" /></a>
			<span class="txtstrong">*</span><br/><bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.isNotify.tip"/><xform:radio property="fdIsNotify" onValueChange="showNotifyConfig" >
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceNo"/>
		</td><td width=35% >
			<html:text  property="fdInsuranceNo"/><span class="txtstrong">*</span>
		</td>
	</tr>
	<!-- 用于设置保险到期前通知的定时任务 -->
<tr id="notifyConfig">
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.before.day"/>
		</td><td width=35% >
			<html:text property="fdNotifyBeforeDay"/><bean:message key="kmCarmngInsuranceInfo.notify.day.unit" bundle="km-carmng"/><span class="txtstrong">*</span>
		</td>		
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.persons"/>
		</td><td width=35%>
			<html:hidden property="fdNotifyPersonIds"/>
				<html:text property="fdNotifyPersonNames" styleClass="inputsgl" style="width:70%" readonly="true" />
				<a href="#" onclick="Dialog_Address(true, 'fdNotifyPersonIds','fdNotifyPersonNames', ';',ORG_TYPE_PERSON);">
				 <bean:message key="dialog.selectOrg" />
				</a><span class="txtstrong">*</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsurancePrice"/>
		</td><td width=35% >
			<html:text property="fdInsurancePrice"/><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</td>		
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceFee"/>
		</td><td width=35%>
			<html:text property="fdInsuranceFee" /><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsDamag"/>
		</td><td width=35%>
			<sunbor:enums property="fdIsDamag"  enumsType="common_yesno_number" elementType="radio" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsThirdInsurance"/>
		</td><td width=35%>
			<sunbor:enums property="fdIsThirdInsurance"  enumsType="common_yesno_number"  elementType="radio"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsRobInsurance"/>
		</td><td width=35%>
			<sunbor:enums property="fdIsRobInsurance"  enumsType="common_yesno_number"  elementType="radio"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsGlassInsurance"/>
		</td><td width=35%>
			<sunbor:enums property="fdIsGlassInsurance"  enumsType="common_yesno_number"  elementType="radio"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsAbatement"/>
		</td><td width=35%>
			<sunbor:enums property="fdIsAbatement"  enumsType="common_yesno_number"  elementType="radio"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsHeadline"/>
		</td><td width=35%>
			<sunbor:enums property="fdIsHeadline"  enumsType="common_yesno_number"  elementType="radio"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdIsLiability"/>
		</td><td width=35% colspan="3">
			<sunbor:enums   property="fdIsLiability"  enumsType="common_yesno_number"  elementType="radio"/>
		</td>
		
	</tr>
	
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdRemark"/>
		</td><td width=35% colspan="3">
			<html:textarea style="width:100%" property="fdRemark"/>
		</td>
	</tr>
					<tr>
					<%--文档附件--%>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-carmng" key="kmCarmngInsuranceInfo.attachment" /></td>
					<td width="85%" bgcolor="#ffffff" colspan="3"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
					</c:import></td>
				</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.docCreatorId"/>
		</td><td width=35%>
			<html:hidden property="docCreatorId"/>
			<html:text property="docCreatorName" readonly="true"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.docCreateTime"/>
		</td><td width=35%>
			<html:text property="docCreateTime" readonly="true"/>
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="kmCarmngInsuranceInfoForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>