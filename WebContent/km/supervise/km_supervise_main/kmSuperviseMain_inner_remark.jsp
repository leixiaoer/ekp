<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="mainForm" value="${ requestScope[param.formName]}"/>
	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
<list:listview channel="remark" >
	<ui:source type="AjaxJson">
            {"url":"/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&fdId=${JsParam.fdId }"}
    </ui:source>
	<list:colTable isDefault="true" layout="sys.ui.listview.listtable" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}&remark=!{fdRemarkStatus}"
		cfg-norecodeLayout="simple">
		<list:col-auto props="index;fdLead.name;fdFinishLevel;fdRemark"></list:col-auto>
	</list:colTable>
</list:listview>
<div style="height: 15px;"></div>
<list:paging channel="remark" layout="sys.ui.paging.simple"></list:paging>