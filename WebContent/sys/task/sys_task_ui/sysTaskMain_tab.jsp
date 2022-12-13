<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@ page language="java" contentType="text/json; charset=UTF-8"
	import="com.landray.kmss.sys.task.model.SysTaskMain,com.landray.kmss.sys.organization.model.SysOrgElement,java.util.*,com.landray.kmss.util.*"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.task.service.ISysTaskMainService"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:if test="${childTaskSize==0}">
</c:if>
<c:if test="${childTaskSize>=0}">
	<c:forEach items="${childTasks}" var="task">
	    <%
			    request.setAttribute("hasChild", false);
				if(pageContext.getAttribute("task")!=null){
					SysTaskMain sysTaskMain = (SysTaskMain)pageContext.getAttribute("task");
					ISysTaskMainService sysTaskMainService = (ISysTaskMainService)SpringBeanUtil.getBean("sysTaskMainService");
					Boolean hasChildTask = sysTaskMainService.hasChildTask(sysTaskMain);
				    if (hasChildTask){ //如果有子任务
				    	request.setAttribute("hasChild", true);
				    }
				}
			%>		
		<tr data-lui-mark-id="lui-rowId-" id="${task.fdId}"
			pid="${task.sysTaskMainParent.fdId}"
			style="cursor: pointer; display: table-row;" hasChild="${hasChild}"
			childTask>
			<td style="text-align: left;" class=""><input
				type="checkbox" name="List_Selected" value="${task.fdId}"
				data-lui-mark="table.content.checkbox"></td>
			<td style="width: 5%" class=""></td>
			<%--任务名--%>
			<td style="text-align: left" class="">
			   <div class="com_subject">${task.docSubject}</div>
			</td>
			<%--任务状态--%>
			<td style="text-align: center; width: 60px;" class="">
			   <kmss:showTaskStatus taskStatus="${task.fdStatus}" />
			</td>
			<%--是否过期--%>
			<td style="text-align: center; width: 60px;" class="">
			   <sunbor:enumsShow value="${task.fdPastDue}" enumsType="sys_task_yesno"  />
			</td>
			<%--任务进度--%>
			<td style="width: 60px;" class="">
				<style>
					.pro_barline {
						width: 113px;
						height: 7px;
						background: #e5e4e1;
						border: 1px solid #d2d1cc;
						text-align: left;
						border-radius: 4px;
					}
					
					.pro_barline .complete {
						height: 7px;
						background: #00a001;
						border-radius: 3px;
					}
					
					.pro_barline .uncomplete {
						height: 7px;
						background: #ff8b00;
						border-radius: 3px;
					}
				</style> 
				<c:out value="${task.fdProgress}" />%
				<div class='pro_barline'>
					<c:if test="${task.fdProgress=='100' }">
						<div class='complete' style="width:${task.fdProgress}%"></div>
					</c:if>
					<c:if test="${task.fdProgress!='100' }">
						<div class='uncomplete' style="width:${task.fdProgress}%"></div>
					</c:if>
				</div>
			</td>
			<%--任务评价--%>
			<td style="width: 60px;" class=""><c:if
					test="${task.sysTaskEvaluate == null}">
					<bean:message key="sysTaskEvaluate.default.fdApprove"
						bundle="sys-task" />
				</c:if> <c:if test="${task.sysTaskEvaluate.sysTaskApprove.fdApprove != ''}">
					<c:out value="${task.sysTaskEvaluate.sysTaskApprove.fdApprove}" />
				</c:if>
			</td>
			<%--指派人--%>
			<td style="width: 60px;" class="">
			    <ui:person personId="${task.fdAppoint.fdId}" personName="${task.fdAppoint.fdName}"></ui:person>
			</td>
			<%--负责人--%>		
			<td style="width: 80px;" class="">
				<%
					if (pageContext.getAttribute("task") != null) {
								List toSysOrgPerform = ((SysTaskMain) pageContext
										.getAttribute("task")).getToSysOrgPerform();
								String personsName = "";
								for (int i = 0; i < toSysOrgPerform.size(); i++) {
									if (i == toSysOrgPerform.size() - 1) {
										personsName += ((SysOrgElement) toSysOrgPerform
												.get(i)).getFdName();
									} else {
										personsName += ((SysOrgElement) toSysOrgPerform
												.get(i)).getFdName() + ";";
									}
								}
								request.setAttribute("personsName", personsName);
							}
				%>
				<p title="${personsName}">
					<c:forEach items="${task.toSysOrgPerform}" var="performName"
						varStatus="vstatus_" begin="0" end="1">
						<ui:person personId="${performName.fdId}"
							personName="${performName.fdName}"></ui:person>
					</c:forEach>
					<c:if test="${fn:length(task.toSysOrgPerform)>2}">
					...
				</c:if>
				</p>
			</td>
			<%--截止时间--%>
			<td style="width: 120px;" class="">
				<%
					if (pageContext.getAttribute("task") != null) {
								SysTaskMain sysTaskMain = (SysTaskMain) pageContext
										.getAttribute("task");
								String dateStr = DateUtil.convertDateToString(
										sysTaskMain.getFdPlanCompleteDateTime(),
										DateUtil.PATTERN_DATETIME);
								request.setAttribute("dateStr", dateStr);
								if ("1".equals(sysTaskMain.getFdPastDue())) {
									int overDay = (int) ((new Date().getTime() - sysTaskMain
											.getFdPlanCompleteDateTime().getTime()) / (1000 * 60 * 60 * 24));
									if (overDay == 0) {
										overDay = 1;
									}
									request.setAttribute("overDay", overDay);
								}
							}
				%>

				<p title="${dateStr}">
					<c:if
						test="${task.fdPastDue=='1' and task.fdStatus!='3' and task.fdStatus!='6' }">
						<bean:message bundle="sys-task"
							key="sysTaskMain.fdPlanCompleteTime.descript.over" />
						<span style="color: red;"><c:out value="${overDay }"></c:out></span>
						<bean:message bundle="sys-task"
							key="sysTaskMain.fdPlanCompleteTime.descript.day" />
					</c:if>
					<c:if
						test="${task.fdPastDue=='0' or  task.fdStatus=='3' or task.fdStatus=='6'}">
						<c:out value="${dateStr }"></c:out>
					</c:if>
				</p>
			</td>
			<td></td>
			<td><kmss:showDate value="${task.docCreateTime}" type="date" /></td>
			
		</tr>
	</c:forEach>
	<script>
		$(function() {
			$("tr[childTask]").unbind("click");
			$("tr[childTask]").bind("click",
							function(event) {
								var $target = $(event.target);
								if ($target[0].tagName != "SPAN"
										&& $target[0].tagName != "A"
										&& $target[0].tagName != "INPUT") {
									var id ="";
									for(;$target[0].tagName != "TR";$target=$target.parent()){
									}
									window.open("${pageContext.request.contextPath}/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId="
													+ $target.attr("id"));
									event.stopPropagation();
								}
							});
		});
	</script>
</c:if>