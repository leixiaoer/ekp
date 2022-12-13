<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@page import="com.landray.kmss.geesun.leave.util.GeesunLeaveUtil" %>
    
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
                <c:when test="${geesunLeaveBarterForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-leave:table.geesunLeaveBarter') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunLeaveBarterForm.docSubject} - " />
                    <c:out value="${lfn:message('geesun-leave:table.geesunLeaveBarter') }" />
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
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/leave/geesun_leave_barter/", 'js', true);
                Com_IncludeFile("mobile_edit.js", "${LUI_ContextPath}/geesun/leave/resource/js/", 'js', true);
            </script>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/leave/geesun_leave_barter/geesunLeaveBarter.do?method=save">

                <div id="scrollView" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
                    <div data-dojo-type="mui/panel/AccordionPanel">
                        <div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('geesun-leave:py.JiBenXinXi') }',icon:'mui-ul'">
                            <div class="muiFormContent">
                                <div class="muiDocFrame muiDocFrameExt">
                                    <div class="muiDocSubject">
                                        ${lfn:message('geesun-leave:table.geesunLeaveBarter')}
                                    </div>
                                </div>
                                <table class="muiSimple" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveBarter.docSubject')}
                                        </td>
                                        <td>
                                            <div id="_xform_docSubject" _xform_type="text">
                                                <xform:text property="docSubject" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveBarter.docCreator')}
                                        </td>
                                        <td>
                                            <div id="_xform_docCreatorId" _xform_type="address">
                                                <ui:person personId="${geesunLeaveBarterForm.docCreatorId}" personName="${geesunLeaveBarterForm.docCreatorName}" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveBarter.docDept')}
                                        </td>
                                        <td>
                                            <div id="_xform_docDeptId" _xform_type="address">
                                                <xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveBarter.docCreateTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_docCreateTime" _xform_type="datetime">
                                                <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveBarter.fdStartTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdStartTime" _xform_type="datetime">
                                                <xform:datetime property="fdStartTime" showStatus="edit" dateTimeType="datetime" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveBarter.fdEndTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEndTime" _xform_type="datetime">
                                                <xform:datetime property="fdEndTime" showStatus="edit" dateTimeType="datetime" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveBarter.fdLeaveHour')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdLeaveHour" _xform_type="text">
                                                <xform:text property="fdLeaveHour" showStatus="edit" validators=" number" mobile="true" style="width:95%;" />
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


                <c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="geesunLeaveBarterForm" />
                    <c:param name="moduleModelName" value="com.landray.kmss.geesun.leave.model.GeesunLeaveBarter" />
                </c:import>

            </html:form>
        </template:replace>
    </template:include>