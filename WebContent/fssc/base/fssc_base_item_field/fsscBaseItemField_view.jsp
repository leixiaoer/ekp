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
<div id="optBarDiv">

    <kmss:auth requestURL="/fssc/base/fssc_base_item_field/fsscBaseItemField.do?method=edit&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscBaseItemField.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
    </kmss:auth>
    <kmss:auth requestURL="/fssc/base/fssc_base_item_field/fsscBaseItemField.do?method=delete&fdId=${param.fdId}">
        <input type="button" value="${lfn:message('button.delete')}" onclick="if(!confirmDelete())return;Com_OpenWindow('fsscBaseItemField.do?method=delete&fdId=${param.fdId}','_self');" />
    </kmss:auth>
    <input type="button" value="${lfn:message('button.close')}" onclick="Com_CloseWindow();" />
</div>
<p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseItemField') }</p>
<center>

    <div style="width:95%;">
        <table class="tb_normal" width="100%">
            <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemField.fdCompany')}
                    </td>
                    <td colspan="3" width="85.0%">
                        ${fsscBaseItemFieldForm.fdCompanyName }
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemField.fdItems')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdItemIds" _xform_type="dialog">
                            <xform:dialog required="true" propertyId="fdItemIds" propertyName="fdItemNames" style="width:95%;">
                                dialogSelect(true,'fssc_base_expense_item_fdParent','fdItemIds','fdItemNames');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemField.fdFields')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdFields" _xform_type="radio">
                            <xform:checkbox property="fdFields">
                                <xform:enumsDataSource enumsType="fssc_base_item_field" />
                            </xform:checkbox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('fssc-base:fsscBaseItemField.fdReservedField')}
                    </td>
                    <td colspan="3" width="85.0%">
                        <div id="_xform_fdFieldOne" _xform_type="text">
                        	<span>${lfn:message('fssc-base:fsscBaseItemField.fdFieldOne')}：</span>
                            <xform:text property="fdFieldOne" style="width:10%;" />
                            <xform:checkbox property="fdRequiredOne">
                                <xform:simpleDataSource value="true">${lfn:message('fssc-base:fsscBaseItemField.fdRequired')}</xform:simpleDataSource>
                            </xform:checkbox>
                        </div>
                        <div id="_xform_fdFieldTwo" _xform_type="text">
                            <span>${lfn:message('fssc-base:fsscBaseItemField.fdFieldTwo')}：</span>
                            <xform:text property="fdFieldTwo" style="width:10%;" />
                            <xform:checkbox property="fdRequiredTwo">
                                <xform:simpleDataSource value="true">${lfn:message('fssc-base:fsscBaseItemField.fdRequired')}</xform:simpleDataSource>
                            </xform:checkbox>
                        </div>
                        <div id="_xform_fdFieldThree" _xform_type="text">
                            <span>${lfn:message('fssc-base:fsscBaseItemField.fdFiledThree')}：</span>
                            <xform:text property="fdFieldThree" style="width:10%;" />
                            <xform:checkbox property="fdRequiredThree">
                                <xform:simpleDataSource value="true">${lfn:message('fssc-base:fsscBaseItemField.fdRequired')}</xform:simpleDataSource>
                            </xform:checkbox>
                         </div>
                        <div id="_xform_fdFieldFour" _xform_type="text">
                            <span>${lfn:message('fssc-base:fsscBaseItemField.fdFieldFour')}：</span>
                            <xform:text property="fdFieldFour" style="width:10%;" />
                            <xform:checkbox property="fdRequiredFour">
                                <xform:simpleDataSource value="true">${lfn:message('fssc-base:fsscBaseItemField.fdRequired')}</xform:simpleDataSource>
                            </xform:checkbox>
                        </div>
                        <div id="_xform_fdFieldFive" _xform_type="text">
                            <span>${lfn:message('fssc-base:fsscBaseItemField.fdFieldFive')}：</span>
                            <xform:text property="fdFieldFive" style="width:10%;" />
                            <xform:checkbox property="fdRequiredFive">
                                <xform:simpleDataSource value="true">${lfn:message('fssc-base:fsscBaseItemField.fdRequired')}</xform:simpleDataSource>
                            </xform:checkbox>
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
        basePath: '/fssc/base/fssc_base_item_field/fsscBaseItemField.do',
        customOpts: {

            ____fork__: 0
        }
    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
</script>
<%@ include file="/resource/jsp/view_down.jsp" %>