<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil"%>
<%
	request.setAttribute("sysUnitEnable", KmSuperviseUtil.isSysUnitEnable());
%>
<template:include ref="config.profile.edit" sidebar="no">
	<template:replace name="title"><bean:message bundle="sys-organization" key="sysOrgConfig" /></template:replace>
	<template:replace name="head">
		<script>
			Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp", null, "js");
		</script>
		<script>$KMSSValidation(document.forms['sysAppConfigForm']);</script>
		<script type="text/javascript">
			function mergeNotifierValue(name) {
				var notifier = [];
				var arrs = document.getElementsByName(name);
				for (var i = 0; i < arrs.length; i++) {
					if(arrs[i].checked)
						notifier.push(arrs[i].value);
				}
				document.getElementsByName('value('+name+')')[0].value = notifier.join(';');
			}
			
			function mergeTimeValue(name) {
				var day = document.getElementsByName(name+"_day")[0].value;
				if(!day) day = '0';
				var hour = document.getElementsByName(name+"_hour")[0].value;
				if(!hour) hour = '0';
				var minute = document.getElementsByName(name+"_minute")[0].value;
				if(!minute) minute = '0';
				var time = day+":"+hour+":"+minute;
				if(time == '0:0:0') {
					document.getElementsByName('value('+name+')')[0].value = '';
				} else {
					document.getElementsByName('value('+name+')')[0].value = time;
				}
			}
			
			function submitConfig() {
				mergeNotifierValue("earlySuperviseNotifier");
				mergeNotifierValue("earlyFeedbackNotifier");
				mergeNotifierValue("delayFeedbackNotifier");
				mergeNotifierValue("earlyStageNotifier");
				mergeNotifierValue("delaySuperviseNotifier");
				mergeNotifierValue("delayStageNotifier");
				
				mergeTimeValue("earlySuperviseTime");
				mergeTimeValue("earlyFeedbackTime");
				mergeTimeValue("delayFeedbackTime");
				mergeTimeValue("earlyStageTime");
				mergeTimeValue("delaySuperviseTime");
				mergeTimeValue("delayStageTime");
				
				var hour = document.getElementsByName("endFeedbackTime_hour")[0].value;
				if(!hour) hour = '0';
				var minute = document.getElementsByName("endFeedbackTime_minute")[0].value;
				if(!minute) minute = '0';
				var time = hour+":"+minute;
				if(time == '0:0') {
					document.getElementsByName('value(endFeedbackTime)')[0].value = '18:0';
				} else {
					document.getElementsByName('value(endFeedbackTime)')[0].value = time;
				}
				Com_Submit(document.sysAppConfigForm, 'update');
			}
			
			function initTimeValue(name) {
				var time = $("[name='value("+name+")']");
				var value = time.val();
				if(!value){
					// 默认1天
					$("[name='"+name+"_day']").val('1');
					$("[name='"+name+"_hour']").val('0');
					$("[name='"+name+"_minute']").val('0');
				} else {
					var times = value.split(":");
					$("[name='"+name+"_day']").val(times[0]);
					$("[name='"+name+"_hour']").val(times[1]);
					$("[name='"+name+"_minute']").val(times[2]);
				}
			}
			seajs.use(['lui/jquery'],function($) {
				$(document).ready(function(){
					var formValidator = new $KMSSValidation(document.forms['sysAppConfigForm'], {onSubmit:false, immediate:false});
					Com_Parameter.event["submit"].push(function() {
						return formValidator.validate();
					});
					initTimeValue("earlySuperviseTime");
					initTimeValue("earlyFeedbackTime");
					initTimeValue("delayFeedbackTime");
					initTimeValue("earlyStageTime");
					initTimeValue("delaySuperviseTime");
					initTimeValue("delayStageTime");
					
					var earlySuperviseNotifier = $("[name='value(earlySuperviseNotifier)']").val();
					if(earlySuperviseNotifier) {
						var earlySuperviseNotifiers = earlySuperviseNotifier.split(';');
						for (var i = 0; i < earlySuperviseNotifiers.length; i++) {
							$("[name='earlySuperviseNotifier'][value='"+earlySuperviseNotifiers[i]+"']").prop('checked',true);
						}
					}else{
						$("[name='earlySuperviseNotifier'][value='20']").prop('checked',true);
						$("[name='earlySuperviseNotifier'][value='30']").prop('checked',true);
					}
					
					var earlyFeedbackNotifier = $("[name='value(earlyFeedbackNotifier)']").val();
					
					if(earlyFeedbackNotifier) {
						var earlyFeedbackNotifiers = earlyFeedbackNotifier.split(';');
						for (var i = 0; i < earlyFeedbackNotifiers.length; i++) {
							$("[name='earlyFeedbackNotifier'][value='"+earlyFeedbackNotifiers[i]+"']").prop('checked',true);
						}
					}else{
						$("[name='earlyFeedbackNotifier'][value='10']").prop('checked',true);
					}
					
					var delayFeedbackNotifier = $("[name='value(delayFeedbackNotifier)']").val();
					if(delayFeedbackNotifier) {
						var delayFeedbackNotifiers = delayFeedbackNotifier.split(';');
						for (var i = 0; i < delayFeedbackNotifiers.length; i++) {
							$("[name='delayFeedbackNotifier'][value='"+delayFeedbackNotifiers[i]+"']").prop('checked',true);
						}
					}else{
						$("[name='delayFeedbackNotifier'][value='10']").prop('checked',true);
					}
					
					var earlyStageNotifier = $("[name='value(earlyStageNotifier)']").val();
					if(earlyStageNotifier) {
						var earlyStageNotifiers = earlyStageNotifier.split(';');
						for (var i = 0; i < earlyStageNotifiers.length; i++) {
							$("[name='earlyStageNotifier'][value='"+earlyStageNotifiers[i]+"']").prop('checked',true);
						}
					}else{
						$("[name='earlyStageNotifier'][value='40']").prop('checked',true);
					}
					
					var delaySuperviseNotifier = $("[name='value(delaySuperviseNotifier)']").val();
					if(delaySuperviseNotifier) {
						var delaySuperviseNotifiers = delaySuperviseNotifier.split(';');
						for (var i = 0; i < delaySuperviseNotifiers.length; i++) {
							$("[name='delaySuperviseNotifier'][value='"+delaySuperviseNotifiers[i]+"']").prop('checked',true);
						}
					}else{
						$("[name='delaySuperviseNotifier'][value='10']").prop('checked',true);
						$("[name='delaySuperviseNotifier'][value='20']").prop('checked',true);
						$("[name='delaySuperviseNotifier'][value='30']").prop('checked',true);
					}
					
					var delayStageNotifier = $("[name='value(delayStageNotifier)']").val();
					if(delayStageNotifier) {
						var delayStageNotifiers = delayStageNotifier.split(';');
						for (var i = 0; i < delayStageNotifiers.length; i++) {
							$("[name='delayStageNotifier'][value='"+delayStageNotifiers[i]+"']").prop('checked',true);
						}
					}else{
						$("[name='delayStageNotifier'][value='20']").prop('checked',true);
						$("[name='delayStageNotifier'][value='30']").prop('checked',true);
						$("[name='delayStageNotifier'][value='40']").prop('checked',true);
					}
					
					var endFeedbackTime = $("[name='value(endFeedbackTime)']").val();
					if(endFeedbackTime) {
						var endFeedbackTimes = endFeedbackTime.split(':');
						$("[name='endFeedbackTime_hour']").val(endFeedbackTimes[0]);
						$("[name='endFeedbackTime_minute']").val(endFeedbackTimes[1]);
					}else{
						$("[name='endFeedbackTime_hour']").val("18");
						$("[name='endFeedbackTime_minute']").val("0");
					}
				});
			});
		</script>
		<style>
			.contentTD input[type='text'] {
				width:60px;
			}
		</style>
	</template:replace>
	<template:replace name="content">
		<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do" >
			<div style="margin-top:25px">
			<p class="configtitle">
				<kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.warn" />
			</p>
			<center>
			<table class="tb_normal" width=90%>
				<tr>
					<td class="td_normal_title" width=15% rowspan="7">
						<kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.warn" />
					</td><td colspan=3 class="contentTD">
					<html:hidden property="value(earlyFeedbackTime)"/>
					<p><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.feedback.early" /><input validate="min(0) digits" type="text" class="inputsgl" name="earlyFeedbackTime_day"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.day" />
					<input type="text" validate="range(0,23) digits" class="inputsgl" name="earlyFeedbackTime_hour"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.hour" />
					<input type="text" validate="range(0,59) digits" class="inputsgl" name="earlyFeedbackTime_minute"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.minute" />
					<kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.alert" />
					<html:hidden property="value(earlyFeedbackNotifier)"/>
					<label><input type="checkbox" name="earlyFeedbackNotifier" value="10" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.undertake.person" /> </label>
					<c:choose>
					<c:when test="${sysUnitEnable eq 'true' }">
					<label><input type="checkbox" name="earlyFeedbackNotifier" value="20"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.org.supervise.contact" /></label>
					<label><input type="checkbox" name="earlyFeedbackNotifier" value="30"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.co.org.supervise.contact" /></label>
					</c:when>
					<c:otherwise>
					<label><input type="checkbox" name="earlyFeedbackNotifier" value="30"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.co.org.supervise.contact.person" /></label>
					</c:otherwise>
					</c:choose>
					</p></td></tr>
					
					<tr><td colspan=3 class="contentTD">
					<html:hidden property="value(endFeedbackTime)"/>
					<p><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.feedback.end" /><input validate="range(0,23) digits" type="text" class="inputsgl" name="endFeedbackTime_hour"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.hour" />
					<input validate="range(0,59) digits" type="text" class="inputsgl" name="endFeedbackTime_minute"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.minute" /></p>
					<p><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.feedback.end.tip1" /></p>
					<p><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.feedback.end.tip2" /></p>
					</td></tr>
					
					<tr>
					<td colspan=3 class="contentTD">
					<html:hidden property="value(delayFeedbackTime)"/>
					<p><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.feedback.delay" /><input validate="min(0) digits" type="text" class="inputsgl" name="delayFeedbackTime_day"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.day" />
					<input type="text" validate="range(0,23) digits" class="inputsgl" name="delayFeedbackTime_hour"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.hour" />
					<input type="text" validate="range(0,59) digits" class="inputsgl" name="delayFeedbackTime_minute"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.minute" />
					<kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.alert" />
					<html:hidden property="value(delayFeedbackNotifier)"/>
					<label><input type="checkbox" name="delayFeedbackNotifier" value="10" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.undertake.person" /> </label>
					<c:choose>
					<c:when test="${sysUnitEnable eq 'true' }">
					<label><input type="checkbox" name="delayFeedbackNotifier" value="20"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.org.supervise.contact" /></label>
					<label><input type="checkbox" name="delayFeedbackNotifier" value="30"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.co.org.supervise.contact" /></label>
					</c:when>
					<c:otherwise>
					<label><input type="checkbox" name="earlyFeedbackNotifier" value="30"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.co.org.supervise.contact.person" /></label>
					</c:otherwise>
					</c:choose>
					</p></td></tr>
					
					<tr><td colspan=3 class="contentTD">
					<html:hidden property="value(earlyStageTime)"/>
					<p><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.stage.early" /><input validate="min(0) digits" type="text" class="inputsgl" name="earlyStageTime_day"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.day" />
					<input validate="range(0,23) digits" type="text" class="inputsgl" name="earlyStageTime_hour"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.hour" />
					<input validate="range(0,59) digits" type="text" class="inputsgl" name="earlyStageTime_minute"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.minute" /><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.alert" />
					<html:hidden property="value(earlyStageNotifier)"/>
					<label><input type="checkbox" name="earlyStageNotifier" value="10"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.charge.leader" /></label>
					<label><input type="checkbox" name="earlyStageNotifier" value="20"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.resp.person" /></label>
					<c:if test="${sysUnitEnable eq 'true' }">
					<label><input type="checkbox" name="earlyStageNotifier" value="30"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.org.supervise.contact" /></label>
					</c:if>
					<label><input type="checkbox" name="earlyStageNotifier" value="40" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.undertake.person" /></label>
					<c:if test="${sysUnitEnable eq 'true' }">
					<label><input type="checkbox" name="earlyStageNotifier" value="50"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.undertake.supervise.contractor" /></label>
					</c:if>
					</p></td></tr>
					
					<tr><td colspan=3 class="contentTD">
					<html:hidden property="value(delayStageTime)"/>
					<p><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.stage.delay" /><input validate="min(0) digits" type="text" class="inputsgl" name="delayStageTime_day"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.day" />
					<input validate="range(0,23) digits" type="text" class="inputsgl" name="delayStageTime_hour"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.hour" />
					<input validate="range(0,59) digits" type="text" class="inputsgl" name="delayStageTime_minute"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.minute" /><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.alert" />
					<html:hidden property="value(delayStageNotifier)"/>
					<label><input type="checkbox" name="delayStageNotifier" value="10"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.charge.leader" /></label>
					<label><input type="checkbox" name="delayStageNotifier" value="20" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.resp.person" /></label>
					<c:if test="${sysUnitEnable eq 'true' }">
					<label><input type="checkbox" name="delayStageNotifier" value="30" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.org.supervise.contact" /></label>
					</c:if>
					<label><input type="checkbox" name="delayStageNotifier" value="40" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.undertake.person" /></label>
					<c:if test="${sysUnitEnable eq 'true' }">
					<label><input type="checkbox" name="delayStageNotifier" value="50"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.undertake.supervise.contractor" /></label>
					</c:if>
					</p></td></tr>
					
					<tr><td colspan=3 class="contentTD">
					<html:hidden property="value(earlySuperviseTime)"/>
					<p><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.supervise.early" /><input validate="min(0) digits" type="text" class="inputsgl" name="earlySuperviseTime_day"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.day" />
					<input validate="range(0,23) digits" type="text" class="inputsgl" name="earlySuperviseTime_hour"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.hour" />
					<input validate="range(0,59) digits" type="text" class="inputsgl" name="earlySuperviseTime_minute"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.minute" /><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.alert" />
					<html:hidden property="value(earlySuperviseNotifier)"/>
					<label><input type="checkbox" name="earlySuperviseNotifier" value="10"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.charge.leader" /></label>
					<label><input type="checkbox" name="earlySuperviseNotifier" value="20" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.resp.person" /></label>
					<c:if test="${sysUnitEnable eq 'true' }">
					<label><input type="checkbox" name="earlySuperviseNotifier" value="30" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.org.supervise.contact" /></label>
					</c:if>
					</p></td></tr>
					
					<tr><td colspan=3 class="contentTD">
					<html:hidden property="value(delaySuperviseTime)"/>
					<p><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.supervise.delay" /><input validate="min(0) digits" type="text" class="inputsgl" name="delaySuperviseTime_day"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.day" />
					<input validate="range(0,23) digits" type="text" class="inputsgl" name="delaySuperviseTime_hour"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.hour" />
					<input validate="range(0,59) digits" type="text" class="inputsgl" name="delaySuperviseTime_minute"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.minute" /><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.alert" />
					<html:hidden property="value(delaySuperviseNotifier)"/>
					<label><input type="checkbox" name="delaySuperviseNotifier" value="10" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.charge.leader" /></label>
					<label><input type="checkbox" name="delaySuperviseNotifier" value="20" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.resp.person" /></label>
					<c:if test="${sysUnitEnable eq 'true' }">
					<label><input type="checkbox" name="delaySuperviseNotifier" value="30" disabled="disabled"/><kmss:message bundle="km-supervise" key="kmSuperviseWarnConfig.org.supervise.contact" /></label>
					</c:if>
					</p></td></tr>
			</table>
			<div style="margin-bottom: 10px;margin-top:25px">
				   <ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="submitConfig();" order="1" ></ui:button>
			</div>
			</center>
			</div>
			<html:hidden property="method_GET"/>
			<html:hidden property="modelName" value="com.landray.kmss.km.supervise.model.KmSuperviseWarnConfig"/>
		</html:form>
	</template:replace>
</template:include>
