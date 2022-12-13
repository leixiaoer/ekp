<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.list">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null or param.moduleName==''}">
			<c:out value="${lfn:message('sys-task:module.sys.task') }"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="csshead">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/mobile/css/themes/default/calendar.css?s_cache=${MUI_Cache}"></link>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/task/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<mui:min-file name="mui-task.js"/>
	</template:replace>
	<template:replace name="content">
	
		<div class="muiCalendarContainer">
			<div id="calendar" data-dojo-type="mui/calendar/CalendarView">
				<div style="margin: 1rem 1rem 0;">
					<div data-dojo-type="mui/calendar/CalendarHeader"></div>
				</div>
			
				<div data-dojo-type="mui/calendar/CalendarWeek"></div>
				<div data-dojo-type="mui/calendar/CalendarContent"></div>
				<div data-dojo-type="mui/calendar/CalendarBottom" data-dojo-props="url:''">
					<div data-dojo-type="mui/calendar/CalendarListScrollableView">
						<%
							if ("zh".equals(UserUtil.getKMSSUser().getLocale().getLanguage())) {
								request.setAttribute("nodataImgPath", request.getContextPath() + 
										"/sys/task/mobile/resource/images/calendar_nodate.png");
							} else {
								request.setAttribute("nodataImgPath", request.getContextPath() + 
										"/sys/task/mobile/resource/images/calendar_nodate_en.png");
							}
						%>
						<ul class="muiSysTaskUl"
							data-dojo-type="mui/calendar/CalendarJsonStoreList"
							data-dojo-mixins="sys/task/mobile/resource/js/list/CalendarItemListMixin"
							data-dojo-props="noSetLineHeight:true,nodataImg:'${nodataImgPath}',nodataText:'',
							url:'/sys/task/sys_task_main/sysTaskIndex.do?method=calendar&fdStart=!{fdStart}&fdEnd=!{fdEnd}&fdQueryTimeType=completeTime&fdStatusType=all'">
						</ul>
					</div>
				</div>
			</div>
			
			<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
			   	<li class="calendarLi"
			   		data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'calendarIcon fontmuis muis-my-schedule muiFontSizeM'" onclick="changePage(1)">
			   		<bean:message bundle="sys-task"  key="tree.task.calendar"/>
			   	</li>
				<li class="calendarUnSelected calendarLi"
			   		data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'calendarIcon fontmuis muis-apply muiFontSizeM'" onclick="changePage(2)">
			   		<bean:message bundle="sys-task"  key="sysTaskMain.my"/>
			   	</li>
			</ul>
		</div>
		<kmss:authShow roles="ROLE_SYSTASK_CREATE">
			<div class="calendarAddBtn" onclick="javascript:window.create()">
				<i class="fontmuis muis-new"></i>
			</div>
		</kmss:authShow>
	</template:replace>
</template:include>
<script>
</script>
<script>
	require(['mui/util', 'mui/device/adapter'],function(util, adapter){
		window.doBack=function(){
			adapter.closeWindow();
		};
		
		window.changePage = function (type) {
			if(type == 1) {
				location.href = util.formatUrl('/sys/task/mobile');
			} else {
				location.href = util.formatUrl('/sys/task/mobile/index_list.jsp?moduleName=${param.moduleName}');
			}
		}
		
	});
</script>
<script>
	window.create = function(){
		require(['mui/util'], function(util){
			var url = util.formatUrl('/sys/task/sys_task_main/sysTaskMain.do?method=add');
			window.location = url;
		});
	}
</script>