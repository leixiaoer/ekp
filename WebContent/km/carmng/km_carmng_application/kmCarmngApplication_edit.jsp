<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>
Com_IncludeFile("docutil.js|dialog.js|calendar.js|treeview.js");
</script>
<script type="text/javascript">
function afterSelectTemplate(rtnVal){
	var fdTempletId;
	var fdTempletName;		
	if(rtnVal == null){
		parent.close();
		return;
	}
	var data = rtnVal.GetHashMapArray();
	if(data.length > 0 ){
		fdTempletName = data[0]["name"];
		fdTempletId = data[0]["id"];
	}else{
		return;
	}
	//在chorme浏览器会拦截本窗口的弹窗， 只能打开一个新窗口再关闭旧窗口
	window.open('<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=add"/>&fdTempletId='+fdTempletId);
	window.close();
	document.getElementByName(“fdMotorcadeId”).style.disabled=true;
}
function showTemplateDialog(){
	Dialog_Tree(false,null,null,null,'kmCarmngMotorcadeSetTreeService&categoryId=!{value}',
		'<bean:message key="kmCarmngMotorcadeSet.tree.title" bundle="km-carmng"/>',null,afterSelectTemplate,null,null,true);
}
window.onload = function(){
	if('${JsParam.fdTempletId}'==""&&'${JsParam.method}'=="add")
		showTemplateDialog();
}

