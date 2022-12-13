<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="mainForm" value="${ requestScope[param.formName]}"/>
<c:if test="${param.mode=='config'}">
	<table class="tb_normal" width="100%">
		<tr>
			<td id="dynamicContent" onresize="Doc_LoadFrame('dynamicContent',
				'<c:url value="/km/supervise/km_supervise_dynamic/kmSuperviseDynamic_inner_dynamic.jsp?frame=true&fdSupervise=${JsParam.fdSupervise}"/>');">
				<iframe src="" width=100% height=100% frameborder=0 scrolling=no style="min-height: 100px;">
				</iframe>
			</td>
		</tr>
	</table>
</c:if>
<c:if test="${param.mode!='config'}">
	<c:if test="${param.frame=='true'}">
		<template:include ref="config.list">
    		<template:replace name="content">
				<list:listview channel="dynamic" >
					<ui:source type="AjaxJson">
				            {"url":"/km/supervise/km_supervise_dynamic/kmSuperviseDynamicData.do?method=dynamic&c.eq.fdSupervise=${JsParam.fdSupervise}"}
				    </ui:source>
					<list:colTable isDefault="true" layout="sys.ui.listview.listtable"
						cfg-norecodeLayout="simple"
						rowHref="/km/supervise/km_supervise_dynamic/kmSuperviseDynamic.do?method=view&fdId=!{fdId}">
						<list:col-auto props="docCreator.fdName;docCreateTime;fdContent;fdSupervise.docSubject;"></list:col-auto>
					</list:colTable>
				</list:listview>
				<div style="height: 15px;"></div>
				<list:paging channel="dynamic" layout="sys.ui.paging.simple"></list:paging>
			</template:replace>
		</template:include>
	</c:if>
	<c:if test="${param.frame!='true'}">
			<list:listview channel="dynamic" >
				<ui:source type="AjaxJson">
			            {"url":"/km/supervise/km_supervise_dynamic/kmSuperviseDynamicData.do?method=dynamic&c.eq.fdSupervise=${JsParam.fdSupervise}"}
			    </ui:source>
				<list:colTable isDefault="true" layout="sys.ui.listview.listtable"
					cfg-norecodeLayout="simple"
					rowHref="/km/supervise/km_supervise_dynamic/kmSuperviseDynamic.do?method=view&fdId=!{fdId}">
					<list:col-auto props="docCreator.fdName;docCreateTime;fdContent;fdSupervise.docSubject;"></list:col-auto>
				</list:colTable>
			</list:listview>
			<div style="height: 15px;"></div>
			<list:paging channel="dynamic" layout="sys.ui.paging.simple"></list:paging>
	</c:if>
</c:if>