<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.sys.organization.model.SysOrgPerson"%>
<%@ page import="java.util.*"%>

<table class="tb_normal" width=95% id="TABLE_DocList" align="center" style="table-layout:fixed;">
	<tr align="center">
		<%--序号--%> 
		<td class="td_normal_title" width=3%>
			<bean:message bundle="km-supervise" key="kmSuperviseMain.xuhao"/>
		</td>
		<%--工作事项--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-supervise" key="kmSuperviseMain.workItem"/>
		</td>
		<%--协办单位--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-supervise" key="kmSuperviseMain.co-organizer"/>
		</td>
		<%--协办单位责任人--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-supervise" key="enums.warn.40"/>
		</td>
		<%--变更后协办单位责任人--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-supervise" key="task.update.perform"/>
		</td>
			<%--反馈周期--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>
		</td>
		<%--计划开始--%>
		<td class="td_normal_title" width=12%>
			<bean:message bundle="km-supervise" key="kmSuperviseMain.plan.startTime"/>
		</td>
		<%--计划结束--%>
		<td class="td_normal_title" width=12%>
			<bean:message bundle="km-supervise" key="kmSuperviseMain.plan.endTime"/>
		</td>
		<%-- 计划内容 --%>
		<td class="td_normal_title" width=12%>
			<bean:message bundle="km-supervise" key="kmSuperviseTask.docContent"/>
		</td>
	</tr>
	
	<!-- 基准行 -->
	<tr KMSS_IsReferRow="1" style="display: none">
		<td KMSS_IsRowIndex="1" width="3%"></td>
		<td width="12%" >
			<input type="hidden" id="fdId" name="fdId">
			<xform:text property="fdItems[!{index}].docSubject" style="width:90%;border-bottom:black;text-align:center;" validators="maxLength(200)" showStatus="readOnly"/>
		</td>
		<td width="10%" >
			<xform:address propertyId="fdItems[!{index}].fdOrganizerId" propertyName="fdItems[!{index}].fdOrganizerName" orgType="ORG_TYPE_DEPT" style="width:95%;" showStatus="readOnly"/>
		</td>
		<td width="10%" >
			<xform:address propertyId="fdItems[!{index}].fdOrganizerDutyId" propertyName="fdItems[!{index}].fdOrganizerDutyName" orgType="ORG_TYPE_ALL" style="width:95%;" showStatus="readOnly"/>
		</td>
		<td width="10%" >
			<xform:address propertyId="fdItems[!{index}].fdNewOrganizerDutyId" propertyName="fdItems[!{index}].fdNewOrganizerDutyName" orgType="ORG_TYPE_PERSON" style="width:95%;"/>
		</td>
		<%--反馈周期--%>
		<td width=10%>
			<input type="hidden" id="fdItems[!{index}].fdPeriod" name="fdItems[!{index}].fdPeriod">
			<xform:text property="fdItems[!{index}].fdPeriodValue" style="width:90%;border-bottom:black;text-align:center;" showStatus="readOnly"/>
		</td>
		<td width="10%">
			<xform:datetime property="fdItems[!{index}].fdPlanStartTime" style="width:95%;" dateTimeType="datetime" showStatus="readOnly"/>
		</td>
		<td width="10%">
			<xform:datetime property="fdItems[!{index}].fdPlanEndTime" style="width:95%;" dateTimeType="datetime" showStatus="readOnly"/>
		</td>
		<td width="10%">
			<xform:textarea property="fdItems[!{index}].docContent" style="width:90%" showStatus="readOnly"/>
		</td>
	</tr>
	
</table>


<script type="text/javascript">
	window.onload = function() {
		var data = new KMSSData();
		var status = "";
		var url = "${KMSS_Parameter_ContextPath}sys/task/sys_task_main/sysTaskMain.do?method=findByModelId&fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain&fdModelId=${kmSuperviseMainForm.fdId }&fdStatus=1,2";
	    data.SendToUrl(url, function(data) {
			var results = eval("(" + data.responseText + ")");
			if (results.length > 0) {
				lineCount = 0;
				for(var i=0;i<results.length;i++){
					
					var fieldValues = new Object();
					fieldValues["fdId"]=results[i].fdId;
					fieldValues["fdItems[!{index}].docSubject"]=results[i].docSubject;
					fieldValues["fdItems[!{index}].fdOrganizerId"]=results[i].fdOrganizerId;
					fieldValues["fdItems[!{index}].fdOrganizerName"]=results[i].fdOrganizerName;
					fieldValues["fdItems[!{index}].fdOrganizerDutyId"]=results[i].fdPerformId;
					fieldValues["fdItems[!{index}].fdOrganizerDutyName"]=results[i].fdPerformName;
					fieldValues["fdItems[!{index}].fdPlanStartTime"]=results[i].fdPlanStartTime;
					fieldValues["fdItems[!{index}].fdPlanEndTime"]=results[i].fdPlanCompleteDate + " " + results[i].fdPlanCompleteTime;
					var fdPeriod = "";
					if(results[i].fdPeriod == '1'){
						fdPeriod = "${lfn:message('km-supervise:enums.task_period.1')}";
					}else if(results[i].fdPeriod == '2'){
						fdPeriod = "${lfn:message('km-supervise:enums.task_period.2')}";
					}else{
						fdPeriod = "${lfn:message('km-supervise:enums.task_period.3')}";
					}
					fieldValues["fdItems[!{index}].fdPeriodValue"]=fdPeriod;
					fieldValues["fdItems[!{index}].fdPeriod"]=results[i].fdPeriod;
					//计划内容
			        fieldValues["fdItems[!{index}].docContent"] = results[i].docContent;
					DocList_AddRow(document.getElementById("TABLE_DocList"),null,fieldValues);
			   }
			}
		})
		$('#top').hide();
	};
</script>
