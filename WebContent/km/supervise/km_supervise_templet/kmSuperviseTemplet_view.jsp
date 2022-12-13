<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/resource/jsp/view_top.jsp" %>
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
    
</style>
<div id="optBarDiv">

    <kmss:auth requestURL="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=edit&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.edit')}" onclick="Com_OpenWindow('kmSuperviseTemplet.do?method=edit&fdId=${param.fdId}&fdKey=${param.fdKey}','_self');" order="2" />
    </kmss:auth>
    <kmss:auth requestURL="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=clone&cloneModelId=${param.fdId}">
		<input type="button" value="${lfn:message('km-supervise:kmSuperviseTemplet.button.copy')}" onclick="Com_OpenWindow('kmSuperviseTemplet.do?method=clone&cloneModelId=${param.fdId}&fdKey=${param.fdKey}','_blank');">
	</kmss:auth>
    <kmss:auth requestURL="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=delete&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.delete')}" onclick="if(!confirmDelete())return;Com_OpenWindow('kmSuperviseTemplet.do?method=delete&fdId=${param.fdId}','_self');" />
    </kmss:auth>
    <input type="button" value="${lfn:message('button.close')}" onclick="Com_CloseWindow();" />
</div>
<p class="txttitle">${ lfn:message('km-supervise:table.kmSuperviseTemplet') }</p>
<center>

    <table class="tb_normal" id="Label_Tabel" width="95%">
        <tr LKS_LabelName="${ lfn:message('km-supervise:py.JiBenXinXi') }">
            <td>
                <table class="tb_normal" width="100%">
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('km-supervise:kmSuperviseTemplet.fdName')}
                        </td>
                        <td width="35%">
                            <div id="_xform_fdName" _xform_type="text">
                                <xform:text property="fdName" showStatus="view" style="width:95%;" />
                            </div>
                        </td>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('km-supervise:kmSuperviseTemplet.docCategory')}
                        </td>
                        <td width="35%">
                            <div id="_xform_docCategoryId" _xform_type="dialog">
                                <xform:dialog propertyId="docCategoryId" propertyName="docCategoryName" showStatus="view" style="width:95%;">
                                    Dialog_Category('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','docCategoryId','docCategoryName');
                                </xform:dialog>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('km-supervise:kmSuperviseTemplet.fdIsAvailable')}
                        </td>
                        <td width="35%">
                            <div id="_xform_fdIsAvailable" _xform_type="radio">
                                <xform:radio property="fdIsAvailable" showStatus="view">
                                    <xform:enumsDataSource enumsType="common_yesno" />
                                </xform:radio>
                            </div>
                        </td>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('km-supervise:kmSuperviseTemplet.fdOrder')}
                        </td>
                        <td width="35%">
                            <div id="_xform_fdOrder" _xform_type="text">
                                <xform:text property="fdOrder" showStatus="view" style="width:95%;" />
                            </div>
                        </td>
                    </tr>
                    <c:if test="${'10' eq kmSuperviseTempletForm.fdType }">
                        <tr>
                        	<td class="td_normal_title" width="15%">
                        		<bean:message key="table.kmSuperviseTemplet.change" bundle="km-supervise"/>
                        	</td>
                        	<td colspan="3" width="85.0%">
                        		<xform:dialog propertyId="fdChangeId" propertyName="fdChangeName"  showStatus="view" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.make.plan')}" style="width:95%;">
                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdChangeId','fdChangeName',null,null,null,null,null,null,null,'70');
                                </xform:dialog>
                        	</td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="15%">
                        		<bean:message key="table.kmSuperviseTemplet.make.plan" bundle="km-supervise"/>
                        	</td>
                        	<td colspan="3" width="85.0%">
                        		<xform:dialog propertyId="fdMakePlanId" propertyName="fdMakePlanName" showStatus="view" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.make.plan')}" style="width:95%;">
                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdMakePlanId','fdMakePlanName',null,null,null,null,null,null,null,'20');
                                </xform:dialog>
                        	</td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="15%">
                        		<bean:message key="table.kmSuperviseTemplet.feedback" bundle="km-supervise"/>
                        	</td>
                        	<td colspan="3" width="85.0%">
                        		<xform:dialog propertyId="fdFeedbackId" propertyName="fdFeedbackName" showStatus="view" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.feedback')}" style="width:95%;">
                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdFeedbackId','fdFeedbackName',null,null,null,null,null,null,null,'30');
                                </xform:dialog>
                        	</td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="15%">
                        		<bean:message key="table.kmSuperviseTemplet.stage" bundle="km-supervise"/>
                        	</td>
                        	<td colspan="3" width="85.0%">
                        		<xform:dialog propertyId="fdStageId" propertyName="fdStageName" showStatus="view" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.stage')}" style="width:95%;">
                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdStageId','fdStageName',null,null,null,null,null,null,null,'40');
                                </xform:dialog>
                        	</td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="15%">
                        		<bean:message key="table.kmSuperviseTemplet.termination" bundle="km-supervise"/>
                        	</td>
                        	<td colspan="3" width="85.0%">
                        		<xform:dialog propertyId="fdTerminationId" propertyName="fdTerminationName" showStatus="view" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.termination')}" style="width:95%;">
                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdTerminationId','fdTerminationName',null,null,null,null,null,null,null,'50');
                                </xform:dialog>
                        	</td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="15%">
                        		<bean:message key="table.kmSuperviseTemplet.setup" bundle="km-supervise"/>
                        	</td>
                        	<td colspan="3" width="85.0%">
                        		<xform:dialog propertyId="fdSetupId" propertyName="fdSetupName" showStatus="view" subject="${lfn:message('km-supervise:table.kmSuperviseTemplet.setup')}" style="width:95%;">
                                    Dialog_GlobalCategory('com.landray.kmss.km.supervise.model.KmSuperviseTemplet','fdSetupId','fdSetupName',null,null,null,null,null,null,null,'60');
                                </xform:dialog>
                        	</td>
                        </tr>
                    </c:if>
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('km-supervise:kmSuperviseTemplet.authReaders')}
                        </td>
                        <td colspan="3" width="85.0%">
                            <div id="_xform_authReaderIds" _xform_type="address">
                                <xform:address propertyId="authReaderIds" propertyName="authReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="view" textarea="true" style="width:95%;" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('km-supervise:kmSuperviseTemplet.authEditors')}
                        </td>
                        <td colspan="3" width="85.0%">
                            <div id="_xform_authEditorIds" _xform_type="address">
                                <xform:address propertyId="authEditorIds" propertyName="authEditorNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="view" textarea="true" style="width:95%;" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('km-supervise:kmSuperviseTemplet.docCreator')}
                        </td>
                        <td width="35%">
                            <div id="_xform_docCreatorId" _xform_type="address">
                                ${kmSuperviseTempletForm.docCreatorName}
                            </div>
                        </td>
                        <td class="td_normal_title" width="15%">
                            ${lfn:message('km-supervise:kmSuperviseTemplet.docCreateTime')}
                        </td>
                        <td width="35%">
                            <div id="_xform_docCreateTime" _xform_type="datetime">
                                <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
		<!-- 督办内容 -->
		<c:if test="${'10' eq kmSuperviseTempletForm.fdType }">
	        <c:if test="${kmSuperviseTempletForm.docUseXform == 'false'}">
	            <tr LKS_LabelName="${lfn:message('km-supervise:kmSuperviseMain.fdContent')}">
	                <td>
	                    <table class="tb_normal" width=100%>
	                        <tr>
	                            <td width="15%" class="td_normal_title" valign="top">
	                                ${lfn:message('sys-xform:sysFormTemplate.fdMode')}
	                            </td>
	                            <td width="85%">
	                                ${lfn:message('sys-xform:sysFormTemplate.fdTemplateType.nouse')}
	                            </td>
	                        </tr>
	                        <tr>
	                            <td colspan="4">
	                                <xform:rtf property="docXform" toolbarSet="Default" />
	                            </td>
	                        </tr>
	                    </table>
	                </td>
	            </tr>
	        </c:if>
	        
	        
	        <c:if test="${kmSuperviseTempletForm.docUseXform == 'true' || empty kmSuperviseTempletForm.docUseXform}">
	            <tr LKS_LabelName="${lfn:message('km-supervise:kmSuperviseMain.fdContent')}" style="display:none">
	                <td>
	                    <c:import url="/sys/xform/include/sysFormTemplate_view.jsp" charEncoding="UTF-8">
	                        <c:param name="formName" value="kmSuperviseTempletForm" />
	                        <c:param name="fdKey" value="kmSuperviseMain" />
	                        <c:param name="fdMainModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
	                        <c:param name="useLabel" value="false" />
	                    </c:import>
	                </td>
	            </tr>
	        </c:if>
		</c:if>
		<c:import url="/sys/lbpmservice/include/sysLbpmTemplate_view.jsp" charEncoding="UTF-8">
            <c:param name="formName" value="kmSuperviseTempletForm" />
            <c:param name="fdKey" value="${param.fdKey }" />
            <c:param name="messageKey" value="km-supervise:py.LiuChengChuLi" />
        </c:import>
		<!-- 编号规则 -->
		<c:if test="${'10' eq kmSuperviseTempletForm.fdType }">
	        <c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
	            <c:param name="formName" value="kmSuperviseTempletForm" />
	            <c:param name="modelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
	            <c:param name="messageKey" value="km-supervise:py.BianHaoGuiZe" />
	        </c:import>
	        
	        <tr LKS_LabelName="${ lfn:message('km-supervise:py.MoRenQuanXian') }">
	            <td>
	                <table class="tb_normal" width=100%>
	                    <c:import url="/sys/right/tmp_right_view.jsp" charEncoding="UTF-8">
	                        <c:param name="formName" value="kmSuperviseTempletForm" />
	                        <c:param name="moduleModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseTemplet" />
	                    </c:import>
	                </table>
	            </td>
	        </tr>
		</c:if>

        

    </table>
</center>
<script>
    function confirmDelete(msg) {
        return confirm('${ lfn:message("page.comfirmDelete") }');
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
        basePath: '/km/supervise/km_supervise_templet/kmSuperviseTemplet.do',
        customOpts: {

            ____fork__: 0
        }
    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
</script>
<%@ include file="/resource/jsp/view_down.jsp" %>