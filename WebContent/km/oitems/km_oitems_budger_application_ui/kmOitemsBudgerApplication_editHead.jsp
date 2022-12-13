<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="title">
		<c:choose>
			<c:when test="${ kmOitemsBudgerApplicationForm.method_GET == 'add' }">
				<c:if test="${kmOitemsBudgerApplicationForm.fdType == '1' }">
					<c:out value="${ lfn:message('km-oitems:kmOitems.tree.dept.application') } - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
				</c:if>
				<c:if test="${kmOitemsBudgerApplicationForm.fdType == '2' }">
					<c:out value="${ lfn:message('km-oitems:kmOitems.tree.person.application') } - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
				</c:if>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmOitemsBudgerApplicationForm.docSubject} - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
			<c:if test="${kmOitemsBudgerApplicationForm.method_GET=='edit'}">
				<c:if test="${kmOitemsBudgerApplicationForm.docStatus eq '10'}">
				  <ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('update','true');">
				  </ui:button>
				</c:if>
				  <ui:button text="${lfn:message('button.update') }" order="2" onclick="commitMethod('update','false');">
				  </ui:button>
			</c:if>
			<c:if test="${kmOitemsBudgerApplicationForm.method_GET=='add'}">
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
				<ui:menu-item text="${ lfn:message('km-oitems:kmOitems.tree.modelName') }">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-oitems:kmOitems.msg.application') }">
				</ui:menu-item>
		</ui:menu>
	</template:replace>	