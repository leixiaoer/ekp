<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.geesun.org.util.GeesunOrgUtil" %>
    
        <%
            pageContext.setAttribute("currentPerson", UserUtil.getKMSSUser().getUserId());
        pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
    <template:include ref="default.view">
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
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>
        <template:replace name="title">
            <c:out value="${geesunOrgPersonForm.fdEmpName} - " />
            <c:out value="${ lfn:message('geesun-org:table.geesunOrgPerson') }" />
        </template:replace>
        <template:replace name="toolbar">
            <script>
                function deleteDoc(delUrl) {
                    seajs.use(['lui/dialog'], function(dialog) {
                        dialog.confirm('${ lfn:message("page.comfirmDelete") }', function(isOk) {
                            if(isOk) {
                                Com_OpenWindow(delUrl, '_self');
                            }
                        });
                    });
                }

                function openWindowViaDynamicForm(popurl, params, target) {
                    var form = document.createElement('form');
                    if(form) {
                        try {
                            target = !target ? '_blank' : target;
                            form.style = "display:none;";
                            form.method = 'post';
                            form.action = popurl;
                            form.target = target;
                            if(params) {
                                for(var key in params) {
                                    var
                                    v = params[key];
                                    var vt = typeof
                                    v;
                                    var hdn = document.createElement('input');
                                    hdn.type = 'hidden';
                                    hdn.name = key;
                                    if(vt == 'string' || vt == 'boolean' || vt == 'number') {
                                        hdn.value =
                                        v +'';
                                    } else {
                                        if($.isArray(
                                            v)) {
                                            hdn.value =
                                            v.join(';');
                                        } else {
                                            hdn.value = toString(
                                                v);
                                        }
                                    }
                                    form.appendChild(hdn);
                                }
                            }
                            document.body.appendChild(form);
                            form.submit();
                        } finally {
                            document.body.removeChild(form);
                        }
                    }
                }

                function doCustomOpt(fdId, optCode) {
                    if(!fdId || !optCode) {
                        return;
                    }

                    if(viewOption.customOpts && viewOption.customOpts[optCode]) {
                        var param = {
                            "List_Selected_Count": 1
                        };
                        var argsObject = viewOption.customOpts[optCode];
                        if(argsObject.popup == 'true') {
                            var popurl = viewOption.contextPath + argsObject.popupUrl + '&fdId=' + fdId;
                            for(var arg in argsObject) {
                                param[arg] = argsObject[arg];
                            }
                            openWindowViaDynamicForm(popurl, param, '_self');
                            return;
                        }
                        var optAction = viewOption.contextPath + viewOption.basePath + '?method=' + optCode + '&fdId=' + fdId;
                        Com_OpenWindow(optAction, '_self');
                    }
                }
                window.doCustomOpt = doCustomOpt;
                var viewOption = {
                    contextPath: '${LUI_ContextPath}',
                    basePath: '/geesun/org/geesun_org_person/geesunOrgPerson.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <%-- <kmss:auth requestURL="/geesun/org/geesun_org_person/geesunOrgPerson.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('geesunOrgPerson.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/geesun/org/geesun_org_person/geesunOrgPerson.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('geesunOrgPerson.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth> --%>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('geesun-org:table.geesunOrgPerson') }" href="/geesun/org/geesun_org_person/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

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
                                    <xform:text property="fdPersonId" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdEmpNo')}
                            </td>
                            <td width="35%">
                                <%-- 工号--%>
                                <div id="_xform_fdEmpNo" _xform_type="text">
                                    <xform:text property="fdEmpNo" showStatus="view" style="width:95%;" />
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
                                    <xform:text property="fdEmpName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdParentId')}
                            </td>
                            <td width="35%">
                                <%-- 部门ID--%>
                                <div id="_xform_fdParentId" _xform_type="text">
                                    <xform:text property="fdParentId" showStatus="view" style="width:95%;" />
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
                                    <xform:text property="fdPostId" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdSex')}
                            </td>
                            <td width="35%">
                                <%-- 性别--%>
                                <div id="_xform_fdSex" _xform_type="text">
                                    <xform:text property="fdSex" showStatus="view" style="width:95%;" />
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
                                    <xform:text property="fdBirthDate" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdMobile')}
                            </td>
                            <td width="35%">
                                <%-- 手机号--%>
                                <div id="_xform_fdMobile" _xform_type="text">
                                    <xform:text property="fdMobile" showStatus="view" style="width:95%;" />
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
                                    <xform:text property="fdAddress" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdCountry')}
                            </td>
                            <td width="35%">
                                <%-- 国家--%>
                                <div id="_xform_fdCountry" _xform_type="text">
                                    <xform:text property="fdCountry" showStatus="view" style="width:95%;" />
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
                                    <xform:text property="fdSuperPostId" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdSuperDeptId')}
                            </td>
                            <td width="35%">
                                <%-- 上级部门ID--%>
                                <div id="_xform_fdSuperDeptId" _xform_type="text">
                                    <xform:text property="fdSuperDeptId" showStatus="view" style="width:95%;" />
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
                                    <xform:text property="fdRank" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdEmail')}
                            </td>
                            <td width="35%">
                                <%-- 邮箱--%>
                                <div id="_xform_fdEmail" _xform_type="text">
                                    <xform:text property="fdEmail" showStatus="view" style="width:95%;" />
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
                                    <xform:text property="fdIdCard" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdEntryDate')}
                            </td>
                            <td width="35%">
                                <%-- 入职时间--%>
                                <div id="_xform_fdEntryDate" _xform_type="text">
                                    <xform:text property="fdEntryDate" showStatus="view" style="width:95%;" />
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
                                    <xform:text property="fdLeaveDate" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdCity')}
                            </td>
                            <td width="35%">
                                <%-- 城市--%>
                                <div id="_xform_fdCity" _xform_type="text">
                                    <xform:text property="fdCity" showStatus="view" style="width:95%;" />
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
                                    <xform:text property="fdSubjectName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdWorkState')}
                            </td>
                            <td width="35%">
                                <%-- 在职状态--%>
                                <div id="_xform_fdWorkState" _xform_type="text">
                                    <xform:text property="fdWorkState" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgPerson.fdEstimateTime')}
                            </td>
                            <td colspan="3">
                                <%-- 预计试用期结束时间--%>
                                <div id="_xform_fdEstimateTime" _xform_type="text">
                                    <xform:text property="fdEstimateTime" showStatus="view" style="width:95%;" />
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
                                    <xform:datetime property="fdNewDate" showStatus="view" dateTimeType="datetime" style="width:95%;" />
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
        </template:replace>

    </template:include>