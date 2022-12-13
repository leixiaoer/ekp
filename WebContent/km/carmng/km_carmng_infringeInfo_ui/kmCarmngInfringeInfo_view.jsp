<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="title">
		<c:out value="${ kmCarmngInfringeInfoForm.fdVehiclesInfoNo } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<script>
		seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
			window.deleteInfringeInfo = function(delUrl){
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
			<kmss:auth requestURL="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.edit')}"  onclick="Com_OpenWindow('kmCarmngInfringeInfo.do?method=edit&fdId=${JsParam.fdId}','_self');">
				</ui:button>
			</kmss:auth>
			<kmss:auth requestURL="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}" onclick="deleteInfringeInfo('${LUI_ContextPath}/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=delete&fdId=${JsParam.fdId}');">
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
			<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }" href="/km/carmng/" target="_self" >
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:kmCarmng.tree.car.information3') }">
			</ui:menu-item>
			<ui:menu-item text="${kmCarmngInfringeInfoForm.fdVehiclesInfoNo}">
			</ui:menu-item>
		</ui:menu>
	</template:replace>
	<template:replace name="content"> 
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngInfringeInfo"/></p>
		
		<div style="background:#fff; padding:16px;">
			<html:form action="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do">
				<html:hidden name="kmCarmngInfringeInfoForm" property="fdId"/>
				
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdVehiclesInfoId"/>
						</td><td width=35%>
							<c:out value="${kmCarmngInfringeInfoForm.fdVehiclesInfoNo}" />
						</td>
						<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName"/>
						</td>
						<td width="35%"><c:out value="${kmCarmngInfringeInfoForm.fdVehiclesInfoName}"/>
						</td>
						
					</tr>	
					<tr>
						<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdCategoryName"/>
						</td>
						<td><c:out value="${kmCarmngInfringeInfoForm.fdVehiclesCategoryName}"/></td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeTime"/>
						</td><td width=35%>
							<c:out value="${kmCarmngInfringeInfoForm.fdInfringeTime}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringePerson"/>
						</td><td width=35%>
							<c:out value="${kmCarmngInfringeInfoForm.fdInfringePersonName}" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeFee"/>
						</td><td width=35%>
							<input type="text" name="fdInfringeFee" value="<kmss:showNumber value="${kmCarmngInfringeInfoForm.fdInfringeFee}" pattern="0.00#"/>" readonly="readonly" style="border: none">
							<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
						</td>		
					</tr>
					<tr>		
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeSite"/>
						</td><td width=35% colspan="3">
							<c:out value="${kmCarmngInfringeInfoForm.fdInfringeSite}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngInfringeInfo.fdRemark"/>
						</td><td width=35% colspan="3">
							<kmss:showText value="${kmCarmngInfringeInfoForm.fdRemark}" />
						</td>
					</tr>
					<tr>
						<%-- 文档附件 --%>
						<td width="11%" class="td_normal_title"><bean:message  bundle="km-carmng" key="kmCarmngInsuranceInfo.attachment"/></td>
						<td width="89%" colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="attachment"/>
							<c:param name="formBeanName" value="kmCarmngInfringeInfoForm" />
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
			</html:form>
		</div>
	</template:replace>
</template:include>

