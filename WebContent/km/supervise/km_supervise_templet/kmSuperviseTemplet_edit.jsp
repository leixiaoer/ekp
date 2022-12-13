<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<script src="./resource/weui_switch.js"></script>
<%@ include file="/resource/jsp/edit_top.jsp" %>
<style type="text/css">
   	.lui_paragraph_title{
   		font-size: 15px;
   		color: #15a4fa;
       	padding: 15px 0px 5px 0px;
   	}
   	.lui_paragraph_title span{
   		display: inline-block;
   		margin: -2px 5px 0px 0px;
   	}
</style>
<script>
Com_IncludeFile("security.js|domain.js|form.js|jquery.js");
Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/km/supervise/resource/js/", 'js', true);
Com_IncludeFile("form_option.js", "${LUI_ContextPath}/km/supervise/km_supervise_templet/", 'js', true);
</script>
<script type="text/javascript">
window.onload = function(){
	//默认选中表单模式
	var method = "${kmSuperviseTempletForm.method_GET}";
	if(method == "add" && "${kmSuperviseTempletForm.fdType}" == '10'){
		if($('input:radio[name="sysFormTemplateForms.kmSuperviseMain.fdMode"]')){
			$('input:radio[name="sysFormTemplateForms.kmSuperviseMain.fdMode"][value="1"]').parent().hide();
			$('input:radio[name="sysFormTemplateForms.kmSuperviseMain.fdMode"][value="3"]').prop('checked', true);
		}
		if($('select[name="sysFormTemplateForms.kmSuperviseMain.fdMode"]')){
			$('select[name="sysFormTemplateForms.kmSuperviseMain.fdMode"]').children(":first").remove();
			$('select[name="sysFormTemplateForms.kmSuperviseMain.fdMode"]').children(":nth-child(1)").prop("selected","selected");
		}
		
	}
	if(method == "edit" && "${kmSuperviseTempletForm.fdType}" == '10'){
		if($('input:radio[name="sysFormTemplateForms.kmSuperviseMain.fdMode"]')){
		   $('input:radio[name="sysFormTemplateForms.kmSuperviseMain.fdMode"][value="1"]').parent().hide();
		}
		if($('select[name="sysFormTemplateForms.kmSuperviseMain.fdMode"]')){
			$('select[name="sysFormTemplateForms.kmSuperviseMain.fdMode"]').children(":first").remove();
		}
	}
};
	
    
    function submitForm(method) {
		if(typeof XForm_BeforeSubmitForm != 'undefined' && XForm_BeforeSubmitForm instanceof Function){
			XForm_BeforeSubmitForm(function(){
				kmSupervise_submitForm(method);
			});
		}else{
			kmSupervise_submitForm(method);
        }
    }
    
 // 兼容表单的多浏览器
	function kmSupervise_submitForm(method){
		if("update" != method) {
	        var fdIsExternal = document.getElementById('fdIsExternal');
	        if(fdIsExternal!=null){
		        if(fdIsExternal.checked){
		        	  var fdExternalUrl = document.getElementById('fdExternalUrl_id');
		              if(fdExternalUrl.value==""||fdExternalUrl.value==null){
		                   alert(Data_GetResourceString("km-supervise:kmSuperviseTemplet.fdExternalUrl")+" "+Data_GetResourceString("km-supervise:kmSuperviseTemplet.notNull"));
		                   return;
		              }
		        }
	        }
        }
    	Com_Submit(document.kmSuperviseTempletForm,method);
	}
</script>

    <% 
    	pageContext.setAttribute("currentUser", UserUtil.getKMSSUser());
    	String fdType = request.getParameter("fdType");
    %>

