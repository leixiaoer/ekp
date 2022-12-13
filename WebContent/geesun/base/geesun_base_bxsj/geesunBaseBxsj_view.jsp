<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.geesun.base.util.GeesunBaseUtil" %>
    
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
            <c:out value="${geesunBaseBxsjForm.fdTwoAccountCode} - " />
            <c:out value="${ lfn:message('geesun-base:table.geesunBaseBxsj') }" />
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
                    basePath: '/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <kmss:auth requestURL="/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('geesunBaseBxsj.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('geesunBaseBxsj.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('geesun-base:table.geesunBaseBxsj') }" href="/geesun/base/geesun_base_bxsj/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

            <ui:tabpage expand="false" var-navwidth="90%">
                <ui:content title="${ lfn:message('geesun-base:py.JiBenXinXi') }" expand="true">
                    <div class='lui_form_title_frame'>
                        <div class='lui_form_subject'>
                            ${lfn:message('geesun-base:table.geesunBaseBxsj')}
                        </div>
                        <div class='lui_form_baseinfo'>

                        </div>
                    </div>
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBaseBxsj.fdTwoAccountName')}
                            </td>
                            <td width="35%">
                                <%-- 报销科目名称--%>
                                <div id="_xform_fdTwoAccountName" _xform_type="text">
                                    <xform:text property="fdTwoAccountName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBaseBxsj.fdTwoAccountCode')}
                            </td>
                            <td width="35%">
                                <%-- 报销科目编码--%>
                                <div id="_xform_fdTwoAccountCode" _xform_type="text">
                                    <xform:text property="fdTwoAccountCode" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBaseBxsj.fdRelateType')}
                            </td>
                            <td colspan="3" width="85.0%">
                                <%-- 勾稽类型--%>
                                <div id="_xform_fdRelateType" _xform_type="radio">
                                    <xform:radio property="fdRelateType" htmlElementProperties="id='fdRelateType'" showStatus="view">
                                        <xform:enumsDataSource enumsType="geesun_base_type" />
                                    </xform:radio>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBaseBxsj.fdRelateName')}
                            </td>
                            <td width="35%">
                                <%-- 勾稽字段名称--%>
                                <div id="_xform_fdRelateName" _xform_type="text">
                                    <xform:text property="fdRelateName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBaseBxsj.fdRelateCode')}
                            </td>
                            <td width="35%">
                                <%-- 勾稽关系编码--%>
                                <div id="_xform_fdRelateCode" _xform_type="text">
                                    <xform:text property="fdRelateCode" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
		                    <td class="td_normal_title" width="15%">
		                        ${lfn:message('geesun-base:geesunBaseBxsj.fdFirstCharger')}
		                    </td>
		                    <td colspan="3" width="85.0%">
		                        <div id="_xform_fdFirstChargerIds" _xform_type="address">
		                            <xform:address propertyId="fdFirstChargerIds" propertyName="fdFirstChargerNames" mulSelect="true" orgType="ORG_TYPE_PERSON" showStatus="view" style="width:95%;" />
		                        </div>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="td_normal_title" width="15%">
		                        ${lfn:message('geesun-base:geesunBaseBxsj.fdSecondCharger')}
		                    </td>
		                    <td colspan="3" width="85.0%">
		                        <div id="_xform_fdSecondChargerIds" _xform_type="address">
		                            <xform:address propertyId="fdSecondChargerIds" propertyName="fdSecondChargerNames" mulSelect="true" orgType="ORG_TYPE_PERSON" showStatus="view" style="width:95%;" />
		                        </div>
		                    </td>
		                </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBaseBxsj.docCreator')}
                            </td>
                            <td width="35%">
                                <%-- 创建人--%>
                                <div id="_xform_docCreatorId" _xform_type="address">
                                    <ui:person personId="${geesunBaseBxsjForm.docCreatorId}" personName="${geesunBaseBxsjForm.docCreatorName}" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBaseBxsj.docCreateTime')}
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
                                ${lfn:message('geesun-base:geesunBaseBxsj.docAlteror')}
                            </td>
                            <td width="35%">
                                <%-- 修改人--%>
                                <div id="_xform_docAlterorId" _xform_type="address">
                                    <ui:person personId="${geesunBaseBxsjForm.docAlterorId}" personName="${geesunBaseBxsjForm.docAlterorName}" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBaseBxsj.docAlterTime')}
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
        </template:replace>

    </template:include>