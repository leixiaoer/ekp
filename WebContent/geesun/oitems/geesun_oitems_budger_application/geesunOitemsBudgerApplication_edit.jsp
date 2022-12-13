<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ page import="
	com.landray.kmss.util.KmssMessageWriter,
	com.landray.kmss.util.KmssReturnPage" %>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<script type="text/javascript">
Com_Parameter.CloseInfo="<bean:message key="message.closeWindow"/>";
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("docutil.js|optbar.js|validator.jsp|validation.js|plugin.js|validation.jsp|xform.js", null, "js");
</script>
</head>
<body>
<br>
<% if(request.getAttribute("KMSS_RETURNPAGE")==null){ %>
<logic:messagesPresent>
	<table align=center><tr><td>
		<font class="txtstrong"><bean:message key="errors.header.vali"/></font>
		<bean:message key="errors.header.correct"/>
		<html:messages id="error">
			<br><img src='${KMSS_Parameter_StylePath}msg/dot.gif'>&nbsp;&nbsp;<bean:write name="error"/>
		</html:messages>
	</td></tr></table>
	<hr />
</logic:messagesPresent>
<% }else{
	KmssMessageWriter msgWriter = new KmssMessageWriter(request, (KmssReturnPage)request.getAttribute("KMSS_RETURNPAGE"));
%>
<script>
Com_IncludeFile("msg.js", "style/"+Com_Parameter.Style+"/msg/");
function showMoreErrInfo(index, srcImg){
	var obj = document.getElementById("moreErrInfo"+index);
	if(obj!=null){
		if(obj.style.display=="none"){
			obj.style.display="block";
			srcImg.src = Com_Parameter.StylePath + "msg/minus.gif";
		}else{
			obj.style.display="none";
			srcImg.src = Com_Parameter.StylePath + "msg/plus.gif";
		}
	}
}
</script>
<table align=center><tr><td>
	<br style="font-size:10px">
	<%= msgWriter.DrawMessages() %>
</td></tr></table>
<hr />
<% } %>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
<script type="text/javascript">
function commitMethod(commitType, saveDraft){
	var formObj = document.geesunOitemsBudgerApplicationForm;
	var docStatus = document.getElementsByName("docStatus")[0];
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

	function addOitems(){
		var fdApplicationId = document.getElementsByName("fdId")[0].value ;
		var arguments = new Object();
		arguments.title='<bean:message bundle="geesun-oitems" key="geesunOitemsListing.geesunOitemsListing"/>';
		var href = "<%=request.getContextPath() %>/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication_add.jsp?fdApplicationId="+fdApplicationId;
		var rtnData = window.showModalDialog(href,'',"dialogHeight:600px;dialogWidth:900px;toolbar:no;status:no;location:no");
		document.getElementById("iframe_id").src= "<c:url value='/geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do?method=listForApplication&orderby=fdNo&fdApplicationId=${geesunOitemsBudgerApplicationForm.fdId}&operation=1&windReturnValue='/>"+rtnData;		
	 }

	function changGeesunOitemsTemplet(rtnVal, fdTempId){
		if(rtnVal == undefined){
			return;
		}
		var data = rtnVal.GetHashMapArray();
		var values = "";	 
		for(var i = 0; i < data.length; i++){
			if(data[i]["id"] == fdTempId)
				 values = data[i]["fdType"];
		}
		var href = window.location.href;
		href=Com_SetUrlParameter(href,"type",values);
		//var re = /type=\w*&/;
		//href = href.replace(re,"type="+values+"&");
		window.location.href = href;
	}
	function onChangeGeesunOitemsTemplate(fdTempId){
		var chg = confirm("<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.changeGeesunOitemsTemplate" />");
		if(chg){
			var data = new KMSSData();
			data.SendToBean("geesunOitemsTempletTreeService", function(rtnVal){changGeesunOitemsTemplet(rtnVal,fdTempId)});
		}
		return chg;
	}
</script>
<html:form action="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do" onsubmit="return validateGeesunOitemsBudgerApplicationForm(this);">
<div id="optBarDiv">
	<c:if test="${geesunOitemsBudgerApplicationForm.method_GET=='edit'}">
		<c:if test="${geesunOitemsBudgerApplicationForm.docStatus eq '10'}">
		<input type=button value="<bean:message key="button.savedraft"/>"
			onclick="commitMethod('update','true');">
		</c:if>
		<input type=button value="<bean:message key="button.update"/>"
			onclick="commitMethod('update','false');">
	</c:if>
	<c:if test="${geesunOitemsBudgerApplicationForm.method_GET=='add'}">
		<input
			type=button
			value="<bean:message key="button.savedraft" />"
			onclick="commitMethod('save','true');">
		<input
			type=button
			value="<bean:message key="button.submit"/>"
			onclick="commitMethod('save','false');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle">
<c:if test="${param.type == 'dept' }">
<bean:message  bundle="geesun-oitems" key="geesunOitems.tree.dept.application"/>
</c:if>
<c:if test="${param.type != 'dept' }">
<bean:message  bundle="geesun-oitems" key="geesunOitems.tree.person.application"/>
</c:if>
</p>
<center>
<table id="Label_Tabel" width=95%>
		<html:hidden property="fdId"/>
		<html:hidden property="docStatus"/>
		<html:hidden property="fdOutStatus"/>
		<html:hidden property="fdType"/>
	<tr  LKS_LabelName="<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.base.massage" />">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="table.geesunOitemsTemplet"/>
					</td><td width=35%>
						<xform:radio property="fdTemplateId" required="true" onValueChange="if(!onChangeGeesunOitemsTemplate(this.value))return;">
							<xform:beanDataSource serviceBean="geesunOitemsTempletTreeService" orderBy="geesunOitemsTemplet.docCreateTime desc"/>
						</xform:radio>
					</td>
					<c:if test="${geesunOitemsTempletForm.fdTempletType!='1'}">
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.creator.dept"/>
					</td><td>
					    <html:hidden property="docDeptId"/>
						<html:text property="docDeptName" style="width:60%"/>
						 <a href="#"
										onclick="Dialog_Address(false, 'docDeptId','docDeptName',null,ORG_TYPE_DEPT);">
							 
							<bean:message key="dialog.selectOrg" /> </a><span class="txtstrong">*</span>
					</td>
					</c:if>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docSubject"/>
					</td><td>
						<html:text property="docSubject" style="width:80%"/><span class="txtstrong">*</span>
					</td>
					<td class="td_normal_title" width=15%>
					<c:if test="${param.type=='dept' }">
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicants.deptId"/>
					</c:if>
					<c:if test="${param.type!='dept' }">
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicantsId"/>
					</c:if>
					</td>
					<td width=35%>					
						<html:hidden property="fdApplicantsId"/>
						<html:text property="fdApplicantsName" styleClass="inputsgl" style="width:60%" readonly="true"/>
						 <c:if test="${param.type=='dept' }">
							 <a href="#"
										onclick="Dialog_Address(false, 'fdApplicantsId','fdApplicantsName',null,ORG_TYPE_DEPT);">
							 
								<bean:message key="dialog.selectOrg" /> </a>
						</c:if>
						<c:if test="${param.type !='dept' }">
							 <a href="#"
										onclick="Dialog_Address(false, 'fdApplicantsId','fdApplicantsName',null,ORG_TYPE_PERSON);">							 
								<bean:message key="dialog.selectOrg" /> </a>
						</c:if>						
						<span class="txtstrong">*</span>		
					</td>
				</tr>
				<tr>		
					<td colspan="4">
						<input type="button"
										value="<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.add" />"
										onclick="addOitems();">
						<span class="txtstrong">*</span>
					</td>
				</tr>
				<tr>		
					<td colspan="4" height="300px">	
					<center><b>物品清单</b></center><br>			
					<iframe id="iframe_id" width="100%" height="100%" valign="top" frameborder="0" src="<c:url value="/geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do?method=listForApplication&orderby=fdNo&fdApplicationId=${geesunOitemsBudgerApplicationForm.fdId}&operation=1&opertype=${geesunOitemsBudgerApplicationForm.method_GET}"/>">					
					</iframe>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdReason"/>
					</td><td colspan="3">
						<html:textarea style="width:100%" property="fdReason"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdDesc"/>
					</td><td colspan="3">
						<html:textarea style="width:100%" property="fdDesc"/>
					</td>
				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%>文档附件</td>
					<td colspan="3"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" />
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docCreatorId"/>
					</td><td width=35%>
						<html:hidden property="docCreatorId"/>
						<html:text property="docCreatorName" readonly="true"/>				
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docCreateTime"/>
					</td><td width=35%>
						<html:text property="docCreateTime" readonly="true"/>	
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
			<c:param name="fdKey" value="geesunOitemsTemplet" />
	</c:import>
	<!-- 权限 -->
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
				<table class="tb_normal" width=100%>
				<tr>
					<td width="14%" class="td_normal_title"><bean:message
						bundle="geesun-oitems" key="geesunOitems.authReaders" /></td>
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
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="geesunOitemsBudgerApplicationForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>
