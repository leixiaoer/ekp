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
            <c:out value="${geesunAnnualResetForm.fdHasExecute} - " />
            <c:out value="${ lfn:message('geesun-annual:table.geesunAnnualReset') }" />
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
                    basePath: '/geesun/annual/geesun_annual_reset/geesunAnnualReset.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <kmss:auth requestURL="/geesun/annual/geesun_annual_reset/geesunAnnualReset.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('geesunAnnualReset.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/geesun/annual/geesun_annual_reset/geesunAnnualReset.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('geesunAnnualReset.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('geesun-annual:table.geesunAnnualReset') }" href="/geesun/annual/geesun_annual_reset/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

            <ui:tabpage expand="false" var-navwidth="90%">
                <ui:content title="${ lfn:message('geesun-annual:py.JiBenXinXi') }" expand="true">
                    <div class='lui_form_title_frame'>
                        <div class='lui_form_subject'>
                            ${lfn:message('geesun-annual:table.geesunAnnualReset')}
                        </div>
                        <div class='lui_form_baseinfo'>

                        </div>
                    </div>
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualReset.fdOwner')}
                            </td>
                            <td width="35%">
                                <%-- 归属人--%>
                                <div id="_xform_fdOwnerId" _xform_type="address">
                                    <xform:address propertyId="fdOwnerId" propertyName="fdOwnerName" orgType="ORG_TYPE_PERSON" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualReset.fdAnnual')}
                            </td>
                            <td width="35%">
                                <%-- 年假表--%>
                                <div id="_xform_fdAnnualId" _xform_type="select">
                                    <xform:select property="fdAnnualId" htmlElementProperties="id='fdAnnualId'" showStatus="view">
                                        <xform:beanDataSource serviceBean="geesunAnnualMainService" selectBlock="fdId,fdOwnerNo" />
                                    </xform:select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualReset.fdHasExecute')}
                            </td>
                            <td width="35%">
                                <%-- 是否已执行--%>
                                <div id="_xform_fdHasExecute" _xform_type="select">
                                    <xform:select property="fdHasExecute" htmlElementProperties="id='fdHasExecute'" showStatus="view">
                                        <xform:enumsDataSource enumsType="geesun_annual_is_execute" />
                                    </xform:select>
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualReset.fdExecuteTime')}
                            </td>
                            <td width="35%">
                                <%-- 最新一次执行时间--%>
                                <div id="_xform_fdExecuteTime" _xform_type="datetime">
                                    <xform:datetime property="fdExecuteTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </ui:content>
            </ui:tabpage>
        </template:replace>

    </template:include>