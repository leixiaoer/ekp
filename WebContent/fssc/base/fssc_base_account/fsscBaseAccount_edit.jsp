<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/fssc/base/resource/jsp/jshead.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
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
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_account/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/fssc/base/fssc_base_account/fsscBaseAccount.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${fsscBaseAccountForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.fsscBaseAccountForm, 'update');">
            </c:when>
            <c:when test="${fsscBaseAccountForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.fsscBaseAccountForm, 'save');">
                <input type="button" value="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.fsscBaseAccountForm, 'saveadd');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseAccount') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.fdName')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdName" _xform_type="text">
                            <xform:text property="fdName" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.fdBankName')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdBankName" _xform_type="text">
                            <xform:text property="fdBankName" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.fdBankNo')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdBankNo" _xform_type="text">
                            <xform:text property="fdBankNo" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.fdBankAccount')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdBankAccount" _xform_type="text">
                            <xform:text property="fdBankAccount" validators="digits maxLength(200)" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <fssc:checkUseBank fdBank="CMB">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.fdAccountArea')}
                    </td>
                     <td colspan="3" width="85.0%">
			            <div id="_xform_fdAccountArea" >
			                <div class="inputselectsgl" style="width:95%;">
			                <input  name="fdAccountId"  type="hidden">
			                <div class="input">
			                	 	<input  name="fdAccountArea"  value="${fsscBaseAccountForm.fdAccountArea }" subject="${lfn:message('fssc-base:fsscBaseAccount.fdAccountArea')}" >
			                </div>
			                 <div class="selectitem" onclick="FSSC_SelectAccount();"  ></div>
			                </div>
			            </div>
			        </td>
                </tr>
                </fssc:checkUseBank>
                
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.fdPerson')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdPersonId" _xform_type="address">
                        	<kmss:authShow roles="ROLE_FSSCBASE_ACCOUNT">
                        		<c:set var="account_auth" value="true"></c:set>
                        	</kmss:authShow>
                        	<c:choose>
                        		<c:when test="${account_auth=='true'}">
                        			<xform:address required="true" propertyId="fdPersonId" propertyName="fdPersonName" orgType="ORG_TYPE_PERSON" showStatus="edit" style="width:95%;" />
                        		</c:when>
                        		<c:otherwise>
                        			<xform:address required="true" propertyId="fdPersonId" propertyName="fdPersonName" orgType="ORG_TYPE_PERSON" showStatus="readOnly" style="width:95%;" />
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.fdIsDefault')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdIsDefault" _xform_type="radio">
                            <xform:radio property="fdIsDefault" showStatus="edit">
                                <xform:enumsDataSource enumsType="common_yesno" />
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.fdIsAvailable')}
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
                        ${lfn:message('fssc-base:fsscBaseAccount.docCreator')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${fsscBaseAccountForm.docCreatorId}" personName="${fsscBaseAccountForm.docCreatorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.docCreateTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.docAlteror')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docAlterorId" _xform_type="address">
                            <ui:person personId="${fsscBaseAccountForm.docAlterorId}" personName="${fsscBaseAccountForm.docAlterorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccount.docAlterTime')}
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
        
        function FSSC_SelectAccount(){
      	  dialogSelect(false,'fssc_cmb_city_code','fdAccountId','fdAccountArea');
      	  
        }
    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>