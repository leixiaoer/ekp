<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%> 
<template:include ref="default.edit" sidebar="auto">
	<template:replace name="head">
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
						categoryName = data[0]["fdVehichesTypeName"];	
						text=data[0]["text"];
						document.getElementsByName("fdVehiclesInfoName")[0].value=docSubject;			
						document.getElementsByName("fdVehiclesCategoryName")[0].value=categoryName;	
						document.getElementsByName("fdVehiclesInfoNo")[0].value=text;	
					}
				}
		</script>
	</template:replace>
	<template:replace name="title">
		<c:out value="${ lfn:message('km-carmng:table.kmCarmngMaintenanceInfo') } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:if test="${kmCarmngMaintenanceInfoForm.method_GET=='edit'}">
				<ui:button text="${lfn:message('button.update') }" onclick="Com_Submit(document.kmCarmngMaintenanceInfoForm, 'update');">
				</ui:button>
			</c:if>
			<c:if test="${kmCarmngMaintenanceInfoForm.method_GET=='add'}">
				<ui:button text="${lfn:message('button.save') }" onclick="Com_Submit(document.kmCarmngMaintenanceInfoForm, 'save');">
				</ui:button>
				<ui:button text="${lfn:message('button.saveadd') }" onclick="Com_Submit(document.kmCarmngMaintenanceInfoForm, 'saveadd');">
				</ui:button>
			</c:if>
			<ui:button text="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngMaintenanceInfo"/></p>
		<html:form action="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do">
			<html:hidden property="fdId"/>
			<html:hidden property="docCreatorId"/>
			<html:hidden property="docCreateTime" />
			<html:hidden property="method_GET"/>
			<div class="lui_form_content_frame" style="padding-top: 20px;">	
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdVehiclesInfoId"/>
						</td><td width=35%>
							<xform:dialog propertyId="fdVehiclesInfoId" propertyName="fdVehiclesInfoNo" style="width:40%" required="true" subject="${lfn:message('km-carmng:kmCarmngMaintenanceInfo.fdVehiclesInfoId')}">
								Dialog_TreeList(false, 
								 'fdVehiclesInfoId', 
								 'fdVehiclesInfoNo', 
								 ';', 
								 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
								 '<bean:message key="table.kmCarmngInfomation" bundle="km-carmng"/>',
								  'kmCarmngInfomationTreeService&fdMotorcadeId=!{value}', afterSelectVehicles,
								   null, null, null,
								   '<bean:message key="table.kmCarmngInfomation" bundle="km-carmng"/>')
							</xform:dialog>
						</td>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/>
						</td>
						<td width="35%">
							<html:text readonly="true" property="fdVehiclesInfoName"  style="width:100%" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdCategoryName"/>
						</td>
						<td>
							<html:text readonly="true" property="fdVehiclesCategoryName"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdMaintenanceTime"/>
						</td><td width=35%>
							<xform:datetime property="fdMaintenanceTime" required="true" dateTimeType="date"></xform:datetime>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdMaintenanceFee"/>
						</td><td width=35%>
							<input type="text" name="fdMaintenanceFee" value="<kmss:showNumber value="${kmCarmngMaintenanceInfoForm.fdMaintenanceFee}" pattern="0.00#"/>" validate="currency-dollar min(0) required" maxlength="100" class="inputsgl" subject='<bean:message bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdMaintenanceFee"/>'>
							<span class="txtstrong">*</span>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdPersonId"/>
						</td><td width=35%>
						   <xform:dialog propertyId="fdPersonId" propertyName="fdPersonName" style="width:40%" required="true" subject="${lfn:message('km-carmng:kmCarmngMaintenanceInfo.fdPersonId')}">
								Dialog_TreeList(false, 
								 'fdPersonId', 
								 'fdPersonName', 
								 ';', 
								 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
								 '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>',
								  'kmCarmngDriverInfoTreeService&motorcadeId=!{value}', null,
								   null, null, null,
								   '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>')
							</xform:dialog>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdRepairFee"/>
						</td><td width=35% colspan="3">
							<input type="text" name="fdRepairFee" value="<kmss:showNumber value="${kmCarmngMaintenanceInfoForm.fdRepairFee}" pattern="0.00#"/>" validate="currency-dollar min(0) required" maxlength="100" class="inputsgl" subject='<bean:message bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdRepairFee"/>'>
							<span class="txtstrong">*</span>
							<bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fee.unit"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdRemark"/>
						</td><td width=35% colspan="3">
							<xform:textarea style="width:100%" htmlElementProperties="data-actor-expand='true'" property="fdRemark"/>
						</td>
					</tr>
					<tr>
						<%--文档附件--%>
						<td width="15%" class="td_normal_title"><bean:message
							bundle="km-carmng" key="kmCarmngInsuranceInfo.attachment" /></td>
						<td width="85%" bgcolor="#ffffff" colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attachment" />
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
		</html:form>
		<script language="JavaScript">
		$KMSSValidation(document.forms['kmCarmngMaintenanceInfoForm']);
		</script>
	</template:replace>
</template:include>

