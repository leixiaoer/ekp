<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.util.UserUtil" %>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script type="text/javascript"> 
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("doclist.js|docutil.js|optbar.js");
</script>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
	}
	/**
	 * 打开编辑模态窗口,修改调查结束时间
	 */
	function updateEndTime()
	{
		var url = '<c:url value = "kmPindagateMain_updateEndTime.jsp" />';
		var obj = "${kmPindagateMainForm.docFinishedTime}";
		obj = window.showModalDialog(url, obj,"dialogWidth=540px;dialogHeight=350px");
		if(obj != null){
			Com_OpenWindow('kmPindagateMain.do?method=updateIndagateEndTime&fdId=${JsParam.fdId}&endtime='+encodeURI(obj),'_self');
		}
		return;
	}

	function updateIndagateResultReaders()
	{
		var url = '<c:url value = "kmPindagateMain_updateIndagateResultReaders.jsp" />';
		var obj = "${kmPindagateMainForm.indagateResultReaderIds},"+encodeURI("${kmPindagateMainForm.indagateResultReaderNames}")+",${kmPindagateMainForm.fdId}";
		obj = window.showModalDialog(url, obj,"dialogWidth=540px;dialogHeight=350px");
		if(obj != null){
			Com_OpenWindow('kmPindagateMain.do?method=updateIndagateResultReaders&fdId=${param.fdId}&indagateResultReaderIds='+encodeURI(obj),'_self');
		}
		return;
	}
	
	function copyTemplates(){
		Dialog_Tree(false,null,null,';','kmPindagateMainTempTitleTreeService&parentId=!{value}','<bean:message bundle="km-pindagate" key="kmPindagateMain.category" />',false,copyAsTemplates,null,false,true,'<bean:message bundle="km-pindagate" key="kmPindagateMain.category" />');
	}
	function initIframeData(){
		var participateIframe = document.getElementById("participateIframe");
		var notInvolvedIframe = document.getElementById("notInvolvedIframe");
		var fdMainId = "${kmPindagateMainForm.fdId}";
		participateIframe.src = '<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do"/>?method=viewIndagatePersonInfo&fdId='+fdMainId+'&flag=already';
		notInvolvedIframe.src = '<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do"/>?method=viewIndagatePersonInfo&fdId='+fdMainId+'&flag=absent';
	}

function copyAsTemplates(rtnVal) {
    	if(rtnVal == null) {
    		window.close();
    		return;
    	}
    	var info = rtnVal.GetHashMapArray()[0];
    	if(info===undefined)
    	{
    		window.close();
    		return;
	    }
    	var docCategoryId=info.id;
    	var url='<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do"/>?method=copyAsTemplate&fdId=${param.fdId}&fdCategoryId='+docCategoryId
    	 setTimeout("location='"+url+"';", 100);
    	//Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do"/>?method=copyAsTemplate&fdId=${param.fdId}&fdCategoryId='+docCategoryId,'_self');
    }
</script>
<div id="optBarDiv">
<!-- 开始调查 -->
<c:if test="${kmPindagateMainForm.docStatus=='30'}">
<kmss:auth
	requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=startIndagate&fdId=${param.fdId}"
	requestMethod="GET">
	<input type="button"
		value="<bean:message key="button.startIndagate" bundle="km-pindagate"/>"
		onclick="Com_OpenWindow('kmPindagateMain.do?method=startIndagate&fdId=${param.fdId}','_self');">
</kmss:auth>

</c:if>
<!-- 结束调查 -->
<c:if test="${kmPindagateMainForm.docStatus=='31'}">
<kmss:auth
	requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=stopIndagate&fdId=${param.fdId}"
	requestMethod="GET">
	<input type="button"
		value="<bean:message key="button.updateIndagateEndTime" bundle="km-pindagate"/>"
		onclick="updateEndTime();">
	<input type="button"
		value="<bean:message key="button.updateIndagateResultReaders" bundle="km-pindagate"/>"
		onclick="updateIndagateResultReaders();">
	<input type="button"
		value="<bean:message key="button.stopIndagate" bundle="km-pindagate"/>"
		onclick="Com_OpenWindow('kmPindagateMain.do?method=stopIndagate&fdId=${param.fdId}','_self');">
	<input type="button"
		value="<bean:message key="button.pressAbsent" bundle="km-pindagate"/>"
		onclick="Com_OpenWindow('kmPindagateMain.do?method=pressAbsent&fdId=${param.fdId}','_self');">
