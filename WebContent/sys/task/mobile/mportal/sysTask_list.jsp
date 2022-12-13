<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<link rel="Stylesheet" href="${LUI_ContextPath}/sys/task/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
<ul class="muiPortalTaskSimple"	
	data-dojo-type="sys/mportal/mobile/card/JsonStoreCardList"
	data-dojo-mixins="sys/task/mobile/mportal/js/TaskListMixin"
	data-dojo-props="url:'/sys/task/sys_task_main/sysTaskIndex.do?method=list&orderby=docCreateTime&ordertype=down&rowsize=${param.rowsize}',lazy:false,type:'${param.type}'">
</ul>