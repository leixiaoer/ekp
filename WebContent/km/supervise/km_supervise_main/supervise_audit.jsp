<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<!-- 督办审核页面 -->
<template:include ref="default.simple" rwd="true">
       
        <template:replace name="body">
        	<script type="text/javascript">
				seajs.use(['theme!list']);	
			</script>
			<ui:tabpanel  layout="sys.ui.tabpanel.list" id="tabpanel">
	        	<ui:content title="${lfn:message('km-supervise:lbpm.approval.my') }">
		            	 <% 
		            	 	pageContext.setAttribute("mydoc","approval");
		            	 	pageContext.setAttribute("idNum","1");
		            	 %>
		                 <%@ include file="/km/supervise/km_supervise_main/supervise_audit_list.jsp"%>
	        	</ui:content>
	        	<ui:content title="${lfn:message('km-supervise:lbpm.approved.my') }">
		            	 <% 
		            	 	pageContext.setAttribute("mydoc","approved");
		            	    pageContext.setAttribute("idNum","2");
		            	 %>
		                 <%@ include file="/km/supervise/km_supervise_main/supervise_audit_list.jsp"%>
	        	</ui:content>
	    	</ui:tabpanel>
	    	
	    	<c:set var="frameShowTop" scope="page" value="${(empty param.showTop) ? 'yes' : (param.showTop)}"/>
			<c:if test="${frameShowTop=='yes' }">
				<ui:top id="top"></ui:top>
				<kmss:ifModuleExist path="/sys/help">
					<c:import url="/sys/help/sys_help_template/sysHelp_template_btn.jsp" charEncoding="UTF-8"></c:import>
				</kmss:ifModuleExist>
			</c:if>
        </template:replace>
    </template:include>