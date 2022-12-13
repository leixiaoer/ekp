<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>
	Com_IncludeFile("dialog.js|calendar.js");
</script>
<script language="JavaScript">

 <c:if test="${kmPindagateMainForm.method_GET=='add'}">
	Com_NewFile('com.landray.kmss.km.pindagate.model.KmPindagateTemplate','<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do"/>?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}');
 </c:if>

function submitForm(method, status){
	$("input[name='docStatus']").val(status);
	var canSave = true;
	//if($("textarea[name=indagateParticipantNames]").val()==""||$("textarea[name=indagateParticipantNames]").val()==null){
	//	alert();
	//	return false;
	//}
	if(!validateQuetion(0))
		canSave = false;
	if(!validateIndagateTime())
	    canSave = false;
	if(status=="20"){
		if(!validateIndagateTime())
		    canSave = false;
		if(!validateRemindTime())
			canSave = false;
	}
	if(canSave)
		Com_Submit(document.kmPindagateMainForm, method);
		
}
//校验提醒间隔时间和提醒次数
function validateRemindTime(){
	//提醒时长
	var fdBeginNotifyPre = document.getElementsByName("fdBeginNotifyPre")[0].value;
	//提醒间隔单位
	var fdNotifyTimeUnit = document.getElementsByName("fdNotifyTimeUnit")[0].value;
	//提醒间隔时间
	var fdNotifyInterval = document.getElementsByName("fdNotifyInterval")[0].value;
	//提醒次数
	var fdNotifyFrequency = document.getElementsByName("fdNotifyFrequency")[0].value;
   if(fdNotifyFrequency > 8){
	   alert('<bean:message bundle="km-pindagate" key="kmPindagateMain.fdNotifyFrequencyLimited"/>');
	   return false;
   }
   var changeToMin = null;
	if(fdNotifyTimeUnit == 1)
		changeToMin = fdBeginNotifyPre;
	else if(fdNotifyTimeUnit == 2)
		changeToMin = fdBeginNotifyPre*60;
	else if(fdNotifyTimeUnit == 3)
		changeToMin = fdBeginNotifyPre*24*60;
	var totalRemindTime = fdNotifyInterval*fdNotifyFrequency;
	if(changeToMin < totalRemindTime){
		alert('<bean:message bundle="km-pindagate" key="kmPindagateMain.fdBeginNotifyPreLimited"/>');
		return false;
	}
    return true;
}
//校验题目是否为空
function validateQuetion(index){
	if($('input[name="fdItems['+index+'].fdSplit"]').val() == 'true'){
		index++;
		return validateQuetion(index);
	}else if(!$("input[name='fdItems["+index+"].fdQuestionDef']").val() || $("input[name='fdItems["+index+"].fdQuestionDef']").val() == ""){
		alert("<bean:message bundle="km-pindagate" key="kmPindagateMain.fdQuestionDef.not.null"/>");
	}else{
		return true;
	}
}
//校验调查开始时间和结束时间
function validateIndagateTime(){
	var today = new Date();
    var docStartTime=document.getElementsByName('docStartTime')[0].value;
    var docFinishedTime=document.getElementsByName('docFinishedTime')[0].value;  
    if(docStartTime!=null&&docStartTime!=""){
    	docStartTime+=":00";
    	if(	Date.parse(new Date(docStartTime.replace(/-/g,"/")))<Date.parse(today)){
    	alert("<bean:message bundle="km-pindagate" key="kmPindagateMain.startDate.not.lt.currentDate"/>");return false;}
    }
    if(docFinishedTime!=null&&docFinishedTime!=""){
    	docFinishedTime+=":00";
    	if(docStartTime==null||docStartTime==""){	if(	Date.parse(new Date(docFinishedTime.replace(/-/g,"/")))<Date.parse(today)){
        	alert("<bean:message bundle="km-pindagate" key="kmPindagateMain.endDate.not.lt.currentDate"/>"); return false;}}
    	
    	else if(Date.parse(new Date(docFinishedTime.replace(/-/g,"/")))<=Date.parse(new Date(docStartTime.replace(/-/g,"/")))){
    	alert("<bean:message bundle="km-pindagate" key="kmPindagateMain.endDate.not.lt.startDate"/>"); return false;}
    }
    return true;
}
</script>
<html:form action="/km/pindagate/km_pindagate_main/kmPindagateMain.do">
	<kmss:windowTitle
			subjectKey=""
			moduleKey="km-pindagate:table.kmPindagateMain" />
	<div id="optBarDiv">
	<c:if test="${kmPindagateMainForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.savedraft"/>"
			onclick="submitForm('update','10');">
			<input type=button value="<bean:message key="button.submit"/>"
			onclick="submitForm('update','20');">
	</c:if> 
	<c:if test="${kmPindagateMainForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.savedraft"/>"
			onclick="submitForm('save','10');">
		<input type=button value="<bean:message key="button.submit"/>"
			onclick="submitForm('save','20');">
	</c:if> 
	<input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
		</div>
	<p class="txttitle"><bean:message bundle="km-pindagate"
		key="table.kmPindagateMain" /></p>
	<center>
	<table id="Label_Tabel" width=95%>
		<tr
			LKS_LabelName="<bean:message bundle="km-pindagate" key="kmPindagateMain.mainiInfo" />">
			<td>
			<table class="tb_normal" width="100%" id="mainTable">
				<tr>
					<td width="15%" class="td_normal_title">
						<bean:message bundle="km-pindagate" key="kmPindagateMain.docSubject" />
					</td>
					<td colspan="3">
						<xform:text property="docSubject" style="width:50%;" />
					</td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.template" /></td>
					<td colspan="3">${kmPindagateMainForm.fdTemplateName}
						</td>
					<%--<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docDept" /></td>
					<td><xform:address propertyId="docDeptId"
						propertyName="docDeptName" orgType="ORG_TYPE_DEPT"
						required="true" /></td>--%>
				</tr>
				<tr>
					<td class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docStartTime" /></td>
					<td><xform:datetime property="docStartTime"
						dateTimeType="datetime" /> <br>
					<font color="red"><bean:message bundle="km-pindagate"
						key="kmPindagateMain.tip.null.start.indagate" /></font></td>
					<td class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docFinishedTime" /></td>
					<td><xform:datetime property="docFinishedTime"
						dateTimeType="datetime" /> <br>
					<font color="red"><bean:message bundle="km-pindagate"
						key="kmPindagateMain.tip.null.not.limit.time" /></font></td>
				</tr>
				<%-- 所属场所 --%>
				<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                    <c:param name="id" value="${kmPindagateMainForm.authAreaId}"/>
                </c:import>  
				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.partic.people" /></td>
					<td colspan="3"><xform:address
						propertyId="indagateParticipantIds"
						propertyName="indagateParticipantNames" mulSelect="true"
						orgType="ORG_TYPE_ALL" textarea="true" style="width:95%"
						required="true" /></td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.result.reader" /></td>
					<td colspan="3"><xform:address
						propertyId="indagateResultReaderIds"
						propertyName="indagateResultReaderNames" mulSelect="true"
						orgType="ORG_TYPE_ALL" textarea="true" style="width:95%" /></td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.over.notify.person" /></td>
					<td colspan="3"><xform:address
						propertyId="indagateResultNotifierIds"
						propertyName="indagateResultNotifierNames" mulSelect="true"
						orgType="ORG_TYPE_PERSON" textarea="true" style="width:95%" /></td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.fdQuestionExplain" /></td>
					<td colspan="3"><xform:rtf
						property="fdQuestionExplain" height="300"/></td>
				</tr>
				<tr>
					<td colspan="4" class="td_normal_title"><a href="#"
						onClick="var moreSetting=document.getElementById('moreSetting');moreSetting.style.display=moreSetting.style.display=='none'?'':'none';"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.more.set" />……</a></td>
				</tr>
				<tr style="display: none"  id="moreSetting"><td colspan="4"><table class="tb_normal" ><tr>
					<td class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.notify.type" /></td>
					<td><kmss:editNotifyType property="fdNotifyType" /></td>
					<td class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.before.notify.set" /></td>
					<td>
						<IMG height="1" alt="" src="/icons/ecblank.gif" width="1" border="0"><BR>
						<bean:message bundle="km-pindagate" key="kmPindagateMain.before.time" />
						<strong>
							<xform:text property="fdBeginNotifyPre" style="" /> 
						</strong> 
						<strong>
							<A name="_RefreshKW_F_RemindType"></A> 
							<xform:select property="fdNotifyTimeUnit" showPleaseSelect="false">
								<xform:enumsDataSource enumsType="kmPindagateMain_config_unit" />
							</xform:select> 
						</strong>
						<bean:message bundle="km-pindagate" key="kmPindagateMain.start.remind" /><BR>
						<bean:message bundle="km-pindagate" key="kmPindagateMain.after.each" />
						<strong> 
							<xform:text property="fdNotifyInterval" style="" /> 
						</strong>
						<strong>
							<bean:message bundle="km-pindagate" key="kmPindagateMain.config.min" />
						</strong>
						<bean:message bundle="km-pindagate" key="kmPindagateMain.starting.remind" /><BR>
						<bean:message bundle="km-pindagate" key="kmPindagateMain.remind" />
						<strong>
							<xform:text property="fdNotifyFrequency" style="" /> 
						</strong> 
						<bean:message bundle="km-pindagate" key="kmPindagateMain.times.over" />
					</td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate"
						key="kmPindagateMain.permission.multi.indagate" /></td>
					<td colspan="3"><xform:radio property="fdPersonMulti">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio></td>


				</tr>

				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.is.record.attend.name" /><br>
					<em><bean:message bundle="km-pindagate"
						key="kmPindagateMain.tip.control" /></em></td>
					<%--<td colspan="3"><xform:radio property="fdRecordPartic"  onValueChange="var style=document.getElementById('showIndagatorConfig').style;
						style.display=style.display== 'none'?'':'none';">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio></td>---%>
					<td colspan="3"><xform:radio property="fdRecordPartic">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio></td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docCreatorName" /></td>
					<td width="27%"><xform:address propertyId="docCreatorId"
						propertyName="docCreatorName" orgType="ORG_TYPE_PERSON"
						showStatus="readOnly" style="border:0;" /></td>
					<td width="12%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docCreateTime" /></td>
					<td width="22%"><xform:datetime property="docCreateTime"
						showStatus="readOnly" style="border:0;" /></td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docPublisher" /></td>
					<td width="27%"><xform:address propertyId="docPublisherId"
						propertyName="docPublisherName" orgType="ORG_TYPE_PERSON"
						showStatus="readOnly" style="border:0;" /></td>
					<td width="12%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docPublishTime" /></td>
					<td width="22%"><xform:datetime property="docPublishTime"
						showStatus="readOnly" style="border:0;" /></td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title" valign="top"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.attachment" /></td>
					<td colspan="3"><!-- 附件 --> <c:import
						url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param
								name="formBeanName"
								value="kmPindagateMainForm" />
					</c:import></td>
				</tr></table></td></tr>
				
			</table>
			</td>
		</tr>
		<tr
			LKS_LabelName="<bean:message bundle="km-pindagate" key="table.kmPindagateQuestion" />">
			<td><c:import
				url="/km/pindagate/km_pindagate_question/kmPindagateQuestion_edit.jsp"
				charEncoding="UTF-8">
			</c:import></td>
		</tr>
		<tr
			LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
			<c:set var="mainModelForm" value="${kmPindagateMainForm}"
				scope="request" />
			<c:set var="currModelName"
				value="com.landray.kmss.km.pindagate.model.KmPindagateMain"
				scope="request" />
			<td><%@ include
				file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>

		</tr>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmPindagateMainForm" />
			<c:param name="fdKey" value="pindagateMain" />
		</c:import>
		<!-- 权限 -->
		<tr
			LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmPindagateMainForm" />
					<c:param name="moduleModelName"
						value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
				</c:import>
			</table>
			</td>
		</tr>
	</table>
	</center>
	<xform:text property="docStatus" showStatus="noShow" value="20" />
	<html:hidden property="fdId" />
	<html:hidden property="method_GET" />
	<script>
$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>