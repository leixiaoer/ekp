<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{
		url : "/sys/task/sys_task_main/sysTaskIndex.do?method=list&orderby=docCreateTime&ordertype=down",
		text: "${lfn:message('sys-task:calendar.complete.all')}"
	},
	{
		url : "/sys/task/sys_task_main/sysTaskIndex.do?method=list&q.flag=1&orderby=docCreateTime&ordertype=down",
		text: "${lfn:message('sys-task:mui.sysTaskMain.appoint')}"
	},
	{
		url : "/sys/task/sys_task_main/sysTaskIndex.do?method=list&q.taskStatus=3&orderby=docCreateTime&ordertype=down",
		text: "${lfn:message('sys-task:tree.sysTaskMain.status.complete')}" 
	},
	{
		url : "/sys/task/sys_task_main/sysTaskIndex.do?method=list&q.flag=0&orderby=docCreateTime&ordertype=down",
		text: "${lfn:message('sys-task:mui.sysTaskMain.attention')}"
	},
	{
		url : "/sys/task/sys_task_main/sysTaskIndex.do?method=list&q.evaluateStatus=1&orderby=docCreateTime&ordertype=down",
		text: "${lfn:message('sys-task:mui.sysTaskMain.already.evaluated')}"
	},
	{
		url : "/sys/task/sys_task_main/sysTaskIndex.do?method=list&q.evaluateStatus=0&orderby=docCreateTime&ordertype=down",
		text: "${lfn:message('sys-task:mui.sysTaskMain.no.evaluated')}"
	}
]