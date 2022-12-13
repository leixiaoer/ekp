<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'xform'}">
		<div class="lui_supervise_other_tabpage_head">
			<span class="lui_supervise_tabpage_title">
				<bean:message key="py.DuBanBianGeng" bundle="km-supervise"/>
		    </span>
		</div>
		<table class="tb_simple" width="100%">
			<!-- 变更原因-->
			<tr>
				<td class="td_normal_title lui_supervise_td" width="15%">
					<bean:message bundle="km-supervise" key="kmSuperviseMain.fdChangeDesc" />
				</td>
				<td colspan="3">
					<xform:textarea property="fdChangeDesc" style="width:90%;" 
						required="true" showStatus="edit" validators="maxLength(1500)" placeholder="请输入变更原因"></xform:textarea>
					<html:hidden property="beforeChangeContent"/>
				</td>
			</tr>
			<!-- 相关附件 -->
			<tr>
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-supervise" key="kmSuperviseMain.attChange"/>
				</td>
				<td colspan="3">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="attChange"/>
						<c:param name="formBeanName" value="kmSuperviseMainForm" />
                              <c:param name="fdMulti" value="true" />
					</c:import>		
				</td>
			</tr>
		</table>
           
		<div class="lui_supervise_other_tabpage_head">
			<span class="lui_supervise_tabpage_title">
				<bean:message key="kmSuperviseMain.change.fdContent" bundle="km-supervise"/>
			</span>
		</div>
		<c:import url="/sys/xform/include/sysForm_edit.jsp" charEncoding="UTF-8">
	        <c:param name="formName" value="kmSuperviseMainForm" />
	        <c:param name="fdKey" value="kmSuperviseMain" />
	    	<c:param name="useTab" value="false" />
	    </c:import>
        <c:import url="/km/supervise/km_supervise_main_change/task_change.jsp?isEnable=true" charEncoding="UTF-8"></c:import>
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