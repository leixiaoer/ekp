<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="title">
		<c:out value="${ geesunOitemsBudgerApplicationForm.docSubject } - ${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
	  <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
	  	<c:if test="${geesunOitemsBudgerApplicationForm.docStatus == '30'}">
			<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=receive&fdId=${param.fdId}&type=${param.type}" requestMethod="GET">		
				 <ui:button order="2" text="${ lfn:message('geesun-oitems:geesunOitems.button.receive') }" 
								onclick="Receive();">
				</ui:button>
			</kmss:auth>
		</c:if>
		<c:if test="${geesunOitemsBudgerApplicationForm.docStatus != '00' && geesunOitemsBudgerApplicationForm.docStatus !='31'}">
			<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=edit&fdId=${param.fdId}&type=${param.type}" requestMethod="GET">
				<ui:button order="2" text="${ lfn:message('button.edit') }" 
								onclick="Com_OpenWindow('geesunOitemsBudgerApplication.do?method=edit&fdId=${JsParam.fdId}&type=${JsParam.type}','_self');">
				</ui:button>
			</kmss:auth>
		</c:if>
			<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				<ui:button order="2" text="${ lfn:message('button.delete') }" 
								onclick="Delete();">
				</ui:button>
			</kmss:auth>
	   <c:if test="${geesunOitemsBudgerApplicationForm.docStatus!='10'}">
			<kmss:auth
				requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=print&fdId=${param.fdId}"
				requestMethod="GET">
				<ui:button text="${lfn:message('button.print') }" order="4" 
				    onclick="Com_OpenWindow('geesunOitemsBudgerApplication.do?method=print&fdId=${JsParam.fdId}','_blank');">
			    </ui:button>
			</kmss:auth>
	   </c:if>
		<ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();">
		</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		    <ui:menu layout="sys.ui.menu.nav"  id="simplecategory"> 
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }" href="/geesun/oitems/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('geesun-oitems:geesunOitems.msg.application') }" href="/geesun/oitems/index.jsp" target="_self">
				</ui:menu-item>
			</ui:menu>
	</template:replace>
