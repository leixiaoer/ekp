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
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/base/geesun_base_pay/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/geesun/base/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${geesunBasePayForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-base:table.geesunBasePay') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunBasePayForm.fdPeriod} - " />
                    <c:out value="${ lfn:message('geesun-base:table.geesunBasePay') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ geesunBasePayForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.geesunBasePayForm, 'update');}" />
                    </c:when>
                    <c:when test="${ geesunBasePayForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.geesunBasePayForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('geesun-base:table.geesunBasePay') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/base/geesun_base_pay/geesunBasePay.do">

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
                                        <xform:datetime property="fdYwDate" showStatus="edit" dateTimeType="date" required="true" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBasePay.fdPayDate')}
                                </td>
                                <td width="35%">
                                    <%-- 付款日期--%>
                                    <div id="_xform_fdPayDate" _xform_type="datetime">
                                        <xform:datetime property="fdPayDate" showStatus="edit" dateTimeType="date" required="true" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBasePay.fdPeriod')}
                                </td>
                                <td width="35%">
                                    <%-- 期间--%>
                                    <div id="_xform_fdPeriod" _xform_type="text">
                                        <xform:text property="fdPeriod" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBasePay.fdPayBank1')}
                                </td>
                                <td width="35%">
                                    <%-- 付款银行--%>
                                    <div id="_xform_fdPayBank1" _xform_type="text">
                                        <xform:text property="fdPayBank1" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBasePay.fdPayBank2')}
                                </td>
                                <td width="35%">
                                    <%-- 付款银行科目--%>
                                    <div id="_xform_fdPayBank2" _xform_type="text">
                                        <xform:text property="fdPayBank2" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBasePay.fdPayBank3')}
                                </td>
                                <td width="35%">
                                    <%-- 付款银行名称--%>
                                    <div id="_xform_fdPayBank3" _xform_type="text">
                                        <xform:text property="fdPayBank3" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBasePay.fdAccountCode')}
                                </td>
                                <td width="35%">
                                    <%-- 科目代码--%>
                                    <div id="_xform_fdAccountCode" _xform_type="text">
                                        <xform:text property="fdAccountCode" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBasePay.fdAccountName')}
                                </td>
                                <td width="35%">
                                    <%-- 科目名称--%>
                                    <div id="_xform_fdAccountName" _xform_type="text">
                                        <xform:text property="fdAccountName" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBasePay.fdDemo')}
                                </td>
                                <td colspan="3" width="85.0%">
                                    <%-- 摘要--%>
                                    <div id="_xform_fdDemo" _xform_type="text">
                                        <xform:text property="fdDemo" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdPayMoney" showStatus="edit" validators=" number min(0)" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-base:geesunBasePay.fdRemark')}
                                </td>
                                <td width="35%">
                                    <%-- 备注--%>
                                    <div id="_xform_fdRemark" _xform_type="text">
                                        <xform:text property="fdRemark" showStatus="edit" style="width:95%;" />
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
                <html:hidden property="fdId" />


                <html:hidden property="method_GET" />
            </html:form>
        </template:replace>


    </template:include>