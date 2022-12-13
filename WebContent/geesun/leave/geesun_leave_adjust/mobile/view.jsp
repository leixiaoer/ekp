<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@page import="com.landray.kmss.geesun.leave.util.GeesunLeaveUtil" %>
    
        <%
            pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
    <template:include ref="mobile.view" compatibleMode="true">
        <template:replace name="title">
            <c:out value="${geesunLeaveAdjustForm.docSubject} - " />
            <c:out value="${lfn:message('geesun-leave:table.geesunLeaveAdjust') }" />
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
                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
                Com_IncludeFile("mobile_edit.js", "${LUI_ContextPath}/geesun/leave/resource/js/", 'js', true);
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/leave/geesun_leave_adjust/", 'js', true);
            </script>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/leave/geesun_leave_adjust/geesunLeaveAdjust.do">

                <div id="scrollView" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
                    <div data-dojo-type="mui/panel/AccordionPanel">
                        <div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('geesun-leave:py.JiBenXinXi') }',icon:'mui-ul'">
                            <div class="muiFormContent">
                                <div class="muiDocFrame muiDocFrameExt">
                                    <div class="muiDocSubject">
                                        ${lfn:message('geesun-leave:table.geesunLeaveAdjust')}
                                    </div>
                                </div>
                                <table class="muiSimple" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveAdjust.docSubject')}
                                        </td>
                                        <td>
                                            <div id="_xform_docSubject" _xform_type="text">
                                                <xform:text property="docSubject" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveAdjust.docCreator')}
                                        </td>
                                        <td>
                                            <ui:person personId="${geesunLeaveAdjustForm.docCreatorId}" personName="${geesunLeaveAdjustForm.docCreatorName}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveAdjust.docDept')}
                                        </td>
                                        <td>
                                            <div id="_xform_docDeptId" _xform_type="address">
                                                <xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveAdjust.docCreateTime')}
                                        </td>
                                        <td>
                                            <c:out value="${geesunLeaveAdjustForm.docCreateTime}"></c:out>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveAdjust.fdStartTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdStartTime" _xform_type="text">
                                                <xform:text property="fdStartTime" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveAdjust.fdEndTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdEndTime" _xform_type="text">
                                                <xform:text property="fdEndTime" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-leave:geesunLeaveAdjust.fdLeaveHour')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdLeaveHour" _xform_type="text">
                                                <xform:text property="fdLeaveHour" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>

                        <kmss:auth requestURL="/geesun/leave/geesun_leave_adjust/geesunLeaveAdjust.do?method=edit&fdId=${param.fdId}">
                            <div data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'',label:'${lfn:message('button.edit') }',align:'',href:'/geesun/leave/geesun_leave_adjust/geesunLeaveAdjust.do?method=edit&fdId=${param.fdId}'"></div>
                        </kmss:auth>
                    </ul>
                </div>

                <script type="text/javascript">
                    require(["mui/form/ajax-form!geesunLeaveAdjustForm"]);
                </script>
            </html:form>
        </template:replace>
    </template:include>