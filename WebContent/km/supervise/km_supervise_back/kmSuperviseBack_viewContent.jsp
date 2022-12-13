<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="${lfn:message('km-supervise:py.fanKuiXinXi') }" expand="true">
	   <p class="lui_form_subject">${ lfn:message('km-supervise:py.JieDuanFanKui') }</p>
    
       <div class="lui_form_content_frame" >
           <table class="tb_normal" width="95%">
           <!-- 督办事项 -->
           	<tr>
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-supervise" key="py.DuBanShiXiang" />
				</td>
				<td colspan="3">
					<a href="${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=${kmSuperviseBackForm.fdSuperviseId}" style="color:#4285f4;" target="_Blank">${kmSuperviseBackForm.fdSuperviseName}</a>
				</td>
			</tr>
           	<!-- 反馈单位 -->
           	<tr>
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSysUnit" />
				</td>
				<td colspan="3">
					<c:choose>
						<c:when test="${kmSuperviseBackForm.fdSysUnitEnable eq 'true'}">
							<c:out value="${kmSuperviseBackForm.fdSysUnitName}"></c:out>
						</c:when>
						<c:otherwise>
							<xform:address propertyName="fdUnitName" propertyId="fdUnitId" required="true" showStatus="view"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<!-- 反馈人 -->
			<tr>
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.fdPerson" />
				</td>
				<td colspan="3">
					<xform:address propertyName="fdPersonName" propertyId="fdPersonId" showStatus="view"></xform:address>
				</td>
			</tr>
			<!-- 反馈时间 -->
			<tr>
				<td class="td_normal_title">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.fdFeedbackTime" />
				</td>
				<td>
					<xform:datetime property="fdFeedbackTime" showStatus="view"/>
				</td>
			</tr>
			<!-- 反馈阶段 -->
			<tr>
				<td class="td_normal_title">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.fdTask" />
				</td>
				<td colspan="3">
					<c:out value="${kmSuperviseBackForm.fdTaskSubject}"/>
				</td>
			</tr>
			<!-- 反馈周期 -->
			<c:if test="${kmSuperviseBackForm.fdBackType != '0'}">
			<tr>
				<td class="td_normal_title">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.fdBackPeriod" />
				</td>
				<td colspan="3">
					<c:out value="${kmSuperviseBackForm.fdBackDay}"/>
				</td>
			</tr>
			</c:if>
			<!-- 阶段目标 -->
			<tr>
				<td class="td_normal_title">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.fdStageTarget" />
				</td>
				<td colspan="3">
					<html:hidden property="fdStageTarget" />
					<span id="fdStageTargetSpan"> <c:out value="${kmSuperviseBackForm.fdStageTarget}"/></span>
				</td>
			</tr>
			
			<!-- 任务进度 -->
               <tr>
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSuperviseProgress" />
				</td>
				<td width="35%">
					 <div id="_xform_fdProgress" _xform_type="text">
                        <xform:text property="fdProgress" showStatus="view" style="width:95%;" />%
                    </div>
				</td>
			</tr>
			<!-- 督办状态 -->
			<tr>
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.fdStatus" />
				</td>
				<td colspan="3">
					<xform:radio property="fdStatus" showStatus="view" >
						<xform:enumsDataSource enumsType="km_supervise_back_status" />
					</xform:radio>
				</td>
			</tr>
			
			<!-- 进展情况 -->
			<tr>
				<td class="td_normal_title">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.docProgress" />
				</td>
				<td colspan="3">
					<xform:textarea property="docProgress" style="width:98%;" showStatus="view"/>
				</td>
			</tr>
			<!-- 存在困难及下一步措施 -->
			<tr>
				<td class="td_normal_title">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.docDifficulty"/>
				</td>
				<td colspan="3">
					<xform:textarea property="docDifficulty" style="width:98%;" showStatus="view"/>
				</td>
			</tr>
			<!-- 相关附件 -->
			<tr>
				<td class="td_normal_title">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.attBack"/>
				</td>
				<td colspan="3">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="attBack"/>
						<c:param name="formBeanName" value="kmSuperviseBackForm" />
		                <c:param name="fdMulti" value="true" />
					</c:import>	
				</td>
			</tr>
           </table>
       </div>
</ui:content>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<c:choose>
			<c:when test="${kmSuperviseBackForm.docStatus>='30' || kmSuperviseBackForm.docStatus=='00'}">
		        <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
		            <c:param name="formName" value="kmSuperviseBackForm" />
		            <c:param name="fdKey" value="kmSuperviseFeedback" />
		            <c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="needInitLbpm" value="true" />
	        	</c:import>
			</c:when>
			<c:otherwise>
		        <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
		            <c:param name="formName" value="kmSuperviseBackForm" />
		            <c:param name="fdKey" value="kmSuperviseFeedback" />
		            <c:param name="showHistoryOpers" value="true" />
		            <c:param name="isExpand" value="true" />
		            <c:param name="approveType" value="right" />
	        	</c:import>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
        <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
            <c:param name="formName" value="kmSuperviseBackForm" />
            <c:param name="fdKey" value="kmSuperviseFeedback" />
            <c:param name="showHistoryOpers" value="true" />
            <c:param name="isExpand" value="true" />
       	</c:import>
	</c:otherwise>
</c:choose>