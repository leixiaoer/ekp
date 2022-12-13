<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/fssc/base/resource/jsp/jshead.jsp" %>
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
    if("${fsscBaseMaterialInfoForm.method_GET}" == 'edit') {
        window.document.title = "${ lfn:message('button.edit') } - ${ lfn:message('fssc-base:table.fsscBaseMaterialInfo') }";
    }
    if("${fsscBaseMaterialInfoForm.method_GET}" == 'add') {
        window.document.title = "${ lfn:message('button.add') } - ${ lfn:message('fssc-base:table.fsscBaseMaterialInfo') }";
    }
    var formInitData = {

    };
    var messageInfo = {

    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
    Com_IncludeFile("form.js");
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_material_info/", 'js', true);
    Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
    Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/fssc/base/fssc_base_material_info/fsscBaseMaterialInfo.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${fsscBaseMaterialInfoForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.fsscBaseMaterialInfoForm, 'update');">
            </c:when>
            <c:when test="${fsscBaseMaterialInfoForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.fsscBaseMaterialInfoForm, 'save');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseMaterialInfo') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdName')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <%-- 物资名称--%>
                        <div id="_xform_fdName" _xform_type="text">
                            <xform:text property="fdName" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdCode')}
                    </td>
                    <td width="35%">
                        <%-- 物资编码--%>
                        <div id="_xform_fdCode" _xform_type="text">
                            <xform:text property="fdCode" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdType')}
                    </td>
                    <td width="35%">
                        <%-- 物资类别--%>
                        <div id="_xform_fdTypeId" _xform_type="dialog">
                            <xform:dialog propertyId="fdTypeId" propertyName="fdTypeName" showStatus="edit" required="true" subject="${lfn:message('fssc-base:fsscBaseMaterialInfo.fdType')}" style="width:95%;">
                                dialogSelect(false,'fssc_base_material_type_selectType','fdTypeId','fdTypeName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdUnit')}
                    </td>
                    <td width="35%">
                        <%-- 单位--%>
                        <div id="_xform_fdUnit" _xform_type="text">
                            <xform:text property="fdUnit" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdPrice')}
                    </td>
                    <td width="35%">
                        <%-- 预估单价--%>
                        <div id="_xform_fdPrice" _xform_type="text">
                            <xform:text property="fdPrice" showStatus="edit" validators=" number min(0) scaleLength(2)" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdStatus')}
                    </td>
                    <td width="35%">
                        <%-- 物资状态--%>
                        <div id="_xform_fdStatus" _xform_type="select">
                            <xform:select property="fdStatus" htmlElementProperties="id='fdStatus'" showStatus="edit">
                                <xform:enumsDataSource enumsType="fssc_base_material_status" />
                            </xform:select>
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdIsInventory')}
                    </td>
                    <td width="35%">
                        <%-- 是否需要进行盘点--%>
                        <div id="_xform_fdIsInventory" _xform_type="radio">
                            <xform:radio property="fdIsInventory" htmlElementProperties="id='fdIsInventory'" showStatus="edit">
                                <xform:enumsDataSource enumsType="common_yesno" />
                            </xform:radio>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdIsAvailable')}
                    </td>
                    <td width="35%" colspan="3">
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
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.docCreator')}
                    </td>
                    <td width="35%">
                        <%-- 创建人--%>
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${fsscBaseMaterialInfoForm.docCreatorId}" personName="${fsscBaseMaterialInfoForm.docCreatorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.docCreateTime')}
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
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.docAlteror')}
                    </td>
                    <td width="35%">
                        <%-- 修改人--%>
                        <div id="_xform_docAlterorId" _xform_type="address">
                            <ui:person personId="${fsscBaseMaterialInfoForm.docAlterorId}" personName="${fsscBaseMaterialInfoForm.docAlterorName}" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseMaterialInfo.docAlterTime')}
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
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>