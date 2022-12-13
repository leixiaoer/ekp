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
            <c:out value="${geesunBasePayForm.fdPeriod} - " />
            <c:out value="${ lfn:message('geesun-base:table.geesunBasePay') }" />
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
                    basePath: '/geesun/base/geesun_base_pay/geesunBasePay.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <%-- <!--edit-->
                <kmss:auth requestURL="/geesun/base/geesun_base_pay/geesunBasePay.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('geesunBasePay.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/geesun/base/geesun_base_pay/geesunBasePay.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('geesunBasePay.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth> --%>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('geesun-base:table.geesunBasePay') }" href="/geesun/base/geesun_base_pay/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

            <ui:tabpage expand="false" var-navwidth="90%">
                <ui:content title="${ lfn:message('geesun-base:py.JiBenXinXi') }" expand="true">
                    <div class='lui_form_title_frame'>
                        <div class='lui_form_subject'>
                            ${lfn:message('geesun-base:table.geesunBasePay')}
                        </div>
                        <div class='lui_form_baseinfo'>

                        </div>
                    </div>
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdYwDate')}
                            </td>
                            <td width="35%">
                                <%-- 业务日期--%>
                                <div id="_xform_fdYwDate" _xform_type="datetime">
                                    <xform:datetime property="fdYwDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdPayDate')}
                            </td>
                            <td width="35%">
                                <%-- 付款日期--%>
                                <div id="_xform_fdPayDate" _xform_type="datetime">
                                    <xform:datetime property="fdPayDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdPeriod')}
                            </td>
                            <td width="35%">
                                <%-- 期间--%>
                                <kmss:showPeriod value="${geesunBasePayForm.fdPeriod}"/>
                                <%-- <div id="_xform_fdPeriod" _xform_type="text">
                                    <xform:text property="fdPeriod" showStatus="view" style="width:95%;" />
                                </div> --%>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdOrderId')}
                            </td>
                            <td width="35%">
                                <%-- FOrderId--%>
                                <xform:text property="fdOrderId" showStatus="view" style="width:95%;" />
                            </td>
                        </tr>
                        <TR>
                        	<td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdPayBank1')}
                            </td>
                            <td colspan="3">
                                <%-- 付款银行--%>
                                <xform:select property="fdPayBank1" htmlElementProperties="id='fdPayBank1'" showStatus="view">
				                	<xform:SQLDataSource sql="select FID,fkmmc from cn_account where FIsCash=0 order by fid" dbConnect="项目库"/>
				                </xform:select>
                            </td>
                        </TR>
                        <%-- <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdPayBank2')}
                            </td>
                            <td width="35%">
                                付款银行科目
                                <div id="_xform_fdPayBank2" _xform_type="text">
                                    <xform:text property="fdPayBank2" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdPayBank3')}
                            </td>
                            <td width="35%">
                                付款银行名称
                                <div id="_xform_fdPayBank3" _xform_type="text">
                                    <xform:text property="fdPayBank3" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr> --%>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdAccount')}
                            </td>
                            <td colspan="3">
                                <%-- 科目代码--%>
                                <xform:select property="fdAccountCode" htmlElementProperties="id='fdAccountCode'" showStatus="view">
				                	<xform:SQLDataSource sql="select FAccountID,FName from t_Account where FDelete=0 order by FNumber" dbConnect="项目库"/>
				                </xform:select>
                                <%-- <div id="_xform_fdAccountCode" _xform_type="text">
                                    <xform:text property="fdAccountCode" showStatus="view" style="width:95%;" />
                                </div> --%>
                            </td>
                            <%-- <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdAccountName')}
                            </td>
                            <td width="35%">
                                科目名称
                                <div id="_xform_fdAccountName" _xform_type="text">
                                    <xform:text property="fdAccountName" showStatus="view" style="width:95%;" />
                                </div>
                            </td> --%>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdDemo')}
                            </td>
                            <td colspan="3" width="85.0%">
                                <%-- 摘要--%>
                                <div id="_xform_fdDemo" _xform_type="text">
                                    <xform:text property="fdDemo" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdPayMoney')}
                            </td>
                            <td width="35%">
                                <%-- 付款金额--%>
                                <div id="_xform_fdPayMoney" _xform_type="text">
                                    <xform:text property="fdPayMoney" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.fdRemark')}
                            </td>
                            <td width="35%">
                                <%-- 备注--%>
                                <div id="_xform_fdRemark" _xform_type="text">
                                    <xform:text property="fdRemark" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.docCreator')}
                            </td>
                            <td width="35%">
                                <%-- 创建人--%>
                                <div id="_xform_docCreatorId" _xform_type="address">
                                    <ui:person personId="${geesunBasePayForm.docCreatorId}" personName="${geesunBasePayForm.docCreatorName}" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-base:geesunBasePay.docCreateTime')}
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