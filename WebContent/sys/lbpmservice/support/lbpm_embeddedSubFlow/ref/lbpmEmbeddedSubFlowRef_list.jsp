<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="title">${ lfn:message('sys-lbpmservice-support:table.lbpmEmbeddedSubFlow') }</template:replace>
	<template:replace name="content">
		<!-- 内容列表 -->
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/sys/lbpmservice/support/lbpmEmbeddedSubFlow.do?method=listRef&fdEmbeddedId=${param.fdEmbeddedId}'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
				rowHref="/sys/lbpmservice/support/lbpmEmbeddedSubFlow.do?method=viewTemp&fdModelId=!{fdModelId}&fdModelName=!{fdModelName}">
				<list:col-serial></list:col-serial>
				<list:col-auto props="subject,fdCreator.fdName,fdCreateTime"></list:col-auto>
			</list:colTable>
			<ui:event topic="list.loaded">
				Dropdown.init();
			</ui:event>
		</list:listview>
		<!-- 分页 -->
	 	<list:paging/>
	</template:replace>
</template:include>