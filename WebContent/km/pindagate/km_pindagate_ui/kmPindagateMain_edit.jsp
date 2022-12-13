<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	 //后续改成参数配置参数配置 	
     pageContext.setAttribute("ImageW",300);
     pageContext.setAttribute("ImageH",100);
%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.pindagate.model.KmPindagateMain"></lbpm:lbpmApproveModel> 
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" showQrcode="true" isEdit="true"  formName="kmPindagateMainForm" formUrl="${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_main/kmPindagateMain.do">
			<c:import url="/km/pindagate/km_pindagate_ui/kmPindagateMain_editHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
 		 	</c:import>
 		 	<c:import url="/km/pindagate/km_pindagate_ui/kmPindagateMain_editTab.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.edit" sidebar="auto">
			<c:import url="/km/pindagate/km_pindagate_ui/kmPindagateMain_editHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/pindagate/km_pindagate_ui/kmPindagateMain_editTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>