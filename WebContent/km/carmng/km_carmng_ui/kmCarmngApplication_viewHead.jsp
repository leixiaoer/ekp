<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="title">
		<c:out
			value="${ kmCarmngApplicationForm.docSubject } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet"
			href="${LUI_ContextPath}/km/carmng/resource/css/carmng.css?s_cache=${MUI_Cache}" />
		<script>
			Com_IncludeFile("docutil.js");
			Com_IncludeFile("dialog.js|treeview.js");
			seajs
					.use(
							[ 'lui/dialog', 'lui/jquery' ],
							function(dialog, $) {
								window.deleteApplication = function(delUrl) {
									dialog
											.confirm(
													'<bean:message key="km-carmng:kmCarmngApplication.delete.confirm"/>',
													function(isOk) {
														if (isOk) {
															Com_OpenWindow(
																	delUrl,
																	'_self');
														}
													});
									return;
								};
							});
		</script>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="7">
			<c:if
				test="${kmCarmngApplicationForm.docStatus == '30' &&  kmCarmngApplicationForm.fdIsDispatcher==1}">
				<kmss:auth
					requestURL="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=add&fdAppId=${param.fdId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('km-carmng:kmCarmng.button8')}"
						onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=add&fdAppId=${param.fdId}','_self');">
					</ui:button>
				</kmss:auth>
			</c:if>
			<c:if
				test="${kmCarmngApplicationForm.docStatus == '30' &&  kmCarmngApplicationForm.fdIsDispatcher==4}">
				<kmss:auth
					requestURL="/km/carmng/km_carmng_evaluation/kmCarmngEvaluation.do?method=add&fdAppId=${param.fdId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('km-carmng:kmCarmng.button10')}" onclick="doEvaluate()">
					</ui:button>
				</kmss:auth>
			</c:if>
			<c:if test="${kmCarmngApplicationForm.docStatus != '00' || kmCarmngApplicationForm.docStatus != '30'}">
				<kmss:auth
					requestURL="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=edit&fdId=${param.fdId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('button.edit')}"
						onclick="Com_OpenWindow('kmCarmngApplication.do?method=edit&fdId=${param.fdId}','_self');">
					</ui:button>
				</kmss:auth>
			</c:if>
			<!-- 打印 -->
			<kmss:auth
				requestURL="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=print&fdId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('km-carmng:button.print')}"
					onclick="Com_OpenWindow('kmCarmngApplication.do?method=print&fdId=${param.fdId}');">
				</ui:button>
			</kmss:auth>
			<kmss:auth
				requestURL="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=delete&fdId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}"
					onclick="deleteApplication('kmCarmngApplication.do?method=delete&fdId=${param.fdId}');">
				</ui:button>
			</kmss:auth>
			<ui:button text="${lfn:message('button.close')}" order="5"
				onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"
			style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }"
				icon="lui_icon_s_home" href="${LUI_ContentPath}/sys/portal/page.jsp">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }"
				href="${LUI_ContentPath}/km/carmng">
			</ui:menu-item>
		</ui:menu>
	</template:replace>