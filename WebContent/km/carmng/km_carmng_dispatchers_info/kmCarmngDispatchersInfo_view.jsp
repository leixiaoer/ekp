<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-carmng:kmCarmng.config.info') } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="head">
	<link rel="stylesheet" href="${LUI_ContextPath}/km/carmng/resource/css/carmng.css?s_cache=${MUI_Cache}" /> 
		<script>
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
			function Com_OpenCarInfoWindow(){
			}
			function Com_OpenDriverInfoWindow(){
			}
			Com_IncludeFile("docutil.js");
		</script>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
			<c:if test="${kmCarmngDispatchersInfoForm.fdFlag != '1' }">
			<kmss:auth requestURL="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('km-carmng:kmCarmng.button7')}"
					onclick="Com_OpenWindow('kmCarmngDispatchersInfo.do?method=edit&fdId=${JsParam.fdId}','_self');">
				</ui:button>
			</kmss:auth>
			</c:if>
			<kmss:auth requestURL="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}"
					onclick="deleteInfo('${LUI_ContextPath}/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=delete&fdId=${JsParam.fdId}');">
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
			<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:kmCarmng.config.info') }">
			</ui:menu-item>
		</ui:menu>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle"><bean:message bundle="km-carmng" key="table.kmCarmngDispatchersInfo"/></p>
		<div style="background:#fff; padding:16px;">
			<html:hidden name="kmCarmngDispatchersInfoForm" property="fdId"/>
			<ui:tabpage expand="true">
				<ui:content title="${lfn:message('km-carmng:kmCarmngDispatchersInfo.fdApplication') }" >
					<table class="tb_simple" width=100%>
						<tr>
							<td colspan="4">
								<c:import url="/km/carmng/km_carmng_ui/kmCarmngApplication_detail2.jsp" charEncoding="UTF-8">
									<c:param name="fdApplicationIds" value="${kmCarmngDispatchersInfoForm.fdApplicationIds}"></c:param>
								</c:import>
							</td>
						</tr>
					</table>
				</ui:content>
				<ui:content title="${lfn:message('km-carmng:kmCarmng.config.info') }">
					<c:choose>
						<c:when test="${kmCarmngDispatchersInfoForm.fdDispatchersType == '1' }">
							<table class="tb_simple" width=100%>
								<tr>
									<td><bean:message bundle="km-carmng" key="kmCarmngDispatchersLog.fdRemark"/></td>
								</tr>
								<tr>
									<td style="background-color: #c7c7c7;">${kmCarmngDispatchersInfoForm.fdRemark }</td>
								</tr>
							</table>
						</c:when>
					<c:otherwise>
					<table class="tb_simple" width=100%>
						<tr>
							<td colspan="4" class="checkIn_wrap_td">
								<div class="lui_carmng_dispatch_wrap checkIn_wrap">
									 <div class="lui_carmng_dispatch_content" id="carlistTB">
										<c:forEach items="${kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm}"  var="dispatchersInfoListForm" varStatus="vstatus">
											<div class="lui_carmng_dispatch_carCard" id="${dispatchersInfoListForm.fdCarInfoId}"> 
												<p class="car_plate"><xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoNo" showStatus="view" value="${dispatchersInfoListForm.fdCarInfoNo}" /> </p>
												<ul>
													<li>
													<xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoName" showStatus="view" value="${dispatchersInfoListForm.fdCarInfoName}" /> 
													（<xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoSeatNumber" showStatus="view" value="${dispatchersInfoListForm.fdCarInfoSeatNumber}" /> <bean:message bundle="km-carmng" key="kmCarmngInfomation.seat"/>）</li>
													<li>
														<xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdMotorcadeName" showStatus="view" value="${dispatchersInfoListForm.fdMotorcadeName}" /> 
													</li>
													<li>
														<p class="driver">
															<xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdDriverName" value="${dispatchersInfoListForm.fdDriverName}" /> 
														</p>
														<p class="phone"><xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdRelationPhone" value="${dispatchersInfoListForm.fdRelationPhone}" />
														</p>
													</li>
												</ul>
												<kmss:auth requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}" requestMethod="GET">
												<c:if test="${dispatchersInfoListForm.fdFlag != '1'}">
													<a href="javascript:void(0)" class="btn_checkIn" onclick="Com_OpenWindow('${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}','_self');">${lfn:message('km-carmng:kmCarmng.button5')}</a>
												</c:if>
												<c:if test="${dispatchersInfoListForm.fdFlag == '1'}">
													<a href="javascript:void(0)" class="btn_checkIned" onclick="Com_OpenWindow('${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=view&fdId=${dispatchersInfoListForm.fdRegisterId}','_blank');"><bean:message bundle="km-carmng" key="kmCarmngInformation.dispatchersInfo"/></a>
												</c:if>
												 </kmss:auth>
											</div>
										</c:forEach>
										 <c:if test="${fn:length(kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm)  < 3}">
										 <div class="lui_carmng_dispatch_info">
											<ul>
												<li>
												<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime"/> : <c:out value="${kmCarmngDispatchersInfoForm.fdStartTime}" /> 
												</li>
												<li>
												<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime"/> : <c:out value="${kmCarmngDispatchersInfoForm.fdEndTime}" /> 
												</li>
												<li>
												<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRegisterId"/> : <c:out value="${kmCarmngDispatchersInfoForm.fdRegisterName}" />
												</li>
												<li>
												<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator"/> : <c:out value="${kmCarmngDispatchersInfoForm.docCreatorName}" />
												</li>
												<li>
												<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime"/> : <c:out value="${kmCarmngDispatchersInfoForm.docCreateTime}" />
												</li>
											</ul>
										 </div>
									 	</c:if>
									 </div>
								  </div>
								</td>
							</tr>
						</table>
						 <c:if test="${fn:length(kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm) > 2}">
							<table class="tb_normal" width=100%>
								<tr>
									<td class="td_normal_title" width=15%>
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime"/>
									</td><td width=35%>
										<c:out value="${kmCarmngDispatchersInfoForm.fdStartTime}" />
									</td>
									<td class="td_normal_title" width=15%>
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime"/>
									</td><td width=35%>
										<c:out value="${kmCarmngDispatchersInfoForm.fdEndTime}" />
									</td>		
								</tr>
								<tr>
									<td class="td_normal_title" width=15%>
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRegisterId"/>
									</td><td width=35% colspan="3">
										<c:out value="${kmCarmngDispatchersInfoForm.fdRegisterName}" />
									</td>
								</tr>
								<tr>
									<td class="td_normal_title" width=15%>
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator"/>
									</td><td width=35%>
										<c:out value="${kmCarmngDispatchersInfoForm.docCreatorName}" />
									</td>
									<td class="td_normal_title" width=15%>
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime"/>
									</td><td width=35%>
										<c:out value="${kmCarmngDispatchersInfoForm.docCreateTime}" />
									</td>
								</tr>
						</table>
					</c:if>
					</c:otherwise>
					</c:choose>
				</ui:content>
				<ui:content title="${lfn:message('km-carmng:kmCarmngInformation.dispatchersLog') }" expand="false">
					<ui:event event="show">
					var iframe = document.getElementById("dispatchersLogContent").getElementsByTagName("IFRAME")[0];
					if(iframe.getAttribute('src')=="" || isRefresh){
						iframe.src = "${LUI_ContextPath}/km/carmng/km_carmng_dispatchers_log/kmCarmngDispatchers_log.jsp?fdId=${param.fdId}";
					}
					</ui:event>	
					<table class="tb_normal" width=100% height=100%>
						<tr>
							<td id="dispatchersLogContent">
								<iframe src="" width=100% height=100% frameborder=0 scrolling=no></iframe>
							</td>
						</tr>
					</table>
				</ui:content>
			</ui:tabpage>
		</div>
	</template:replace>
</template:include>
