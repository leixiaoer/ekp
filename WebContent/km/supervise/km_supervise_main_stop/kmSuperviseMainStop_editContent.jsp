<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'xform'}">
		<div class="lui_supervise_other_tabpage_head">
        	<span class="lui_supervise_tabpage_title">
        		<%-- <bean:message bundle="km-supervise" key="py.DuBanBanJie"/> --%>
        		督办终止
        	</span>
		</div>
		<table class="tb_simple" width="100%">
			<!-- 终止人 -->
           	<tr>
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-supervise" key="kmSuperviseMainStop.fdOperator" />
				</td>
				<td colspan="3">
					<xform:address propertyName="fdOperatorName" propertyId="fdOperatorId" showStatus="readOnly" />
				</td>
			</tr>
			<!-- 终止原因-->
			<tr>
				<td class="td_normal_title lui_supervise_td" width="15%">
					<bean:message bundle="km-supervise" key="kmSuperviseMainStop.fdStopDesc" />
				</td>
				<td colspan="3">
					<xform:textarea property="fdStopDesc" style="width:90%;" 
						required="true" showStatus="edit" validators="maxLength(1500)"></xform:textarea>
				</td>
			</tr>
			<!-- 相关附件 -->
			<tr>
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-supervise" key="py.FuJianShangChuan"/>
				</td>
				<td colspan="3">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="attStop"/>
						<c:param name="formBeanName" value="kmSuperviseMainStopForm" />
                              <c:param name="fdMulti" value="true" />
					</c:import>		
				</td>
			</tr>
        </table>
           
        <div class="lui_supervise_other_tabpage_head">
        	<span class="lui_supervise_tabpage_title">
        		<bean:message bundle="km-supervise" key="kmSuperviseMainStop.fdContent"/>
        	</span>
		</div>
		
		<c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
	        <c:param name="formName" value="kmSuperviseMainForm" />
	        <c:param name="fdKey" value="kmSuperviseMain" />
	        <c:param name="useTab" value="false" />
	    </c:import>
          
		<c:import url="/km/supervise/km_supervise_task/task_view_new.jsp?isEnable=true" charEncoding="UTF-8"></c:import>
	</c:when>
	<c:when test="${param.contentType eq 'other'}">
		<c:if test="${param.approveModel ne 'right'}">
			<%--流程--%>
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseMainStopForm" />
				<c:param name="fdKey" value="kmSuperviseTermination" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
			</c:import>
		</c:if>
	</c:when>
</c:choose>