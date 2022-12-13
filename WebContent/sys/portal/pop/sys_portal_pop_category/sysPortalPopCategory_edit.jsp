<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
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
    Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/sys/portal/pop/resource/js/", 'js', true);
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/sys/portal/pop/sys_portal_pop_category/", 'js', true);
    Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/sys/portal/pop/sys_portal_pop_category/sysPortalPopCategory.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${sysPortalPopCategoryForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.sysPortalPopCategoryForm, 'update');">
            </c:when>
            <c:when test="${sysPortalPopCategoryForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.sysPortalPopCategoryForm, 'save');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('sys-portal:table.sysPortalPopCategory') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('sys-portal:sysPortalPopCategory.fdParent')}
                    </td>
                    <td width="35%">
                        <div id="_xform_fdParentId" _xform_type="dialog">
                            <xform:dialog propertyId="fdParentId" propertyName="fdParentName" showStatus="edit" style="width:95%;">
                                Dialog_SimpleCategory('com.landray.kmss.sys.portal.model.SysPortalPopCategory','fdParentId','fdParentName',false,null,'01',null,false,'${JsParam.fdId}');
                            </xform:dialog>
                        </div>
                        </a>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('sys-portal:sysPortalPopCategory.fdName')}
                    </td>
                    <td width="35%">
                        <div id="_xform_fdName" _xform_type="text">
                            <xform:text property="fdName" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('sys-portal:sysPortalPopCategory.fdOrder')}
                    </td>
                    <td width="35%">
                        <div id="_xform_fdOrder" _xform_type="text">
                            <xform:text property="fdOrder" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('sys-portal:sysPortalPopCategory.docCreator')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreatorId" _xform_type="address">
                            <ui:person personId="${sysPortalPopCategoryForm.docCreatorId}" personName="${sysPortalPopCategoryForm.docCreatorName}" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('sys-portal:sysPortalPopCategory.docCreateTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                    <td colspan="2" width="50.0%">
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('sys-portal:sysPortalPopCategory.authReaders')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_authReaderIds" _xform_type="address">
                            <xform:address propertyId="authReaderIds" propertyName="authReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="edit" textarea="true" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('sys-portal:sysPortalPopCategory.authEditors')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_authEditorIds" _xform_type="address">
                            <xform:address propertyId="authEditorIds" propertyName="authEditorNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="edit" textarea="true" style="width:95%;" />
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