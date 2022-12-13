<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.geesun.annual.util.GeesunAnnualUtil" %>
    
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
            <c:out value="${geesunAnnualUseForm.docSubject} - " />
            <c:out value="${ lfn:message('geesun-annual:table.geesunAnnualUse') }" />
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
                    basePath: '/geesun/annual/geesun_annual_use/geesunAnnualUse.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
               <%--  <kmss:auth requestURL="/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('geesunAnnualUse.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('geesunAnnualUse.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth> --%>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('geesun-annual:table.geesunAnnualUse') }" href="/geesun/annual/geesun_annual_use/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
                    <div class='lui_form_title_frame'>
                        <div class='lui_form_subject'>
                            ${lfn:message('geesun-annual:table.geesunAnnualUse')}
                        </div>
                        <div class='lui_form_baseinfo'>

                        </div>
                    </div>
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.docSubject')}
                            </td>
                            <td width="35%">
                                <%-- 标题--%>
                                <div id="_xform_docSubject" _xform_type="text">
                                    <xform:text property="docSubject" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.fdType')}
                            </td>
                            <td width="35%">
                                <%-- 使用类型--%>
                                <div id="_xform_fdType" _xform_type="select">
                                    <xform:select property="fdType" htmlElementProperties="id='fdType'" showStatus="view">
                                        <xform:enumsDataSource enumsType="geesun_annual_use_fdType" />
                                    </xform:select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.fdModelId')}
                            </td>
                            <td width="35%">
                                <%-- 模型ID--%>
                                <div id="_xform_fdModelId" _xform_type="text">
                                    <xform:text property="fdModelId" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.fdUse')}
                            </td>
                            <td width="35%">
                                <%-- 用时--%>
                                <div id="_xform_fdUse" _xform_type="text">
                                    <xform:text property="fdUse" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.fdAnnual')}
                            </td>
                            <td colspan="3" width="85.0%">
                                <%-- 对应年假记录--%>
                                <div id="_xform_fdAnnualId" _xform_type="dialog">
                                    <xform:dialog propertyId="fdAnnualId" propertyName="fdAnnualName" showStatus="view" style="width:95%;">
                                        dialogSelect(false,'geesun_annual_main_selectAnnual','fdAnnualId','fdAnnualName');
                                    </xform:dialog>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.fdBeginDate')}
                            </td>
                            <td width="35%">
                                <%-- 开始日期--%>
                                <div id="_xform_fdBeginDate" _xform_type="datetime">
                                    <xform:datetime property="fdBeginDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.fdBeginTime')}
                            </td>
                            <td width="35%">
                                <%-- 开始时间--%>
                                <div id="_xform_fdBeginTime" _xform_type="datetime">
                                    <xform:datetime property="fdBeginTime" showStatus="view" dateTimeType="time" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.fdEndDate')}
                            </td>
                            <td width="35%">
                                <%-- 结束日期--%>
                                <div id="_xform_fdEndDate" _xform_type="datetime">
                                    <xform:datetime property="fdEndDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.fdEndTime')}
                            </td>
                            <td width="35%">
                                <%-- 结束时间--%>
                                <div id="_xform_fdEndTime" _xform_type="datetime">
                                    <xform:datetime property="fdEndTime" showStatus="view" dateTimeType="time" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.docCreator')}
                            </td>
                            <td width="35%">
                                <%-- 创建人--%>
                                <div id="_xform_docCreatorId" _xform_type="address">
                                    <ui:person personId="${geesunAnnualUseForm.docCreatorId}" personName="${geesunAnnualUseForm.docCreatorName}" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualUse.docCreateTime')}
                            </td>
                            <td width="35%">
                                <%-- 创建时间--%>
                                <div id="_xform_docCreateTime" _xform_type="datetime">
                                    <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                    </table>
        </template:replace>

    </template:include>