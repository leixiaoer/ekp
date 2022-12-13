<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.geesun.annual.util.GeesunAnnualUtil" %>
    
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
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/annual/geesun_annual_use/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/geesun/annual/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${geesunAnnualUseForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-annual:table.geesunAnnualUse') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunAnnualUseForm.docSubject} - " />
                    <c:out value="${ lfn:message('geesun-annual:table.geesunAnnualUse') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ geesunAnnualUseForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.geesunAnnualUseForm, 'update');}" />
                    </c:when>
                    <c:when test="${ geesunAnnualUseForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.geesunAnnualUseForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('geesun-annual:table.geesunAnnualUse') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/annual/geesun_annual_use/geesunAnnualUse.do">

                <ui:tabpage expand="false" var-navwidth="90%">
                    <ui:content title="${ lfn:message('geesun-annual:py.JiBenXinXi') }" expand="true">
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
                                <td colspan="3" width="85.0%">
                                    <%-- 标题--%>
                                    <div id="_xform_docSubject" _xform_type="text">
                                        <xform:text property="docSubject" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="fdModelId" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-annual:geesunAnnualUse.fdUse')}
                                </td>
                                <td width="35%">
                                    <%-- 用时--%>
                                    <div id="_xform_fdUse" _xform_type="text">
                                        <xform:text property="fdUse" showStatus="edit" validators=" number min(0)" style="width:95%;" />
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
                                        <xform:dialog propertyId="fdAnnualId" propertyName="fdAnnualName" showStatus="edit" style="width:95%;">
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
                                        <xform:datetime property="fdBeginDate" showStatus="edit" dateTimeType="date" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-annual:geesunAnnualUse.fdBeginTime')}
                                </td>
                                <td width="35%">
                                    <%-- 开始时间--%>
                                    <div id="_xform_fdBeginTime" _xform_type="datetime">
                                        <xform:datetime property="fdBeginTime" showStatus="edit" dateTimeType="time" style="width:95%;" />
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
                                        <xform:datetime property="fdEndDate" showStatus="edit" dateTimeType="date" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-annual:geesunAnnualUse.fdEndTime')}
                                </td>
                                <td width="35%">
                                    <%-- 结束时间--%>
                                    <div id="_xform_fdEndTime" _xform_type="datetime">
                                        <xform:datetime property="fdEndTime" showStatus="edit" dateTimeType="time" style="width:95%;" />
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
                    </ui:content>
                </ui:tabpage>
                <html:hidden property="fdId" />


                <html:hidden property="method_GET" />
            </html:form>
        </template:replace>


    </template:include>