<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.list" spa="true">
	<%--标签页标题--%>
	<template:replace name="title">
		<c:out value="${ lfn:message('sys-task:module.sys.task') }"></c:out>
	</template:replace>
	<%--左侧--%>
	<template:replace name="nav">
		<%--新建按钮--%>
	
		<ui:combin ref="menu.nav.title">
			<ui:varParam name="title" value="${ lfn:message('sys-task:module.sys.task') }" />
			<ui:varParam name="operation">
				<ui:source type="Static">
					[
						{
							"text": "${ lfn:message('sys-task:sysTaskMain.list.attention') }",
							"href": "/listAttention",
							"router" : true,
							"icon": "lui_iconfont_navleft_com_my_follow"
						},
						{
							"text": "${lfn:message('sys-task:sysTaskMain.list.appoint')}",
							"href": "/listAppoint",
							"router" : true,
							"icon": "lui_iconfont_navleft_task_my_assign"
						},
						{
							"text": "${ lfn:message('sys-task:sysTaskMain.list.perform') }",
							"href": "/listPerform",
							"router" : true,
							"icon": "lui_iconfont_navleft_com_responsible "
						},
						{
							"text": "${ lfn:message('sys-task:sysTaskMain.list.copy') }",
							"href": "/listCopy",
							"router" : true,
							"icon": "lui_iconfont_navleft_com_reserve"
						}
					]
				</ui:source>
			</ui:varParam>
		</ui:combin>
		
		<div class="lui_list_nav_frame">
		<ui:accordionpanel>
			<%--任务查询--%>
			<ui:content title="${ lfn:message('sys-task:sysTaskMain.list.search') }" expand="true">
				<ui:combin ref="menu.nav.simple">
	  				<ui:varParam name="source">
	  					<ui:source type="Static">
	  					[
		  				{
		  					"text" : "${ lfn:message('sys-task:sysTaskMain.list.all') }",
							"href" :  "/listAll",
							"router" : true,  					
		  					"icon" : "lui_iconfont_navleft_task_all"
		  				},{
		  					"text" : "${ lfn:message('sys-task:tree.task.calendar') }",
							"href" :  "/calendar",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_com_calendar"
		  				}
		  				<% if (com.landray.kmss.sys.subordinate.util.SubordinateUtil.getInstance().getModelByModuleAndUser("sys-task:module.sys.task").size() > 0) { %>
		  					,{
		  						"text" : "${lfn:message('sys-task:subordinate.sysTaskMain') }",
		  						"href" :  "/sys/subordinate",
			  					"router" : true,
			  					"icon" : "lui_iconfont_navleft_subordinate"
		  					}
		  				<% } %>
		  				]
	  					</ui:source>
	  				</ui:varParam>
	  			</ui:combin>
			</ui:content>		
			<%--任务分析--%>
			<ui:content title="${ lfn:message('sys-task:tree.analyze') }"  expand="true">
				<ui:combin ref="menu.nav.simple">
	  				<ui:varParam name="source">
	  					<ui:source type="Static">
	  					[
		  				{
		  					"text" : "${ lfn:message('sys-task:tree.load') }",
							"href" :  "/load",
							"router" : true,  					
		  					"icon" : "lui_iconfont_navleft_task_load_analysis"
		  				},{
		  					"text" : "${ lfn:message('sys-task:tree.degree') }",
							"href" :  "/degree",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_task_satisfaction_analysis"
		  				},{
		  					"text" : "${ lfn:message('sys-task:tree.type') }",
							"href" :  "/type",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_task_type_analysis"
		  				},{
		  					"text" : "${ lfn:message('sys-task:tree.trend') }",
							"href" :  "/trend",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_task_trend_analysis"
		  				}]
	  					</ui:source>
	  				</ui:varParam>
	  			</ui:combin>
			</ui:content>				
			<kmss:authShow roles="ROLE_SYSTASK_BACKSTAGE_MANAGER">
				<%--后台管理--%>
				<ui:content title="${ lfn:message('list.otherOpt') }" expand="false">
					<ui:combin ref="menu.nav.simple">
  						<ui:varParam name="source">
  							<ui:source type="Static">
		  					[
		  						{
			  						"text" : "${ lfn:message('list.manager') }",
			  						"href" : "/management",
			  						"router" : true,	
				  					"icon" : "lui_iconfont_navleft_com_background"
			  					}
			  				]
		  					</ui:source>
		  				</ui:varParam>
		  			</ui:combin>
				</ui:content>
			</kmss:authShow>
		</ui:accordionpanel>
		</div>
	</template:replace>
	
	<%--右侧--%>
	<template:replace name="content"> 
		<ui:tabpanel id="sysTaskPanel" layout="sys.ui.tabpanel.list" cfg-router="true">
			<ui:content id="sysTaskMainContent" cfg-route="{path:'/listAttention'}" title="${ lfn:message('sys-task:sysTaskMain.list.all') }">
				<ui:iframe id="sysTaskMainIframe" src="${LUI_ContextPath }/sys/task/sys_task_ui/index.jsp?rwd=true"></ui:iframe>
		 	</ui:content>
		 	 <ui:content id="sysTaskAnalyzeContent" cfg-route="{path:'/load'}" title="任务分析">
		 	 	<ui:iframe id="sysTaskAnalyzeIframe" src="${LUI_ContextPath }/sys/task/sys_task_analyze_ui/index.jsp?rwd=true"></ui:iframe>
		 	 </ui:content>
	 	</ui:tabpanel>
	</template:replace>
	<template:replace name="script">
		<!-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 -->
		<script type="text/javascript">
			seajs.use(['lui/framework/module'],function(Module){
				Module.install('sysTask',{
					//模块变量
					$var : {},
					//模块多语言
					$lang : {
						'listAttention' : '${lfn:message("sys-task:sysTaskMain.list.attention")}',
						'listAppoint' : '${lfn:message("sys-task:sysTaskMain.list.appoint")}',
						'listPerform' : '${lfn:message("sys-task:sysTaskMain.list.perform")}',
						'listCopy' : '${ lfn:message("sys-task:sysTaskMain.list.copy") }',
						'listAll' : '${ lfn:message("sys-task:sysTaskMain.list.all") }',
						'calendar' : '${ lfn:message("sys-task:tree.task.calendar") }',
						'load' : '${ lfn:message("sys-task:tree.load") }',
						'degree' : '${ lfn:message("sys-task:tree.degree") }',
						'type' : '${ lfn:message("sys-task:tree.type") }',
						'trend' : '${ lfn:message("sys-task:tree.trend") }'
					},
					//搜索标识符
					$search : ''
				});
			});
		</script>
		<!-- 引入JS -->
		<script type="text/javascript" src="${LUI_ContextPath}/sys/task/resource/js/index.js"></script>
	</template:replace>
</template:include>