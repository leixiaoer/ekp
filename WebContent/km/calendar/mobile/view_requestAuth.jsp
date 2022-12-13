<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.view" >
	<template:replace name="title">
		<bean:message bundle="km-calendar" key="kmCalendarRequestAuth.persons" />
	</template:replace>
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/calendar/mobile/resource/css/view.css?s_cache=${MUI_Cache}" />
		<style>
			.txtContent {
			    text-align: center;
	    		padding: 1.5rem 0px;
	    	}
    	</style>
	</template:replace>
	<template:replace name="content">
		<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView">
			<div class="muiFormContent kmCalendarFormContent">
				<p class="txtContent">
					<bean:message bundle="km-calendar" key="kmCalendarRequestAuth.persons" />
				</p>
				<table class="muiSimple" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<div class="newMui muiFormEleWrap muiFormGroup showTitle muiFormStatusView muiFormCheckBoxNormal muiFormLeft">
								<div class="muiFormEleTip">
									<span class="muiFormEleTitle"><bean:message bundle="km-calendar" key="kmCalendarRequestAuth.fdRequestPerson" /></span>
								</div>
								<div class="muiFormItem">
									<c:out value="${kmCalendarRequestAuthForm.fdRequestPersonNames}" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div data-dojo-type='mui/form/CheckBoxGroup'
								data-dojo-props="'name':'fdRequestAuth',
								'mul':true,'concentrate':false,
								'showStatus':'view',
								'alignment':'V',
								'orient':'vertical',
								'subject':'<bean:message key="kmCalendarRequestAuth.fdRequestAuth" bundle="km-calendar"/>',
								'store':[{'text':'<bean:message key="kmCalendarRquestAuth.fdRequestAuth.authRead" bundle="km-calendar"/>','value':'authRead','checked':true,'disabled':'disabled'},
								{'text':'<bean:message key="kmCalendarRquestAuth.fdRequestAuth.authEdit" bundle="km-calendar"/>','value':'authEdit','checked':false},
								{'text':'<bean:message key="kmCalendarRquestAuth.fdRequestAuth.authModify" bundle="km-calendar"/>','value':'authModify','checked':false}]">
							</div> 
						</td>
					</tr>
				</table>
			</div>
		</div>
	</template:replace>
</template:include>