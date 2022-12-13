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
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_accounts_com/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/fssc/base/fssc_base_accounts_com/fsscBaseAccountsCom.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${fsscBaseAccountsComForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.fsscBaseAccountsComForm, 'update');">
            </c:when>
            <c:when test="${fsscBaseAccountsComForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.fsscBaseAccountsComForm, 'save');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseAccountsCom') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccountsCom.fdCompany')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCompanyId" _xform_type="dialog">
                         <%-- 是否开启下发  选择是 --%>
						<fssc:switchOn property="fdIsOpenIssued">
                        	<xform:text property="fdCompanyId" showStatus="noShow"></xform:text>
                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="view" style="width:95%;">
                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
                            </xform:dialog>
                        </fssc:switchOn>
                        <%-- 是否开启下发  选择否 --%>
						<fssc:switchOff property="fdIsOpenIssued">
                        	<fssc:switchOff property="fdShowType">
                        	<xform:text property="fdCompanyId" showStatus="noShow"></xform:text>
                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="view" style="width:95%;">
                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
                            </xform:dialog>
                            </fssc:switchOff>
                        	<fssc:switchOn property="fdShowType">
                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" subject="${lfn:message('fssc-base:fsscBaseAccountsCom.fdCompany')}" required="true"  showStatus="edit" style="width:95%;">
                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
                            </xform:dialog>
                            </fssc:switchOn>
                        </fssc:switchOff>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccountsCom.fdParent')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdParentId" _xform_type="dialog">
                         <%-- 是否开启下发  选择是 --%>
						<fssc:switchOn property="fdIsOpenIssued">
                        	<xform:text property="fdParentId" showStatus="noShow"></xform:text>
                            <xform:dialog propertyId="fdParentId" propertyName="fdParentName" showStatus="view" style="width:95%;">
                                dialogSelect(false,'fssc_base_accounts_com_fdAccount','fdParentId','fdParentName');
                            </xform:dialog>
                        </fssc:switchOn>
                         <%-- 是否开启下发  选择否 --%>
						<fssc:switchOff property="fdIsOpenIssued">
							<xform:dialog propertyId="fdParentId" propertyName="fdParentName" showStatus="edit" subject="${lfn:message('fssc-base:fsscBaseAccountsCom.fdParent')}" style="width:95%;">
                                dialogSelect(false,'fssc_base_accounts_com_fdAccount','fdParentId','fdParentName');
                            </xform:dialog>
						</fssc:switchOff>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccountsCom.fdName')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdName" _xform_type="text">
                        <%-- 是否开启下发  选择是 --%>
						<fssc:switchOn property="fdIsOpenIssued">
                        	<xform:text property="fdName" showStatus="noShow"></xform:text>
                            <xform:text property="fdName" showStatus="view" style="width:95%;" />
                        </fssc:switchOn>
                        <%-- 是否开启下发  选择否 --%>
						<fssc:switchOff property="fdIsOpenIssued">
							<xform:text property="fdName" showStatus="edit" style="width:95%;" />
						</fssc:switchOff>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccountsCom.fdCode')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCode" _xform_type="text">
                        <%-- 是否开启下发  选择是 --%>
						<fssc:switchOn property="fdIsOpenIssued">
                       	 	<xform:text property="fdCode" showStatus="noShow"></xform:text>
                            <xform:text property="fdCode" showStatus="view" style="width:95%;" />
                        </fssc:switchOn>
                         <%-- 是否开启下发  选择否 --%>
						<fssc:switchOff property="fdIsOpenIssued">
							 <xform:text property="fdCode" showStatus="edit" style="width:95%;" />
						</fssc:switchOff>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccountsCom.fdStatus')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdStatus" _xform_type="radio">
                            <xform:radio property="fdStatus" showStatus="edit">
                                <xform:enumsDataSource enumsType="fssc_base_doc_status" />
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccountsCom.fdCostItem')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdCostItem" _xform_type="radio">
                            <xform:checkbox property="fdCostItem" showStatus="edit">
                                <xform:enumsDataSource enumsType="fssc_base_cost_item" />
                            </xform:checkbox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccountsCom.docCreator')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${fsscBaseAccountsComForm.docCreatorId}" personName="${fsscBaseAccountsComForm.docCreatorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccountsCom.docCreateTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccountsCom.docAlteror')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docAlterorId" _xform_type="address">
                            <ui:person personId="${fsscBaseAccountsComForm.docAlterorId}" personName="${fsscBaseAccountsComForm.docAlterorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseAccountsCom.docAlterTime')}
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
    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>