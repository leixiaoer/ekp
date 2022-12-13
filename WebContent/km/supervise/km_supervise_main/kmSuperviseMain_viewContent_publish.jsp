<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'baseInfo'}">
<ui:content title="${lfn:message('km-supervise:py.DuBanLiXiang')}" expand="true" >
	<!-- 状态标识 -->
	<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_banner.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmSuperviseMainForm" />
		<c:param name="approveType" value="${param.approveModel}" />
	</c:import>
	<p class="txttitle">
		<bean:write name="kmSuperviseMainForm" property="docSubject" />
	</p>
    <c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
        <c:param name="formName" value="kmSuperviseMainForm" />
        <c:param name="fdKey" value="kmSuperviseMain" />
        <c:param name="useTab" value="false" />
    </c:import>
    
    <div class="lui_supervise_plan_other">
      	<table class="tb_simple">
         	<tr>
               	<td class="td1">
               		<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>：
               	</td>
             	<td class="td2">
             		<c:choose>
	               		<c:when test="${kmSuperviseMainForm.fdBackType eq '0'}">
	               			<bean:message bundle="km-supervise" key="enums.task.back.default"/>
	               		</c:when>
	               		<c:when test="${kmSuperviseMainForm.fdBackType eq '1'}">
	               			<bean:message bundle="km-supervise" key="enums.task.back.week"/>
	               		</c:when>
	               		<c:when test="${kmSuperviseMainForm.fdBackType eq '2'}">
	               			<bean:message bundle="km-supervise" key="enums.task.back.double.week"/>
	               		</c:when>
	               		<c:when test="${kmSuperviseMainForm.fdBackType eq '3'}">
	               			<bean:message bundle="km-supervise" key="enums.task.back.month"/>
	               		</c:when>
	               		<c:when test="${kmSuperviseMainForm.fdBackType eq '4'}">
	               			<bean:message bundle="km-supervise" key="enums.task.back.three.month"/>
	               		</c:when>
	               		<c:when test="${kmSuperviseMainForm.fdBackType eq '5'}">
	               			<bean:message bundle="km-supervise" key="enums.task.back.year"/>
	               		</c:when>
	               	</c:choose>
             	</td>
         	</tr>
         	<c:if test="${not empty kmSuperviseMainForm.attachmentForms['attTask'].attachments }">
         		<tr>
             		<td class="td1"><bean:message bundle="km-supervise" key="py.FuJian"/>：</td>
             		<td class="td2">
             			<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
				     		<c:param name="fdKey" value="attTask" />
				           	<c:param name="formBeanName" value="kmSuperviseMainForm" />
				           	<c:param name="fdMulti" value="true" />
				        </c:import>
             		</td>
         		</tr>
         	</c:if>
     	</table>
   	</div>
   	
   	<c:choose>
   		<c:when test="${type=='admin'}">
   			<%@include file="/km/supervise/km_supervise_main/kmSuperviseMain_viewContent_publish_admin.jsp"%>
   		</c:when>
   		<c:when test="${type=='manage'}">
   			<%@include file="/km/supervise/km_supervise_main/kmSuperviseMain_viewContent_publish_manage.jsp"%>
   		</c:when>
   		<c:when test="${type=='charge'}">
   			<%@include file="/km/supervise/km_supervise_main/kmSuperviseMain_viewContent_publish_charge.jsp"%>
   		</c:when>
   		<c:otherwise>
   			<%@include file="/km/supervise/km_supervise_main/kmSuperviseMain_viewContent_publish_user.jsp"%>
   		</c:otherwise>
   	</c:choose>
   	             
	
</ui:content>

</c:when>
<c:when test="${param.contentType eq 'other'}">
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<%-- 流程 --%>
		<c:choose>
			<c:when test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
					<c:param name="fdKey" value="kmSuperviseMain" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseMainForm, 'publishDraft');" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="needInitLbpm" value="true" />
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
					<c:param name="fdKey" value="kmSuperviseMain" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="needInitLbpm" value="true" />
				</c:import>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<%-- 流程 --%>
		<c:choose>
			<c:when test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
					<c:param name="fdKey" value="kmSuperviseMain" />
					<c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseMainForm, 'publishDraft');" />
					<c:param name="showHistoryOpers" value="true" />
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
					<c:param name="fdKey" value="kmSuperviseMain" />
					<c:param name="showHistoryOpers" value="true" />
				</c:import>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
<%-- 督办考评 --%>
<c:if test="${not empty kmSuperviseMainForm.fdRemarkStatus and kmSuperviseMainForm.fdRemarkStatus eq '1' }">
	<ui:content title="${ lfn:message('km-supervise:py.DuBanKaoPing') }">
		<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_inner_remark.jsp" charEncoding="UTF-8">
            <c:param name="formName" value="kmSuperviseMainForm" />
        </c:import>
	</ui:content>
</c:if>
<%-- 督办沟通 --%>
<c:if test="${kmSuperviseMainForm.docStatus!='10'}">
	<kmss:ifModuleExist path = "/km/collaborate/">
		<%request.setAttribute("communicateTitle",ResourceUtil.getString("kmSuperviseMain.communicateTitle","km-supervise"));%>
			<c:import url="/km/collaborate/import/kmCollaborateMain_view.jsp" charEncoding="UTF-8">
				<c:param name="commuTitle" value="${communicateTitle}" />
				<c:param name="formName" value="kmSuperviseMainForm" />
				<c:param name="docSubject" value="${kmSuperviseMainForm.docSubject}" />
			</c:import>
	</kmss:ifModuleExist>
</c:if>


<ui:content title="${lfn:message('km-supervise:py.changeRecord') }">
	<ui:event event="show"> 
		var url = '<%= request.getContextPath() %>/km/supervise/km_supervise_main_change/kmSuperviseMainChange_list.jsp?fdOriginId=${kmSuperviseMainForm.fdId}';
		document.getElementById("changeContent").setAttribute("src",url);
	</ui:event>
	<iframe id="changeContent" width=100% height="1000" frameborder=0 scrolling=no>
	</iframe>
</ui:content>


<%-- 权限 --%>
<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
   	<c:param name="formName" value="kmSuperviseMainForm" />
   	<c:param name="moduleModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
</c:import>
</c:when>
</c:choose>
