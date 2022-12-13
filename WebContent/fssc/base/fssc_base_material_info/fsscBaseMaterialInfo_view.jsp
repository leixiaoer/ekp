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
    	.inputsgl[readonly], .tb_normal .inputsgl[readonly] {
      		border: 0px;
      		color: #868686
    	}
    
</style>
<script type="text/javascript">
    if("${fsscBaseMaterialInfoForm.fdName}" != "") {
        window.document.title = "${fsscBaseMaterialInfoForm.fdName} - ${ lfn:message('fssc-base:table.fsscBaseMaterialInfo') }";
    }
    Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
</script>
<div id="optBarDiv">

    <kmss:auth requestURL="/fssc/base/fssc_base_material_info/fsscBaseMaterialInfo.do?method=edit&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscBaseMaterialInfo.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
    </kmss:auth>
    <kmss:auth requestURL="/fssc/base/fssc_base_material_info/fsscBaseMaterialInfo.do?method=delete&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.delete')}" onclick="if(!confirmDelete())return;Com_OpenWindow('fsscBaseMaterialInfo.do?method=delete&fdId=${param.fdId}','_self');" />
    </kmss:auth>
    <input type="button" value="${lfn:message('button.close')}" onclick="Com_CloseWindow();" />
</div>
<p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseMaterialInfo') }</p>
<center>

    <div style="width:95%;">
        <table class="tb_normal" width="100%">
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdName')}
                </td>
                <td colspan="3" width="85.0%">
                    <%-- 物资名称--%>
                    <div id="_xform_fdName" _xform_type="text">
                        <xform:text property="fdName" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdCode')}
                </td>
                <td width="35%">
                    <%-- 物资编码--%>
                    <div id="_xform_fdCode" _xform_type="text">
                        <xform:text property="fdCode" showStatus="view" style="width:95%;" />
                    </div>
                </td>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdType')}
                </td>
                <td width="35%">
                    <%-- 物资类别--%>
                    <div id="_xform_fdTypeId" _xform_type="dialog">
                        <xform:dialog propertyId="fdTypeId" propertyName="fdTypeName" showStatus="view" style="width:95%;">
                            dialogSelect(false,'fssc_base_material_type_selectType','fdTypeId','fdTypeName');
                        </xform:dialog>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdUnit')}
                </td>
                <td width="35%">
                    <%-- 单位--%>
                    <div id="_xform_fdUnit" _xform_type="text">
                        <xform:text property="fdUnit" showStatus="view" style="width:95%;" />
                    </div>
                </td>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdPrice')}
                </td>
                <td width="35%">
                    <%-- 预估单价--%>
                    <div id="_xform_fdPrice" _xform_type="text">
                        <xform:text property="fdPrice" showStatus="view" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdStatus')}
                </td>
                <td width="35%">
                    <%-- 物资状态--%>
                    <div id="_xform_fdStatus" _xform_type="select">
                        <xform:select property="fdStatus" htmlElementProperties="id='fdStatus'" showStatus="view">
                            <xform:enumsDataSource enumsType="fssc_base_material_status" />
                        </xform:select>
                    </div>
                </td>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdIsInventory')}
                </td>
                <td width="35%">
                    <%-- 是否需要进行盘点--%>
                    <div id="_xform_fdIsInventory" _xform_type="radio">
                        <xform:radio property="fdIsInventory" htmlElementProperties="id='fdIsInventory'" showStatus="view">
                            <xform:enumsDataSource enumsType="common_yesno" />
                        </xform:radio>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.fdIsAvailable')}
                </td>
                <td width="35%" colspan="3">
                    <%-- 是否有效--%>
                    <div id="_xform_fdIsAvailable" _xform_type="radio">
                        <xform:radio property="fdIsAvailable" htmlElementProperties="id='fdIsAvailable'" showStatus="edit">
                            <xform:enumsDataSource enumsType="common_yesno" />
                        </xform:radio>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.docCreator')}
                </td>
                <td width="35%">
                    <%-- 创建人--%>
                    <div id="_xform_docCreatorId" _xform_type="address">
                        <ui:person personId="${fsscBaseMaterialInfoForm.docCreatorId}" personName="${fsscBaseMaterialInfoForm.docCreatorName}" />
                    </div>
                </td>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.docCreateTime')}
                </td>
                <td width="35%">
                    <%-- 创建时间--%>
                    <div id="_xform_docCreateTime" _xform_type="datetime">
                        <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.docAlteror')}
                </td>
                <td width="35%">
                    <%-- 修改人--%>
                    <div id="_xform_docAlterorId" _xform_type="address">
                        <ui:person personId="${fsscBaseMaterialInfoForm.docAlterorId}" personName="${fsscBaseMaterialInfoForm.docAlterorName}" />
                    </div>
                </td>
                <td class="td_normal_title" width="15%">
                    ${lfn:message('fssc-base:fsscBaseMaterialInfo.docAlterTime')}
                </td>
                <td width="35%">
                    <%-- 更新时间--%>
                    <div id="_xform_docAlterTime" _xform_type="datetime">
                        <xform:datetime property="docAlterTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</center>
<script>
    var formInitData = {

    };

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
        basePath: '/fssc/base/fssc_base_material_info/fsscBaseMaterialInfo.do',
        customOpts: {

            ____fork__: 0
        }
    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
</script>
<%@ include file="/resource/jsp/view_down.jsp" %>