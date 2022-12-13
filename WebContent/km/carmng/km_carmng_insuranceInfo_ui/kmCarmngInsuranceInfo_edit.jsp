<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%> 
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>

<template:include ref="default.edit" sidebar="auto">
	<template:replace name="head">
		<script type="text/javascript">
		Com_IncludeFile("dialog.js|jquery.js|calendar.js", null, "js");
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
		<script type="text/javascript">
		seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
			window.showNotifyConfig = function(value,_this){
				if(value=="true"){
					$("#notifyConfig").show();
					document.getElementById("NotifyBeforeDay").setAttribute("validate", "required");
					document.getElementById("NotifyPerson").setAttribute("validate", "required");
			}else{
				document.getElementById("NotifyBeforeDay").setAttribute("validate", "");
				document.getElementById("NotifyPerson").setAttribute("validate", "");
				$("#notifyConfig").hide();
			}};
			//当选择通知时判断提前天数和通知人是否为空
			window.check =function(){
				var fdIsNotify = $("input[name='fdIsNotify']:checked").val();
				var startDate = document.getElementsByName("fdInsuranceStartTime")[0].value;
				var endDate = document.getElementsByName("fdInsuranceEndTime")[0].value;
				if(startDate!="" && endDate!=""){
					var sd = new Date(startDate.replace(/-/g,"/"));
				    var ed = new Date(endDate.replace(/-/g,"/"));	
				    if(Date.parse(sd) - Date.parse(ed)>0){
					    dialog.alert('<bean:message  bundle="km-carmng" key="kmCarmng.error.message10"/>');
					    return false; 
					}	
				}
				return true;
				};
			//页面加载后判断是否显示配置通知界面
			LUI.ready( function() {
				var fdIsNotify = $("input[name='fdIsNotify']:checked").val();
				if(fdIsNotify=="false"){
					document.getElementById("NotifyBeforeDay").setAttribute("validate", "");
					document.getElementById("NotifyPerson").setAttribute("validate", "");
					$("#notifyConfig").hide();
				}
				
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
			});
		});
		</script>
	</template:replace>
	<template:replace name="title">
		<c:choose>
			<c:when test="${kmCarmngInsuranceInfoForm.method_GET=='add'}">
				<c:out value="${ lfn:message('km-carmng:kmCarmngApplication.add') } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
			</c:when>
			<c:when test="${kmCarmngInsuranceInfoForm.method_GET=='edit'}">
				<c:out value="${kmCarmngInsuranceInfoForm.fdVehiclesInfoNo} - ${lfn:message('km-carmng:module.km.carmng')}"></c:out>
			</c:when>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:if test="${kmCarmngInsuranceInfoForm.method_GET=='edit'}">
				<ui:button text="${lfn:message('button.update') }" onclick="if(!check())return;Com_Submit(document.kmCarmngInsuranceInfoForm, 'update');">
				</ui:button>
			</c:if>
			<c:if test="${kmCarmngInsuranceInfoForm.method_GET=='add'}">
				<ui:button text="${lfn:message('button.save') }" onclick="if(!check())return;Com_Submit(document.kmCarmngInsuranceInfoForm, 'save');">
				</ui:button>
				<ui:button text="${lfn:message('button.saveadd') }" onclick="if(!check())return;Com_Submit(document.kmCarmngInsuranceInfoForm, 'saveadd');">
				</ui:button>
			</c:if>
			<ui:button text="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInsuranceInfo"/></p>
		<html:form action="/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do">
			<html:hidden property="fdId"/>
			<html:hidden property="fdVehiclesInfoId"/>
			<html:hidden property="fdNotifyPersonIds"/>
			<html:hidden property="docCreatorId"/>
			<html:hidden property="docCreateTime" />
			<html:hidden property="method_GET"/>
			<div class="lui_form_content_frame" style="padding-top: 20px;">	
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehiclesInfoId"/>
						</td><td width=35%>
							<xform:text style="inputsgl" property="fdVehiclesInfoNo" required="true"/>
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
						</td>
						<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/>
						</td>
						<td width="35%">
							<html:text readonly="true" property="fdVehiclesInfoName" style="width:100%" />
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
							<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdProductBrand"/>
						</td><td width=35%>
							<xform:text property="fdProductBrand" required="true"/>
						</td>		
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdRegisterTime"/>
						</td><td width=35%>
							<xform:datetime property="fdRegisterTime" dateTimeType="date" style="width:35%" required="true"></xform:datetime>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceStartTime"/>
						</td><td width=35%>
							<xform:datetime property="fdInsuranceStartTime" dateTimeType="date" style="width:35%" required="true"></xform:datetime>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceEndTime"/>
						</td><td width=35%>
							<xform:datetime property="fdInsuranceEndTime" style="width:35%" dateTimeType="date" required="true"></xform:datetime>
							<br/><bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.isNotify.tip"/><xform:radio property="fdIsNotify" onValueChange="showNotifyConfig" >
								<xform:enumsDataSource enumsType="common_yesno" />
							</xform:radio>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceNo"/>
						</td><td width=35% >
							<xform:text  property="fdInsuranceNo" required="true"/>
						</td>
					</tr>
					<!-- 用于设置保险到期前通知的定时任务 -->
				<tr id="notifyConfig">
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.before.day"/>
						</td><td width=35% >
							<xform:text property="fdNotifyBeforeDay" required="true" subject="${lfn:message('km-carmng:kmCarmngInsuranceInfo.notify.before.day')}" htmlElementProperties="id='NotifyBeforeDay'"/><bean:message key="kmCarmngInsuranceInfo.notify.day.unit" bundle="km-carmng"/>
						</td>		
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.persons"/>
						</td><td width=35%>
							<xform:address propertyName="fdNotifyPersonNames" subject="${lfn:message('km-carmng:kmCarmngInsuranceInfo.notify.persons')}" htmlElementProperties="id='NotifyPerson'" propertyId="fdNotifyPersonIds" orgType="ORG_TYPE_PERSON" required="true" style="width:35%"></xform:address>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsurancePrice"/>
						</td><td width=35% >
							<input type="text" name="fdInsurancePrice" value="<kmss:showNumber value="${kmCarmngInsuranceInfoForm.fdInsurancePrice}" pattern="0.00#"/>" validate="currency-dollar min(0) required" maxlength="100" class="inputsgl" subject='<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsurancePrice"/>'>
							<span class="txtstrong">*</span>
							<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
						</td>		
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceFee"/>
						</td><td width=35%>
							<input type="text" name="fdInsuranceFee" value="<kmss:showNumber value="${kmCarmngInsuranceInfoForm.fdInsuranceFee}" pattern="0.00#"/>" validate="currency-dollar min(0) required" maxlength="100" class="inputsgl" subject='<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsuranceFee"/>'>
							<span class="txtstrong">*</span>
							<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
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
		</html:form>
		<script language="JavaScript">
		$KMSSValidation(document.forms['kmCarmngInsuranceInfoForm']);
		</script>
	</template:replace>
</template:include>

