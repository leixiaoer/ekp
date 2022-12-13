<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.supervise.model.KmSuperviseParamConfig"%>
<% 
	pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); 
	KmSuperviseParamConfig paramConfig = new KmSuperviseParamConfig();
	pageContext.setAttribute("paramConfig",paramConfig);
%>
<c:choose>
	<c:when test="${param.contentType eq 'baseInfo'}">
		<ui:content title="${lfn:message('km-supervise:py.DuBanLiXiang')}" expand="true">
                <c:if test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
                    <div id="kmSuperviseDiv">
                    <c:import url="/sys/xform/include/sysForm_edit.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmSuperviseMainForm" />
                        <c:param name="fdKey" value="kmSuperviseMain" />
                        <c:param name="useTab" value="false" />
                    </c:import>
                    </div>
                </c:if>
                
                <c:choose>
            		<c:when test="${paramConfig.taskFieldEnable }">
            			<c:import url="/km/supervise/km_supervise_task/task_add_new.jsp?isEnable=true" charEncoding="UTF-8"></c:import>
            		</c:when>
            		<c:otherwise>
            			<c:import url="/km/supervise/km_supervise_task/task_add_new.jsp?isEnable=false" charEncoding="UTF-8"></c:import>
            		</c:otherwise>
            	</c:choose>
            </ui:content>
	</c:when>
	<c:when test="${param.contentType eq 'other'}">
		<c:if test="${param.approveModel ne 'right'}">
			<c:import url="/sys/lbpmservice/import/sysLbpmProcess_edit.jsp" charEncoding="UTF-8">
                <c:param name="formName" value="kmSuperviseMainForm" />
                <c:param name="fdKey" value="kmSuperviseMain" />
                <c:param name="isExpand" value="true" />
            </c:import>
        </c:if>

        <c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
            <c:param name="formName" value="kmSuperviseMainForm" />
            <c:param name="moduleModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
        </c:import>
               
	</c:when>
</c:choose>