</kmss:auth>
</c:if>
	<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=copyAsTemplate&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="kmPindagateMain.copyAsTemplate" bundle="km-pindagate"/>"
				onclick="copyTemplates();">
	</kmss:auth>
	<kmss:authShow roles="ROLE_KMPINDAGATE_CREATE">
		<input type="button"
				value="<bean:message key="kmPindagateMain.copyAsNewPindagateMain" bundle="km-pindagate"/>"
				onclick="Com_OpenWindow(encodeURIComponent(Com_Parameter.ContextPath+'km/pindagate/km_pindagate_main/kmPindagateMain.do?method=add&fdTemplateId=${kmPindagateMainForm.fdTemplateId}&fdTemplateName='+encodeURI(encodeURI('${kmPindagateMainForm.fdTemplateName }'))+'&fdPindagateId=${param.fdId}&copyPindagate=true)','_self');">
	</kmss:authShow>
<c:if test="${kmPindagateMainForm.docStatus!='31'&&kmPindagateMainForm.docStatus!='32'}">
	<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmPindagateMain.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	</c:if>
	
	<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmPindagateMain.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<kmss:windowTitle
			subjectKey=""
			moduleKey="km-pindagate:table.kmPindagateMain" />
<p class="txttitle"><bean:message bundle="km-pindagate" key="table.kmPindagateMain"/></p>

