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
                <c:when test="${geesunAnnualMainForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-annual:table.geesunAnnualMain') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunAnnualMainForm.fdOwnerNo} - " />
                    <c:out value="${lfn:message('geesun-annual:table.geesunAnnualMain') }" />
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
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/annual/geesun_annual_main/", 'js', true);
                Com_IncludeFile("mobile_edit.js", "${LUI_ContextPath}/geesun/annual/resource/js/", 'js', true);
            </script>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=save">

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
                                                <xform:address propertyId="fdOwnerId" propertyName="fdOwnerName" orgType="ORG_TYPE_PERSON" showStatus="edit" required="true" subject="${lfn:message('geesun-annual:geesunAnnualMain.fdOwner')}" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdOwnerNo')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdOwnerNo" _xform_type="text">
                                                <xform:text property="fdOwnerNo" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.docDept')}
                                        </td>
                                        <td>
                                            <div id="_xform_docDeptId" _xform_type="address">
                                                <xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="edit" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdTotal')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdTotal" _xform_type="text">
                                                <xform:text property="fdTotal" showStatus="edit" validators=" number min(0)" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdRemain')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdRemain" _xform_type="text">
                                                <xform:text property="fdRemain" showStatus="edit" validators=" number min(0)" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdFrozen')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdFrozen" _xform_type="text">
                                                <xform:text property="fdFrozen" showStatus="edit" validators=" number min(0)" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.fdUsed')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdUsed" _xform_type="text">
                                                <xform:text property="fdUsed" showStatus="edit" validators=" number min(0)" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.docCreator')}
                                        </td>
                                        <td>
                                            <div id="_xform_docCreatorId" _xform_type="address">
                                                <ui:person personId="${geesunAnnualMainForm.docCreatorId}" personName="${geesunAnnualMainForm.docCreatorName}" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('geesun-annual:geesunAnnualMain.docCreateTime')}
                                        </td>
                                        <td>
                                            <div id="_xform_docCreateTime" _xform_type="datetime">
                                                <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" mobile="true" style="width:95%;" />
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