<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.geesun.annual.util.GeesunAnnualUtil" %>
    
        <%
            pageContext.setAttribute("currentPerson", UserUtil.getKMSSUser().getUserId());
        pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
    <template:include ref="default.view">
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
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>
        <template:replace name="title">
            <c:out value="${geesunAnnualMainForm.fdOwnerNo} - " />
            <c:out value="${ lfn:message('geesun-annual:table.geesunAnnualMain') }" />
        </template:replace>
        <template:replace name="toolbar">
            <script>
                function deleteDoc(delUrl) {
                    seajs.use(['lui/dialog'], function(dialog) {
                        dialog.confirm('${ lfn:message("page.comfirmDelete") }', function(isOk) {
                            if(isOk) {
                                Com_OpenWindow(delUrl, '_self');
                            }
                        });
                    });
                }

                function openWindowViaDynamicForm(popurl, params, target) {
                    var form = document.createElement('form');
                    if(form) {
                        try {
                            target = !target ? '_blank' : target;
                            form.style = "display:none;";
                            form.method = 'post';
                            form.action = popurl;
                            form.target = target;
                            if(params) {
                                for(var key in params) {
                                    var
                                    v = params[key];
                                    var vt = typeof
                                    v;
                                    var hdn = document.createElement('input');
                                    hdn.type = 'hidden';
                                    hdn.name = key;
                                    if(vt == 'string' || vt == 'boolean' || vt == 'number') {
                                        hdn.value =
                                        v +'';
                                    } else {
                                        if($.isArray(
                                            v)) {
                                            hdn.value =
                                            v.join(';');
                                        } else {
                                            hdn.value = toString(
                                                v);
                                        }
                                    }
                                    form.appendChild(hdn);
                                }
                            }
                            document.body.appendChild(form);
                            form.submit();
                        } finally {
                            document.body.removeChild(form);
                        }
                    }
                }

                function doCustomOpt(fdId, optCode) {
                    if(!fdId || !optCode) {
                        return;
                    }

                    if(viewOption.customOpts && viewOption.customOpts[optCode]) {
                        var param = {
                            "List_Selected_Count": 1
                        };
                        var argsObject = viewOption.customOpts[optCode];
                        if(argsObject.popup == 'true') {
                            var popurl = viewOption.contextPath + argsObject.popupUrl + '&fdId=' + fdId;
                            for(var arg in argsObject) {
                                param[arg] = argsObject[arg];
                            }
                            openWindowViaDynamicForm(popurl, param, '_self');
                            return;
                        }
                        var optAction = viewOption.contextPath + viewOption.basePath + '?method=' + optCode + '&fdId=' + fdId;
                        Com_OpenWindow(optAction, '_self');
                    }
                }
                window.doCustomOpt = doCustomOpt;
                var viewOption = {
                    contextPath: '${LUI_ContextPath}',
                    basePath: '/geesun/annual/geesun_annual_main/geesunAnnualMain.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <%-- <kmss:auth requestURL="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('geesunAnnualMain.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth> --%>
                <!--delete-->
                <kmss:auth requestURL="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('geesunAnnualMain.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('geesun-annual:table.geesunAnnualMain') }" href="/geesun/annual/geesun_annual_main/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

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
                            <td colspan="3">
                                <%-- 归属人--%>
                                <div id="_xform_fdOwnerId" _xform_type="address">
                                    <xform:address propertyId="fdOwnerId" propertyName="fdOwnerName" orgType="ORG_TYPE_PERSON" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdOwnerNo')}
                            </td>
                            <td width="35%">
                                <%-- 工号--%>
                                <div id="_xform_fdOwnerNo" _xform_type="text">
                                    <xform:text property="fdOwnerNo" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.docDept')}
                            </td>
                            <td width="35%">
                                <%-- 所属部门--%>
                                <div id="_xform_docDeptId" _xform_type="address">
                                    <xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdLastResetDate')}
                            </td>
                            <td width="35%">
                                <%-- 上一次年假额度重置时间--%>
                                <div id="_xform_fdLastResetDate" _xform_type="datetime">
                                    <xform:datetime property="fdLastResetDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                        	<td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdNextResetDate')}
                            </td>
                            <td width="35%">
                                <%-- 下一次年假额度重置时间--%>
                                <div id="_xform_fdNextResetDate" _xform_type="datetime">
                                    <xform:datetime property="fdNextResetDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdTotal')}
                            </td>
                            <td width="35%">
                                <%-- 年假总额度--%>
                                <div id="_xform_fdTotal" _xform_type="text">
                                    <xform:text property="fdTotal" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdRemain')}
                            </td>
                            <td width="35%">
                                <%-- 年假剩余额度--%>
                                <div id="_xform_fdRemain" _xform_type="text">
                                    <xform:text property="fdRemain" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdFrozen')}
                            </td>
                            <td width="35%">
                                <%-- 年假冻结额度--%>
                                <div id="_xform_fdFrozen" _xform_type="text">
                                    <xform:text property="fdFrozen" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdUsed')}
                            </td>
                            <td width="35%">
                                <%-- 年假已用额度--%>
                                <div id="_xform_fdUsed" _xform_type="text">
                                    <xform:text property="fdUsed" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdLastTotal')}
                            </td>
                            <td width="35%">
                                <%-- 上一年度总额度--%>
                                <div id="_xform_fdLastTotal" _xform_type="text">
                                    <xform:text property="fdLastTotal" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdLastRemain')}
                            </td>
                            <td width="35%">
                                <%-- 上一年度剩余额度--%>
                                <div id="_xform_fdLastRemain" _xform_type="text">
                                    <xform:text property="fdLastRemain" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdLastFrozen')}
                            </td>
                            <td width="35%">
                                <%-- 上一年度冻结额度--%>
                                <div id="_xform_fdLastFrozen" _xform_type="text">
                                    <xform:text property="fdLastFrozen" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('geesun-annual:geesunAnnualMain.fdLastUsed')}
                            </td>
                            <td width="35%">
                                <%-- 上一年度已用额度--%>
                                <div id="_xform_fdLastUsed" _xform_type="text">
                                    <xform:text property="fdLastUsed" showStatus="view" style="width:95%;" />
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
				<ui:content title="${ lfn:message('geesun-annual:geesunAnnualMain.alterRecord') }${alterRecordInfoCount}" cfg-disable="false">
					<list:listview channel="mailInfo1">
						<ui:source type="AjaxJson">
							{"url":"/geesun/annual/geesun_annual_alter/geesunAnnualAlter.do?method=listdata&fdModelName=com.landray.kmss.geesun.annual.model.GeesunAnnualMain&modelId=${geesunAnnualMainForm.fdId}"}
						</ui:source>
						<list:colTable isDefault="true" layout="sys.ui.listview.listtable"  cfg-norecodeLayout="simple" 
						  rowHref="/geesun/annual/geesun_annual_alter/geesunAnnualAlter.do?method=view&fdId=!{fdId}">
							<list:col-auto props="fdFieldName;fdModelId;fdSource;docCreator.name;docCreateTime"></list:col-auto>
						</list:colTable>						
					</list:listview>
					<div style="height: 15px;"></div>
					<list:paging channel="mailInfo1" layout="sys.ui.paging.simple"></list:paging>
				</ui:content>
				<ui:content title="${ lfn:message('geesun-annual:geesunAnnualMain.usingRecord') }${usingRecordInfoCount}" cfg-disable="false">
					<list:listview channel="usingInfo1">
						<ui:source type="AjaxJson">
							{"url":"/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=listdata&type=using&fdType=leave&modelId=${geesunAnnualMainForm.fdId}"}
						</ui:source>
						<list:colTable isDefault="true" layout="sys.ui.listview.listtable"  cfg-norecodeLayout="simple" 
						  rowHref="/km/review/km_review_main/kmReviewMain.do?method=view&fdId=!{fdModelId}">
							<list:col-auto props="docSubject;fdType;fdUse;docCreator.name;docCreateTime"></list:col-auto>
						</list:colTable>						
					</list:listview>
					<div style="height: 15px;"></div>
					<list:paging channel="usingInfo1" layout="sys.ui.paging.simple"></list:paging>
				</ui:content>
				<ui:content title="${ lfn:message('geesun-annual:geesunAnnualMain.usedRecord') }${usedRecordInfoCount}" cfg-disable="false">
					<list:listview channel="usedInfo2">
						<ui:source type="AjaxJson">
							{"url":"/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=listdata&type=used&fdType=leave&modelId=${geesunAnnualMainForm.fdId}"}
						</ui:source>
						<list:colTable isDefault="true" layout="sys.ui.listview.listtable"  cfg-norecodeLayout="simple" 
						  rowHref="/km/review/km_review_main/kmReviewMain.do?method=view&fdId=!{fdModelId}">
							<list:col-auto props="docSubject;fdType;fdUse;docCreator.name;docCreateTime"></list:col-auto>
						</list:colTable>						
					</list:listview>
					<div style="height: 15px;"></div>
					<list:paging channel="usedInfo2" layout="sys.ui.paging.simple"></list:paging>
				</ui:content>
				<ui:content title="${ lfn:message('geesun-annual:geesunAnnualMain.resumeRecord') }${resumeRecordInfoCount}" cfg-disable="false">
					<list:listview channel="usedInfo3">
						<ui:source type="AjaxJson">
							{"url":"/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=listdata&fdType=resume&modelId=${geesunAnnualMainForm.fdId}"}
						</ui:source>
						<list:colTable isDefault="true" layout="sys.ui.listview.listtable"  cfg-norecodeLayout="simple" 
						  rowHref="/km/review/km_review_main/kmReviewMain.do?method=view&fdId=!{fdModelId}">
							<list:col-auto props="docSubject;fdType;fdUse;docCreator.name;docCreateTime"></list:col-auto>
						</list:colTable>						
					</list:listview>
					<div style="height: 15px;"></div>
					<list:paging channel="usedInfo3" layout="sys.ui.paging.simple"></list:paging>
				</ui:content>
            </ui:tabpage>
        </template:replace>

    </template:include>