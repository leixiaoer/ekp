<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.geesun.leave.util.GeesunLeaveUtil" %>
    
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
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/leave/geesun_leave_barter/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/geesun/leave/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${geesunLeaveBarterForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-leave:table.geesunLeaveBarter') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunLeaveBarterForm.docSubject} - " />
                    <c:out value="${ lfn:message('geesun-leave:table.geesunLeaveBarter') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ geesunLeaveBarterForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.geesunLeaveBarterForm, 'update');}" />
                    </c:when>
                    <c:when test="${ geesunLeaveBarterForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.geesunLeaveBarterForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('geesun-leave:table.geesunLeaveBarter') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/leave/geesun_leave_barter/geesunLeaveBarter.do">

                <ui:tabpage expand="false" var-navwidth="90%">
                    <ui:content title="${ lfn:message('geesun-leave:py.JiBenXinXi') }" expand="true">
                        <table class="tb_normal" width="100%">
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-leave:geesunLeaveBarter.docSubject')}
                                </td>
                                <td colspan="3" width="85.0%">
                                    <%-- 主题--%>
                                    <div id="_xform_docSubject" _xform_type="text">
                                        <xform:text property="docSubject" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-leave:geesunLeaveBarter.docCreator')}
                                </td>
                                <td width="35%">
                                    <%-- 申请人--%>
                                    <div id="_xform_docCreatorId" _xform_type="address">
                                        <ui:person personId="${geesunLeaveBarterForm.docCreatorId}" personName="${geesunLeaveBarterForm.docCreatorName}" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-leave:geesunLeaveBarter.docDept')}
                                </td>
                                <td width="35%">
                                    <%-- 所属部门--%>
                                    <div id="_xform_docDeptId" _xform_type="address">
                                        <xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-leave:geesunLeaveBarter.fdStartTime')}
                                </td>
                                <td width="35%">
                                    <%-- 调休开始时间--%>
                                    <div id="_xform_fdStartTime" _xform_type="datetime">
                                        <xform:datetime property="fdStartTime" showStatus="edit" dateTimeType="datetime" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-leave:geesunLeaveBarter.fdEndTime')}
                                </td>
                                <td width="35%">
                                    <%-- 调休结束时间--%>
                                    <div id="_xform_fdEndTime" _xform_type="datetime">
                                        <xform:datetime property="fdEndTime" showStatus="edit" dateTimeType="datetime" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-leave:geesunLeaveBarter.fdLeaveHour')}
                                </td>
                                <td width="35%">
                                    <%-- 调休时数--%>
                                    <div id="_xform_fdLeaveHour" _xform_type="text">
                                        <xform:text property="fdLeaveHour" showStatus="edit" validators=" number" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-leave:geesunLeaveBarter.docCreateTime')}
                                </td>
                                <td width="35%">
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