<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/resource/jsp/edit_top.jsp" %>
<%@ include file="/fssc/base/resource/jsp/jshead.jsp"%>
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
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_item_account/", 'js', true);
    Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
    Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/fssc/base/fssc_base_item_account/fsscBaseItemAccount.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${fsscBaseItemAccountForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.fsscBaseItemAccountForm, 'update');">
            </c:when>
            <c:when test="${fsscBaseItemAccountForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.fsscBaseItemAccountForm, 'save');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseItemAccount') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemAccount.fdCompany')}
                    </td>
                    <td width="35%">
                        <%-- 公司--%>
                        <div id="_xform_fdCompanyId" _xform_type="dialog">
                            <fssc:switchOff property="fdShowType">
                                <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="readOnly" style="width:95%;">
                                    dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
                                </xform:dialog>
                            </fssc:switchOff>
                            <fssc:switchOn property="fdShowType">
                                <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" subject="${lfn:message('fssc-base:fsscBaseItemAccount.fdCompany')}" showStatus="edit" required="true" style="width:95%;">
                                    oldFdCompanyId = $('[name=fdCompanyId]').val();
                                    oldFdCompanyName = $('[name=fdCompanyName]').val();
                                    dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName',selectFdCompanyNameCallback);
                                </xform:dialog>
                            </fssc:switchOn>
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemAccount.fdExpenseItem')}
                    </td>
                    <td width="35%">
                        <%-- 费用类型--%>
                        <div id="_xform_fdExpenseItemId" _xform_type="dialog">
                            <xform:dialog propertyId="fdExpenseItemId" propertyName="fdExpenseItemName"  showStatus="edit" required="true" subject="${lfn:message('fssc-base:fsscBaseItemAccount.fdExpenseItem')}" style="width:95%;">
                                selectItem();
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemAccount.fdAmortize')}
                    </td>
                    <td width="35.0%">
                        <%-- 待摊科目--%>
                        <div id="_xform_fdAmortizeId" _xform_type="dialog">
                            <xform:dialog propertyId="fdAmortizeId" propertyName="fdAmortizeName" subject="${lfn:message('fssc-base:fsscBaseItemAccount.fdAmortize')}" showStatus="edit" style="width:95%;">
                                selectAmortize();
                            </xform:dialog>
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemAccount.fdAccruals')}
                    </td>
                    <td width="35.0%">
                        <%-- 预提科目--%>
                        <div id="_xform_fdAmortizeId" _xform_type="dialog">
                            <xform:dialog propertyId="fdAccrualsId" propertyName="fdAccrualsName" subject="${lfn:message('fssc-base:fsscBaseItemAccount.fdAccruals')}" showStatus="edit" style="width:95%;">
                                selectAccruals();
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemAccount.fdIsAvailable')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <%-- 是否有效--%>
                        <div id="_xform_fdIsAvailable" _xform_type="radio">
                            <xform:radio property="fdIsAvailable" htmlElementProperties="id='fdIsAvailable'" showStatus="edit">
                                <xform:enumsDataSource enumsType="common_yesno" />
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemAccount.fdDesc')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <%-- 描述--%>
                        <div id="_xform_fdDesc" _xform_type="textarea">
                            <xform:textarea property="fdDesc" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemAccount.docCreator')}
                    </td>
                    <td width="35%">
                        <%-- 创建人--%>
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${fsscBaseItemAccountForm.docCreatorId}" personName="${fsscBaseItemAccountForm.docCreatorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemAccount.docCreateTime')}
                    </td>
                    <td width="35%">
                        <%-- 创建时间--%>
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemAccount.docAlteror')}
                    </td>
                    <td width="35%">
                        <%-- 修改人--%>
                        <div id="_xform_docAlterorId" _xform_type="address">
                            <ui:person personId="${fsscBaseItemAccountForm.docAlterorId}" personName="${fsscBaseItemAccountForm.docAlterorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemAccount.docAlterTime')}
                    </td>
                    <td width="35%">
                        <%-- 更新时间--%>
                        <div id="_xform_docAlterTime" _xform_type="datetime">
                            <xform:datetime property="docAlterTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
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
    <script>
        //选择公司回调函数
        function selectFdCompanyNameCallback(rtnData){
            if(oldFdCompanyId != $("input[name='fdCompanyId']").val()){//公司改动
                $("input[name='fdExpenseItemId']").val("");//
                $("input[name='fdExpenseItemName']").val("");
                $("input[name='fdAmortizeId']").val("");//
                $("input[name='fdAmortizeName']").val("");
            }
        }
        function selectItem(){
            var fdCompanyId = $("[name='fdCompanyId']").val();
            if(fdCompanyId){
                dialogSelect(false,'fssc_base_expense_item_fdParent','fdExpenseItemId','fdExpenseItemName');
            }else{
                seajs.use(['lui/jquery','lui/dialog'], function($, dialog) {
                    dialog.alert("${lfn:message('fssc-base:message.pleaseSelectCompany')}")
                });
            }
        }
        function selectAmortize(){
            var fdCompanyId = $("[name='fdCompanyId']").val();
            if(fdCompanyId){
                dialogSelect(false,'fssc_base_accounts_com_fdAccount','fdAmortizeId','fdAmortizeName');
            }else{
                seajs.use(['lui/jquery','lui/dialog'], function($, dialog) {
                    dialog.alert("${lfn:message('fssc-base:message.pleaseSelectCompany')}")
                });
            }
        }
        function selectAccruals(){
            var fdCompanyId = $("[name='fdCompanyId']").val();
            if(fdCompanyId){
                dialogSelect(false,'fssc_base_accounts_com_fdAccount','fdAccrualsId','fdAccrualsName');
            }else{
                seajs.use(['lui/jquery','lui/dialog'], function($, dialog) {
                    dialog.alert("${lfn:message('fssc-base:message.pleaseSelectCompany')}")
                });
            }
        }

    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>