<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="config.profile.edit" sidebar="no">
<template:replace name="title"><bean:message bundle="sys-task" key="tree.task.config" /></template:replace>
<template:replace name="content">
<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do">
	<div style="margin-top:25px">
	<p class="configtitle"><bean:message bundle="sys-task" key="tree.task.config" /></p>
		<center>
			<table class="tb_normal" width=80%>
				<tr>
					<td class="td_normal_title" width="20%">
					    <bean:message bundle="sys-task" key="tree.task.config.todoTaskFinish" />
					</td>
					<td colspan="3">
						<xform:radio property="value(todoTaskFinishConfig)" showStatus="edit">
							<xform:enumsDataSource enumsType="sys_task_config_todoTaskFinish" />
						</xform:radio>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						 <bean:message bundle="sys-task" key="sysTaskFeedback.fdNotifyType.taskAssignor" />
					</td>
					<td>
						<div class='sysAttendConfig-item'>
							<ui:switch property="value(fdTaskAssignor)" checked="true"
								enabledText="${ lfn:message('sys-task:sysTaskFeedback.btn.enable') }"
								disabledText="${ lfn:message('sys-task:sysTaskFeedback.btn.unabl') }">
							</ui:switch>
						</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="sys-task" key="tree.task.config.fdIsAllowReject"/>
					</td>
					<td colspan="3">
						<ui:switch property="value(fdIsAllowReject)"  
							enabledText="${lfn:message('sys-task:sysTaskFeedback.btn.enable')}" 
							disabledText="${lfn:message('sys-task:sysTaskFeedback.btn.unabl')}">
						</ui:switch>
					</td>		
				</tr>
				<!-- 缓存配置 -->
					<tr>
						<td class="td_normal_title" width="20%">
							<bean:message bundle="sys-portal" key="sys.portlet.cache"/>
						</td>
						<td>
						<table>
							<tr>
								<td>
									<bean:message bundle="sys-portal" key="sys.portlet.cache.maxElementsInMemory"/>: 
									<xform:text style="width:50px" property="value(maxElementsInMemory)" validators="digits min(10)" required="true"></xform:text>
									<br>
									<span style="color:red"><bean:message bundle="sys-portal" key="sys.portlet.cache.maxElementsInMemory.desc"/></span>
								</td>
							</tr>
							<tr>
								<td>
									<br>
									<bean:message bundle="sys-portal" key="sys.portlet.cache.cacheSearchCount"/>:
									<xform:text style="width:50px" property="value(cacheSearchCount)" validators="digits min(200)" required="true"></xform:text>
									<br>
									<span style="color:red"><bean:message bundle="sys-portal" key="sys.portlet.cache.cacheSearchCount.desc"/></span>
								</td>
						    </tr>
						    <tr>
								<td>
									<br>
									<bean:message bundle="sys-portal" key="sys.portlet.cache.cacheType"/>:
									<xform:radio property="value(cacheType)" alignment="H" required="true">
										<xform:simpleDataSource value="1" textKey="sys.portlet.cache.cacheType1" bundle="sys-portal"></xform:simpleDataSource>
										<xform:simpleDataSource value="2" textKey="sys.portlet.cache.cacheType2" bundle="sys-portal"></xform:simpleDataSource>
										<% if(com.landray.kmss.sys.cache.redis.RedisConfig.ENABLED) { %>
										<xform:simpleDataSource value="3" textKey="sys.portlet.cache.cacheType3" bundle="sys-portal"></xform:simpleDataSource>
										<% } %>
									</xform:radio>
									<br>
									<span style="color:red"><bean:message bundle="sys-portal" key="sys.portlet.cache.cacheType1.desc"/></span>
									<br>
									<span style="color:red"><bean:message bundle="sys-portal" key="sys.portlet.cache.cacheType2.desc"/></span>
									<% if(com.landray.kmss.sys.cache.redis.RedisConfig.ENABLED) { %>
									<br>
									<span style="color:red"><bean:message bundle="sys-portal" key="sys.portlet.cache.cacheType3.desc"/></span>
									<% } %>
								</td>
						    </tr>
						</table>		
					</td>
				</tr>
				<html:hidden property="method_GET" />
			</table>
			<div style="margin-bottom: 10px;margin-top:25px">
				  <ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="commitMethod();"></ui:button>
			</div>
		</center>
	</div>
</html:form>
<script type="text/javascript">
	$KMSSValidation();
 	function commitMethod(){
 			Com_Submit(document.sysAppConfigForm, 'update');
 	}
</script>
</template:replace>
</template:include>
