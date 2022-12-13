<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsWebOfficeUtil"%>
<%@page import="com.landray.kmss.sys.xform.util.LangUtil"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.lang.String" %>
<%@ page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.landray.kmss.sys.appconfig.service.ISysAppConfigService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<% pageContext.setAttribute("_isJGEnabled", new Boolean(com.landray.kmss.sys.attachment.util.JgWebOffice.isJGEnabled()));%>

<c:if test="${kmReviewTemplateForm.fdIsExternal != 'true'}">	
    <script src="./kmReviewTemplate_edit_external.js"></script>
</c:if>

<script src="./resource/weui_switch.js"></script>

<script language="JavaScript">
	var editShowJgCount = 0;
	Com_IncludeFile("dialog.js");
	Com_IncludeFile("data.js");
	window.onload = function(){
		//默认选中表单模式
		var method = "${kmReviewTemplateForm.method_GET}";
		
		if(method == "add"){
			if($('select[name="sysFormTemplateForms.reviewMainDoc.fdMode"]')){
				$('select[name="sysFormTemplateForms.reviewMainDoc.fdMode"]').children(":nth-child(2)").prop("selected","selected");
			}
		}

		//公司产品JS库有问题，其中生成的按钮没有ID属性，导致ie6不能够用该语句查找
		var tt = document.getElementsByTagName("INPUT");
		for(var i=0;i<tt.length;i++){
			
			if(tt[i].name == "editonline_krt_showRevisions"){
				tt[i].style.display = "none";
			}
			if(tt[i].name == "editonline_printPreview"){
				tt[i].style.display = "none";
			}
		}
		
	};

	Com_AddEventListener(window,"load",showBaseLabel);

	function showBaseLabel(){
		//setTimeout("Doc_SetCurrentLabel('Label_Tabel', 1, true);", 300);
		// 添加标签切换事件
		var table = document.getElementById("Label_Tabel");
		if(table != null && window.Doc_AddLabelSwitchEvent){
			Doc_AddLabelSwitchEvent(table, "switchTabShowJG");
		}
	}

	function switchTabShowJG(tableName, index){
		var trs = document.getElementById(tableName).rows;
		var fdModeObj = document.getElementsByName("sysFormTemplateForms.reviewMainDoc.fdMode")[0];
		if(trs[index].id =="tr_content"&&fdModeObj.value == "5"){
			$("#wordEdit").css({
				width:'100%',
				height:'550px'
			});
			var obj = document.getElementById("JGWebOffice_editonline_krt");			
			setTimeout(function(){
				if(obj&&Attachment_ObjectInfo['editonline_krt'] && !jg_attachmentObject_editonline_krt.hasLoad){
					jg_attachmentObject_editonline_krt.load();
					jg_attachmentObject_editonline_krt.show();
					jg_attachmentObject_editonline_krt.ocxObj.Active(true);	
					editShowJgCount++;					
				 }				
			},1000);
			chromeHideJGByObjId_2015(1, 'JGWebOffice_editonline_krt');
		}else{
			$("#wordEdit").css({
				left:'0px',
				top:'0px',
				width:'0px',
				height:'0px',
				overflow:'hidden'
			});
			chromeHideJG_2015(0);
		}
	}
	

	function refreshDisplay() {
		var fields = document.getElementsByName("fdLableVisiable");
		var tableRows = document.getElementById("Table_Info").rows;
		if(fields[0].checked) {
			tableRows[2].style.display="none";
		}
		if(fields[1].checked) {
			tableRows[2].style.display="";
		}
	}
	// ADD BY WUZB 20171031
	Com_Parameter.event["submit"].push(function(){
		var useWord = document.getElementsByName('fdUseWord')[0];
		if (null != useWord) {
			var obj = document.getElementById("JGWebOffice_editonline_krt");
			if (useWord.value == "true") {
				if ("${pageScope._isJGEnabled}" == "true") {
					if(obj&&Attachment_ObjectInfo['editonline_krt'] && jg_attachmentObject_editonline_krt.hasLoad){
						jg_attachmentObject_editonline_krt.ocxObj.Active(true);
						jg_attachmentObject_editonline_krt._submit();
					}
				}
			}else{
				if(obj&&Attachment_ObjectInfo['editonline_krt'] && jg_attachmentObject_editonline_krt.hasLoad){
					jg_attachmentObject_editonline_krt.unLoad();
				}
				$("#wordEdit").remove();
			}
		}		
		return true;
	});
	
	function ShowRtfView(b) {
		var rtfView = document.getElementById('rtfView');
		var display = b ? '' : 'none';
		rtfView.style.display = display;
	}

	// ADD BY WUZB 20171031
	function ShowWordView(b) {
		if(b){
			$("#wordEdit").css({
				width:'100%',
				height:'550px'
			});	
			var obj = document.getElementById("JGWebOffice_editonline_krt");
			setTimeout(function(){
				if(obj&&Attachment_ObjectInfo['editonline_krt'] && !jg_attachmentObject_editonline_krt.hasLoad){
					jg_attachmentObject_editonline_krt.load();
					jg_attachmentObject_editonline_krt.show();
					jg_attachmentObject_editonline_krt.ocxObj.Active(true);
				 }				
			},1000);
			chromeHideJGByObjId_2015(1, 'JGWebOffice_editonline_krt');
		}else{
			$("#wordEdit").css({
				width:'0px',
				height:'0px'
			});
			chromeHideJG_2015(0);
		}
		var fdUseWord = document.getElementsByName('fdUseWord')[0];
		fdUseWord.value = (b);
	}
	
	function XForm_Mode_Listener(key,value) {
		var showRtf = false;
		var showWord = false;
		var useForm = false;
		if (value == '1') {
			showRtf = true;
		}else if(value == '3' || value == '2' || value == '4'){
			useForm = true;
		}else if (value == '5') {
			showWord = true;
		}
		
		document.getElementsByName('fdUseForm')[0].value= useForm;
		ShowRtfView(showRtf);
		ShowWordView(showWord);
		
		if (value !== "3"){
			$("[name='fdIsImport']").val("false");
			$("[name='fdUnImportFieldIds']").val("");
			$("[name='fdUnImportFieldNames']").val("");
			$("#xformMainImportTD").hide();
		}else{
			$("#xformMainImportTD").show();
		}
	}
	

	function checkPrefix(){
		<% if(com.landray.kmss.sys.number.util.NumberResourceUtil.isModuleNumberEnable("com.landray.kmss.km.review.model.KmReviewMain")){ %>
			return true;
		<%}%>
		var prefix = document.getElementsByName("fdNumberPrefix")[0].value;
		var fdId = document.getElementsByName("fdId")[0].value;
		var url = encodeURI(Com_Parameter.ResPath+"jsp/ajax.jsp?&tempId="+fdId+"&serviceName=kmReviewTemplateService&prefixStr="+prefix);
		var xmlHttpRequest;
		if (window.XMLHttpRequest) { // Non-IE browsers
	       xmlHttpRequest = new XMLHttpRequest();
	    }else if (window.ActiveXObject) { // IE   
	    	try {		  
				xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (othermicrosoft) {
				try {				
					xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (failed) {					
					xmlHttpRequest = false;
				}
			}
		}	
		if (xmlHttpRequest) {	      
	        xmlHttpRequest.open("GET", url, false);
	        xmlHttpRequest.send();	    
			var result = xmlHttpRequest.responseText.replace(/\s/g,"").replace(/;/g,"\n");
			if(trim(result)!=""){
				if(!confirm("<bean:message bundle="km-review" key="message.template.same.prefix" />".replace("%result%",result))){   
					return false;
				}
			}
		}
		return true;
	}
	//公式选择器
	function genTitleRegByFormula(fieldId, fieldName){
	//	Formula_Dialog(idField,nameField,Formula_GetVarInfoByModelName("com.landray.kmss.km.review.model.KmReviewMain"), "String");
		Formula_Dialog(fieldId, fieldName, XForm_getXFormDesignerObj_reviewMainDoc(), 'String');
	}
	
	// 兼容表单的多浏览器
	function kmReview_submitForm(method){
		if("update" != method) {
	        var fdIsExternal = document.getElementById('fdIsExternal');
	        if(fdIsExternal!=null){
		        if(fdIsExternal.checked){
		        	  var fdExternalUrl = document.getElementById('fdExternalUrl_id');
		              if(fdExternalUrl.value==""||fdExternalUrl.value==null){
		                   alert(Data_GetResourceString("km-review:kmReviewMain.fdExternalUrl")+" "+Data_GetResourceString("km-review:kmReviewMain.notNull"));
		                   return;
		              }
		        }
	        }
        }

        // 判断描述字符长度
        var newvalue = document.getElementsByName("fdDesc")[0].value.replace(/[^\x00-\xff]/g, "***");
		if(newvalue.length > 1500) {
			var fdDesc = "${lfn:message('km-review:kmReviewTemplate.fdDesc')}";
			var msg = '<bean:message key="errors.maxLength"/>'.replace("{0}", fdDesc).replace("{1}", 1500);
			alert(msg);
			return;
		}
        
    	Com_Submit(document.kmReviewTemplateForm,method);
	}
    
    function submitForm(method) {
		if(typeof XForm_BeforeSubmitForm != 'undefined' && XForm_BeforeSubmitForm instanceof Function){
			XForm_BeforeSubmitForm(function(){
				kmReview_submitForm(method);
			});
		}else{
			kmReview_submitForm(method);
        }
    }

</script>
<kmss:windowTitle moduleKey="km-review:table.kmReviewMain"  subjectKey="km-review:table.kmReviewTemplate" subject="${kmReviewTemplateForm.fdName}" />
<html:form action="/km/review/km_review_template/kmReviewTemplate.do" 
	onsubmit="return validateKmReviewTemplateForm(this)&&checkPrefix();">
	<div id="optBarDiv">
		<c:if test="${kmReviewTemplateForm.method_GET=='edit'}">
			<%--更新--%>
			<input id="languageUpdate" type=button value="<bean:message key="button.update"/>"
				onclick="submitForm('update');">
		</c:if>
		 <c:if test="${kmReviewTemplateForm.method_GET=='add' || kmReviewTemplateForm.method_GET=='clone'}">
		 	<%--新增--%>
			<input type=button value="<bean:message key="button.save"/>"
				onclick="submitForm('save');">
			<input type=button value="<bean:message key="button.saveadd"/>"
				onclick="submitForm('saveadd');">
		</c:if> 
			<%--关闭--%>
			<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
	</div>

	<p class="txttitle">
		<bean:message bundle="km-review" key="table.kmReviewTemplate" />
	</p>

	<center>
	
	<table id="Label_Tabel" width=95%>
		<tr LKS_LabelName="<bean:message bundle='km-review' key='kmReviewTemplateLableName.templateInfo'/>">
			<td>
				<table class="tb_normal" width=100%>
					<html:hidden property="fdId" />
					<%--模板名称--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-review" key="kmReviewTemplate.fdName" />
						</td>
						<td width=85% colspan="3">
						<%-- 
							<html:text property="fdName" style="width:80%;" /><span class="txtstrong">*</span>
						--%>
							<xform:text property="fdName" style="width:80%;" required="true"></xform:text>
							<br>
							<%--外部流程--%>
							<c:choose>
							  <c:when test="${kmReviewTemplateForm.method_GET=='edit' or kmReviewTemplateForm.method_GET=='clone'}">
							  	<c:if test="${kmReviewTemplateForm.fdIsExternal == 'true'}">	
								    <xform:checkbox property="fdIsExternal" htmlElementProperties="disabled=disabled">
									   	<xform:simpleDataSource value="true"><bean:message bundle="km-review" key="kmReviewMain.fdIsExternal"/></xform:simpleDataSource>
									</xform:checkbox>
								</c:if>
							  </c:when>
							  <c:otherwise>
							  	 <xform:checkbox property="fdIsExternal" htmlElementProperties="id=fdIsExternal">
								   	<xform:simpleDataSource value="true"><bean:message bundle="km-review" key="kmReviewMain.fdIsExternal"/></xform:simpleDataSource>
								 </xform:checkbox>
							  </c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr id="fdIsMobile">
						<td class="td_normal_title" width=15%><bean:message bundle="km-review" key="kmReviewTemplate.fdIsMobileCreate" /></td>
						<td ${kmReviewTemplateForm.fdIsExternal == 'true' ? 'colspan=3' : ''}>
							<sunbor:enums property="fdIsMobileCreate" enumsType="common_yesno" elementType="radio" />
						</td>
						<c:if test="${kmReviewTemplateForm.fdIsExternal != 'true'}">
						<td class="td_normal_title" width=15%><bean:message bundle="km-review" key="kmReviewTemplate.fdIsMobileApprove" /></td>
						<td width=35%>
							<sunbor:enums property="fdIsMobileApprove" enumsType="common_yesno" elementType="radio" />
						</td>
						</c:if>
					</tr>
					<c:if test="${kmReviewTemplateForm.fdIsExternal != 'true'}">
					<tr id="fdIsMobileView">
						<td class="td_normal_title" width=15%><bean:message bundle="km-review" key="kmReviewTemplate.fdIsMobileView" /></td>
						<td width=35%>
							<sunbor:enums property="fdIsMobileView" enumsType="common_yesno" elementType="radio" />
						</td>
						<td class="td_normal_title" width=15%><bean:message bundle="km-review" key="kmReviewMain.fdCanCircularize" /></td>
						<td width=35%>
							<sunbor:enums property="fdCanCircularize" enumsType="common_yesno" elementType="radio" />
						</td>
					</tr>
					</c:if>
				    <%--外部URL--%>
				    <c:if test="${kmReviewTemplateForm.fdIsExternal == 'true'}">	
				    	<tr id="fdExternalUrl">
				    </c:if>
				    <c:if test="${kmReviewTemplateForm.fdIsExternal != 'true'}">	
						<tr id="fdExternalUrl" style="display: none">
					</c:if>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-review" key="kmReviewMain.fdExternalUrl" />
						</td>
						<td width=85% colspan="3">
							<html:textarea property="fdExternalUrl" styleId="fdExternalUrl_id" style="width:80%;height:40px" /><span class="txtstrong">*</span>
						</td>
					</tr>
					<%--适用类别--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-review" key="kmReviewMain.fdCatoryName" />
						</td>
						<td width=85% colspan="3">
							<html:hidden property="fdCategoryId" /> 
							<xform:text property="fdCategoryName"  style="width:80%;" required="true"/>
							&nbsp;&nbsp;&nbsp;
							<a href="#" onclick="Dialog_Category('com.landray.kmss.km.review.model.KmReviewTemplate','fdCategoryId','fdCategoryName');">
								<bean:message key="dialog.selectOther" />
							</a>
							<c:if test="${not empty noAccessCategory}">
								<script language="JavaScript">
									function closeWindows(rtnVal){
										if(rtnVal==null){
											window.close();
										}
									}
									if(!confirm("<bean:message arg0="${noAccessCategory}" key="error.noAccessCreateTemplate.alert" />")){
										window.close();
									}else{
										Dialog_Category('com.landray.kmss.km.review.model.KmReviewTemplate','fdCategoryId','fdCategoryName',null,null,null,null,closeWindows, true);
									}
								</script>
							</c:if>						
						</td>
					</tr>
					<%--是否可用--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-review" key="kmReviewTemplate.fdIsAvailable" />
						</td>
						<td width=35%>
							<html:hidden property="fdIsAvailable" /> 
							<label class="weui_switch">
								<span class="weui_switch_bd">
									<input type="checkbox" ${'true' eq kmReviewTemplateForm.fdIsAvailable ? 'checked' : '' } />
									<span></span>
									<small></small>
								</span>
								<span id="fdIsAvailableText"></span>
							</label>
							<script type="text/javascript">
								function setText(status) {
									if(status) {
										$("#fdIsAvailableText").text('<bean:message bundle="km-review" key="kmReviewTemplate.fdIsAvailable.true" />');
									} else {
										$("#fdIsAvailableText").text('<bean:message bundle="km-review" key="kmReviewTemplate.fdIsAvailable.false" />');
									}
								}
								$(".weui_switch :checkbox").on("click", function() {
									var status = $(this).is(':checked');
									$("input[name=fdIsAvailable]").val(status);
									setText(status);
								});
								setText(${kmReviewTemplateForm.fdIsAvailable});
							</script>
						</td>
						<td class="td_normal_title" width=15%><bean:message bundle="km-review" key="kmReviewTemplate.fdIsCopyDoc" /></td>
						<td width=35%>
							<sunbor:enums property="fdIsCopyDoc" enumsType="common_yesno" elementType="radio" />
						</td>
					</tr>
					<!-- 表单数据导入 -->
					<tr id="xformMainImportTD">
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-review" key="kmReviewTemplate.fdIsImport"/>
						</td>
						<td width=85% colspan="3">
							<ui:switch property="fdIsImport" onValueChange="importSwitchChange(this.checked)" enabledText="${lfn:message('sys-ui:ui.switch.enabled')}" disabledText="${lfn:message('sys-ui:ui.switch.disabled')}"></ui:switch>
							<span id="selectUnImportWrap" style="display:${kmReviewTemplateForm.fdIsImport eq 'true' ? '' : 'none'};">
								<bean:message bundle="km-review" key="kmReviewTemplate.umImportFormField"/>
								<html:hidden property="fdUnImportFieldIds" /> 						
							 	<html:text property="fdUnImportFieldNames" readonly="true" styleClass="inputsgl" style="width:30%"/>
							 	<a href="#" onclick="selectUnImportFields('fdUnImportFieldIds','fdUnImportFieldNames');"> 
									<bean:message key="dialog.selectOther" /> 
								</a>
							</span>
						</td>
						</tr>
						<!-- 是否开启签署 -->
					<kmss:ifModuleExist path="/elec/yqqs">
						<tr>
							<td class="td_normal_title" width=15%>
								<bean:message bundle="km-review" key="kmReviewMain.fdSignEnable"/>
							</td>
							<td colspan="3">
								<ui:switch property="fdSignEnable" showType="edit" checked="${kmReviewTemplateForm.fdSignEnable}"  checkVal="true" unCheckVal="false"/>
								<bean:message bundle="km-review" key="kmReviewMain.fdSignEnable.tip"/>
							</td>
						</tr>
					</kmss:ifModuleExist>
					<%--模板描述--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-review" key="kmReviewTemplate.fdDesc" />
						</td>
						<td width=85% colspan="3"><html:textarea property="fdDesc" style="width:80%;" /></td>
					</tr>
					<%---辅类别modify by zhouchao--%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-review" key="table.sysCategoryProperty" />
						</td>
						<td width=85% colspan="3">
							<html:hidden property="docPropertyIds" /> 						
						 	<html:text property="docPropertyNames" readonly="true" styleClass="inputsgl" style="width:70%" /> 
						 	<a href="#" onclick="Dialog_property(true, 'docPropertyIds','docPropertyNames', ';',ORG_TYPE_PERSON);"> 
								<bean:message key="dialog.selectOther" /> 
							</a>
						</td> 
					</tr>
					<tr>
					<!-- 前缀 -->
					<% if(!com.landray.kmss.sys.number.util.NumberResourceUtil.isModuleNumberEnable("com.landray.kmss.km.review.model.KmReviewMain")){ %>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-review" key="kmReviewTemplate.fdNumberPrefix" /></td>
					
					<td width=35%>
						<xform:text property="fdNumberPrefix" style="width:80%;" required="true"></xform:text>
					</td>
					<%} %>
					<!-- 排序号 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-review" key="kmReviewMain.fdOrder" /></td>

					<td width=35% 
						<% if(com.landray.kmss.sys.number.util.NumberResourceUtil.isModuleNumberEnable("com.landray.kmss.km.review.model.KmReviewMain")){ %>
						colspan="3"
						<%} %>
					><xform:text property="fdOrder" style="width:80%;" validators="digits"></xform:text>
						<% if(com.landray.kmss.sys.number.util.NumberResourceUtil.isModuleNumberEnable("com.landray.kmss.km.review.model.KmReviewMain")){ %>
							<html:hidden property="fdNumberPrefix"  value="BH"/>
						<%} %>
					</td>
				</tr>
	  <c:if test="${kmReviewTemplateForm.fdIsExternal != 'true'}">				
				<!-- 实施反馈人 -->
				<tr id="fdFeedbackModify">
					<td class="td_normal_title" width=17%><bean:message
						bundle="km-review" key="table.kmReviewFeedback" /></td>
					<td width=83% colspan="3">
						<xform:address mulSelect="true" propertyId="fdFeedBackIds" propertyName="fdFeedbackNames" orgType="ORG_TYPE_ALL|ORG_TYPE_ROLE" style="width:50%" ></xform:address>
						&nbsp;<bean:message
						bundle="km-review" key="kmReviewTemplate.fdFeedbackModify" /> <sunbor:enums
						property="fdFeedbackModify" enumsType="common_yesno"
						elementType="radio" /></td>
				</tr>
				<!-- 标题自动生成规则 -->
				<tr id="number">
					<td class="td_normal_title" width=17%><bean:message
						bundle="km-review" key="kmReviewTemplate.titleRegulation" /></td>
					<td width=83% colspan="3">
						<html:hidden property="titleRegulation" />
						<html:text property="titleRegulationName" style="width:50%" readonly="true"
						styleClass="inputsgl" /> <a href="#"
						onclick="genTitleRegByFormula('titleRegulation','titleRegulationName')"><bean:message bundle="km-review" key="kmReviewTemplate.formula" /></a>
						<br/> 
						<bean:message bundle="km-review" key="kmReviewTemplate.titleRegulation.tip" />
					</td>
				</tr>
				<!-- 关键字 -->
				<tr id="fdKeywordIds">
					<td class="td_normal_title" width=17%><bean:message
						bundle="km-review" key="kmReviewKeyword.fdKeyword" /></td>
					<td width=83% colspan="3"><html:hidden property="fdKeywordIds" /> <html:text
						property="fdKeywordNames" style="width:50%;" /></td>
				</tr>
	 </c:if>			
				<%-- 所属场所 --%>
				<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                     <c:param name="id" value="${kmReviewTemplateForm.authAreaId}"/>
                </c:import>
				<!-- 可使用者 -->
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-review" key="table.kmReviewTemplateUser" /></td>
					<td  width=85% colspan="3">
						<xform:address textarea="true" mulSelect="true" propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
						<br>
						<bean:message key="kmReviewTemplate.tepmlateUser" bundle="km-review"/>
				   </td>
				</tr>
				<!-- 可维护者 -->
				<tr id="authEditor">
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-review" key="table.kmReviewTemplateEditor" /></td>
					<td width=85% colspan="3">
						<xform:address textarea="true" mulSelect="true" propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:97%;height:90px;" ></xform:address>
						<br>
						<bean:message key="kmReviewTemplate.tepmlateManager" bundle="km-review"/>
					</td>
				</tr>
				<%---新建时，不显示 创建人，创建时间 modify by zhouchao---%>
               <c:if
		         test="${kmReviewTemplateForm.method_GET=='edit'}">
				<tr>
					<!-- 创建人员 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-review" key="kmReviewTemplate.docCreatorId" /></td>
					
					<td width=35%><html:text property="docCreatorName"
						readonly="true" style="width:50%;" /></td>
					<!-- 创建时间 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-review" key="kmReviewTemplate.docCreateTime" /></td>
					<td width=35%><html:text property="docCreateTime"
						readonly="true" style="width:50%;" /></td>
				</tr>
				<c:if test="${not empty kmReviewTemplateForm.docAlterorName}">
				<tr>
					<!-- 修改人 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-review" key="kmReviewTemplate.docAlteror" /></td>
					<td width=35%><bean:write name="kmReviewTemplateForm"
						property="docAlterorName" /></td>
					<!-- 修改时间 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-review" key="kmReviewTemplate.docAlterTime" /></td>
					<td width=35%><bean:write name="kmReviewTemplateForm"
						property="docAlterTime" /></td>
				</tr>
				</c:if>
				</c:if>
			</table>
			</td>
		</tr>
  <c:if test="${kmReviewTemplateForm.fdIsExternal != 'true'}">				
		<!-- 表单 -->
		<tr id="tr_content" LKS_LabelName="<kmss:message key="km-review:kmReviewDocumentLableName.reviewContent" />">
			<td>
			<c:import url="/sys/xform/include/sysFormTemplate_edit.jsp"
				charEncoding="UTF-8">
				<c:param name="formName" value="kmReviewTemplateForm" />
				<c:param name="fdKey" value="reviewMainDoc" />
				<c:param name="fdMainModelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
				<c:param name="messageKey" value="km-review:kmReviewDocumentLableName.reviewContent" />
				<c:param name="useLabel" value="false" />
				<c:param name="addOptionType" value="km-review:kmReviewDocumentLableName.wordStype|5"></c:param>
				<c:param name="openBaseInfoDesign" value="true"></c:param>
			</c:import>
			<table id="rtfView" class="tb_normal" width=100% style="border-top:0;">
				<tr>
					<td colspan="4" style="border-top:0;">
						<html:hidden property="fdUseForm" />
						<kmss:editor property="docContent" toolbarSet="Default" height="1000" />
					</td>
				</tr>
			</table>
			
			<%
     			pageContext.setAttribute("_isWpsWebOfficeEnable", new Boolean(SysAttWpsWebOfficeUtil.isEnable()));
     			pageContext.setAttribute("_isWpsCloudEnable", new Boolean(SysAttWpsCloudUtil.isEnable()));
     			
     			//加载项
     			pageContext.setAttribute("_isWpsAddonsEnable", new Boolean(SysAttWpsCloudUtil.isEnableWpsWebOffice()));
     			
     			
			%>

			<table class="tb_normal" width=100% style="border-top:0;">
				<tr>
					<td colspan="4">
						<html:hidden property="fdUseWord" value="${kmReviewTemplateForm.fdUseWord}"/>
						<div id="wordEdit" style="height: 1px;width: 1px;">
								<c:choose>
									<c:when test="${pageScope._isWpsCloudEnable == 'true'}">
										<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="mainContent" />
											<c:param name="load" value="false" />
											<c:param name="bindSubmit" value="false"/>	
											<c:param name="fdModelId" value="${kmReviewTemplateForm.fdId}"/>	
											<c:param name="fdModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate"/>	
											<c:param name="fdTempKey" value="${kmReviewTemplateForm.fdId}" />
										</c:import>
									</c:when>
									<c:when test="${pageScope._isWpsWebOfficeEnable == 'true'}">
										<c:import url="/sys/attachment/sys_att_main/wps/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="mainContent" />
											<c:param name="load" value="false" />
											<c:param name="bindSubmit" value="false"/>	
											<c:param name="fdModelId" value="${kmReviewTemplateForm.fdId}"/>	
											<c:param name="fdModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate"/>	
											<c:param name="fdTempKey" value="${kmReviewTemplateForm.fdId}" />
										</c:import>
									</c:when>
									<c:when test="${pageScope._isWpsAddonsEnable == 'true'}">
										
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="mainContent" />
											<c:param name="fdMulti" value="false" />
											<c:param name="fdModelId" value="${kmReviewTemplateForm.fdId}" />
											<c:param name="fdModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate" />
											<c:param name="bindSubmit" value="false"/>
										    <c:param name="isTemplate" value="true"/>
											<c:param name="fdTemplateKey" value="mainContent" />
											<c:param name="templateBeanName" value="kmReviewTemplateForm" />
											<c:param name="showDelete" value="false" />
											<c:param name="wpsExtAppModel" value="kmReviewTemplate" />
											<c:param name="canRead" value="false" />
											<c:param name="addToPreview" value="false" />
											<c:param  name="hideTips"  value="true"/>
											<c:param  name="hideReplace"  value="true"/>
											<c:param  name="canChangeName"  value="true"/>
											<c:param name="canEdit" value="true" />
										    <c:param name="canPrint" value="false" />
											<c:param  name="filenameWidth"  value="250"/>
										</c:import>
            
            
									</c:when>
									<c:otherwise>
									
										<%
											// 金格启用模式
											if(com.landray.kmss.sys.attachment.util.JgWebOffice.isJGEnabled()) {
												pageContext.setAttribute("sysAttMainUrl", "/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp");
											} else {
												pageContext.setAttribute("sysAttMainUrl", "/sys/attachment/sys_att_main/sysAttMain_edit.jsp");
											}
										%>
										<c:import url="${sysAttMainUrl}" charEncoding="UTF-8">
											<c:param name="fdKey" value="editonline_krt" />
											<c:param name="fdAttType" value="office" />
											<c:param name="load" value="false" />
											<c:param name="fdModelId" value="${kmReviewTemplateForm.fdId}" />
											<c:param name="fdModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate" />
											<c:param name="formBeanName" value="kmReviewTemplateForm" />
											<c:param name="bindSubmit" value="false"/>
											<c:param name="isTemplate" value="true"/>
											<c:param name="attHeight" value="550" />
										</c:import>
										
									</c:otherwise>
							</c:choose>
							
							
						</div>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		
		<%----编号机制开始--%>
		<% if(com.landray.kmss.sys.number.util.NumberResourceUtil.isModuleNumberEnable("com.landray.kmss.km.review.model.KmReviewMain")){ %>
			<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmReviewTemplateForm" />
				<c:param name="fdKey" value="reviewMainDoc" />
				<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain"/>
			</c:import>
		<%} %>
		<%----编号机制结束--%>
		
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmReviewTemplateForm" />
			<c:param name="fdKey" value="reviewMainDoc" />
		</c:import>

		<!-- 文档关联 -->
		<tr
			LKS_LabelName="<bean:message bundle='km-review' key='kmReviewTemplateLableName.relationInfo'/>">
			<c:set var="mainModelForm" value="${kmReviewTemplateForm}"
				scope="request" />
			<c:set
				var="currModelName"
				value="com.landray.kmss.km.review.model.KmReviewMain"
				scope="request" />
			<td><%@ include
				file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>
		</tr>
		<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
				<table class="tb_normal" width=100%>
					<c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
						<c:param
							name="formName"
							value="kmReviewTemplateForm" />
						<c:param
							name="moduleModelName"
							value="com.landray.kmss.km.review.model.KmReviewTemplate" />
					</c:import>
				</table>
			</td>
		</tr>
		<%--
		<!--提醒机制(分类) 开始-->
		<tr LKS_LabelName="<bean:message bundle="sys-notify" key="sysNotify.remind.calendar" />">
		  <td>
			  <table class="tb_normal" width=100%>
				 <c:import url="/sys/notify/include/sysNotifyRemindCategory_edit.jsp"	charEncoding="UTF-8">
					<c:param name="formName" value="kmReviewTemplateForm" />
					<c:param name="fdKey" value="reviewMainDoc" />
					<c:param name="fdPrefix" value="sysNotifyRemindCategory_edit" />
				</c:import>
			  </table>
		  </td>
		</tr>
		<!--提醒机制(分类) 结束-->
		--%>
		
		
		<%--日程机制(普通模块) 开始
		<tr LKS_LabelName="<bean:message bundle="sys-agenda" key="module.sys.agenda" />">
		  <td>
			  <table class="tb_normal" width=100%>
				 <c:import url="/sys/agenda/include/sysAgendaCategory_general_edit.jsp"	charEncoding="UTF-8">
					<c:param name="formName" value="kmReviewTemplateForm" />
					<c:param name="fdKey" value="reviewMainDoc" />
					<c:param name="fdPrefix" value="sysAgendaCategory_general_edit" />
				</c:import>
			  </table>
		  </td>
		</tr>--%>
		<%--多语言 --%>
		<%  if(LangUtil.isEnableMultiLang(request.getParameter("fdMainModelName"), "model") && LangUtil.isEnableAdminDoMultiLang()) {%>
		<c:import url="/sys/xform/lang/include/sysFormMultiLang_edit.jsp"	charEncoding="UTF-8">
				<c:param name="formName" value="kmReviewTemplateForm" />
				<c:param name="fdKey" value="reviewMainDoc" />
		</c:import>
		<% } %>
		<%--日程机制(表单模块) 开始--%>
		<tr LKS_LabelName="<bean:message bundle="sys-agenda" key="module.sys.agenda.syn" />">
		  <td>
		  	<table class="tb_normal" width=100%>
		  		<%--同步时机 --%>
				<tr>
					<td width="15%">
						<bean:message bundle="sys-agenda" key="module.sys.agenda.syn.time" />
					</td>
					<td width="85%" colspan="3">
						<xform:radio property="syncDataToCalendarTime"  showStatus="edit">
							<xform:enumsDataSource enumsType="kmReviewMain_syncDataToCalendarTime" />
						</xform:radio>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="padding: 0px;">
						 <c:import url="/sys/agenda/include/sysAgendaCategory_formula_edit.jsp"	charEncoding="UTF-8">
							<c:param name="formName" value="kmReviewTemplateForm" />
							<c:param name="fdKey" value="reviewMainDoc" />
							<c:param name="fdPrefix" value="sysAgendaCategory_formula_edit" />
							<c:param name="fdMainModelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
							<%--可选字段 1.syncTimeProperty:同步时机字段； 2.noSyncTimeValues:当syncTimeProperty为此值时，隐藏同步机制 --%>
							<c:param name="syncTimeProperty" value="syncDataToCalendarTime" />
							<c:param name="noSyncTimeValues" value="noSync" />
						</c:import>
					</td>
				</tr>
			</table>
		  </td>
		</tr>
		<!--日程机制(表单模块) 结束-->
		<!-- 打印机制 -->
		<c:import url="/sys/print/include/sysPrintTemplate_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmReviewTemplateForm" />
			<c:param name="fdKey" value="reviewMainDoc" />
			<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain"></c:param>
			<c:param name="templateModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate"></c:param>
		</c:import>
		<!-- 归档设置 -->
		<c:import url="/km/archives/include/kmArchivesFileSetting_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmReviewTemplateForm" />
			<c:param name="fdKey" value="reviewMainDoc" />
			<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
			<c:param name="templateService" value="kmReviewTemplateService" />
			<c:param name="moduleUrl" value="km/review" />
		</c:import>
		<!-- 沉淀设置 -->
		<c:import url="/kms/multidoc/kms_multidoc_subside/include/kmsSubsideFileSetting_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmReviewTemplateForm" />
			<c:param name="fdKey" value="reviewMainDoc" />
			<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
			<c:param name="templateService" value="kmReviewTemplateService" />
		</c:import>
		<!-- 规则机制 -->
		<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmReviewTemplateForm" />
			<c:param name="fdKey" value="reviewMainDoc" />
			<c:param name="templateModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate"></c:param>
		</c:import>
		<%-- 提醒中心 --%>
		<kmss:ifModuleExist path="/sys/remind/">
		<c:import url="/sys/remind/include/sysRemindTemplate_edit.jsp" charEncoding="UTF-8">
			<%-- 模板Form名称 --%>
			<c:param name="formName" value="kmReviewTemplateForm" />
			<%-- KEY --%>
			<c:param name="fdKey" value="reviewMainDoc" />
			<%-- 模板全名称 --%>
			<c:param name="templateModelName" value="com.landray.kmss.km.review.model.KmReviewTemplate" />
			<%-- 主文档全名称 --%>
			<c:param name="modelName" value="com.landray.kmss.km.review.model.KmReviewMain" />
			<%-- 主文档模板属性 --%>
			<c:param name="templateProperty" value="fdTemplate" />
			<%-- 模块路径 --%>
			<c:param name="moduleUrl" value="km/review" />
		</c:import>
		</kmss:ifModuleExist>
	</c:if>	
	</table>
	</center>
	<html:hidden property="method_GET" />
</html:form>
<script language="JavaScript">
Com_IncludeFile("calendar.js");
Com_IncludeFile("sysFormMainImport.js",Com_Parameter.ContextPath + "sys/xform/impt/js/","js",true);
$(document).ready(function () {
	$('input[name="fdCategoryName"]').attr("readonly","readonly");
})
</script>
<html:javascript formName="kmReviewTemplateForm" cdata="false"
	dynamicJavascript="true" staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>
