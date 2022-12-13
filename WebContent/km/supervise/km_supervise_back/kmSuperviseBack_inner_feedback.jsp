<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="mainForm" value="${ requestScope[param.formName]}"/>
<c:if test="${param.mode=='config'}">
	<table class="tb_normal" width="100%">
		<tr>
			<td id="feedbackContent" onresize="Doc_LoadFrame('feedbackContent',
				'<c:url value="/km/supervise/km_supervise_back/kmSuperviseBack_inner_feedback.jsp?frame=true&fdSupervise=${JsParam.fdSupervise}"/>');">
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
				<list:listview channel="feedback" >
					<ui:source type="AjaxJson">
				            {"url":"/km/supervise/km_supervise_back/kmSuperviseBackData.do?method=feedback&c.eq.fdSupervise=${JsParam.fdSupervise}"}
				    </ui:source>
					<list:colTable isDefault="true" layout="sys.ui.listview.listtable"
						cfg-norecodeLayout="simple"
						rowHref="/km/supervise/km_supervise_back/kmSuperviseBack.do?method=view&fdId=!{fdId}">
						<list:col-auto props="fdPerson.fdName;fdFeedbackTime;fdProgress;fdResult;"></list:col-auto>
					</list:colTable>
				</list:listview>
				<div style="height: 15px;"></div>
				<list:paging channel="feedback" layout="sys.ui.paging.simple"></list:paging>
			</template:replace>
		</template:include>
	</c:if>
	<c:if test="${param.frame!='true'}">
			<list:listview channel="feedback" >
				<ui:source type="AjaxJson">
			            {"url":"/km/supervise/km_supervise_back/kmSuperviseBackData.do?method=feedback&c.eq.fdSupervise=${JsParam.fdSupervise}"}
			    </ui:source>
				<list:colTable isDefault="true" layout="sys.ui.listview.listtable"
					cfg-norecodeLayout="simple"
					rowHref="/km/supervise/km_supervise_back/kmSuperviseBack.do?method=view&fdId=!{fdId}">
					<list:col-auto props="index;fdPerson.name;fdFeedbackTime;fdProgress;fdResult;operations"></list:col-auto>
				</list:colTable>
			</list:listview>
			<div style="height: 15px;"></div>
			<list:paging channel="feedback" layout="sys.ui.paging.simple"></list:paging>
	</c:if>
</c:if>