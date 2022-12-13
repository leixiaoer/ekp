<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.geesun.org.util.GeesunOrgUtil" %>
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
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/org/geesun_org_record/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/geesun/org/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${geesunOrgRecordForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-org:table.geesunOrgRecord') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunOrgRecordForm.stext} - " />
                    <c:out value="${ lfn:message('geesun-org:table.geesunOrgRecord') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ geesunOrgRecordForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.geesunOrgRecordForm, 'update');}" />
                    </c:when>
                    <c:when test="${ geesunOrgRecordForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.geesunOrgRecordForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('geesun-org:table.geesunOrgRecord') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/org/geesun_org_record/geesunOrgRecord.do">

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
                                        <xform:select property="fdOrganType" htmlElementProperties="id='fdOrganType'" showStatus="edit">
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
                                        <xform:text property="stext" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.objid')}
                                </td>
                                <td width="35%">
                                    <%-- OBJID--%>
                                    <div id="_xform_objid" _xform_type="text">
                                        <xform:text property="objid" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="objidUp" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.priox')}
                                </td>
                                <td width="35%">
                                    <%-- PRIOX--%>
                                    <div id="_xform_priox" _xform_type="text">
                                        <xform:text property="priox" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="zhrOmJglx" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.zsfyx')}
                                </td>
                                <td width="35%">
                                    <%-- ZSFYX--%>
                                    <div id="_xform_zsfyx" _xform_type="text">
                                        <xform:text property="zsfyx" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="objidSUp" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.zzDatum')}
                                </td>
                                <td width="35%">
                                    <%-- ZZ_DATUM--%>
                                    <div id="_xform_zzDatum" _xform_type="text">
                                        <xform:text property="zzDatum" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="begda" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.nachn')}
                                </td>
                                <td width="35%">
                                    <%-- NACHN--%>
                                    <div id="_xform_nachn" _xform_type="text">
                                        <xform:text property="nachn" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="phone" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.gbdat')}
                                </td>
                                <td width="35%">
                                    <%-- GBDAT--%>
                                    <div id="_xform_gbdat" _xform_type="text">
                                        <xform:text property="gbdat" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="call" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.gender')}
                                </td>
                                <td width="35%">
                                    <%-- GENDER--%>
                                    <div id="_xform_gender" _xform_type="text">
                                        <xform:text property="gender" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="wxid" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.pernr')}
                                </td>
                                <td width="35%">
                                    <%-- PERNR--%>
                                    <div id="_xform_pernr" _xform_type="text">
                                        <xform:text property="pernr" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="plans02" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.email')}
                                </td>
                                <td width="35%">
                                    <%-- EMAIL--%>
                                    <div id="_xform_email" _xform_type="text">
                                        <xform:text property="email" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="zhrOmGwzd" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.plans01')}
                                </td>
                                <td width="35%">
                                    <%-- PLANS_01--%>
                                    <div id="_xform_plans01" _xform_type="text">
                                        <xform:text property="plans01" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="zhrOmGwzj" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.vnamc')}
                                </td>
                                <td width="35%">
                                    <%-- VNAMC--%>
                                    <div id="_xform_vnamc" _xform_type="text">
                                        <xform:text property="vnamc" showStatus="edit" style="width:95%;" />
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
                                        <xform:text property="orgeh" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-org:geesunOrgRecord.icnum')}
                                </td>
                                <td width="35%">
                                    <%-- ICNUM--%>
                                    <div id="_xform_icnum" _xform_type="text">
                                        <xform:text property="icnum" showStatus="edit" style="width:95%;" />
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
                <html:hidden property="fdId" />


                <html:hidden property="method_GET" />
            </html:form>
        </template:replace>


    </template:include>
