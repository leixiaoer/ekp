<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%--标签页标题--%>
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmPindagateMainForm.method_GET == 'add' }">
				<c:out value="${lfn:message('km-pindagate:kmPindagateMain.opt.create')} - ${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmPindagateMainForm.docSubject} - ${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<%--路径导航--%>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"  id="categoryId"> 
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-pindagate:module.km.pindagate') }">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.set') }">
			</ui:menu-item>
			<ui:menu-source autoFetch="false" >
				<ui:source type="AjaxJson">
					{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.pindagate.model.KmPindagateTemplate&categoryId=${kmPindagateMainForm.fdTemplateId}&currId=!{value}&nodeType=!{nodeType}"} 
				</ui:source>
			</ui:menu-source>
		</ui:menu>
	</template:replace>	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" var-navwidth="85%" layout="sys.ui.toolbar.float" count="2">
			<%--更新页面--%>
			<c:if test="${kmPindagateMainForm.method_GET=='edit'}">
				<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('updatedraft', '10');">
				</ui:button>
				
				<c:choose>
				<c:when test="${param.approveModel eq 'right' && kmPindagateMainForm.method_GET=='edit'}">
				    <ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('update', '20');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
				</ui:button>
				</c:when>
				<c:otherwise>
					<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('update', '20');">
				</ui:button>
				</c:otherwise>
				</c:choose>
			
			</c:if> 
			<%--新增页面--%>
			<c:if test="${kmPindagateMainForm.method_GET=='add'}">
				<ui:button text="${lfn:message('button.savedraft') }" order="1" onclick="commitMethod('savedraft', '10');">
				</ui:button>
				<c:choose>
					<c:when test="${param.approveModel eq 'right' && kmPindagateMainForm.method_GET=='add'}">
					 	 <ui:button text="${lfn:message('button.submit') }" order="1" onclick="commitMethod('save', '20');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
						</ui:button>
					</c:when>
					<c:otherwise>
						<ui:button text="${lfn:message('button.submit') }" order="1" onclick="commitMethod('save', '20');">
						</ui:button>
					</c:otherwise>
				</c:choose>
				
			</c:if> 
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace> 