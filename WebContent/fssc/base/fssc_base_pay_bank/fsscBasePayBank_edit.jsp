<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/fssc/base/resource/jsp/jshead.jsp" %>
<%@ include file="/resource/jsp/edit_top.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
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
    	.inputsgl[readonly], .tb_normal .inputsgl[readonly] {
      		border: 0px;
      		color: #868686
    	}
    
</style>
<script type="text/javascript">
    var formInitData = {

    };
    var messageInfo = {

    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
    Com_IncludeFile("form.js");
    Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_pay_bank/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/fssc/base/fssc_base_pay_bank/fsscBasePayBank.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${fsscBasePayBankForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.fsscBasePayBankForm, 'update');">
            </c:when>
            <c:when test="${fsscBasePayBankForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.fsscBasePayBankForm, 'save');">
                <input type="button" value="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.fsscBasePayBankForm, 'saveadd');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBasePayBank') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdCompany')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCompanyId" _xform_type="dialog">
                            <fssc:switchOff property="fdShowType">
	                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="view" style="width:95%;">
	                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
	                            </xform:dialog>
	                             <html:hidden property="fdCompanyId"/>
                            </fssc:switchOff>
                        	<fssc:switchOn property="fdShowType">
	                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" subject="${lfn:message('fssc-base:fsscBasePayBank.fdCompany')}" showStatus="edit" required="true" style="width:95%;">
	                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
	                            </xform:dialog>
                            </fssc:switchOn>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                            ${lfn:message('fssc-base:fsscBasePayBank.fdAccountName')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdAccountName" _xform_type="text">
                            <xform:text property="fdAccountName" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdCode')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCode" _xform_type="text">
                            <xform:text property="fdCode" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdBankName')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdBankName" _xform_type="text">
                            <xform:text property="fdBankName" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdBankNo')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdBankNo" _xform_type="text">
                            <xform:text property="fdBankNo" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdBankAccount')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdBankAccount" _xform_type="text">
                            <xform:text property="fdBankAccount" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
               	<tr>
                	 <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdAccountsCom')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <xform:dialog propertyId="fdAccountsComId" propertyName="fdAccountsComName" subject="${lfn:message('fssc-base:fsscBasePayBank.fdAccountsCom')}" showStatus="edit" style="width:95%;">
	                         dialogSelect(false,'fssc_base_accounts_com_fdAccount','fdAccountsComId','fdAccountsComName');
	                     </xform:dialog>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdUse')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdUse" _xform_type="textarea">
                            <xform:textarea property="fdUse" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                 <fssc:checkUseBank >
                  <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdPayBankBelong')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdPayBankBelong" >
                          <xform:select property="fdPayBankBelong" >
                          			<xform:enumsDataSource enumsType="fs_base_pay_bank_belong" />
                          </xform:select>
                        </div>
                    </td>
                    </tr>
                    </fssc:checkUseBank>
                    <fssc:checkUseBank fdBank="CMB">
                    <tr>
                     <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdAccountAreaName')}
                    </td>
					 <td colspan="3" width="85.0%">
                       	<div id="_xform_fdAccountAreaName" _xform_type="dialog">
                           <xform:dialog propertyId="fdAccountAreaId" propertyName="fdAccountAreaName" showStatus="edit" style="width:95%;" subject="${lfn:message('fssc-base:fsscBasePayBank.fdAccountAreaName')}" >
                               dialogSelect(false,'fssc_cmb_account_area','fdAccountAreaId','fdAccountAreaName',selectFdAccountCallback);
                           </xform:dialog>
                           <input name="fdAccountAreaId" type="hidden"/>
                       	</div>
                  		</td>
                    </tr>
                 </fssc:checkUseBank>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.fdIsAvailable')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdIsAvailable" _xform_type="radio">
                            <xform:radio property="fdIsAvailable" showStatus="edit">
                                <xform:enumsDataSource enumsType="common_yesno" />
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.docCreator')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${fsscBasePayBankForm.docCreatorId}" personName="${fsscBasePayBankForm.docCreatorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.docCreateTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.docAlteror')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docAlterorId" _xform_type="address">
                            <ui:person personId="${fsscBasePayBankForm.docAlterorId}" personName="${fsscBasePayBankForm.docAlterorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBasePayBank.docAlterTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docAlterTime" _xform_type="datetime">
                            <xform:datetime property="docAlterTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </center>
    <html:hidden property="fdId" />
    <html:hidden property="method_GET" />
    <script>
        $KMSSValidation();
    	$("#_xform_fdPayBankBelong").change(function(){
    		var selectVal = $("#_xform_fdPayBankBelong option:selected").val();
    		console.log(selectVal);
			if(selectVal=='1'){
				$("input[name=fdAccountAreaName]").attr("validate","required maxLength(2000)");
				$("#_xform_fdAccountAreaName").append("<span id='requiredSpan' style='color: red;'>*</span>");
			}else{
				$("input[name=fdAccountAreaName]").attr("validate","");
				$("#requiredSpan").remove();
			}
    	});
    	if(window.navigator.userAgent.toLowerCase().indexOf("msie")>-1||window.navigator.userAgent.toLowerCase().indexOf("trident")>-1){//IE
    		setTimeout(function(){initData();},100);
    	}else{//非IE
    		$(document).ready(function(){
    			initData();
    		});
    	};
    	
    	function initData (){
    		var selectVal = $("#_xform_fdPayBankBelong option:selected").val();
			if(selectVal=='1'){
				$("input[name=fdAccountAreaName]").attr("validate","required maxLength(2000)");
				$("#_xform_fdAccountAreaName").append("<span id='requiredSpan' style='color: red;'>*</span>");
			}else{
				$("input[name=fdAccountAreaName]").attr("validate","");
				$("#requiredSpan").remove();
			}
		}
    	
    	//回调
    	function selectFdAccountCallback(rtnData) {
			if(rtnData && rtnData.length > 0){
				var obj = rtnData[0];
				$("input[name='fdAccountAreaId']").val(obj.fdAreaCode);//开户行账号
				$("input[name='fdAccountAreaName']").val(obj.fdArea);//开户行
			}
		}
    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>