<center>
<table id="Label_Tabel" width=95%>
	<tr LKS_LabelName="<bean:message bundle="km-pindagate" key="kmPindagateMain.mainiInfo" />">
		<td>
		<table class="tb_normal" width="100%" id="mainTable">
		<tr>
				<td width="15%" class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateMain.docSubject"/></td>
				<td colspan="3">
				<xform:text property="docSubject" style="width:50%;"/>
				</td>
			</tr>
			<tr>
				<td width="15%" class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateMain.template"/></td>
				<td>
				<xform:text property="fdTemplateName" style="width:50%;"/>
				</td>
				<%--<td width="15%" class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateMain.docDept"/></td>
				<td>
				<xform:text property="docDeptName" style="width:50%;"/>
				</td>--%>
			</tr>
			<tr>
				<td class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateMain.docStartTime"/></td>
				<td>
					<xform:datetime property="docStartTime" />
					<br><font color="red"><bean:message bundle="km-pindagate"
						key="kmPindagateMain.tip.null.start.indagate" /></font>
				</td>
				<td class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateMain.docFinishedTime"/></td>
				<td>
					<xform:datetime property="docFinishedTime" />
					<br><font color="red"><bean:message bundle="km-pindagate"
						key="kmPindagateMain.tip.null.not.limit.time" /></font>
				</td>
			</tr>
			<%-- 所属场所 --%>
			<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                <c:param name="id" value="${kmPindagateMainForm.authAreaId}"/>
            </c:import>  
		  <tr>
				<td width="15%" class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateMain.partic.people"/></td>
				<td colspan="3">
						<xform:address propertyId="indagateParticipantIds" propertyName="indagateParticipantNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%"/>
				</td>
			</tr>
    	<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.result.reader" /></td>
				<td colspan="3"><xform:address propertyId="indagateResultReaderIds" propertyName="indagateResultReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%"/></td>
			</tr>	
			<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.over.notify.person" /></td>
				<td colspan="3"><xform:address propertyId="indagateResultNotifierIds" propertyName="indagateResultNotifierNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%"/></td>
			</tr>
			<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.fdQuestionExplain" /></td>
				<td colspan="3">
				<c:if test="${kmPindagateMainForm.fdQuestionExplain!=null}">
					<xform:rtf property="fdQuestionExplain" height="220" width="80%" toolbarSet="Default"/>
				</c:if>
				</td>
			</tr>
							
			<tr>
      	<td colspan="4" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.more.set" /></td>
  		</tr>
			<tr>
				<td class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.notify.type" /></td>
	  		<td><kmss:showNotifyType value="${kmPindagateMainForm.fdNotifyType}"/></td>
	  		<td class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.before.notify.set" /></td>
	  		<td><IMG height="1" alt="" src="/icons/ecblank.gif" width="1" border="0"><BR><bean:message bundle="km-pindagate"
						key="kmPindagateMain.before.time" /><strong>
        <xform:text property="fdBeginNotifyPre" style="" />
	    	</strong> <strong><A name="_RefreshKW_F_RemindType"></A>
					<xform:select property="fdNotifyTimeUnit" >
					<xform:enumsDataSource enumsType="kmPindagateMain_config_unit" />
			</xform:select>
        </strong><bean:message bundle="km-pindagate"
						key="kmPindagateMain.start.remind" /><BR>
        	<bean:message bundle="km-pindagate"
						key="kmPindagateMain.after.each" /><strong>
        <xform:text property="fdNotifyInterval" style="" />
        </strong><strong><bean:message
						bundle="km-pindagate" key="kmPindagateMain.config.min" /></strong><bean:message
						bundle="km-pindagate" key="kmPindagateMain.starting.remind" /><BR>
        	<bean:message bundle="km-pindagate" key="kmPindagateMain.remind" /><strong>
        <xform:text property="fdNotifyFrequency" style="" />
      	</strong> <bean:message
						bundle="km-pindagate" key="kmPindagateMain.times.over" /></td>
			</tr>
			<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate"
						key="kmPindagateMain.permission.multi.indagate" /> </td>
				<td colspan="3"><xform:radio property="fdPersonMulti">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio></td>	
			</tr>

			<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.is.record.attend.name" /><br><em><bean:message bundle="km-pindagate"
						key="kmPindagateMain.tip.control" /></em></td>
				<td colspan="3">
				<xform:radio property="fdRecordPartic">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
				</td>
			</tr>
			<%--	
			<c:if test="${kmPindagateMainForm.fdRecordPartic=='true'}">
			<tr>
				<td class="td_normal_title" width="15%"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.show.indagated.config" /></td>
				<td><bean:message bundle="km-pindagate"
						key="kmPindagateMain.when.indagator.less" /><xform:text property="fdInvestigatedShow" style="" /><bean:message
						bundle="km-pindagate" key="kmPindagateMain.show.indagated.name" /></td>
				<td class="td_normal_title" width="15%" ><bean:message
						bundle="km-pindagate"
						key="kmPindagateMain.not.indagator.show.config" /></td>
				<td nowrap="true"><bean:message bundle="km-pindagate"
						key="kmPindagateMain.when.not.indagator.less" /><xform:text property="fdUninvestigateShow" style="" /><bean:message
						bundle="km-pindagate"
						key="kmPindagateMain.show.not.indagated.list" /></td>
			</tr>
			</c:if>--%>
			<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docCreatorName" /></td>
				<td width="27%"><xform:address propertyId="docCreatorId" propertyName="docCreatorName" orgType="ORG_TYPE_PERSON" showStatus="readOnly" style="border:0;"/></td>
				<td width="12%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docCreateTime" /></td>
				<td width="22%"><xform:datetime property="docCreateTime" showStatus="readOnly" style="border:0;"/></td>
			</tr>
			<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docPublisher" /></td>
				<td width="27%"><xform:address propertyId="docPublisherId" propertyName="docPublisherName" orgType="ORG_TYPE_PERSON" showStatus="readOnly" style="border:0;"/></td>
				<td width="12%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.docPublishTime" /></td>
				<td width="22%"><xform:datetime property="docPublishTime" showStatus="readOnly" style="border:0;"/></td>
			</tr>
			<tr>
				<td width="15%" class="td_normal_title" valign="top"><bean:message
						bundle="km-pindagate" key="kmPindagateMain.attachment" /></td>
				<td colspan="3">
				 <!-- 附件-->
                    <c:import
					url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" 
					charEncoding="UTF-8">
					<c:param name="fdKey" value="attachment"/>
					<c:param name="formBeanName" value="kmPindagateMainForm" />
				</c:import>
		</td>
			</tr>
			<tr>
				<td width="15%" class="td_normal_title" valign="top"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.analysisResponses.attachment" /></td>
				<td colspan="3">
				 <!-- 参与人员答卷分析结果附件-->
                    <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="resultsDetail"/>
					<c:param name="formBeanName" value="kmPindagateMainForm" />
				</c:import>
		</td>
			</tr>
		</table>
	</td>
 </tr>
  <%--调查题目 --%>
  <tr LKS_LabelName="<bean:message bundle="km-pindagate" key="table.kmPindagateQuestion" />">
	    <td>
			<c:import url="/km/pindagate/km_pindagate_question/kmPindagateQuestion_view.jsp" charEncoding="UTF-8">
				</c:import>            	
	    </td>
  </tr>       
  <%--关联--%>
  <tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
          	<c:set var="mainModelForm" value="${kmPindagateMainForm}"
			scope="request" />
		<c:set var="currModelName"
			value="com.landray.kmss.km.pindagate.model.KmPindagateMain"
			scope="request" />
		<td><%@ include
			file="/sys/relation/include/sysRelationMain_view.jsp"%></td>
  </tr>    
  <%--流程--%>
  <c:import url="/sys/workflow/include/sysWfProcess_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmPindagateMainForm" />
		<c:param name="fdKey" value="pindagateMain" />
	</c:import> 
  <%--权限--%>
   <tr
		LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
		<table class="tb_normal" width=100%>
			<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmPindagateMainForm" />
				<c:param name="moduleModelName"
					value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
			</c:import>
			
		</table>
		</td>
	</tr> 
	 <%--查看调查人员--%>
	<c:if test="${kmPindagateMainForm.fdRecordPartic=='true'&&(kmPindagateMainForm.docStatus=='31'||kmPindagateMainForm.docStatus=='32')}">
	 	<tr	LKS_LabelName="<bean:message bundle="km-pindagate" key="kmPindagate.indagator.show" />" style="display:none">
		<td colspan="4" onresize="initIframeData();">
		<table class="tb_normal"  width="100%"  >	
			<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagate.indagated.persons" /></td>
				<td  width="85%" >
					<img src='${KMSS_Parameter_StylePath}portal/spinner.gif' border='0' id="participateImg">
					<iframe id="participateIframe" allowTransparency="true" width="100%" 
						marginheight="0" marginwidth="0" scrolling=no frameborder=0 src=''></iframe>
				</td>
			</tr>	
			<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagate.indagating.persons" /></td>
				<td  width="85%" >
					<img src='${KMSS_Parameter_StylePath}portal/spinner.gif' border='0' id="notInvolvedImg">
					<iframe id="notInvolvedIframe" allowTransparency="true" width="100%" 
						marginheight="0" marginwidth="0" scrolling=no frameborder=0 src=''></iframe>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	</c:if>
	<%--传阅/阅读--%>
	<c:if test="${kmPindagateMainForm.docStatus=='30'||kmPindagateMainForm.docStatus=='31'||kmPindagateMainForm.docStatus=='32'}">
		<c:import url="/sys/circulation/include/sysCirculationMain_view.jsp"
				charEncoding="UTF-8">
			<c:param name="formName" value="kmPindagateMainForm" />
		</c:import>
		<c:import url="/sys/readlog/include/sysReadLog_view.jsp" 
				charEncoding="UTF-8">
			<c:param name="formName" value="kmPindagateMainForm" />
		</c:import>
	</c:if>
  </table>
</center>
<xform:text property="docStatus" showStatus="noShow"/>
<%@ include file="/resource/jsp/view_down.jsp"%>