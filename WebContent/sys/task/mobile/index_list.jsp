<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.list">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null or param.moduleName==''}">
			<c:out value="${lfn:message('sys-task:module.sys.task') }"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/task/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
		
		<div data-dojo-type="mui/header/Header" data-dojo-props="height:'3.8rem'">
			<div
				data-dojo-type="mui/nav/MobileCfgNavBar" 
				data-dojo-props=" defaultUrl:'/sys/task/mobile/nav.jsp',modelName:'com.landray.kmss.sys.task.model.SysTaskMain' ">
			</div>
			
			<div
				data-dojo-type="mui/search/SearchButtonBar" 
				data-dojo-props="modelName:'com.landray.kmss.sys.task.model.SysTaskMain' ">
			</div>
		</div>
		
		<div data-dojo-type="mui/list/NavSwapScrollableView">
		    <ul style="padding: 0 1.25rem;"
		    	data-dojo-type="mui/list/JsonStoreList" 
		    	data-dojo-mixins="sys/task/mobile/resource/js/list/CalendarItemListMixin"
		    	data-dojo-props="nodataImg:'${LUI_ContextPath}/sys/mobile/css/themes/default/images/address-empty.png'">
			</ul>
		</div>
		
		<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
		   	<li class="calendarUnSelected calendarLi"
		   		data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'calendarIcon fontmuis muis-my-schedule muiFontSizeM'" onclick="changePage(1)">
		   		<bean:message bundle="sys-task"  key="tree.task.calendar"/>
		   	</li>
			<li class="calendarLi"
		   		data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'calendarIcon fontmuis muis-apply muiFontSizeM'" onclick="changePage(2)">
		   		<bean:message bundle="sys-task"  key="sysTaskMain.my"/>
		   	</li>
		</ul>
		
		<kmss:authShow roles="ROLE_SYSTASK_CREATE">	
			<div class="calendarAddBtn" onclick="javascript:window.create()">
				<i class="fontmuis muis-new"></i>
			</div>
		</kmss:authShow>
	</template:replace>
</template:include>
<script>
	require(['mui/util'],function(util){
		window.backToCalendar=function(){
			location.href=util.formatUrl('/sys/task/mobile/index.jsp?moduleName=${param.moduleName}');
		};
		window.create=function(){
			var url='${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=add';
			var fdSourceType = "${param.fdSourceType}";
			if(fdSourceType=='KK_IM'){
				var params ="{sessionId:'${param.fdSessionId}',sessionType:'${param.fdSessionType}',typeId:'${param.fdTypeId}',sessionName:'${param.fdSessionName}'}";
				url+='&data='+encodeURIComponent(params);
			}
			window.open(url,'_top');
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