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
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_wbs/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/fssc/base/fssc_base_wbs/fsscBaseWbs.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${fsscBaseWbsForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.fsscBaseWbsForm, 'update');">
            </c:when>
            <c:when test="${fsscBaseWbsForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.fsscBaseWbsForm, 'save');">
                <input type="button" value="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.fsscBaseWbsForm, 'saveadd');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseWbs') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
            	<tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseWbs.fdCompany')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <html:hidden property="fdCompanyId"/>
                        <fssc:switchOff property="fdShowType">
                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="view" style="width:95%;">
                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
                            </xform:dialog>
                        </fssc:switchOff>
                       	<fssc:switchOn property="fdShowType">
                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" subject="${lfn:message('fssc-base:fsscBaseWbs.fdCompany')}" showStatus="edit" required="true" style="width:95%;">
                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
                            </xform:dialog>
                         </fssc:switchOn>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseWbs.fdParent')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdParent" _xform_type="dialog">
                            <xform:dialog propertyId="fdParentId" propertyName="fdParentName" subject="${lfn:message('fssc-base:fsscBaseWbs.fdParent')}" showStatus="edit" style="width:95%;">
                                dialogSelect(false,'fssc_base_wbs_fdParent','fdParentId','fdParentName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseWbs.fdName')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdName" _xform_type="text">
                            <xform:text property="fdName" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseWbs.fdCode')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCode" _xform_type="text">
                            <c:if test="${empty fsscBaseWbsForm.fdCode}">
                        		<xform:text property="fdCode" showStatus="edit" required="true" style="width:95%;" />
                        	</c:if>
                        	<c:if test="${not empty fsscBaseWbsForm.fdCode}">
                        		<xform:text property="fdCode" showStatus="view" style="width:95%;" />
                        	</c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseWbs.fdProject')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdProjectId" _xform_type="dialog">
                            <xform:dialog propertyId="fdProjectId" propertyName="fdProjectName" subject="${lfn:message('fssc-base:fsscBaseWbs.fdProject')}" showStatus="edit" style="width:95%;">
                                selectProject();
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseWbs.fdIsAvailable')}
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
                        ${lfn:message('fssc-base:fsscBaseWbs.docCreator')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${fsscBaseWbsForm.docCreatorId}" personName="${fsscBaseWbsForm.docCreatorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseWbs.docCreateTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseWbs.docAlteror')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docAlterorId" _xform_type="address">
                            <ui:person personId="${fsscBaseWbsForm.docAlterorId}" personName="${fsscBaseWbsForm.docAlterorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseWbs.docAlterTime')}
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
        seajs.use(['lui/jquery','lui/dialog','lang!fssc-base'], function($, dialog ,lang){
        	window.selectProject= function (){
            		var fdCompanyId=$("input[name='fdCompanyId']").val();
            		if(fdCompanyId==""){
            			dialog.alert(lang["message.pleaseSelectCompany"]);
            			return ;
            		}
             	dialogSelect(false,'fssc_base_project_project','fdProjectId','fdProjectName',null,{project:'wbs'});
             }
        });
    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>