<html:form action="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${kmSuperviseTempletForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="submitForm('update');">
            </c:when>
            <c:when test="${kmSuperviseTempletForm.method_GET=='add' || kmSuperviseTempletForm.method_GET=='clone'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="submitForm('save');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('km-supervise:table.kmSuperviseTemplet') }</p>
    <center>
		<html:hidden property="fdType" />
		<c:choose>
			<c:when test="${kmSuperviseTempletForm.fdType == '10'}">
				<table class="tb_normal" id="Label_Tabel" width="95%" LKS_LabelDefaultIndex="2">
			</c:when>
			<c:otherwise>
				<table class="tb_normal" id="Label_Tabel" width="95%" >
			</c:otherwise>
		</c:choose>
            <tr LKS_LabelName="${ lfn:message('km-supervise:py.JiBenXinXi') }">
                <td>
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseTemplet.fdName')}
                            </td>
                            <td width="35%">
                                <div id="_xform_fdName" _xform_type="text">
                                    <xform:text property="fdName" showStatus="edit" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseTemplet.docCategory')}
                            </td>
                            <td width="35%">
                                <div id="_xform_docCategoryId" _xform_type="dialog">
                                    <xform:dialog propertyId="docCategoryId" propertyName="docCategoryName" showStatus="edit" required="true" subject="${lfn:message('km-supervise:kmSuperviseTemplet.docCategory')}" style="width:95%;">
                                        Dialog_Category('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','docCategoryId','docCategoryName');
                                    </xform:dialog>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseTemplet.fdIsAvailable')}
                            </td>
                            <td width="35%">
                                <html:hidden property="fdIsAvailable" /> 
								<label class="weui_switch">
									<span class="weui_switch_bd">
										<input type="checkbox" ${'true' eq kmSuperviseTempletForm.fdIsAvailable ? 'checked' : '' } />
										<span></span>
										<small></small>
									</span>
									<span id="fdIsAvailableText"></span>
								</label>
								<script type="text/javascript">
									function setText(status) {
										if(status) {
											$("#fdIsAvailableText").text('<bean:message key="kmSuperviseTemplet.fdIsAvailable.yes" bundle="km-supervise" />');
										} else {
											$("#fdIsAvailableText").text('<bean:message key="kmSuperviseTemplet.fdIsAvailable.no" bundle="km-supervise" />');
										}
									}
									$(".weui_switch :checkbox").on("click", function() {
										var status = $(this).is(':checked');
										$("input[name=fdIsAvailable]").val(status);
										setText(status);
									});
									setText('${kmSuperviseTempletForm.fdIsAvailable}');
								</script>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseTemplet.fdOrder')}
                            </td>
                            <td width="35%">
                                <div id="_xform_fdOrder" _xform_type="text">
                                    <xform:text property="fdOrder" showStatus="edit" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <c:if test="${'10' eq kmSuperviseTempletForm.fdType }">
                        	<tr>
	                        	<td class="td_normal_title" width="15%">
	                        		<bean:message key="table.kmSuperviseTemplet.change" bundle="km-supervise"/>
	                        	</td>
	                        	<td colspan="3" width="85.0%">
	                        		<xform:dialog propertyId="fdChangeId" propertyName="fdChangeName" required="true" showStatus="edit" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.make.plan')}" style="width:95%;">
	                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdChangeId','fdChangeName',null,null,null,null,null,null,null,'70');
	                                </xform:dialog>
	                        	</td>
	                        </tr>
	                        <tr>
	                        	<td class="td_normal_title" width="15%">
	                        		<bean:message key="table.kmSuperviseTemplet.make.plan" bundle="km-supervise"/>
	                        	</td>
	                        	<td colspan="3" width="85.0%">
	                        		<xform:dialog propertyId="fdMakePlanId" propertyName="fdMakePlanName" required="true" showStatus="edit" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.make.plan')}" style="width:95%;">
	                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdMakePlanId','fdMakePlanName',null,null,null,null,null,null,null,'20');
	                                </xform:dialog>
	                        	</td>
	                        </tr>
	                        <tr>
	                        	<td class="td_normal_title" width="15%">
	                        		<bean:message key="table.kmSuperviseTemplet.feedback" bundle="km-supervise"/>
	                        	</td>
	                        	<td colspan="3" width="85.0%">
	                        		<xform:dialog propertyId="fdFeedbackId" propertyName="fdFeedbackName" required="true" showStatus="edit" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.feedback')}" style="width:95%;">
	                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdFeedbackId','fdFeedbackName',null,null,null,null,null,null,null,'30');
	                                </xform:dialog>
	                        	</td>
	                        </tr>
	                        <tr>
	                        	<td class="td_normal_title" width="15%">
	                        		<bean:message key="table.kmSuperviseTemplet.stage" bundle="km-supervise"/>
	                        	</td>
	                        	<td colspan="3" width="85.0%">
	                        		<xform:dialog propertyId="fdStageId" propertyName="fdStageName" required="true" showStatus="edit" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.stage')}" style="width:95%;">
	                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdStageId','fdStageName',null,null,null,null,null,null,null,'40');
	                                </xform:dialog>
	                        	</td>
	                        </tr>
	                        <tr>
	                        	<td class="td_normal_title" width="15%">
	                        		<bean:message key="table.kmSuperviseTemplet.termination" bundle="km-supervise"/>
	                        	</td>
	                        	<td colspan="3" width="85.0%">
	                        		<xform:dialog propertyId="fdTerminationId" propertyName="fdTerminationName" required="true" showStatus="edit" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.termination')}" style="width:95%;">
	                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdTerminationId','fdTerminationName',null,null,null,null,null,null,null,'50');
	                                </xform:dialog>
	                        	</td>
	                        </tr>
	                        <tr>
	                        	<td class="td_normal_title" width="15%">
	                        		<bean:message key="table.kmSuperviseTemplet.setup" bundle="km-supervise"/>
	                        	</td>
	                        	<td colspan="3" width="85.0%">
	                        		<xform:dialog propertyId="fdSetupId" propertyName="fdSetupName" required="true" showStatus="edit" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.setup')}" style="width:95%;">
	                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdSetupId','fdSetupName',null,null,null,null,null,null,null,'60');
	                                </xform:dialog>
	                        	</td>
	                        </tr>
                        </c:if>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseTemplet.authReaders')}
                            </td>
                            <td colspan="3" width="85.0%">
                                <div id="_xform_authReaderIds" _xform_type="address">
                                    <xform:address propertyId="authReaderIds" propertyName="authReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="edit" textarea="true" style="width:95%;" />
                                </div>
								<bean:message key="kmSuperviseTemplet.tepmlateUser" bundle="km-supervise"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseTemplet.authEditors')}
                            </td>
                            <td colspan="3" width="85.0%">
                                <div id="_xform_authEditorIds" _xform_type="address">
                                    <xform:address propertyId="authEditorIds" propertyName="authEditorNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="edit" textarea="true" style="width:95%;" />
                                </div>
                                <bean:message key="kmSuperviseTemplet.tepmlateManager" bundle="km-supervise"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseTemplet.docCreator')}
                            </td>
                            <td width="35%">
                                <div id="_xform_docCreatorId" _xform_type="address">
                                    ${kmSuperviseTempletForm.docCreatorName}
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseTemplet.docCreateTime')}
                            </td>
                            <td width="35%">
                                <div id="_xform_docCreateTime" _xform_type="datetime">
                                    <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
			<!-- 督办内容 -->
			<c:if test="${'10' eq kmSuperviseTempletForm.fdType}">
            <tr LKS_LabelName="${lfn:message('km-supervise:kmSuperviseMain.fdContent')}" style="display:none">
                <td>
                    <c:import url="/sys/xform/include/sysFormTemplate_edit.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmSuperviseTempletForm" />
                        <c:param name="fdKey" value="kmSuperviseMain" />
                        <c:param name="fdMainModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
                        <c:param name="useLabel" value="false" />
                    </c:import>
                    <table id="rtfView" class="tb_normal" width="100%" style="border-top:0;">
                        <tr>
                            <td colspan="4" style="border-top:0;">
                                <html:hidden property="docUseXform" />
                                <kmss:editor property="docXform" toolbarSet="Default" height="1000" />
                            </td>
                        </tr>
                    </table>
                    <script language="JavaScript">
                        function XForm_Mode_Listener(key, value) {
                            var rtfView = document.getElementById('rtfView');
                            var $docUseXform = $("input[type='hidden'][name='docUseXform']");
                            var docUseXform = $docUseXform[0];
                            var display;
                            if(value == '1') {
                                display = '';
                                docUseXform.value = (false);
                            } else {
                                display = 'none';
                                docUseXform.value = (true);
                            }
                            rtfView.style.display = display;
                        }
                    </script>
                </td>
            </tr>
            </c:if>
            
            <!-- 流程处理 -->
            <c:import url="/sys/lbpmservice/include/sysLbpmTemplate_edit.jsp" charEncoding="UTF-8">
                <c:param name="formName" value="kmSuperviseTempletForm" />
                <c:param name="fdKey" value="${param.fdKey }" />
                <c:param name="messageKey" value="km-supervise:py.LiuChengChuLi" />
            </c:import>
			
			<!-- 编号规则 -->
			<c:if test="${'10' eq kmSuperviseTempletForm.fdType }">
	            <c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
	                <c:param name="formName" value="kmSuperviseTempletForm" />
	                <c:param name="fdKey" value="${param.fdKey }" />
	                <c:param name="modelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
	                <c:param name="messageKey" value="km-supervise:py.BianHaoGuiZe" />
	            </c:import>
	
	            <tr LKS_LabelName="<bean:message bundle='km-supervise' key='py.GuanLianXinXi' />">
	                <c:set var="mainModelForm" value="${kmSuperviseTempletForm}" scope="request" />
	                <c:set var="currModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" scope="request" />
	                <td>
	                    <%@ include file="/sys/relation/include/sysRelationMain_edit.jsp" %>
	                </td>
	            </tr>
	            
	            <!-- 权限 -->
	            <tr LKS_LabelName="${ lfn:message('km-supervise:py.MoRenQuanXian') }">
	                <td>
	                    <table class="tb_normal" width=100%>
	                        <c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
	                            <c:param name="formName" value="kmSuperviseTempletForm" />
	                            <c:param name="moduleModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseTemplet" />
	                        </c:import>
	                    </table>
	                </td>
	            </tr>
			</c:if>
			
			

        </table>
    </center>
    <html:hidden property="fdId" />
    <html:hidden property="method_GET" />
    <script>
    	Com_IncludeFile("jquery.js");
        $KMSSValidation();
    </script>
    <script>
	$(document).ready( function() {
    	
		setTimeout(hiddenRadio,2500);
		setTimeout(setRadio, 2500);

	});
  //隐藏流程标签中前两种流程定义方式
    function hiddenRadio()
    {
    	var typeRadio = document.getElementsByName("sysWfTemplateForms.${param.fdKey}.fdType");
    	if(typeRadio.length>0)
    	{
    		typeRadio[0].style.display = "none";
    		typeRadio[1].style.display = "none";
    		typeRadio[2].checked = "checked";
    	}
    	var typeLabel;
    	if ($("#TB_LbpmTemplate_${param.fdKey}").length > 0) {
    		typeLabel = $("#TB_LbpmTemplate_${param.fdKey}").find('label');
    		document.getElementById('A_LbpmTemplate_${param.fdKey}').style.visibility='hidden';
    	}
    	if ($("#TB_WorkFlowTemplate_${param.fdKey}").length > 0) {
    		typeLabel = $("#TB_WorkFlowTemplate_${param.fdKey}").find('label');
    		document.getElementById('A_WorkFlowTemplate_${param.fdKey}').style.visibility='hidden';
    	}
    	if(typeLabel)
    	{
    		typeLabel[0].style.display = "none";
    		typeLabel[1].style.display = "none";
    	}
    }

    function setRadio(){
    	var radio = document.getElementsByName("sysWfTemplateForms.${param.fdKey}.fdType");
    	if(radio.length>0)
    	{
    		if(typeof WorkFlow_ChgDisplay!='undefined'&&typeof WorkFlow_ChgDisplay == "function"){
    		    WorkFlow_ChgDisplay('${param.fdKey}',radio[2].value);
    		  }
    		if(typeof LBPM_Template_TypeChg!='undefined'&&typeof LBPM_Template_TypeChg == "function"){
    		 LBPM_Template_TypeChg(radio[2].value, '${param.fdKey}', 'sysWfTemplateForms.${JsParam.fdKey}.', true);
    		}
    		radio[2].click();
    	}
    }
    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>