<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@ page language="java" contentType="text/json; charset=UTF-8"
    import="com.landray.kmss.sys.task.model.SysTaskMain,com.landray.kmss.sys.organization.model.SysOrgElement,java.util.*,com.landray.kmss.util.*"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.task.service.ISysTaskMainService"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="sysTaskMain" list="${queryPage.list }"  custom="false">
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		<%--任务名称--%>
		<list:data-column col="docSubject" title="${ lfn:message('sys-task:sysTaskMain.docSubject') }" style="text-align:left" escape="false">
			<span class="com_subject"><c:out value="${sysTaskMain.docSubject}" /></span>
		</list:data-column>
		<list:data-column col="pid" title=" " escape="false"  >
			<span style="display:none">${sysTaskMain.fdId}:${sysTaskMain.sysTaskMainParent.fdId}:</span>
		</list:data-column>
		<%--任务状态--%>
		<list:data-column headerStyle="width:60px;"  col="fdStatus" title="${ lfn:message('sys-task:sysTaskMain.fdStatus') }" escape="false" style="text-align:center;width:60px;">
			<kmss:showTaskStatus taskStatus="${sysTaskMain.fdStatus}" />
		</list:data-column>
		<%--是否过期--%>
		<list:data-column headerStyle="width:60px;"  col="fdPastDue" title="${ lfn:message('sys-task:sysTaskMain.pastdue.yesno') }" style="width:60px;">
			<sunbor:enumsShow value="${sysTaskMain.fdPastDue}" enumsType="sys_task_yesno"  />
		</list:data-column>
		<%--任务进度--%>
		<list:data-column headerStyle="width:60px;" col="fdProgress" title="${ lfn:message('sys-task:sysTaskMain.fdProgress') }" escape="false"  style="width:60px;">
			<style>
				.pro_barline{width: 113px;height: 7px;background: #e5e4e1;border: 1px solid #d2d1cc;text-align: left;border-radius: 4px;}
				.pro_barline .complete{height: 7px;background: #00a001;border-radius: 3px;}
				.pro_barline .uncomplete{height: 7px;background: #ff8b00;border-radius: 3px;}
			</style>
			<c:out value="${sysTaskMain.fdProgress}" />%
			<div class='pro_barline'>
				<c:if test="${sysTaskMain.fdProgress=='100' }">
					<div class='complete' style="width:${sysTaskMain.fdProgress}%"></div>
				</c:if>
				<c:if test="${sysTaskMain.fdProgress!='100' }">
					<div class='uncomplete' style="width:${sysTaskMain.fdProgress}%"></div>
				</c:if>
			</div>
		</list:data-column>
		<%--任务评价--%>
		<list:data-column headerStyle="width:60px;" col="sysTaskEvaluate" escape="false"  title="${ lfn:message('sys-task:sysTaskMain.sysTaskEvaluate') }" style="width:60px;">
			<c:if test = "${sysTaskMain.sysTaskEvaluate == null}" >
				<bean:message key="sysTaskEvaluate.default.fdApprove" bundle="sys-task"/>
			</c:if>
			<c:if test = "${sysTaskMain.sysTaskEvaluate.sysTaskApprove.fdApprove != ''}" >
				<c:out value="${sysTaskMain.sysTaskEvaluate.sysTaskApprove.fdApprove}" />
			</c:if>
		</list:data-column>
		<%-- 指派人--%>
		<list:data-column headerStyle="width:60px;" col="fdAppoint.fdName" title="${ lfn:message('sys-task:sysTaskFeedback.fdNotifyType.appoint') }" escape="false" style="width:60px;">
			<ui:person personId="${sysTaskMain.fdAppoint.fdId}" personName="${sysTaskMain.fdAppoint.fdName}"></ui:person>
		</list:data-column>
		<%--接收人 --%>
		<list:data-column headerStyle="width:100px;"  col="toSysOrgPerform" escape="false" title="${ lfn:message('sys-task:table.sysTaskMainPerform') }" style="width:80px;">
			<%
			if(pageContext.getAttribute("sysTaskMain")!=null){
		    List toSysOrgPerform=((SysTaskMain)pageContext.getAttribute("sysTaskMain")).getToSysOrgPerform();
			String personsName="";
				for(int i=0;i<toSysOrgPerform.size();i++){
					if(i==toSysOrgPerform.size()-1){
					 	personsName+=((SysOrgElement)toSysOrgPerform.get(i)).getFdName();	
					}else{
	                  	personsName+=((SysOrgElement)toSysOrgPerform.get(i)).getFdName()+";";	
					}
				 }
			request.setAttribute("personsName",personsName);
			}
			%>
			<p title="${personsName}">
				<c:forEach items="${sysTaskMain.toSysOrgPerform}" var="performName" varStatus="vstatus_" begin="0" end="1">
					<ui:person personId="${performName.fdId}" personName="${performName.fdName}"></ui:person>
				</c:forEach>
				<c:if test="${fn:length(sysTaskMain.toSysOrgPerform)>2}">
					...
				</c:if>
			</p>
		</list:data-column>
		<%-- 计划完成时间:如果未过期显示"计划完成时间"，如果过期显示"超过X天" --%>
		<list:data-column headerStyle="width:140px;" col="fdPlanCompleteDateTime" escape="false" title="${ lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime') }" style="width:120px;">
			<%
				if(pageContext.getAttribute("sysTaskMain")!=null){
					SysTaskMain sysTaskMain=(SysTaskMain)pageContext.getAttribute("sysTaskMain");
					String dateStr=DateUtil.convertDateToString(sysTaskMain.getFdPlanCompleteDateTime(), ResourceUtil.getString("date.format.datetime", request.getLocale()));
					request.setAttribute("dateStr", dateStr);
					if("1".equals(sysTaskMain.getFdPastDue())){
						int overDay=(int)((new Date().getTime()-sysTaskMain.getFdPlanCompleteDateTime().getTime())/(1000*60*60*24));
						if(overDay==0){
							overDay=1;
						}
						if(overDay == 1){
							request.setAttribute("dayDescription", ResourceUtil.getString("sysTaskMain.fdPlanCompleteTime.descript.day", "sys-task"));
						}else{
							request.setAttribute("dayDescription", ResourceUtil.getString("sysTaskMain.fdPlanCompleteTime.descript.days", "sys-task"));
						}
						request.setAttribute("overDay", overDay);
					}
				}
			%>
			
			<p title="${dateStr}">
				<c:if test="${sysTaskMain.fdPastDue=='1' and sysTaskMain.fdStatus!='3' and sysTaskMain.fdStatus!='6' }">
					<bean:message bundle="sys-task" key="sysTaskMain.fdPlanCompleteTime.descript.over"/>
					<span style="color:red;"><c:out value="${overDay }"></c:out></span>
					<c:out value="${dayDescription}"></c:out>
				</c:if>
				<c:if test="${sysTaskMain.fdPastDue=='0' or  sysTaskMain.fdStatus=='3' or sysTaskMain.fdStatus=='6'}">
					<c:out value="${dateStr }"></c:out>
				</c:if>
			</p>
			
		</list:data-column>
		
		<list:data-column col="hasChild" title=" " escape="false"  >
			<%
			    request.setAttribute("hasChild", false);
				if(pageContext.getAttribute("sysTaskMain")!=null){
					SysTaskMain sysTaskMain = (SysTaskMain)pageContext.getAttribute("sysTaskMain");
					ISysTaskMainService sysTaskMainService = (ISysTaskMainService)SpringBeanUtil.getBean("sysTaskMainService");
					Boolean hasChildTask = sysTaskMainService.hasChildTask(sysTaskMain);
				    if (hasChildTask){ //如果有子任务
				    	request.setAttribute("hasChild", true);
				    }
				}
			%>			
			<span style="display:none"><c:out value="${hasChild}"></c:out></span>
		</list:data-column>
		<list:data-column headerStyle="width:80px" col="docCreateTime" title="${ lfn:message('sys-task:sysTaskMain.docCreateTime') }" escape="false">
		    <kmss:showDate value="${sysTaskMain.docCreateTime}" type="date" /> 
		</list:data-column>		
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>