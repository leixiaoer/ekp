<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.geesun.base.util.GeesunBaseUtil" %>
    
        <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser());
        pageContext.setAttribute("currentPerson", UserUtil.getKMSSUser().getUserId());
        pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
    <template:include ref="default.edit">
        <template:replace name="head">
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

                var initData = {
                    contextPath: '${LUI_ContextPath}'
                };
                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
                Com_IncludeFile("form.js");
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/base/geesun_base_audit/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/geesun/base/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${geesunBaseAuditForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-base:table.geesunBaseAudit') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunBaseAuditForm.fdAccountName} - " />
                    <c:out value="${ lfn:message('geesun-base:table.geesunBaseAudit') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ geesunBaseAuditForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.geesunBaseAuditForm, 'update');}" />
                    </c:when>
                    <c:when test="${ geesunBaseAuditForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.geesunBaseAuditForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('geesun-base:table.geesunBaseAudit') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/base/geesun_base_audit/geesunBaseAudit.do">

                <ui:tabpage expand="false" var-navwidth="90%">
                    <ui:content title="${ lfn:message('geesun-base:py.JiBenXinXi') }" expand="true">
                        <div class='lui_form_title_frame'>
                            <div class='lui_form_subject'>
                                ${lfn:message('geesun-base:table.geesunBaseAudit')}
                            </div>
                            <div class='lui_form_baseinfo'>

                            </div>
                        </div>
                        <table class="tb_normal" width="100%">
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBaseAudit.fdAccountName')}
                                </td>
                                <td width="35%">
                                    <%-- 科目名称--%>
                                    <div id="_xform_fdAccountName" _xform_type="text">
                                        <xform:text property="fdAccountName" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBaseAudit.fdAccountCode')}
                                </td>
                                <td width="35%">
                                    <%-- 科目编码--%>
                                    <div id="_xform_fdAccountCode" _xform_type="text">
                                        <xform:text property="fdAccountCode" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBaseAudit.fdPersons')}
                                </td>
                                <td colspan="3" width="85.0%">
                                    <%-- 审批人--%>
                                    <div id="_xform_fdPersonIds" _xform_type="address">
                                        <xform:address propertyId="fdPersonIds" propertyName="fdPersonNames" mulSelect="true" orgType="ORG_TYPE_PERSON" showStatus="edit" textarea="true" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBaseAudit.docCreator')}
                                </td>
                                <td width="35%">
                                    <%-- 创建人--%>
                                    <div id="_xform_docCreatorId" _xform_type="address">
                                        <ui:person personId="${geesunBaseAuditForm.docCreatorId}" personName="${geesunBaseAuditForm.docCreatorName}" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBaseAudit.docCreateTime')}
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
                                    ${lfn:message('geesun-base:geesunBaseAudit.docAlteror')}
                                </td>
                                <td width="35%">
                                    <%-- 修改人--%>
                                    <div id="_xform_docAlterorId" _xform_type="address">
                                        <ui:person personId="${geesunBaseAuditForm.docAlterorId}" personName="${geesunBaseAuditForm.docAlterorName}" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBaseAudit.docAlterTime')}
                                </td>
                                <td width="35%">
                                    <%-- 更新时间--%>
                                    <div id="_xform_docAlterTime" _xform_type="datetime">
                                        <xform:datetime property="docAlterTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </ui:content>
                </ui:tabpage>
                <html:hidden property="fdId" />


                <html:hidden property="method_GET" />
            </html:form>
        </template:replace>


    </template:include>