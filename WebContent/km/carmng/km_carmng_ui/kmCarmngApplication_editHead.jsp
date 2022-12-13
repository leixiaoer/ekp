<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.ResourceUtil"%>
<template:replace name="head">
		<link rel="stylesheet"
			href="${LUI_ContextPath}/km/carmng/resource/css/carmng.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="title">
		<c:choose>
			<c:when test="${kmCarmngApplicationForm.method_GET=='add'}">
				<c:out
					value="${ lfn:message('km-carmng:table.kmCarmngApplication') } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
			</c:when>
			<c:when test="${kmCarmngApplicationForm.method_GET=='edit'}">
				<c:out
					value="${kmCarmngApplicationForm.docSubject} - ${lfn:message('km-carmng:module.km.carmng')}"></c:out>
			</c:when>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:if test="${kmCarmngApplicationForm.method_GET=='edit'}">
				<c:if test="${kmCarmngApplicationForm.docStatus eq '10'}">
					<ui:button text="${lfn:message('button.savedraft') }"
						onclick="commitMethod('update','true');">
					</ui:button>
				</c:if>
				<c:choose>
				<c:when test="${param.approveModel eq 'right'}">
					<ui:button text="${lfn:message('button.update') }" styleClass="lui_widget_btn_primary" isForcedAddClass="true"
					onclick="commitMethod('update','false');">
				</ui:button>
				</c:when>
				<c:otherwise>
					<ui:button text="${lfn:message('button.update') }"
					onclick="commitMethod('update','false');">
				</ui:button>
				</c:otherwise>
			</c:choose>
			</c:if>
			<c:if test="${kmCarmngApplicationForm.method_GET=='add'}">
				<ui:button text="${lfn:message('button.savedraft') }"
					onclick="commitMethod('save','true');">
				</ui:button>
				<c:choose>
				<c:when test="${param.approveModel eq 'right'}">
					
					<ui:button text="${lfn:message('button.submit') }" styleClass="lui_widget_btn_primary" isForcedAddClass="true"
						onclick="commitMethod('save','false');">
					</ui:button>
				</c:when>
				<c:otherwise>
					<ui:button text="${lfn:message('button.submit') }"
						onclick="commitMethod('save','false');">
					</ui:button>
				</c:otherwise>
			</c:choose>
				
				
			</c:if>
			<ui:button text="${lfn:message('button.close') }" order="5"
				onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"
			style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }"
				icon="lui_icon_s_home">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }">
			</ui:menu-item>
		</ui:menu>
	</template:replace>