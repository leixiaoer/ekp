<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.geesun.org.util.GeesunOrgUtil" %>
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
            <c:out value="${geesunOrgRecordForm.stext} - " />
            <c:out value="${ lfn:message('geesun-org:table.geesunOrgRecord') }" />
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
                    basePath: '/geesun/org/geesun_org_record/geesunOrgRecord.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <%-- <kmss:auth requestURL="/geesun/org/geesun_org_record/geesunOrgRecord.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('geesunOrgRecord.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <kmss:auth requestURL="/geesun/org/geesun_org_record/geesunOrgRecord.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('geesunOrgRecord.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth> --%>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('geesun-org:table.geesunOrgRecord') }" href="/geesun/org/geesun_org_record/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

            <ui:tabpage expand="false" var-navwidth="90%">
                <ui:content title="${ lfn:message('geesun-org:py.JiBenXinXi') }" expand="true">
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" colspan="4" width="100%">
                                ${ lfn:message('geesun-org:table.geesunOrgRecord') }
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.fdOrganType')}
                            </td>
                            <td colspan="3" width="85.0%">
                                <%-- 组织类型--%>
                                <div id="_xform_fdOrganType" _xform_type="select">
                                    <xform:select property="fdOrganType" htmlElementProperties="id='fdOrganType'" showStatus="view">
                                        <xform:enumsDataSource enumsType="geesun_org_oran_type" />
                                    </xform:select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.stext')}
                            </td>
                            <td width="35%">
                                <%-- STEXT--%>
                                <div id="_xform_stext" _xform_type="text">
                                    <xform:text property="stext" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.objid')}
                            </td>
                            <td width="35%">
                                <%-- OBJID--%>
                                <div id="_xform_objid" _xform_type="text">
                                    <xform:text property="objid" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.objidUp')}
                            </td>
                            <td width="35%">
                                <%-- OBJID_UP--%>
                                <div id="_xform_objidUp" _xform_type="text">
                                    <xform:text property="objidUp" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.priox')}
                            </td>
                            <td width="35%">
                                <%-- PRIOX--%>
                                <div id="_xform_priox" _xform_type="text">
                                    <xform:text property="priox" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.zhrOmJglx')}
                            </td>
                            <td width="35%">
                                <%-- ZHR_OM_JGLX--%>
                                <div id="_xform_zhrOmJglx" _xform_type="text">
                                    <xform:text property="zhrOmJglx" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.zsfyx')}
                            </td>
                            <td width="35%">
                                <%-- ZSFYX--%>
                                <div id="_xform_zsfyx" _xform_type="text">
                                    <xform:text property="zsfyx" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.objidSUp')}
                            </td>
                            <td width="35%">
                                <%-- OBJID_S_UP--%>
                                <div id="_xform_objidSUp" _xform_type="text">
                                    <xform:text property="objidSUp" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.zzDatum')}
                            </td>
                            <td width="35%">
                                <%-- ZZ_DATUM--%>
                                <div id="_xform_zzDatum" _xform_type="text">
                                    <xform:text property="zzDatum" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.begda')}
                            </td>
                            <td width="35%">
                                <%-- BEGDA--%>
                                <div id="_xform_begda" _xform_type="text">
                                    <xform:text property="begda" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.nachn')}
                            </td>
                            <td width="35%">
                                <%-- NACHN--%>
                                <div id="_xform_nachn" _xform_type="text">
                                    <xform:text property="nachn" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.phone')}
                            </td>
                            <td width="35%">
                                <%-- PHONE--%>
                                <div id="_xform_phone" _xform_type="text">
                                    <xform:text property="phone" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.gbdat')}
                            </td>
                            <td width="35%">
                                <%-- GBDAT--%>
                                <div id="_xform_gbdat" _xform_type="text">
                                    <xform:text property="gbdat" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.call')}
                            </td>
                            <td width="35%">
                                <%-- CALL--%>
                                <div id="_xform_call" _xform_type="text">
                                    <xform:text property="call" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.gender')}
                            </td>
                            <td width="35%">
                                <%-- GENDER--%>
                                <div id="_xform_gender" _xform_type="text">
                                    <xform:text property="gender" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.wxid')}
                            </td>
                            <td width="35%">
                                <%-- WXID--%>
                                <div id="_xform_wxid" _xform_type="text">
                                    <xform:text property="wxid" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.pernr')}
                            </td>
                            <td width="35%">
                                <%-- PERNR--%>
                                <div id="_xform_pernr" _xform_type="text">
                                    <xform:text property="pernr" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.plans02')}
                            </td>
                            <td width="35%">
                                <%-- PLANS_02--%>
                                <div id="_xform_plans02" _xform_type="text">
                                    <xform:text property="plans02" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.email')}
                            </td>
                            <td width="35%">
                                <%-- EMAIL--%>
                                <div id="_xform_email" _xform_type="text">
                                    <xform:text property="email" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.zhrOmGwzd')}
                            </td>
                            <td width="35%">
                                <%-- ZHR_OM_GWZD--%>
                                <div id="_xform_zhrOmGwzd" _xform_type="text">
                                    <xform:text property="zhrOmGwzd" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.plans01')}
                            </td>
                            <td width="35%">
                                <%-- PLANS_01--%>
                                <div id="_xform_plans01" _xform_type="text">
                                    <xform:text property="plans01" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.zhrOmGwzj')}
                            </td>
                            <td width="35%">
                                <%-- ZHR_OM_GWZJ--%>
                                <div id="_xform_zhrOmGwzj" _xform_type="text">
                                    <xform:text property="zhrOmGwzj" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.vnamc')}
                            </td>
                            <td width="35%">
                                <%-- VNAMC--%>
                                <div id="_xform_vnamc" _xform_type="text">
                                    <xform:text property="vnamc" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.orgeh')}
                            </td>
                            <td width="35%">
                                <%-- ORGEH--%>
                                <div id="_xform_orgeh" _xform_type="text">
                                    <xform:text property="orgeh" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.icnum')}
                            </td>
                            <td width="35%">
                                <%-- ICNUM--%>
                                <div id="_xform_icnum" _xform_type="text">
                                    <xform:text property="icnum" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-org:geesunOrgRecord.docCreateTime')}
                            </td>
                            <td width="35%">
                                <%-- 创建时间--%>
                                <div id="_xform_docCreateTime" _xform_type="datetime">
                                    <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                                </div>
                            </td>
                            <td colspan="2">
                            </td>
                        </tr>
                    </table>
                </ui:content>
            </ui:tabpage>
        </template:replace>

    </template:include>
