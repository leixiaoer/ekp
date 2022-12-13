<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<script type="text/javascript">
Com_IncludeFile("docutil.js|dialog.js|calendar.js|jquery.js");
function afterSelectDrivers(rtnVal){
	if(rtnVal == null){
		return;
	}
	var data = rtnVal.GetHashMapArray();
	if( data.length > 0){
		var fdRelationPhone = data[0]["fdRelationPhone"];
		document.getElementsByName("fdRelationPhone")[0].value=fdRelationPhone;	
		if(data[0]["sysId"]==null){
			document.getElementsByName("fdSysDriverId")[0].value="";
		}else{	
			document.getElementsByName("fdSysDriverId")[0].value=data[0]["sysId"];
		}
	}
}
function showNotifyConfig(value,_this){
	if(value=="true"){
		$("#notifyConfig").show();
		$("#annuaCheckId").show();$("#frequencyId").show();
}else{
	$("#notifyConfig").hide();
	$("#annuaCheckId").hide();$("#frequencyId").hide();
}}
//当选择通知时判断提前天数和通知人是否为空
function check(){
	var fdIsNotify = $("input[name='fdIsNotify']:checked").val();
	if(fdIsNotify=="true"){
	var fdNotifyBeforeDay=document.getElementsByName("fdNotifyBeforeDay")[0].value;
	if(fdNotifyBeforeDay==null||fdNotifyBeforeDay=="") {alert('<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.tip1"/>');return false;}
	if(fdNotifyBeforeDay<0||fdNotifyBeforeDay!=parseInt(fdNotifyBeforeDay)) {alert('<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.tip3"/>');return false;}
	var fdAnnuaCheckTime=document.getElementsByName("fdAnnuaCheckTime")[0].value;
	if(fdAnnuaCheckTime==null||fdAnnuaCheckTime==""){alert('<bean:message  bundle="km-carmng" key="kmCarmngInfomation.error1"/>');return false;}
	var fdAnnuaCheckFrequency=document.getElementsByName("fdAnnuaCheckFrequency")[0].value;
	if(fdAnnuaCheckFrequency==null||fdAnnuaCheckFrequency==""){alert('<bean:message  bundle="km-carmng" key="kmCarmngInfomation.error2"/>');return false;}
	if(fdAnnuaCheckFrequency<=0||fdAnnuaCheckFrequency!=parseInt(fdAnnuaCheckFrequency)){alert('<bean:message  bundle="km-carmng" key="kmCarmngInfomation.error3"/>');return false;}
	var fdNotifyPersonIds=document.getElementsByName("fdNotifyPersonIds")[0].value;
	if(fdNotifyPersonIds==null||fdNotifyPersonIds==""){alert('<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.tip2"/>');return false;}}
	return true;
	}
