<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
	Com_IncludeFile("docutil.js");
</script>
<div id="optBarDiv">
		<kmss:auth requestURL="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmCarmngInfomation.do?method=edit&fdId=${param.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmCarmngInfomation.do?method=delete&fdId=${param.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInfomation"/></p>
<center>
<table id="Label_Tabel" width=95%>
		<html:hidden name="kmCarmngInfomationForm" property="fdId"/>
	<!-- 车辆信息 -->
	<tr  LKS_LabelName="<bean:message bundle="km-carmng" key="table.kmCarmngInfomation" />">
		<td>
			<table class="tb_normal" width=100%>
	<tr>
		<!-- 车牌号码 -->
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdNo"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdNo}" />
		</td>
		<!-- 车辆名称 -->
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docSubject"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.docSubject}" />
		</td>
		<td colspan="3" rowspan="5">
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="kmCarmngPic" />
			<c:param name="formBeanName" value="kmCarmngInfomationForm" />
			<c:param name="fdAttType" value="pic"/>
		</c:import> 
		</td>
	</tr>
	<tr>
		<!-- 车辆类型 -->
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdVehichesType"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdVehichesTypeName}" />
		</td>
		<!-- 座位数 -->
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdSeatNumber"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdSeatNumber}" />
		</td>
	</tr>
	<tr>
		<!-- 所属车队 -->
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdMotorcadeId"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdMotorcadeName}" />
		</td>
		<!-- 载客/载货量 -->
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdCardParameter"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdCardParameter}" />
		</td>
	</tr>
	<tr>
		<!-- 驾驶员姓名 -->
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdDriverName"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdDriverName}" />
		</td>
		<!-- 定额燃油标准 -->
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdFuelStandard"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdFuelStandard}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdBuyTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdBuyTime}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdAnnuaCheckTime"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdAnnuaCheckTime}" /><br/><bean:message  bundle="km-carmng" key="kmCarmngInfomation.isNotify.tip"/><xform:radio property="fdIsNotify" >
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
	</tr>
	<c:if test="${kmCarmngInfomationForm.fdIsNotify=='true'}">
		<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.before.day"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdNotifyBeforeDay}" /><bean:message key="kmCarmngInsuranceInfo.notify.day.unit" bundle="km-carmng"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.notify.persons"/>
		</td><td colspan="10">
			<c:out value="${kmCarmngInfomationForm.fdNotifyPersonNames}" />
		</td>
	</tr>
	</c:if>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdAnnuaCheckFrequency"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdAnnuaCheckFrequency}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdInsutanceTime"/>
		</td><td colspan="10">
			<c:out value="${kmCarmngInfomationForm.fdInsutanceTime}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdInsutanceComputer"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdInsutanceComputer}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdPassageMoney"/>
		</td><td colspan="10">
			<c:out value="${kmCarmngInfomationForm.fdPassageMoney}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdYearlongTicket"/>
		</td><td width=35%>
			<c:out value="${kmCarmngInfomationForm.fdYearlongTicket}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdRelationPhone"/>
		</td><td colspan="10">
			<c:out value="${kmCarmngInfomationForm.fdRelationPhone}" />
		</td>
	</tr>
	<tr>
		<td  class="td_normal_title" width=15%> 
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docStatus"/>
		</td>
		<td colspan="10">
			<sunbor:enumsShow enumsType = "kmCarmngInformation_status"  value="${kmCarmngInfomationForm.docStatus}"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdRemark"/>
		</td><td width=35% colspan="6">
			<kmss:showText value="${kmCarmngInfomationForm.fdRemark}" />
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
		</td><td width=35% colspan="6">
			<c:out value="${kmCarmngInfomationForm.docCreateTime}" />
		</td>
	</tr>
	</table>
	</td>
	</tr>
	<!-- 历史用车 -->
	<tr  LKS_LabelName="<bean:message bundle="km-carmng" key="kmCarmng.history.record" />">
		<td>
			<table class="tb_normal" width=100%>
				<iframe frameborder="0" style="width:100%;height:400px" src="<c:url value="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=listByCarmngInfo&fdCarId=${kmCarmngInfomationForm.fdId}"/>"></iframe>
			</table>
		</td>
	</tr>
	<!-- 违章信息 -->
	<tr  LKS_LabelName="<bean:message bundle="km-carmng" key="table.kmCarmngInfringeInfo" />">
		<td>
			<table class="tb_normal" width=100%>
			<iframe frameborder="0" style="width:100%;height:400px" 
			src="<c:url value="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=list&fdCarId=${kmCarmngInfomationForm.fdId}&fdNo=${kmCarmngInfomationForm.fdNo}&docSubject=${kmCarmngInfomationForm.docSubject}&fdVehichesType=${kmCarmngInfomationForm.fdVehichesTypeName}&fdDriverId=${kmCarmngInfomationForm.fdDriverId}&fdDriverName=${kmCarmngInfomationForm.fdDriverName}"/>"></iframe>
			</table>
		</td>
	</tr>
	<!-- 车辆保险 -->
	<tr  LKS_LabelName="<bean:message bundle="km-carmng" key="table.kmCarmngInsuranceInfo" />">
		<td>
			<table class="tb_normal" width=100%>
			<iframe frameborder="0" style="width:100%;height:400px" src="<c:url value="/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do?method=list&fdCarId=${kmCarmngInfomationForm.fdId}&fdNo=${kmCarmngInfomationForm.fdNo}&docSubject=${kmCarmngInfomationForm.docSubject}&fdVehichesType=${kmCarmngInfomationForm.fdVehichesTypeName}"/>"></iframe>
			</table>
		</td>
	</tr>
	<!-- 车辆保养 -->
	<tr  LKS_LabelName="<bean:message bundle="km-carmng" key="table.kmCarmngMaintenanceInfo" />">
		<td>
			<table class="tb_normal" width=100%>				
				<iframe frameborder="0" style="width:100%;height:400px" src="<c:url value="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=list&fdCarId=${kmCarmngInfomationForm.fdId}&fdNo=${kmCarmngInfomationForm.fdNo}&docSubject=${kmCarmngInfomationForm.docSubject}&fdVehichesType=${kmCarmngInfomationForm.fdVehichesTypeName}"/>"></iframe>
			</table>
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>