<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content" >
		<script type="text/javascript">Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js", null, "js");</script>
		<script>
			$KMSSValidation();//校验框架
			seajs.use(['lui/dialog', 'lui/jquery'],function(dialog,$) {
				//确认
				window.clickOk=function(){
					var _validation = $KMSSValidation(document.forms['kmSuperviseUrgeForm']);
					var formObj = document.kmSuperviseUrgeForm;
					Com_Submit(formObj, "urgeSupervise");
				};
			});
		</script>
		<div style="margin:10px auto;text-align: center;">
			<html:form action="/km/supervise/km_supervise_urge/kmSuperviseUrge.do">
			<html:hidden property="fdMainIds"/>
			<table id="Table_Main" class="tb_normal"width="80%"align="center">
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-supervise" key="kmSuperviseUrge.fdNotifyPersons" />
					</td>
					<td width="85%" colspan="3">
						<xform:checkbox property="fdNotifyPersons" showStatus="edit" required="true">
							<xform:simpleDataSource value="10"><bean:message key="kmSuperviseUrge.fdLeads" bundle="km-supervise"/></xform:simpleDataSource>
							<xform:simpleDataSource value="20"><bean:message key="kmSuperviseUrge.fdSponsor" bundle="km-supervise"/></xform:simpleDataSource>
							<xform:simpleDataSource value="30"><bean:message key="kmSuperviseUrge.current.task.fdSponsor" bundle="km-supervise"/></xform:simpleDataSource>
							<c:if test="${kmSuperviseUrgeForm.fdSysUnitEnable eq 'true'}">
								<xform:simpleDataSource value="40"><bean:message key="kmSuperviseUrge.fdSysUnit" bundle="km-supervise"/></xform:simpleDataSource>
							</c:if>
						</xform:checkbox>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-supervise" key="kmSuperviseUrge.fdNotifyType"/>
					</td>
					<td width="85%" colspan="3">
						 <kmss:editNotifyType property="fdNotifyType"  />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-supervise" key="kmSuperviseUrge.fdNotifyMessage"/>
					</td>
					<td width="85%" colspan="3">
						<xform:textarea property="fdNotifyMessage" style="width:95%;" 
								required="true" showStatus="edit" validators="maxLength(1500)" placeholder="请输入您的催办意见"></xform:textarea>
					</td>
				</tr>
			</table>
			<div style="width:50px;margin: 10px auto;">
				<ui:button text="${lfn:message('button.ok') }" onclick="clickOk();" />
			</div>
			</html:form>
		</div>
		<div style="height: 60px;"></div>
	</template:replace>
</template:include>