<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@page import="com.landray.kmss.geesun.base.util.GeesunBaseUtil" %>
    
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
            <c:out value="${geesunBaseBxsjForm.fdTwoAccountCode} - " />
            <c:out value="${lfn:message('geesun-base:table.geesunBaseBxsj') }" />
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
                Com_IncludeFile("mobile_edit.js", "${LUI_ContextPath}/geesun/base/resource/js/", 'js', true);
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/base/geesun_base_bxsj/", 'js', true);
            </script>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do">

                <div id="scrollView" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
                    <div data-dojo-type="mui/panel/AccordionPanel">
                        <div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('geesun-base:py.JiBenXinXi') }',icon:'mui-ul'">
                            <div class="muiFormContent">
                                <div class="muiDocFrame muiDocFrameExt">
                                    <div class="muiDocSubject">
                                        ${lfn:message('geesun-base:table.geesunBaseBxsj')}
                                    </div>
                                </div>
                                <table class="muiSimple" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-base:geesunBaseBxsj.fdTwoAccountName')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdTwoAccountName" _xform_type="text">
                                                <xform:text property="fdTwoAccountName" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-base:geesunBaseBxsj.fdTwoAccountCode')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdTwoAccountCode" _xform_type="text">
                                                <xform:text property="fdTwoAccountCode" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-base:geesunBaseBxsj.fdRelateName')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdRelateName" _xform_type="text">
                                                <xform:text property="fdRelateName" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-base:geesunBaseBxsj.fdRelateCode')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdRelateCode" _xform_type="text">
                                                <xform:text property="fdRelateCode" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-base:geesunBaseBxsj.fdRelateType')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdRelateType" _xform_type="radio">
                                                <xform:radio property="fdRelateType" htmlElementProperties="id='fdRelateType'" showStatus="view" mobile="true">
                                                    <xform:enumsDataSource enumsType="geesun_base_type" />
                                                </xform:radio>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-base:geesunBaseBxsj.docCreator')}
                                        </td>
                                        <td>
                                            <ui:person personId="${geesunBaseBxsjForm.docCreatorId}" personName="${geesunBaseBxsjForm.docCreatorName}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-base:geesunBaseBxsj.docAlteror')}
                                        </td>
                                        <td>
                                            <ui:person personId="${geesunBaseBxsjForm.docAlterorId}" personName="${geesunBaseBxsjForm.docAlterorName}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-base:geesunBaseBxsj.docCreateTime')}
                                        </td>
                                        <td>
                                            <c:out value="${geesunBaseBxsjForm.docCreateTime}"></c:out>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-base:geesunBaseBxsj.docAlterTime')}
                                        </td>
                                        <td>
                                            <c:out value="${geesunBaseBxsjForm.docAlterTime}"></c:out>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>

                        <kmss:auth requestURL="/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do?method=edit&fdId=${param.fdId}">
                            <div data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'',label:'${lfn:message('button.edit') }',align:'',href:'/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do?method=edit&fdId=${param.fdId}'"></div>
                        </kmss:auth>
                    </ul>
                </div>

                <script type="text/javascript">
                    require(["mui/form/ajax-form!geesunBaseBxsjForm"]);
                </script>
            </html:form>
        </template:replace>
    </template:include>