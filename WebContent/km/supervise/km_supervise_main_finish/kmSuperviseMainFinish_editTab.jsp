<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:replace name="content"> 
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmSuperviseMainFinishForm" method="post" action ="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main_finish/kmSuperviseMainFinish.do">
	</c:if>
	<html:hidden property="fdId" />
	<html:hidden property="docSubject" />
    <html:hidden property="fdMainId" />
    <html:hidden property="docStatus" />
    <html:hidden property="method_GET" />
    <c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpage collapsed="true" id="finishTabPage">
				<script>
					LUI.ready(function(){
						setTimeout(function(){
							var reviewTabPage = LUI("finishTabPage");
							if(reviewTabPage!=null){
								reviewTabPage.element.find(".lui_tabpage_float_collapse").hide();
								reviewTabPage.element.find(".lui_tabpage_float_navs_mark").hide();
							}
						},100)
					})
				</script>
				<c:import url="/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
			</ui:tabpage>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'
				var-supportExpand="true" var-expand="true">
				
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainFinishForm" />
					<c:param name="fdKey" value="kmSuperviseSetup" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%" >
				<c:import url="/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
				<c:import url="/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	  			</c:import>
			</ui:tabpage>
			</form>
		</c:otherwise>
	</c:choose>
</template:replace>
<c:if test="${param.approveModel eq 'right'}">
	<template:replace name="barRight">
		<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
			<%--流程--%>
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseMainFinishForm" />
				<c:param name="fdKey" value="kmSuperviseSetup" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
				<c:param name="approveType" value="right" />
				<c:param name="approvePosition" value="right" />
			</c:import>
		</ui:tabpanel>
	</template:replace>
</c:if>
