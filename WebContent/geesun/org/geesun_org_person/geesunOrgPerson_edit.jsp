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
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/org/geesun_org_person/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/geesun/org/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${geesunOrgPersonForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-org:table.geesunOrgPerson') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunOrgPersonForm.fdPersonId} - " />
                    <c:out value="${ lfn:message('geesun-org:table.geesunOrgPerson') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ geesunOrgPersonForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.geesunOrgPersonForm, 'update');}" />
                    </c:when>
                    <c:when test="${ geesunOrgPersonForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.geesunOrgPersonForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('geesun-org:table.geesunOrgPerson') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/org/geesun_org_person/geesunOrgPerson.do">

                <ui:tabpage expand="false" var-navwidth="90%">
                    <ui:content title="${ lfn:message('geesun-org:py.JiBenXinXi') }" expand="true">
                        <div class='lui_form_title_frame'>
                            <div class='lui_form_subject'>
                                ${lfn:message('geesun-org:table.geesunOrgPerson')}
                            </div>
                            <div class='lui_form_baseinfo'>

                            </div>
                        </div>
                        <table class="tb_normal" width="100%">
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdPersonId')}
                                </td>
                                <td width="35%">
                                    <%-- 人员ID--%>
                                    <div id="_xform_fdPersonId" _xform_type="text">
                                        <xform:text property="fdPersonId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdEmpNo')}
                                </td>
                                <td width="35%">
                                    <%-- 工号--%>
                                    <div id="_xform_fdEmpNo" _xform_type="text">
                                        <xform:text property="fdEmpNo" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdEmpName')}
                                </td>
                                <td width="35%">
                                    <%-- 姓名--%>
                                    <div id="_xform_fdEmpName" _xform_type="text">
                                        <xform:text property="fdEmpName" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdParentId')}
                                </td>
                                <td width="35%">
                                    <%-- 部门ID--%>
                                    <div id="_xform_fdParentId" _xform_type="text">
                                        <xform:text property="fdParentId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdPostId')}
                                </td>
                                <td width="35%">
                                    <%-- 岗位ID--%>
                                    <div id="_xform_fdPostId" _xform_type="text">
                                        <xform:text property="fdPostId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdSex')}
                                </td>
                                <td width="35%">
                                    <%-- 性别--%>
                                    <div id="_xform_fdSex" _xform_type="text">
                                        <xform:text property="fdSex" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdBirthDate')}
                                </td>
                                <td width="35%">
                                    <%-- fd_birth_day--%>
                                    <div id="_xform_fdBirthDate" _xform_type="text">
                                        <xform:text property="fdBirthDate" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdMobile')}
                                </td>
                                <td width="35%">
                                    <%-- 手机号--%>
                                    <div id="_xform_fdMobile" _xform_type="text">
                                        <xform:text property="fdMobile" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdAddress')}
                                </td>
                                <td width="35%">
                                    <%-- 地址--%>
                                    <div id="_xform_fdAddress" _xform_type="text">
                                        <xform:text property="fdAddress" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdCountry')}
                                </td>
                                <td width="35%">
                                    <%-- 国家--%>
                                    <div id="_xform_fdCountry" _xform_type="text">
                                        <xform:text property="fdCountry" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdSuperPostId')}
                                </td>
                                <td width="35%">
                                    <%-- 上级岗位ID--%>
                                    <div id="_xform_fdSuperPostId" _xform_type="text">
                                        <xform:text property="fdSuperPostId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdSuperDeptId')}
                                </td>
                                <td width="35%">
                                    <%-- 上级部门ID--%>
                                    <div id="_xform_fdSuperDeptId" _xform_type="text">
                                        <xform:text property="fdSuperDeptId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdRank')}
                                </td>
                                <td width="35%">
                                    <%-- 职级--%>
                                    <div id="_xform_fdRank" _xform_type="text">
                                        <xform:text property="fdRank" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdEmail')}
                                </td>
                                <td width="35%">
                                    <%-- 邮箱--%>
                                    <div id="_xform_fdEmail" _xform_type="text">
                                        <xform:text property="fdEmail" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdIdCard')}
                                </td>
                                <td width="35%">
                                    <%-- 身份证号--%>
                                    <div id="_xform_fdIdCard" _xform_type="text">
                                        <xform:text property="fdIdCard" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdEntryDate')}
                                </td>
                                <td width="35%">
                                    <%-- 入职时间--%>
                                    <div id="_xform_fdEntryDate" _xform_type="text">
                                        <xform:text property="fdEntryDate" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdLeaveDate')}
                                </td>
                                <td width="35%">
                                    <%-- 离职时间--%>
                                    <div id="_xform_fdLeaveDate" _xform_type="text">
                                        <xform:text property="fdLeaveDate" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdCity')}
                                </td>
                                <td width="35%">
                                    <%-- 城市--%>
                                    <div id="_xform_fdCity" _xform_type="text">
                                        <xform:text property="fdCity" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdSubjectName')}
                                </td>
                                <td width="35%">
                                    <%-- 科目--%>
                                    <div id="_xform_fdSubjectName" _xform_type="text">
                                        <xform:text property="fdSubjectName" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdWorkState')}
                                </td>
                                <td width="35%">
                                    <%-- 在职状态--%>
                                    <div id="_xform_fdWorkState" _xform_type="text">
                                        <xform:text property="fdWorkState" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.fdNewDate')}
                                </td>
                                <td width="35%">
                                    <%-- 更新时间--%>
                                    <div id="_xform_fdNewDate" _xform_type="datetime">
                                        <xform:datetime property="fdNewDate" showStatus="edit" dateTimeType="datetime" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgPerson.docCreateTime')}
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