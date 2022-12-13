<%@page import="com.landray.kmss.km.pindagate.model.KmPindagateConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.profile.edit" sidebar="no">
<template:replace name="content">
<%
	KmPindagateConfig kmPindagateConfig = new KmPindagateConfig();
	request.setAttribute("kmPindagateConfig", kmPindagateConfig);
%>
<html:form action="/km/pindagate/km_pindagate_config/kmPindagateConfig.do">
<div style="margin-top:25px">
<p class="configtitle"><bean:message key="kmPindagate.tree.parameter.config" bundle="km-pindagate" /></p>
<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=35%>
			<bean:message key="kmPindagate.parameter.config.maxRowSize"  bundle="km-pindagate"/>
		</td><td colspan=3>
			<html:text property="maxRowSize" size="10"/><span class="txtstrong">*<bean:message key="kmPindagate.parameter.config.maxRowSize.indicate"  bundle="km-pindagate"/></span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=35%>
			<bean:message key="kmPindagate.parameter.config.otherAnwerSize"  bundle="km-pindagate"/>
		</td><td colspan=3>
			<html:text property="otherAnwerSize" size="10"/><span class="txtstrong">*<bean:message key="kmPindagate.parameter.config.otherAnwerSize.indicate"  bundle="km-pindagate"/></span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=35%>
			<bean:message key="kmPindagate.parameter.config.numberOfCell"  bundle="km-pindagate"/>
		</td><td colspan=3>
			<html:text property="numberOfCell" size="10"/><span class="txtstrong">*<bean:message key="kmPindagate.parameter.config.numberOfCell.indicate"  bundle="km-pindagate"/></span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=35%>
			<bean:message key="kmPindagate.parameter.config.notifyType"  bundle="km-pindagate"/>
		</td><td colspan=3>
			<kmss:editNotifyType property="notifyType"  value="${kmPindagateConfig.notifyType }"/><span class="txtstrong"><bean:message key="kmPindagate.parameter.config.notifyType.indicate"  bundle="km-pindagate"/></span>
		</td>
	</tr>
	
	
	
	
</table>
<div style="margin-bottom: 10px;margin-top:25px">
	   <ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="submint();" order="1" ></ui:button>
</div>
</center>
</div>
<html:hidden property="method_GET"/>
</html:form>
<script type="text/javascript">
function submint(){
	var maxRowSize = document.getElementsByName("maxRowSize")[0].value;
	var otherAnwerSize = document.getElementsByName("otherAnwerSize")[0].value;
	var numberOfCell = document.getElementsByName("numberOfCell")[0].value;
	if(maxRowSize == null || maxRowSize == ""){
		alert('<bean:message key="kmPindagate.parameter.config.maxRowSize" bundle="km-pindagate"/><bean:message key="kmPindagate.validate.message.notNull" bundle="km-pindagate"/>');
		return;
	}
	if(otherAnwerSize == null || otherAnwerSize == ""){
		alert('<bean:message key="kmPindagate.parameter.config.otherAnwerSize" bundle="km-pindagate"/><bean:message key="kmPindagate.validate.message.notNull" bundle="km-pindagate"/>');
		return;
	}
	if(numberOfCell == null || numberOfCell == ""){
		alert('<bean:message key="kmPindagate.parameter.config.numberOfCell" bundle="km-pindagate"/><bean:message key="kmPindagate.validate.message.notNull" bundle="km-pindagate"/>');
		return;
	}
	var   r   =  /^[0-9]*[1-9][0-9]*$/;//正整数     
	if(!r.test(maxRowSize)||parseInt(maxRowSize)>65536){
		alert('<bean:message key="kmPindagate.parameter.config.maxRowSize" bundle="km-pindagate"/><bean:message key="kmPindagate.validate.message.mustBeInteger1" bundle="km-pindagate"/>');
		return;
	}
	if(!r.test(otherAnwerSize)||parseInt(otherAnwerSize)>1000){
		alert('<bean:message key="kmPindagate.parameter.config.otherAnwerSize" bundle="km-pindagate"/><bean:message key="kmPindagate.validate.message.mustBeInteger2" bundle="km-pindagate"/>');
		return;
	}
	if(!r.test(numberOfCell)){
		alert('<bean:message key="kmPindagate.parameter.config.numberOfCell" bundle="km-pindagate"/><bean:message key="kmPindagate.validate.message.mustBeInteger3" bundle="km-pindagate"/>');
		return;
	}
	Com_Submit(document.kmPindagateConfigForm, 'update');
}
</script>
</template:replace>
</template:include>