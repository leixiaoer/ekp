<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do">
<div id="optBarDiv">
	<input type=button value="<bean:message key="button.update"/>"
		onclick="Com_Submit(document.sysAppConfigForm, 'update');">
</div>
<p class="txttitle"><bean:message bundle="geesun-org" key="geesunOrgSynchroConfig.config" /></p>
<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width="20%">
			<bean:message bundle="geesun-org" key="geesunOrgSynchroConfig.fdUrl" />
		</td>
		<td>
			<xform:text property="value(fdUrl)" style="width:300px;"/>
		</td>
	</tr>
	<%-- <tr>
		<td class="td_normal_title" width="20%">
			<bean:message bundle="geesun-org" key="geesunOrgSynchroConfig.fdUserName" />
		</td>
		<td>
			<xform:text property="value(fdUserName)" style="width:300px;"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="20%">
			<bean:message bundle="geesun-org" key="geesunOrgSynchroConfig.fdPassword" />
		</td>
		<td>
			<xform:text property="value(fdPassword)" style="width:300px;"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="20%">
			<bean:message bundle="geesun-org" key="geesunOrgSynchroConfig.fdAccount" />
		</td>
		<td>
			<xform:text property="value(fdAccount)" style="width:300px;"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="20%">
			<bean:message bundle="geesun-org" key="geesunOrgSynchroConfig.fdSecretKey" />
		</td>
		<td>
			<xform:text property="value(fdSecretKey)" style="width:300px;"/>
		</td>
	</tr> --%>
	<tr>
		<td class="td_normal_title" width="20%">
			<bean:message bundle="geesun-org" key="geesunOrgSynchroConfig.fdZzType" />
		</td>
		<td>
			<xform:radio property="value(fdZzType)"  showStatus="edit">
				<xform:simpleDataSource value="1" bundle="geesun-org" textKey="geesunOrgSynchroConfig.fdZzType.ALL"></xform:simpleDataSource>
				<xform:simpleDataSource value="2" bundle="geesun-org" textKey="geesunOrgSynchroConfig.fdZzType.ZL"></xform:simpleDataSource>
			</xform:radio>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="20%">
			<bean:message bundle="geesun-org" key="geesunOrgSynchroConfig.fdFilterParentIds" />
		</td>
		<td>
			<xform:textarea property="value(fdFilterParentIds)" style="width:90%;height:300px;"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="20%">
			<bean:message bundle="geesun-org" key="geesunOrgSynchroConfig.fdNotifyType" />
		</td>
		<td>
			<kmss:editNotifyType property="value(fdNotifyType)" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="20%">
			<bean:message bundle="geesun-org" key="geesunOrgSynchroConfig.notifyExceptionTarget" />
		</td>
		<td>
			<xform:address propertyId="value(notifyExceptionTargetIds)" propertyName="value(notifyExceptionTargetNames)" mulSelect="true" orgType="ORG_TYPE_PERSON" style="width:85%">
			</xform:address>
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET" />
<input type="hidden" name="modelName" value="com.landray.kmss.geesun.org.model.GeesunOrgSynchroConfig" />
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>
