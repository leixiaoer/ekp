<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.geesun.org.util.GeesunOrgUtil" %>
    
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
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/org/geesun_org_organ/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/geesun/org/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${geesunOrgOrganForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-org:table.geesunOrgOrgan') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunOrgOrganForm.fdDeptId} - " />
                    <c:out value="${ lfn:message('geesun-org:table.geesunOrgOrgan') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ geesunOrgOrganForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.geesunOrgOrganForm, 'update');}" />
                    </c:when>
                    <c:when test="${ geesunOrgOrganForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.geesunOrgOrganForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('geesun-org:table.geesunOrgOrgan') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/org/geesun_org_organ/geesunOrgOrgan.do">

                <ui:tabpage expand="false" var-navwidth="90%">
                    <ui:content title="${ lfn:message('geesun-org:py.JiBenXinXi') }" expand="true">
                        <div class='lui_form_title_frame'>
                            <div class='lui_form_subject'>
                                ${lfn:message('geesun-org:table.geesunOrgOrgan')}
                            </div>
                            <div class='lui_form_baseinfo'>

                            </div>
                        </div>
                        <table class="tb_normal" width="100%">
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgOrgan.fdDeptId')}
                                </td>
                                <td width="35%">
                                    <%-- 部门ID--%>
                                    <div id="_xform_fdDeptId" _xform_type="text">
                                        <xform:text property="fdDeptId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgOrgan.fdDeptName')}
                                </td>
                                <td width="35%">
                                    <%-- 部门名称--%>
                                    <div id="_xform_fdDeptName" _xform_type="text">
                                        <xform:text property="fdDeptName" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgOrgan.fdParentId')}
                                </td>
                                <td width="35%">
                                    <%-- 上级部门ID--%>
                                    <div id="_xform_fdParentId" _xform_type="text">
                                        <xform:text property="fdParentId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgOrgan.fdSetupDate')}
                                </td>
                                <td width="35%">
                                    <%-- 生效时间--%>
                                    <div id="_xform_fdSetupDate" _xform_type="datetime">
                                        <xform:datetime property="fdSetupDate" showStatus="edit" dateTimeType="date" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgOrgan.fdIsDel')}
                                </td>
                                <td width="35%">
                                    <%-- 是否删除--%>
                                    <div id="_xform_fdIsDel" _xform_type="text">
                                        <xform:text property="fdIsDel" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgOrgan.fdNewDate')}
                                </td>
                                <td width="35%">
                                    <%-- 更新时间--%>
                                    <div id="_xform_fdNewDate" _xform_type="datetime">
                                        <xform:datetime property="fdNewDate" showStatus="edit" dateTimeType="datetime" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgOrgan.docCreateTime')}
                                </td>
                                <td colspan="3" width="85.0%">
                                    <%-- 创建时间--%>
                                    <div id="_xform_docCreateTime" _xform_type="datetime">
                                        <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
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