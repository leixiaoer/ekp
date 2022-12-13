<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="title">
		<c:choose>
			<c:when test="${ geesunOitemsBudgerApplicationForm.method_GET == 'add' }">
				<c:out value="${lfn:message('geesun-oitems:geesunOitems.create.title') } - ${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${geesunOitemsBudgerApplicationForm.docSubject} - ${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
			<c:if test="${geesunOitemsBudgerApplicationForm.method_GET=='edit'}">
				<c:if test="${geesunOitemsBudgerApplicationForm.docStatus eq '10'}">
				  <ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('update','true');">
				  </ui:button>
				</c:if>
				  <ui:button text="${lfn:message('button.update') }" order="2" onclick="commitMethod('update','false');">
				  </ui:button>
			</c:if>
			<c:if test="${geesunOitemsBudgerApplicationForm.method_GET=='add'}">
			      <ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('save','true');">
				  </ui:button>
				  <ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('save','false');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
				  </ui:button>
			</c:if>
			<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
			</ui:button>
		</ui:toolbar>  
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"  id="simplecategory"> 
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('geesun-oitems:geesunOitems.msg.application') }">
				</ui:menu-item>
		</ui:menu>
	</template:replace>	
