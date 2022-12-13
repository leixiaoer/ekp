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
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/geesun/annual/geesun_annual_main/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/geesun/annual/resource/js/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
                /**************************************************
            	*员工选择
            	**************************************************/
            	function selectOwner(){
            		Dialog_Address(false,'fdOwnerId','fdOwnerName',';',ORG_TYPE_PERSON, afterOwnerSelect, null, false, true, '选择归属人');
            	}
            	/**************************************************
            	*主文档中员工选择之后执行函数
            	**************************************************/
            	function afterOwnerSelect(rtnVal){
            		if(rtnVal){
            			var obj = rtnVal.GetHashMapArray()[0];
            			if(obj){
            				var id=obj.id;
            				var data = new KMSSData();
            				data.AddBeanData('geesunAnnualMainService&ownerId='+id);
            				data.PutToField('fdOwnerDept', 'docDeptName');
            				data.PutToField('fdOwnerDeptId', 'docDeptId');
            				data.PutToField('fdLoginName', 'fdOwnerNo');
            			}
            		}
            	}
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${geesunAnnualMainForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('geesun-annual:table.geesunAnnualMain') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${geesunAnnualMainForm.fdOwnerNo} - " />
                    <c:out value="${ lfn:message('geesun-annual:table.geesunAnnualMain') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ geesunAnnualMainForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="if(validateDetail()){Com_Submit(document.geesunAnnualMainForm, 'update');}" />
                    </c:when>
                    <c:when test="${ geesunAnnualMainForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="if(validateDetail()){Com_Submit(document.geesunAnnualMainForm, 'save');}" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('geesun-annual:table.geesunAnnualMain') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/geesun/annual/geesun_annual_main/geesunAnnualMain.do">

                <ui:tabpage expand="false" var-navwidth="90%">
                    <ui:content title="${ lfn:message('geesun-annual:py.JiBenXinXi') }" expand="true">
                        <div class='lui_form_title_frame'>
                            <div class='lui_form_subject'>
                                ${lfn:message('geesun-annual:table.geesunAnnualMain')}
                            </div>
                            <div class='lui_form_baseinfo'>

                            </div>
                        </div>
                        <table class="tb_normal" width="100%">
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-annual:geesunAnnualMain.fdOwner')}
                                </td>
                                <td width="35%">
                                    <%-- 归属人--%>
                                    <div id="_xform_fdOwnerId" _xform_type="address">
                                    	<xform:address propertyId="fdOwnerId" propertyName="fdOwnerName" orgType="ORG_TYPE_PERSON" showStatus="edit" 
                                    		required="true" subject="${lfn:message('geesun-annual:geesunAnnualMain.fdOwner')}" style="width:95%;" />
                                    </div>
                                </td>
                                <%-- <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-annual:geesunAnnualMain.fdOwnerNo')}
                                </td>
                                <td width="35%">
                                    工号
                                    <div id="_xform_fdOwnerNo" _xform_type="text">
                                        <xform:text property="fdOwnerNo" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            	<td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-annual:geesunAnnualMain.docDept')}
                                </td>
                                <td width="35%">
                                    所属部门
                                    <div id="_xform_docDeptId" _xform_type="address">
                                        <xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td> --%>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-annual:geesunAnnualMain.fdTotal')}
                                </td>
                                <td width="35%">
                                    <%-- 年假总额度--%>
                                    <div id="_xform_fdTotal" _xform_type="text">
                                        <xform:text property="fdTotal" showStatus="edit" validators=" number min(0)" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-annual:geesunAnnualMain.docCreator')}
                                </td>
                                <td width="35%">
                                    <%-- 创建人--%>
                                    <div id="_xform_docCreatorId" _xform_type="address">
                                        <ui:person personId="${geesunAnnualMainForm.docCreatorId}" personName="${geesunAnnualMainForm.docCreatorName}" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('geesun-annual:geesunAnnualMain.docCreateTime')}
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
                <html:hidden property="fdLastTotal" />
                <html:hidden property="method_GET" />
            </html:form>
        </template:replace>

    </template:include>