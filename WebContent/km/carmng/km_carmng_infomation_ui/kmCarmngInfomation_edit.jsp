<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>

<template:include ref="default.edit" sidebar="auto">
	<template:replace name="head">
		<script type="text/javascript">
			Com_IncludeFile("docutil.js|dialog.js|calendar.js|jquery.js");

			seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
				LUI.ready( function() {
					var fdIsNotify = $("input[name='fdIsNotify']:checked").val();
					if(fdIsNotify=="false"){
						document.getElementById("NotifyBeforeDay").setAttribute("validate", "");
						document.getElementById("NotifyPerson").setAttribute("validate", "");
						$("#notifyConfig").hide();
					}
				});
				window.afterSelectDrivers = function(rtnVal){
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
				};
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
			});

			function addCategory(){
				seajs.use(['lui/dialog'],function(dialog){
					dialog.simpleCategory('com.landray.kmss.km.carmng.model.KmCarmngCategory','fdVehichesTypeId','fdVehichesTypeName',false,null,null,true,null,false);
				});
			}
			</script>
	</template:replace>
	<template:replace name="title">
		<c:choose>
			<c:when test="${kmCarmngInfomationForm.method_GET=='add'}">
				<c:out value="${ lfn:message('km-carmng:kmCarmngApplication.add') } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
			</c:when>
			<c:when test="${kmCarmngInfomationForm.method_GET=='edit'}">
				<c:out value="${kmCarmngInfomationForm.fdNo} - ${lfn:message('km-carmng:module.km.carmng')}"></c:out>
			</c:when>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:if test="${kmCarmngInfomationForm.method_GET=='edit'}">
				<ui:button text="${lfn:message('button.update') }" onclick="Com_Submit(document.kmCarmngInfomationForm, 'update');">
				</ui:button>
			</c:if>
			<c:if test="${kmCarmngInfomationForm.method_GET=='add'}">
				<ui:button text="${lfn:message('button.save') }" onclick="Com_Submit(document.kmCarmngInfomationForm, 'save');">
				</ui:button>
				<ui:button text="${lfn:message('button.saveadd') }" onclick="Com_Submit(document.kmCarmngInfomationForm, 'saveadd');">
				</ui:button>
			</c:if>
			<ui:button text="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInfomation"/></p>
		<html:form action="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do">
			<html:hidden property="fdId"/>
			<html:hidden property="fdSysDriverId" />
			<html:hidden property="fdNotifyPersonIds"/>
			<html:hidden property="docCreatorId"/>
			<html:hidden property="docCreateTime"/>
			<html:hidden property="method_GET"/>
			
			<div class="lui_form_content_frame" style="padding-top: 20px;">	
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdNo"/>
						</td><td width=30%>
							<xform:text property="fdNo" required="true"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docSubject"/>
						</td><td width=30%>
							<xform:text property="docSubject" required="true"/>
						</td>
						<td colspan="3" rowspan="8" style="width: 160px;">
						<div style="min-width:160px;">
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
								<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdVin"/>
							</td><td width=35%>
								<xform:text property="fdVin" required="true"/>
						</td>
						<td class="td_normal_title" width=15%>
								<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdEngineNumber"/>
							</td><td width=35%>
								<xform:text property="fdEngineNumber" required="true"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdVehichesType"/>
						</td>
						<td width=35%>
							<xform:dialog propertyId="fdVehichesTypeId" propertyName="fdVehichesTypeName" style="width:42%" required="true" htmlElementProperties="readonly='true'" subject="${lfn:message('km-carmng:kmCarmngInfomation.fdVehichesType')}">
								addCategory();
							</xform:dialog>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdSeatNumber"/>
						</td><td width=35%>
							<xform:text property="fdSeatNumber" required="true"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdMotorcadeId"/>
						</td><td width=35%>
							<xform:select property="fdMotorcadeId" showPleaseSelect="true" showStatus="edit" required="true" style="width:35%">
								<xform:beanDataSource serviceBean="kmCarmngMotorcadeSetService" whereBlock="kmCarmngMotorcadeSet.isEffective = 'true' or kmCarmngMotorcadeSet.isEffective is null" orderBy="kmCarmngMotorcadeSet.fdId desc" />
							</xform:select>
						</td>
							<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdDriverName"/>
						</td><td  width=35%>
						 <xform:dialog propertyId="fdDriverId" propertyName="fdDriverName" style="width:42%">
							Dialog_TreeList(false, 
								 'fdDriverId', 
								 'fdDriverName', 
								 ';', 
								 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
								 '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>',
								  'kmCarmngDriverInfoTreeService&motorcadeId=!{value}', afterSelectDrivers,
								   null, null, null,
								   null)
						</xform:dialog>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdCardParameter"/>
						</td><td width=35%>
							<xform:text property="fdCardParameter"/>
						</td>
							<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdFuelStandard"/>
						</td><td width=35%>
							<xform:text property="fdFuelStandard"/>
						</td>
					</tr>	
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdBuyTime"/>
						</td><td width=35%>
							<xform:datetime property="fdBuyTime"></xform:datetime>
				
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdAnnuaCheckTime"/>
						</td><td width=35%>
							<xform:datetime property="fdAnnuaCheckTime" required="true" dateTimeType="date"></xform:datetime>	
							<br/><bean:message  bundle="km-carmng" key="kmCarmngInfomation.isNotify.tip"/><xform:radio property="fdIsNotify" onValueChange="showNotifyConfig" >
								<xform:enumsDataSource enumsType="common_yesno" />
							</xform:radio>
								
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
							<xform:address style="width:45%" subject="${lfn:message('km-carmng:kmCarmngInsuranceInfo.notify.persons')}" propertyName="fdNotifyPersonNames" required="true" htmlElementProperties="id='NotifyPerson'" propertyId="fdNotifyPersonIds" orgType="ORG_TYPE_PERSON"></xform:address>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdAnnuaCheckFrequency"/>
						</td><td width=35%>
							<xform:text property="fdAnnuaCheckFrequency" required="true" validators="digits min(0)"/>
							<!-- #131778 新增半年检改成下拉框的形式  -->
							<%-- <bean:message  bundle="km-carmng" key="kmCarmng.message.frequency"/> --%>
								<xform:select property="fdUnit"
										htmlElementProperties="id='fdUnit'" showStatus="edit" showPleaseSelect="false">
										<xform:enumsDataSource enumsType="kmCarmngInfomation_type_unit" />
								</xform:select>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdInsutanceTime"/>
						</td><td width=35%>
							<xform:datetime property="fdInsutanceTime" dateTimeType="date"></xform:datetime>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdInsutanceComputer"/>
						</td><td width=35%>
							<xform:text property="fdInsutanceComputer"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdPassageMoney"/>
						</td><td width=15%>
							<c:if test="${not empty kmCarmngInfomationForm.fdPassageMoney}">
								<input type="text" name="fdPassageMoney" value="<kmss:showNumber value="${kmCarmngInfomationForm.fdPassageMoney}" pattern="##0.00####"/>" validate="number min(0)" style="width:95%;" class="inputsgl">
							</c:if>
							<c:if test="${empty kmCarmngInfomationForm.fdPassageMoney}">
								<xform:text property="fdPassageMoney" validators="number min(0)" style="width:95%;"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdYearlongTicket"/>
						</td><td width=35%>
							<xform:text property="fdYearlongTicket"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdRelationPhone"/>
						</td><td colspan="10">
							<xform:text property="fdRelationPhone" validators="phoneNumber"/>
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
							<xform:textarea style="width:100%" htmlElementProperties="data-actor-expand='true'" property="fdRemark"/>
						</td>
					</tr>
					
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docCreatorId"/>
						</td><td width=35%>
							<c:out value="${kmCarmngInfomationForm.docCreatorName}" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docCreateTime"/>
						</td><td width=35% colspan="4">
							<c:out value="${kmCarmngInfomationForm.docCreateTime}" />
						</td>
					</tr>
				</table>
			</div>
		</html:form>
		<script language="JavaScript">
		$KMSSValidation(document.forms['kmCarmngInfomationForm']);
		</script>
	</template:replace>
</template:include>

