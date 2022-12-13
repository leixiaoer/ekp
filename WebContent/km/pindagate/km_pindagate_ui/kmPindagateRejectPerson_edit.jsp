<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	 //后续改成参数配置参数配置	
     pageContext.setAttribute("ImageW",300);
     pageContext.setAttribute("ImageH",100);
%>
<template:include ref="default.simple"  sidebar="auto">


	<template:replace name="content"> 
		<style>
			.pindagate_slideDown {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowd_blue.png) no-repeat 0 3px;cursor: pointer;}
			.pindagate_slideUp {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowU_blue.png) no-repeat 0 3px;cursor: pointer;}
		</style>
		<html:form action="/km/pindagate/km_pindagate_ui/kmPindagateRejectPerson.do">
			<html:hidden property="responseTime"/>
			<div><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.writingReasons"/></div>
			<textarea style="resize:none;" rows="40" cols="62"></textarea>
		</html:form>
	</template:replace>
</template:include>