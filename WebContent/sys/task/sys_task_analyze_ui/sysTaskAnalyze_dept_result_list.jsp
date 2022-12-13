<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="java.util.*"%>
<%@page import="com.landray.kmss.util.NumberUtil"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript" src="../js/tableSort.js"></script>
<script type="text/javascript">
Com_IncludeFile("optbar.js|list.js|jquery.js");
function doClick(url){
	url = url +"&isincludechild=${lfn:escapeJs(isincludechild)}"
					+"&isincludechildtask=${lfn:escapeJs(isincludechildtask)}"
					+"&fdStartDate=${lfn:escapeJs(startDate)}"
					+"&fdEndDate=${lfn:escapeJs(endDate)}"
					+"&dateQueryType=${JsParam.dateQueryType}";
	window.open(url);
}
</script>
<script type="text/javascript" src="../js/tableSort.js"></script>
<script type="text/javascript" >
$(document).ready(function(){
	var frame = parent.document.getElementById("iframe_id");
	if(frame.contentWindow){
		if(frame.height != frame.contentWindow.document.body.scrollHeight){
			frame.height = frame.contentWindow.document.body.scrollHeight+10;	
		}
	}
});
</script>
<style>
sortheader{
	background-color:#d8e9fd;
	align:"center" ;
	bgcolor:"#d8e9fd"
}
</style>
<table id="table_id" class="sortable"  cellspacing="1" cellpadding="5" width="100%"  bgcolor="#666666"  border="0" >
		<tr align="center" style="background-color:#d8e9fd" title="<bean:message bundle="sys-task" key="sysTaskAnalyze.column.title"/>">		
				<td width="2%"><bean:message key="page.serial"/></td>				
					<td width="5%">
						<bean:message bundle="sys-task" key="sysTaskAnalyze.deptName"/>
					</td>
				<c:if test="${analyzeType =='1' ||  analyzeType =='3'}">
					<td width="5%">
						<bean:message bundle="sys-task" key="sysTaskAnalyze.account"/>
					</td>
					<td width="5%">
						<bean:message bundle="sys-task" key="sysTaskAnalyze.account.complete.true"/>
					</td>
					<td width="5%">
						<bean:message bundle="sys-task" key="sysTaskAnalyze.account.complete.false"/>
					</td>
					<td width="5%">
						<bean:message bundle="sys-task" key="sysTaskAnalyze.account.complete.overtime"/>
					</td>
					<td width="5%">
						<bean:message bundle="sys-task" key="sysTaskAnalyze.account.complete.per"/>
					</td>
				</c:if>
				<c:if test="${analyzeType !='1'}">
					<c:forEach items="${approveList}" var="taskApprove" varStatus="vstatus_">
						<td width="5%">
					      <c:out value="${taskApprove.fdApprove}" />
						</td>
					</c:forEach>
					<td width="5%">
				       满意度平均值
					</td>
				</c:if>
		</tr>
	<c:if test="${rtnSize>0}">
		<c:forEach items="${rtnList}" var="taskAnalyzeContext" varStatus="vstatus">
			<c:if test="${(vstatus.index+1)%2==0}">
				<c:set var="bgcolor" value="#f5f5f5" />
			</c:if>
			<c:if test="${(vstatus.index+1)%2!=0}">
				<c:set var="bgcolor" value="#ffffff" />
			</c:if>
			<c:if test="${param.type =='detail' && param.fdId == sysCommunicateMain.fdId}">
				<c:set var="bgcolor" value="#FFFACD" />
			</c:if>
			<tr align="center" style="cursor: pointer" bgcolor="${bgcolor}"
			    onclick="doClick('<c:url value="/sys/task/sys_task_ui/sysTaskMain_analyze_list.jsp" />?method=listByDept&fdId=${sysTaskAnalyzeForm.fdId}&orgId=${taskAnalyzeContext.hbmOrgElement.fdId}&orgName=${taskAnalyzeContext.hbmOrgElement.fdName}')"
			    onmouseover="this.style.background='#cccccc'"
			    onmouseout="this.style.background='${bgcolor}'">
				<td align="center">${vstatus.index+1}</td>				
				<td align="center">
					<c:out value="${taskAnalyzeContext.hbmOrgElement.fdName}" />					
				</td>
				<c:if test="${analyzeType =='1' ||  analyzeType =='3'}">
				<td style="text-align:center">
					<c:out value="${taskAnalyzeContext.taskCount}" />		
				</td>
				<td align="center">
					<c:out value="${taskAnalyzeContext.taskComplementTrueCount}" />		
				</td>
				<td align="center">
					<c:out value="${taskAnalyzeContext.taskComplementFalseCount}" />		
				</td>
				<td align="center">
					<c:out value="${taskAnalyzeContext.taskComplementOverTime}" />		
				</td>
				<td align="center">
						<c:set var="taskCount" value="${taskAnalyzeContext.taskCount}" scope="request" />
						<c:set var="taskComplementTrueCount" value="${taskAnalyzeContext.taskComplementTrueCount}" scope="request" />
						<% 
						  String taskCount = request.getAttribute("taskCount").toString();
						  String taskComplementTrueCount = request.getAttribute("taskComplementTrueCount").toString();
						  Double count =  Double.parseDouble(taskCount);
						  Double complementTrueCount =  Double.parseDouble(taskComplementTrueCount);
						  Double complementPer = 0.0D;
						  if (count>0){
						     complementPer = complementTrueCount/count;
						  }			
						  complementPer =complementPer*100;
						  String complementPerTemp = NumberUtil.roundDecimal(complementPer);
						  request.setAttribute("complementPer",complementPerTemp);
						 %>
						  ${complementPer}%
				</td>
				</c:if>
				<c:if test="${approveList != null}">
						<c:forEach items="${approveList}" var="taskApprove" varStatus="vstatus1">
							<c:forEach items="${taskAnalyzeContext.evaluateMap}" var ="evaluate" varStatus = "vstatus11">
								<c:if test="${taskApprove.fdId == evaluate.key}">
									<td>
										<c:out value="${evaluate.value}"/>
										<c:set value="1" var="flag"/>		
									</td>
								</c:if>					
						   </c:forEach>
					   		<c:if test="${flag!='1'}">
					   			<td>
									0		
								</td>
					   		</c:if>
					   		<c:set value="0" var="flag"/>		
					   </c:forEach>
				    <td>
						<kmss:showNumber value="${taskAnalyzeContext.taskEvaluateScore/taskAnalyzeContext.taskEvaluateCount}" pattern="#.##"/>
					</td>
				</c:if>
			</tr>
		</c:forEach>
	</c:if>
</table>
<%@ include file="/resource/jsp/list_down.jsp"%>