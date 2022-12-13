<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
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
		    
		</style>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<kmss:auth requestURL="/km/supervise/km_supervise_back/kmSuperviseBack.do?method=edit&fdId=${param.fdId}">
        		<ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('kmSuperviseBack.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
    		</kmss:auth>
		    <kmss:auth requestURL="/km/supervise/km_supervise_back/kmSuperviseBack.do?method=delete&fdId=${param.fdId}">
		        <ui:button text="${lfn:message('button.delete')}" onclick="if(!confirmDelete())return;Com_OpenWindow('kmSuperviseBack.do?method=delete&fdId=${param.fdId}','_self');" />
		    </kmss:auth>
    		<ui:button text="${lfn:message('button.close')}" onclick="Com_CloseWindow();" />
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<ui:tabpage>
			<p class="txttitle">${ lfn:message('km-supervise:table.kmSuperviseBack') }</p>
			<ui:content title="${ lfn:message('km-supervise:py.DuBanFanKui') }">
				<table class="tb_normal" width="100%">
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('km-supervise:kmSuperviseBack.fdPerson')}
		                </td>
		                <td width="35%">
		                    <div id="_xform_fdPersonId" _xform_type="address">
		                        <xform:address propertyId="fdPersonId" propertyName="fdPersonName" orgType="ORG_TYPE_ALL" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('km-supervise:kmSuperviseMain.fdUnit')}
		                </td>
		                <td width="35%">
		                    <div id="_xform_fdUnitId" _xform_type="address">
		                        <xform:address propertyId="fdUnitId" propertyName="fdUnitName" orgType="ORG_TYPE_ALL" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('km-supervise:kmSuperviseBack.fdProgress')}
		                </td>
		                <td width="35%">
		                    <div id="_xform_fdProgress" _xform_type="text">
		                        <xform:text property="fdProgress" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('km-supervise:kmSuperviseBack.fdFeedbackTime')}
		                </td>
		                <td width="35%">
		                    <div id="_xform_fdFeedbackTime" _xform_type="datetime">
		                        <xform:datetime property="fdFeedbackTime" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('km-supervise:kmSuperviseBack.fdStartTime')}
		                </td>
		                <td width="35%">
		                    <div id="_xform_fdStartTime" _xform_type="datetime">
		                        <xform:datetime property="fdStartTime" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('km-supervise:kmSuperviseBack.fdEndTime')}
		                </td>
		                <td width="35%">
		                    <div id="_xform_fdEndTime" _xform_type="datetime">
		                        <xform:datetime property="fdEndTime" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('km-supervise:kmSuperviseBack.fdRequire')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <div id="_xform_fdRequire" _xform_type="textarea">
		                        <xform:textarea property="fdRequire" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('km-supervise:kmSuperviseBack.fdResult')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <div id="_xform_fdResult" _xform_type="textarea">
		                        <xform:textarea property="fdResult" showStatus="view" style="width:95%;" />
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="td_normal_title" width="15%">
		                    ${lfn:message('km-supervise:kmSuperviseBack.attBack')}
		                </td>
		                <td colspan="3" width="85.0%">
		                    <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
		                        <c:param name="fdKey" value="attBack" />
		                        <c:param name="formBeanName" value="kmSuperviseBackForm" />
		                        <c:param name="fdMulti" value="true" />
		                    </c:import>
		                </td>
		            </tr>
	        	</table>
			</ui:content>
		</ui:tabpage>
	</template:replace>
</template:include>
<script>
    function confirmDelete(msg) {
        return confirm('<bean:message key="page.comfirmDelete"/>');
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
        basePath: '/km/supervise/km_supervise_back/kmSuperviseBack.do',
        customOpts: {

            ____fork__: 0
        }
    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
</script>