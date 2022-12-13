<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@page import="com.landray.kmss.geesun.annual.util.GeesunAnnualUtil" %>
    
        <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser());
        pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
    <template:include ref="mobile.edit" compatibleMode="true">
        <template:replace name="title">
            <c:choose>
                <c:when test="${geesunAnnualUseForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-annual:table.geesunAnnualUse') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunAnnualUseForm.docSubject} - " />
                    <c:out value="${lfn:message('geesun-annual:table.geesunAnnualUse') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="head">
            <style>
                .detailTips{
                				color: red;
                	    		font-weight: lighter;
                	    		display: inline-block;
                	    		font-size: 1rem;
                			}
                			.muiFormNoContent{
                				padding-left:1rem;
                				border-top:1px solid #ddd;
                				border-bottom: 1px solid #ddd;
                			 }
                			 .muiDocFrameExt{
                				margin-left: 0rem;
                			 }
                			 .muiDocFrameExt .muiDocInfo{
                				border: none;
                			 }
            </style>
            <script type="text/javascript">
                var formInitData = {

                };
                var lang = {
                    "the": "${lfn:message('page.the')}",
                    "row": "${lfn:message('page.row')}"
                };
                var messageInfo = {

                };

                var initData = {
                    contextPath: '${LUI_ContextPath}'
                };
                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/annual/geesun_annual_use/", 'js', true);
                Com_IncludeFile("mobile_edit.js", "${LUI_ContextPath}/geesun/annual/resource/js/", 'js', true);
            </script>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=save">

                <div id="scrollView" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
                    <div data-dojo-type="mui/panel/AccordionPanel">
                        <div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('geesun-annual:py.JiBenXinXi') }',icon:'mui-ul'">
                            <div class="muiFormContent">
                                <div class="muiDocFrame muiDocFrameExt">
                                    <div class="muiDocSubject">
                                        ${lfn:message('geesun-annual:table.geesunAnnualUse')}
                                    </div>
                                </div>
                                <table class="muiSimple" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualUse.docSubject')}
                                        </td>
                                        <td>
                                            <div id="_xform_docSubject" _xform_type="text">
                                                <xform:text property="docSubject" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualUse.fdModelId')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdModelId" _xform_type="text">
                                                <xform:text property="fdModelId" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualUse.fdUse')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdUse" _xform_type="text">
                                                <xform:text property="fdUse" showStatus="edit" validators=" number min(0)" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualUse.docCreator')}
                                        </td>
                                        <td>
                                            <div id="_xform_docCreatorId" _xform_type="address">
                                                <ui:person personId="${geesunAnnualUseForm.docCreatorId}" personName="${geesunAnnualUseForm.docCreatorName}" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualUse.docCreateTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_docCreateTime" _xform_type="datetime">
                                                <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualUse.fdBeginDate')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdBeginDate" _xform_type="datetime">
                                                <xform:datetime property="fdBeginDate" showStatus="edit" dateTimeType="date" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualUse.fdBeginTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdBeginTime" _xform_type="datetime">
                                                <xform:datetime property="fdBeginTime" showStatus="edit" dateTimeType="time" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualUse.fdEndDate')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEndDate" _xform_type="datetime">
                                                <xform:datetime property="fdEndDate" showStatus="edit" dateTimeType="date" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualUse.fdEndTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEndTime" _xform_type="datetime">
                                                <xform:datetime property="fdEndTime" showStatus="edit" dateTimeType="time" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualUse.fdAnnual')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdAnnualId" _xform_type="dialog">
                                                <div data-dojo-type="mui/form/CommonDialog" data-dojo-props="idField:'fdAnnualId',nameField:'fdAnnualName',isMul:false,modelName:'com.landray.kmss.geesun.annual.model.GeesunAnnualMain',dataURL:getSource('geesun_annual_main_selectAnnual'),subject:'${lfn:message('geesun-annual:geesunAnnualUse.fdAnnual')}',curIds:'${lfn:escapeHtml(lfn:escapeJs(geesunAnnualUseForm.fdAnnualId))}',curNames:'${lfn:escapeHtml(lfn:escapeJs(geesunAnnualUseForm.fdAnnualName))}',afterSelect:afterDialogSel">
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
                        <li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext " data-dojo-props="colSize:2,onClick:function(){submitFormValidate();}">
                            <bean:message key="button.submit" />
                        </li>
                    </ul>
                </div>
                <html:hidden property="fdId" />
                <html:hidden property="method_GET" />


            </html:form>
        </template:replace>
    </template:include>