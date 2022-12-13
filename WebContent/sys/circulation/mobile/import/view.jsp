<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="kmReviewMainForm" value="${requestScope[param.formName]}" />
<c:if test="${kmReviewMainForm.circulationForm.fdIsShow=='true'}">
	<c:set var="_cir_count" value="" />
	<c:set var="showOption" value="${param.showOption}" />
    <c:set var="_cir_icon" value="" />
   <c:set var="_cir_label" value="" />
   
  <c:if test="${showOption == 'icon' }">
    <c:set var="_cir_icon" value="mui mui-intr" />
</c:if>
<c:if test="${showOption == 'label'}">
	<c:set var="_cir_label" value="${empty param.label ? lfn:message('sys-circulation:sysCirculationMain.button.circulation') : param.label}" />
</c:if>
<c:if test="${showOption == 'all' || empty showOption }">
    <c:set var="_cir_icon" value="mui mui-intr" />
    <c:if test="${ empty showOption}">
		<c:set var="_cir_label" value="${param.label}" />
	</c:if>
	<c:if test="${ showOption == 'all'}">
		<c:set var="_cir_label" value="${lfn:message('sys-circulation:sysCirculationMain.button.circulation')}" />
	</c:if>
</c:if>
   
	<c:if test="${kmReviewMainForm.circulationForm.fdCirculationCount!=null && kmReviewMainForm.circulationForm.fdCirculationCount!='' }">
			<c:set var="_cir_count" value="${kmReviewMainForm.circulationForm.fdCirculationCount}" />
			<c:set var="_cir_count" value="${fn:replace(_cir_count,'(','')}" />
			<c:set var="_cir_count" value="${fn:replace(_cir_count,')','')}" />
	</c:if>
	<c:if test="${empty _cir_label}">
	<div data-dojo-type="mui/tabbar/TabBarButton"
		data-dojo-props='icon1:"${_cir_icon}",align:"${param.align}",
			badge:"${_cir_count}",href:"/sys/circulation/mobile/index.jsp?modelName=${kmReviewMainForm.modelClass.name}&modelId=${kmReviewMainForm.fdId}&fdKey=${param.fdKey }"'>
	</div>
	</c:if>
	<c:if test="${not empty _cir_label}">
	<c:if test="${not empty _cir_count}"><c:set var="_cir_label" value="${_cir_label}(${_cir_count})" /></c:if>
	<div data-dojo-type="mui/tabbar/TabBarButton"
		data-dojo-props='icon1:"",align:"${param.align}",label:"${_cir_label}",
			href:"/sys/circulation/mobile/index.jsp?modelName=${kmReviewMainForm.modelClass.name}&modelId=${kmReviewMainForm.fdId}&fdKey=${param.fdKey}&isNew=${param.isNew}"'>
	</div>
	</c:if>
</c:if>
