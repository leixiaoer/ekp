<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="title">
		<c:out value="${ kmCarmngInfomationForm.docSubject } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<script>
			Com_IncludeFile("docutil.js");

			seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
				window.deleteInfo = function(delUrl){
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(isOk){
						if(isOk){
							Com_OpenWindow(delUrl,'_self');
						}	
					});
					return;
				};
			});
		</script>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
			<kmss:auth requestURL="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=edit&motorcadeId=${kmCarmngInfomationForm.fdMotorcadeId}&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('kmCarmngInfomation.do?method=edit&motorcadeId=${kmCarmngInfomationForm.fdMotorcadeId}&fdId=${param.fdId}','_self');">
				</ui:button>
			</kmss:auth>
			<kmss:auth requestURL="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=delete&motorcadeId=${kmCarmngInfomationForm.fdMotorcadeId}&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}" onclick="deleteInfo('${LUI_ContextPath}/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=delete&motorcadeId=${kmCarmngInfomationForm.fdMotorcadeId}&fdId=${param.fdId}');">
				</ui:button>
			</kmss:auth>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }"  href="/km/carmng/" target="_self" >
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:kmCarmngInfomation.all') }" href="/km/carmng/km_carmng_info_ui/index.jsp" target="_self">
			</ui:menu-item>
			<ui:menu-item text="${kmCarmngInfomationForm.docSubject}">
			</ui:menu-item>
		</ui:menu>
	</template:replace>
	<template:replace name="content"> 
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInfomation"/></p>
		
		<div style="background:#fff; padding:16px;">
			<html:form action="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do">
				<html:hidden name="kmCarmngInfomationForm" property="fdId"/>
				
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
							<div style="min-width:150px">
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="kmCarmngPic" />
									<c:param name="formBeanName" value="kmCarmngInfomationForm" />
									<c:param name="fdAttType" value="pic"/>
								</c:import> 
							</div>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
								<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdVin"/>
						</td><td width=35%>
								<c:out value="${kmCarmngInfomationForm.fdVin}" />
						</td>
						<td class="td_normal_title" width=15%>
								<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdEngineNumber"/>
						</td><td width=35%>
							<c:out value="${kmCarmngInfomationForm.fdEngineNumber}" />
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
						<!-- 年检频率 -->
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdAnnuaCheckFrequency"/>
						</td><td width=35%>
							<c:out value="${kmCarmngInfomationForm.fdAnnuaCheckFrequency}" />
							<c:if test="${kmCarmngInfomationForm.fdUnit =='1' || empty kmCarmngInfomationForm.fdUnit}">
								<bean:message key="kmCarmng.message.frequency" bundle="km-carmng"/>
							</c:if>
							<c:if test="${kmCarmngInfomationForm.fdUnit =='2'}">
								<bean:message key="kmCarmng.message.frequency.month" bundle="km-carmng"/>
							</c:if>
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
			</html:form>
		</div>
		<ui:tabpage expand="false">
			<!-- 历史用车 -->
			<ui:content title="${ lfn:message('km-carmng:kmCarmng.history.record') }">
				<ui:event event="show">
							var iframe = document.getElementById("historyRecord").getElementsByTagName("IFRAME")[0];
							if(iframe.getAttribute('src')=="" || isRefresh){
								iframe.src = "../km_carmng_dispatchers_info/kmCarmngDispatchersInfo_infoList.jsp?fdCarId=${kmCarmngInfomationForm.fdId}";
							}
				</ui:event>	
				<table class="tb_normal" width="100%">
							<tr><td id="historyRecord"><iframe src="" width=100% height=100% frameborder=0 scrolling=no></iframe></td></tr>
			    </table>
			</ui:content>
			<!-- 违章信息 -->
			<ui:content title="${ lfn:message('km-carmng:table.kmCarmngInfringeInfo') }">
				<ui:event event="show">
							var iframe = document.getElementById("infringeInfo").getElementsByTagName("IFRAME")[0];
							if(iframe.getAttribute('src')=="" || isRefresh){
								iframe.src = "../km_carmng_infringeInfo_ui/kmCarmngInfringeInfo_infoList.jsp?fdCarId=${kmCarmngInfomationForm.fdId}";
							}
				</ui:event>	
				<table class="tb_normal" width="100%">
							<tr><td id="infringeInfo"><iframe src="" width=100% height=100% frameborder=0 scrolling=no></iframe></td></tr>
			    </table>
			</ui:content>
			<!-- 车辆保险 -->
			<ui:content title="${ lfn:message('km-carmng:table.kmCarmngInsuranceInfo') }">
				<ui:event event="show">
							var iframe = document.getElementById("insuranceInfo").getElementsByTagName("IFRAME")[0];
							if(iframe.getAttribute('src')=="" || isRefresh){
								iframe.src = "../km_carmng_insuranceInfo_ui/kmCarmngInsuranceInfo_infoList.jsp?fdCarId=${kmCarmngInfomationForm.fdId}";
							}
				</ui:event>	
				<table class="tb_normal" width="100%">
							<tr><td id="insuranceInfo"><iframe src="" width=100% height=100% frameborder=0 scrolling=no></iframe></td></tr>
			    </table>
			</ui:content>
			<!-- 车辆保养 -->
			<ui:content title="${ lfn:message('km-carmng:table.kmCarmngMaintenanceInfo') }">
				<ui:event event="show">
							var iframe = document.getElementById("maintenanceInfo").getElementsByTagName("IFRAME")[0];
							if(iframe.getAttribute('src')=="" || isRefresh){
								iframe.src = "../km_carmng_maintenanceInfo_ui/kmCarmngMaintenanceInfo_infoList.jsp?fdCarId=${kmCarmngInfomationForm.fdId}";
							}
				</ui:event>	
				<table class="tb_normal" width="100%">
							<tr><td id="maintenanceInfo"><iframe src="" width=100% height=100% frameborder=0 scrolling=no></iframe></td></tr>
			    </table>
			</ui:content>
		</ui:tabpage>
	</template:replace>
</template:include>