function afterAddress(rtnVal){
	if(rtnVal == undefined){
		return;
	}
	var data = rtnVal.GetHashMapArray();
	if( data.length > 0){
		document.getElementsByName("fdUserNumber")[0].value = data.length  ;
	}
	
}
//添加对时间的判断by张文添
function commitMethod(commitType, saveDraft){	
	var formObj = document.kmCarmngApplicationForm;
	//validateKmCarmngApplicationForm(formObj);
	var docStatus = document.getElementsByName("docStatus")[0];	
	var fdStartDate=document.getElementsByName("fdStartTime")[0].value;
	var fdEndDate = document.getElementsByName("fdEndTime")[0].value;
    var nowDate=new Date();
    var now=nowDate.getFullYear()+"-";
    now = now+(nowDate.getMonth()+1)+"-";
    now = now+nowDate.getDate();
    now = now.replace(/-/g,"/");
    fdStartDate=fdStartDate.replace(/-/g,"/");
    fdEndDate = fdEndDate.replace(/-/g,"/");
    if(Date.parse(now)-Date.parse(fdStartDate)>0){      
    alert("<bean:message bundle="km-carmng" key="kmCarmng.error.message9"/>");         
    return false;}
	 if(Date.parse(fdStartDate)-Date.parse(fdEndDate)>0){
		 alert("<bean:message bundle="km-carmng" key="kmCarmng.error.message10"/>");
		 return false; 
	 }
	if(docStatus.value!="30"){
		if(saveDraft=="true"){
			docStatus.value="10";
		}else{
			docStatus.value="20";
		}
		document.getElementsByName("fdOutStatus")[0].value='0' ;
	}
	Com_Submit(formObj, commitType);
}
</script>
<html:form
	action="/km/carmng/km_carmng_application/kmCarmngApplication.do"
	onsubmit="return validateKmCarmngApplicationForm(this);">
	<div id="optBarDiv"><c:if
		test="${kmCarmngApplicationForm.method_GET=='edit'}">
		<c:if test="${kmCarmngApplicationForm.docStatus eq '10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="commitMethod('update','true');">
		</c:if>
		<input type=button value="<bean:message key="button.update"/>"
			onclick="commitMethod('update','false');">
	</c:if> <c:if test="${kmCarmngApplicationForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.savedraft"/>"
			onclick="commitMethod('save','true');">
		<input type=button value="<bean:message key="button.submit"/>"
			onclick="commitMethod('save','false');">
	</c:if> <input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();"></div>

	<p class="txttitle"><bean:message bundle="km-carmng"
		key="table.kmCarmngApplication" /></p>

	<center>
	<table id="Label_Tabel" width=95%>
		<html:hidden property="fdId" />
		<html:hidden property="docStatus" />
		<html:hidden property="fdOutStatus" />
		<html:hidden property="fdIsDispatcher" />
		<tr
			LKS_LabelName="<bean:message bundle="km-carmng" key="kmCarmng.tree.application" />">
			<td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.docSubject" /></td>
					<td width=35%><html:text size="40" property="docSubject" /><span
						class="txtstrong">*</span></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdMotorcadeId" /></td>
					<td width=35%><html:hidden property="fdMotorcadeId" /> <html:text
						readonly="true" property="fdMotorcadeName" /><input type="button" title="<bean:message  bundle="km-carmng" key="kmCarmng.tree.base.intro"/>" style= "background:url(userinfo_icon.gif);width: 20px" onclick="Com_OpenWindow('<c:url value="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do" />?method=view&fdId=${kmCarmngApplicationForm.fdMotorcadeId}');"/></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdApplicationPerson" />
					</td>
					<td width=35%><html:hidden property="fdApplicationPersonId" />
					<html:text property="fdApplicationPersonName" /> <a href="#"
						onclick="Dialog_Address(false, 'fdApplicationPersonId', 'fdApplicationPersonName', ';', ORG_TYPE_PERSON)" /><bean:message
						key="dialog.selectOrg" /></a></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng"
						key="kmCarmngApplication.fdApplicationPersonPhone" /></td>
					<td width=35%><html:text property="fdApplicationPersonPhone" /><span
						class="txtstrong">*</span></td>
				</tr>

				<tr>
				     <td class="td_normal_title" width=15%>
			          <bean:message  bundle="km-carmng" key="kmCarmngApplication.fdApplicationDept"/>
		              </td><td width=35%>
			          <html:hidden property="fdApplicationDeptId"/>
			          <html:text readonly="true" styleClass="inputsgl" property="fdApplicationDeptName" /> 
				      <a href="#" onclick="Dialog_Address(false, 'fdApplicationDeptId','fdApplicationDeptName', null, ORG_TYPE_DEPT);"> 
				      <bean:message key="dialog.selectOrg" /></a>
		            </td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdDestination" /></td>
					<td width="35%" colspan="3"><html:text
						property="fdDestination" size="30" /><span class="txtstrong">*</span>
					</td>

				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdApplicationPath" />
					</td>
					<td width=35% colspan="3"><html:text size="120"
						property="fdApplicationPath" /><span class="txtstrong">*</span></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdStartTime" /></td>
					<td width=35%><html:text styleClass="inputsgl" readonly="true"
						property="fdStartTime" /> <a href="#"
						onclick="selectDateTime('fdStartTime');"> <bean:message
						key="dialog.selectTime" /></a> <span class="txtstrong">*</span></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdEndTime" /></td>
					<td width=35%><html:text styleClass="inputsgl" readonly="true"
						property="fdEndTime" /> <a href="#"
						onclick="selectDateTime('fdEndTime');"> <bean:message
						key="dialog.selectTime" /></a><span class="txtstrong">*</span></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdUserPersons" /></td>
					<td width=35% colspan="3"><html:hidden
						property="fdUserPersonIds" /> <html:textarea style="width:96%"
						readonly="true" property="fdUserPersonNames" /> <a href="#"
						onclick="Dialog_Address(true, 'fdUserPersonIds', 'fdUserPersonNames', ';', ORG_TYPE_PERSON,afterAddress)" />
					<bean:message key="dialog.selectOrg" /></a><span class="txtstrong">*</span>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdUserNumber" /></td>
					<td width=35% colspan="3"><html:text readonly="true"
						property="fdUserNumber" /></td>
				</tr>

				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdApplicationReason" />
					</td>
					<td width=35% colspan="3"><html:textarea style="width:100%"
						property="fdApplicationReason" /></td>
				</tr>
				<!--<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngMotorcadeSet.fdRemark" /></td>
					<td width=35% colspan="3"><kmss:showText
						value="${kmCarmngApplicationForm.fdMotorcadeRemark}" /></td>
				</tr>-->
				<html:hidden property="docCreatorId" />
				<html:hidden property="docCreateTime" />
			</table>
			</td>
		</tr>

		<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmCarmngApplicationForm" />
			<c:param name="fdKey" value="kmCarmngMotorcadeSet" />
		</c:import>
		<!-- 权限 -->
		<!--<tr
			LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmCarmngApplicationForm" />
					<c:param name="moduleModelName"
						value="com.landray.kmss.km.carmng.model.KmCarmngApplication" />
				</c:import>
			</table>
			</td>
		</tr>-->
        <tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
				<table class="tb_normal" width=100%>
					<tr>
						<td width="14%" class="td_normal_title"><bean:message
							bundle="km-carmng" key="kmCarmngApplication.authReaderId" /></td>
						<td width="86%" colspan="3"><html:hidden
							property="authReaderIds" /> <html:textarea
							property="authReaderNames" style="width:90%" rows="4"
							readonly="true" styleClass="inputmul" /> <a href="#"
							onclick="Dialog_Address(true, 'authReaderIds', 'authReaderNames', ';', null);">
						<bean:message key="dialog.selectOrg" /> </a><br>
						<bean:message key="right.read.authReaders.note" bundle="sys-right" /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</center>
	<html:hidden property="method_GET" />
</html:form>
<html:javascript formName="kmCarmngApplicationForm" cdata="false"
	dynamicJavascript="true" staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>