//页面加载后判断是否显示配置通知界面
window.onload=function(){
	var fdIsNotify = $("input[name='fdIsNotify']:checked").val();
	if(fdIsNotify=="false"){$("#notifyConfig").hide();$("#annuaCheckId").hide();$("#frequencyId").hide();}
}
</script>
<html:form action="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do" onsubmit="return validateKmCarmngInfomationForm(this);">
<div id="optBarDiv">
	<c:if test="${kmCarmngInfomationForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="if(!check())return;Com_Submit(document.kmCarmngInfomationForm, 'update');">
	</c:if>
	<c:if test="${kmCarmngInfomationForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="if(!check())return;Com_Submit(document.kmCarmngInfomationForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="if(!check())return;Com_Submit(document.kmCarmngInfomationForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInfomation"/></p>

<center>
<table class="tb_normal" width=95%>
		<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdNo"/>
		</td><td width=30%>
			<html:text property="fdNo" size="30"/>
			<span class="txtstrong">*</span>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docSubject"/>
		</td><td width=30%>
			<html:text property="docSubject" size="60" /><span class="txtstrong">*</span>
		</td>
		<td colspan="3" rowspan="8" style="width: 160px;">
		<div style="width: 160px;">
		 <c:import
			url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="fdKey" value="kmCarmngPic" />
			<c:param name="fdMulti" value="false" />
			<c:param name="fdAttType" value="pic" />
			<c:param name="fdImgHtmlProperty" value="width=120" />
			<c:param name="fdModelId" value="${kmCarmngInfomation.fdId}" />
			<c:param name="fdModelName"
				value="com.landray.kmss.km.carmng.model.KmCarmngInformation" />
			<%-- 图片设定大小 --%>
			<c:param name="picWidth" value="150" />
			<c:param name="picHeight" value="100" />
		</c:import>
		</div>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdVehichesType"/>
		</td><td width=35%>
			<html:hidden property="fdVehichesTypeId"/>
			<html:text styleClass="inputsgl" readonly="true" property="fdVehichesTypeName"/>
			<a href="#"
						onclick="Dialog_Tree(false, 
				 'fdVehichesTypeId', 
				 'fdVehichesTypeName', 
				 ',', 
				 'kmCarmngCategoryTreeService&categoryId=!{value}', 
				 '<bean:message key="table.kmCarmngCategory" bundle="km-carmng"/>',
				  null, null,
				   null, null, null,
				   '<bean:message key="table.kmCarmngCategory" bundle="km-carmng"/>')"><bean:message
						key="dialog.selectOther" /> </a><span class="txtstrong">*</span>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdSeatNumber"/>
		</td><td width=35%>
			<html:text property="fdSeatNumber"/><span class="txtstrong">*</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdMotorcadeId"/>
		</td><td width=35%>
			<kmss:dropList property = "fdMotorcadeId" serviceBean = "kmCarmngMotorcadeSetService" readValue = "true" />
			<span class="txtstrong">*</span>
			
		</td>
			<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdDriverName"/>
		</td><td  width=35%>
			<html:hidden property="fdDriverId"/>
			<html:text property="fdDriverName"/>
			<html:hidden
				property="fdSysDriverId" />
		   <a href="#"
						onclick="Dialog_TreeList(false, 
				 'fdDriverId', 
				 'fdDriverName', 
				 ';', 
				 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
				 '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>',
				  'kmCarmngDriverInfoTreeService&motorcadeId=!{value}', afterSelectDrivers,
				   null, null, null,
				   '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>')"><bean:message
						key="dialog.selectOther" /> </a>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdCardParameter"/>
		</td><td width=35%>
			<html:text property="fdCardParameter"/>
		</td>
			<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdFuelStandard"/>
		</td><td width=35%>
			<html:text property="fdFuelStandard"/>
		</td>
	</tr>	
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdBuyTime"/>
		</td><td width=35%>
			<html:text styleClass="inputsgl" readonly="true" property="fdBuyTime"/>
			<a href="#" onclick="selectDateTime('fdBuyTime');"> <bean:message
				key="dialog.selectTime" /></a>	

		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdAnnuaCheckTime"/>
		</td><td width=35%>
			<html:text styleClass="inputsgl" readonly="true" property="fdAnnuaCheckTime"/>
			<a href="#" onclick="selectDate('fdAnnuaCheckTime');"> <bean:message
				key="dialog.selectTime" /></a><span class="txtstrong" id="annuaCheckId">*</span>	<br/><bean:message  bundle="km-carmng" key="kmCarmngInfomation.isNotify.tip"/><xform:radio property="fdIsNotify" onValueChange="showNotifyConfig" >
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
				
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
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdAnnuaCheckFrequency"/>
		</td><td width=35%>
			<html:text property="fdAnnuaCheckFrequency"/>
			<bean:message  bundle="km-carmng" key="kmCarmng.message.frequency"/>
			<span class="txtstrong" id="frequencyId">*</span>	
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdInsutanceTime"/>
		</td><td width=35%>
			<html:text styleClass="inputsgl" readonly="true" property="fdInsutanceTime"/>
			<a href="#" onclick="selectDate('fdInsutanceTime');"> <bean:message
				key="dialog.selectTime" /></a>	
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdInsutanceComputer"/>
		</td><td width=35%>
			<html:text property="fdInsutanceComputer"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdPassageMoney"/>
		</td><td width=15%>
			<html:text property="fdPassageMoney"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdYearlongTicket"/>
		</td><td width=35%>
			<html:text property="fdYearlongTicket"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdRelationPhone"/>
		</td><td colspan="10">
			<html:text property="fdRelationPhone"/>
		</td>
	</tr>
	<tr>
		<td  class="td_normal_title" width=15%> 
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docStatus"/>
		</td>
		<td colspan="10">
			<sunbor:enums enumsType = "kmCarmngInformation_status" bundle="km-carmng" elementType ="select" property="docStatus"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdRemark"/>
		</td><td width=35% colspan="6">
			<html:textarea style="width:100%" property="fdRemark"/>
		</td>
	</tr>
	
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docCreatorId"/>
		</td><td width=35%>
			<html:hidden property="docCreatorId"/>
			<html:text readonly="true" property="docCreatorName"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docCreateTime"/>
		</td><td width=35% colspan="4">
			<html:text readonly="true" property="docCreateTime"/>
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="kmCarmngInfomationForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>