<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.edit" sidebar="auto">
	<template:replace name="head">
		<script type="text/javascript">
		Com_IncludeFile("dialog.js|calendar.js", null, "js");
		</script>
		<script type="text/javascript">
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
		function vehiclesInfoNoTree(){
			Dialog_TreeList(false, 'fdVehiclesInfoId','fdVehiclesInfoNo', ';', 
					 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
					 '<bean:message key="table.kmCarmngInfomation" bundle="km-carmng"/>',
					  'kmCarmngInfomationTreeService&fdMotorcadeId=!{value}', afterSelectVehicles,
					   null, null, null,
					   '<bean:message key="table.kmCarmngInfomation" bundle="km-carmng"/>');
		}
		function infringePersonTree(){
			Dialog_TreeList(false, 'fdInfringePersonId',  'fdInfringePersonName', ';',  
					 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
					 '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>',
					  'kmCarmngDriverInfoTreeService&motorcadeId=!{value}', 
					   null, null, null, null,
					   '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>');
		}
		seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
			LUI.ready( function() {
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
			});
		});
		</script>
	</template:replace>
	<template:replace name="title">
		<c:choose>
			<c:when test="${kmCarmngInfringeInfoForm.method_GET=='add'}">
				<c:out value="${ lfn:message('km-carmng:kmCarmngApplication.add') } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
			</c:when>
			<c:when test="${kmCarmngInfringeInfoForm.method_GET=='edit'}">
				<c:out value="${kmCarmngInfringeInfoForm.fdVehiclesInfoName}- ${lfn:message('km-carmng:module.km.carmng')}"></c:out>
			</c:when>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:if test="${kmCarmngInfringeInfoForm.method_GET=='edit'}">
				<ui:button text="${lfn:message('button.update') }" onclick="Com_Submit(document.kmCarmngInfringeInfoForm, 'update');">
				</ui:button>
			</c:if>
			<c:if test="${kmCarmngInfringeInfoForm.method_GET=='add'}">
				<ui:button text="${lfn:message('button.save') }" onclick="Com_Submit(document.kmCarmngInfringeInfoForm, 'save');">
				</ui:button>
				<ui:button text="${lfn:message('button.saveadd') }" onclick="Com_Submit(document.kmCarmngInfringeInfoForm, 'saveadd');">
				</ui:button>
			</c:if>
			<ui:button text="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInfringeInfo"/></p>
		
		<html:form action="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do">
			<html:hidden property="fdId"/>
			<html:hidden property="fdVehiclesInfoId"/>
			<html:hidden property="fdInfringePersonId"/>
			<html:hidden property="docCreatorId"/>
			<html:hidden property="docCreateTime" />
			<html:hidden property="method_GET"/>
			
			<div class="lui_form_content_frame" style="padding-top: 20px;">	
				<table class="tb_normal" width=100%>
					<tr>
						<!-- 车牌号码 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngInfringeInfo.fdVehiclesInfoId"/>
						</td><td width=35%>
						    <input name="fdVehiclesInfoNo" subject='<bean:message bundle="km-carmng" key="kmCarmngInfringeInfo.fdVehiclesInfoId"/>' 
							class="inputsgl"  type="text" value="${lfn:escapeHtml(kmCarmngInfringeInfoForm.fdVehiclesInfoNo)}" 
							validate="required"  onclick="javascript:vehiclesInfoNoTree();">
							<span class="txtstrong">*</span>
							<a href="#" onclick="javascript:vehiclesInfoNoTree();"><bean:message key="dialog.selectOther" /></a>
						</td>
						<td class="td_normal_title" width=15%><bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/></td>
						<td width="35%"><html:text readonly="true" property="fdVehiclesInfoName"  style="width:100%"/></td>
					</tr>
					<tr>		
						<td class="td_normal_title" width=15%><bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdCategoryName"/></td>
						<td><html:text readonly="true" property="fdVehiclesCategoryName"/></td>
						<!-- 违章时间 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeTime"/>
						</td><td width=35%>
							<xform:datetime property="fdInfringeTime" required="true" htmlElementProperties="readonly" validators="before"></xform:datetime>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringePerson"/>
						</td><td width=35%>
							<input name="fdInfringePersonName" subject='<bean:message bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringePerson"/>' 
							class="inputsgl"  type="text" value="${lfn:escapeHtml(kmCarmngInfringeInfoForm.fdInfringePersonName)}" 
							validate="required"  onclick="javascript:infringePersonTree();">
							<span class="txtstrong">*</span>
							<a href="#" onclick="javascript:infringePersonTree();"><bean:message key="dialog.selectOther" /></a>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeFee"/>
						</td><td width=35%>
							<input type="text" name="fdInfringeFee" value="<kmss:showNumber value="${kmCarmngInfringeInfoForm.fdInfringeFee}" pattern="0.00#"/>" validate="currency-dollar min(0) required" maxlength="100" class="inputsgl" subject='<bean:message bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeFee"/>'>
							<span class="txtstrong">*</span>
							<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>		
						</td>
						
					</tr>
					<!-- 违章地点 -->
					<tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeSite"/>
						</td><td width="85%" colspan="3">
							<xform:text property="fdInfringeSite" required="true" style="width:97%"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdRemark"/>
						</td><td width=35% colspan="3">
							<xform:textarea style="width:100%" htmlElementProperties="data-actor-expand='true'" property="fdRemark" validators="maxLength(2000)"/>
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
			</div>
		</html:form>
		<script language="JavaScript">
		$KMSSValidation(document.forms['kmCarmngInfringeInfoForm']);
		</script>
	</template:replace>
</template:include>

