<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@page import="com.landray.kmss.geesun.annual.util.GeesunAnnualUtil" %>
    
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
            <c:out value="${geesunAnnualMainForm.fdOwnerNo} - " />
            <c:out value="${lfn:message('geesun-annual:table.geesunAnnualMain') }" />
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
                Com_IncludeFile("mobile_edit.js", "${LUI_ContextPath}/geesun/annual/resource/js/", 'js', true);
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/annual/geesun_annual_main/", 'js', true);
            </script>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/annual/geesun_annual_main/geesunAnnualMain.do">

                <div id="scrollView" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
                    <div data-dojo-type="mui/panel/AccordionPanel">
                        <div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('geesun-annual:py.JiBenXinXi') }',icon:'mui-ul'">
                            <div class="muiFormContent">
                                <div class="muiDocFrame muiDocFrameExt">
                                    <div class="muiDocSubject">
                                        ${lfn:message('geesun-annual:table.geesunAnnualMain')}
                                    </div>
                                </div>
                                <table class="muiSimple" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdOwner')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdOwnerId" _xform_type="address">
                                                <xform:address propertyId="fdOwnerId" propertyName="fdOwnerName" orgType="ORG_TYPE_PERSON" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdOwnerNo')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdOwnerNo" _xform_type="text">
                                                <xform:text property="fdOwnerNo" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.docDept')}
                                        </td>
                                        <td>
                                            <div id="_xform_docDeptId" _xform_type="address">
                                                <xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdTotal')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdTotal" _xform_type="text">
                                                <xform:text property="fdTotal" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdRemain')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdRemain" _xform_type="text">
                                                <xform:text property="fdRemain" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdFrozen')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdFrozen" _xform_type="text">
                                                <xform:text property="fdFrozen" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdUsed')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdUsed" _xform_type="text">
                                                <xform:text property="fdUsed" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.docCreator')}
                                        </td>
                                        <td>
                                            <ui:person personId="${geesunAnnualMainForm.docCreatorId}" personName="${geesunAnnualMainForm.docCreatorName}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.docCreateTime')}
                                        </td>
                                        <td>
                                            <c:out value="${geesunAnnualMainForm.docCreateTime}"></c:out>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>

                        <kmss:auth requestURL="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=edit&fdId=${param.fdId}">
                            <div data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'',label:'${lfn:message('button.edit') }',align:'',href:'/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=edit&fdId=${param.fdId}'"></div>
                        </kmss:auth>
                    </ul>
                </div>

                <script type="text/javascript">
                    require(["mui/form/ajax-form!geesunAnnualMainForm"]);
                </script>
            </html:form>
        </template:replace>
    </template:include>