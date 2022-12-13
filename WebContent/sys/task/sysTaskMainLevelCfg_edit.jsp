<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="config.profile.edit" sidebar="no">
	<template:replace name="title"><bean:message bundle="sys-task" key="tree.task.level.set" /></template:replace>
	<template:replace name="content">
		<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do">
<div style="margin-top:25px">
<p class="configtitle"><bean:message bundle="sys-task" key="tree.task.level.set" /></p>
	<center>
		<table  class="tb_normal" width=80%>
			<tr>
				<td class="td_normal_title" width="20%">
				    <bean:message bundle="sys-task" key="tree.task.level.set.num" />
				</td>
				<td>
					<div>
						<xform:text property="value(fdLevel)" style="width:100px" required="true" validators="digits nonnegative" subject="${lfn:message('sys-task:tree.task.level.set.num')}"/>
						(<bean:message bundle="sys-task" key="sysTaskMain.config.level.tip"/>)
					</div>
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
	var _validation=$KMSSValidation(document.forms['sysAppConfigForm']);
    var configLevelValidators={
    		'nonnegative':{
    			error:"<bean:message key='sysTaskMain.config.level.nonnegative' bundle='sys-task'/>",
				test:function(value){
					if(value>0){
						return true;
					}else{
						return false;
					}
				}
    		}
    };
    _validation.addValidators(configLevelValidators);

 	function commitMethod(){
 			Com_Submit(document.sysAppConfigForm, 'update');
 	}
</script>
	</template:replace>
</template:include>
