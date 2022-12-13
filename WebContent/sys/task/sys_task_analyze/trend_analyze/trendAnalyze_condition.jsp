<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div id="div_condtionSection">
	<table class="tb_simple" width=100%>
		<html:hidden property="fdId"/>
		<tr>
			<%--报表名称--%>
			<td class="td_normal_title" width=15% >
				<bean:message  bundle="sys-task" key="sysTaskAnalyze.docSubject"/>
			</td>
			<td  colspan=3>
				<xform:text property="docSubject" style="width:80%;" showStatus="edit" validators="maxLength(200)"></xform:text>
			</td>
		</tr>
		<tr>
			<%--对象类型--%>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="sys-task" key="sysTaskAnalyze.analyzeObj.type"/>
			</td>
			<td width=85% colspan="3">
				<xform:radio property="fdAnalyzeObjType" showStatus="edit">
					<xform:enumsDataSource enumsType="sysTaskAnalyze_analyzeObj_type"></xform:enumsDataSource>
				</xform:radio>
				<html:hidden property="fdAnalyzeType" value="${sysTaskAnalyzeForm.fdAnalyzeType }"/>	
			</td>
		</tr>	
		<tr>
			<%--对象范围--%>
			<td class="td_normal_title" width="15%" >
				<bean:message  bundle="sys-task" key="sysTaskAnalyze.analyzeObj.bound"/>
			</td>
			<td colspan="3">
				<c:set var="orgType" value="ORG_TYPE_DEPT|ORG_TYPE_ORG"></c:set>
				<c:if test="${ sysTaskAnalyzeForm.fdAnalyzeObjType == '2'}">
					<c:set var="orgType" value="ORG_TYPE_PERSON"></c:set>
				</c:if>
				<xform:address subject="${lfn:message('sys-task:sysTaskAnalyze.analyzeObj.bound') }" propertyId="fdBoundIds" propertyName="fdBoundNames" 
					orgType="${orgType}" isLoadDataDict="false" required="true" mulSelect="fasle" style="width:80%;" showStatus="edit"></xform:address>
				<div id="childrow" <c:if test="${ sysTaskAnalyzeForm.fdAnalyzeObjType == '2'}">style="display:none"</c:if>>
				<xform:checkbox property="fdIsincludechild" showStatus="edit">
					<xform:simpleDataSource value="1"><bean:message  bundle="sys-task" key="sysTaskAnalyze.fdIsincludechild"/></xform:simpleDataSource>
				</xform:checkbox>
				</div>
  				<html:hidden property="fdIsincludechildTask" value="1"/>
			</td>
		</tr>
		<tr>
  			 	<td class="td_normal_title" width="15%" >
  			 		<bean:message  bundle="sys-task" key="sysTaskAnalyze.fdDateQueryType"/>
  			 	</td>
				<td colspan="3">
   					<xform:checkbox property="fdDateQueryType" showStatus="edit" value="${sysTaskAnalyzeForm.fdDateQueryType}">
						<xform:enumsDataSource enumsType="sysTaskAnalyze_fdDateQueryType"></xform:enumsDataSource>
					</xform:checkbox>
					<span class="lui_icon_s_cue5" title="${lfn:message('sys-task:sysTaskAnalyze.tip1') }"
						style="width:16px;height: 16px;display: inline-block;cursor: pointer;" >
					</span>    
 				</td>
		</tr>
		
		<%--阅读者 --%>
		<tr>
			<td class="td_normal_title"><bean:message bundle="sys-right" key="right.read.authReaders" /></td>
			<td colspan="3">
				<xform:address textarea="true" mulSelect="true" showStatus="edit"
					propertyId="authReaderIds" propertyName="authReaderNames" style="width:80%;">
				</xform:address>
			</td>
		</tr>
		<c:import url="/sys/task/sys_task_analyze/common/sysTaskAnalyze_timeArea.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="sysTaskAnalyzeForm"/>
			<c:param name="selfDefine" value="false"/>
		</c:import>
	</table>
	<input name="rowsize" type="hidden"/>
	<input name="pageno" type="hidden"/>
</div>