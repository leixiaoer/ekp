<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.fssc.ledger.util.FsscLedgerUtil,com.landray.kmss.fssc.common.util.FsscCommonUtil" %>
    
        <%
            pageContext.setAttribute("currentPerson", UserUtil.getKMSSUser().getUserId());
	        pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
	        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
	        if(UserUtil.getUser().getFdParentOrg() != null) {
	            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
	        } else {
	            pageContext.setAttribute("currentOrg", "");
	        }
	        if(FsscCommonUtil.checkHasModule("/fssc/payment/")){
	  		   request.setAttribute("fdIsPayment",true);
	  	    }
        
        %>
    
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

                    'fdDetailList': '${lfn:escapeJs(lfn:message("fssc-ledger:table.fsscLedgerContractClause"))}'
                };
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>
        <template:replace name="title">
            <c:out value="${fsscLedgerContractForm.fdContractName} - " />
            <c:out value="${ lfn:message('fssc-ledger:table.fsscLedgerContract') }" />
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
                    basePath: '/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <kmss:auth requestURL="/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscLedgerContract.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('fsscLedgerContract.do?method=delete&fdId=${param.fdId}');" order="4" />
                </kmss:auth>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerContract') }" href="/fssc/ledger/fssc_ledger_contract/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">

            <ui:tabpage expand="false" var-navwidth="90%">
                <ui:content title="${ lfn:message('fssc-ledger:py.JiBenXinXi') }" expand="true">
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdContractName')}
                            </td>
                            <td colspan="5" width="83.4%">
                                <%-- 合同名称--%>
                                <div id="_xform_fdContractName" _xform_type="text">
                                    <xform:text property="fdContractName" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdContractCode')}
                            </td>
                            <td width="16.6%">
                                <%-- 合同编号--%>
                                <div id="_xform_fdContractCode" _xform_type="text">
                                    <xform:text property="fdContractCode" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdErpNo')}
                            </td>
                            <td width="16.6%">
                                <%-- ERP核算编号--%>
                                <div id="_xform_fdErpNo" _xform_type="text">
                                    <xform:text property="fdErpNo" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdParentContractNo')}
                            </td>
                            <td width="16.6%">
                                <%-- 上游合同号--%>
                                <div id="_xform_fdParentContractNo" _xform_type="text">
                                    <xform:text property="fdParentContractNo" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdSupplier')}
                            </td>
                            <td width="16.6%">
                                <%-- 签约公司--%>
                                <div id="_xform_fdSupplierId" _xform_type="dialog">
                                    <xform:dialog propertyId="fdSupplierId" propertyName="fdSupplierName" showStatus="view" style="width:95%;">
                                        dialogSelect(false,'fssc_base_supplier_getSupplier','fdSupplierId','fdSupplierName');
                                    </xform:dialog>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdSignDate')}
                            </td>
                            <td width="16.6%">
                                <%-- 签约日期--%>
                                <div id="_xform_fdSignDate" _xform_type="datetime">
                                    <xform:datetime property="fdSignDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdEffectDate')}
                            </td>
                            <td width="16.6%">
                                <%-- 合同生效日期--%>
                                <div id="_xform_fdEffectDate" _xform_type="datetime">
                                    <xform:datetime property="fdEffectDate" showStatus="view" dateTimeType="date" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdContractType')}
                            </td>
                            <td width="16.6%">
                                <%-- 合同类别--%>
                                <div id="_xform_fdContractType" _xform_type="select">
                                    <xform:select property="fdContractType" htmlElementProperties="id='fdContractType'" showStatus="view">
                                        <xform:enumsDataSource enumsType="fssc_ledger_contract_type" />
                                    </xform:select>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdContractStatus')}
                            </td>
                            <td width="16.6%">
                                <%-- 合同状态--%>
                                <div id="_xform_fdContractStatus" _xform_type="select">
                                    <xform:select property="fdContractStatus" htmlElementProperties="id='fdContractStatus'" showStatus="view">
                                        <xform:enumsDataSource enumsType="fssc_ledger_contract_status" />
                                    </xform:select>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdLedgerType')}
                            </td>
                            <td width="16.6%">
                                <%-- 合同类型--%>
                                <div id="_xform_fdLedgerType" _xform_type="radio">
                                    <xform:radio property="fdLedgerType" htmlElementProperties="id='fdLedgerType'" showStatus="view">
                                        <xform:enumsDataSource enumsType="fssc_ledger_ledger_type" />
                                    </xform:radio>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdAgent')}
                            </td>
                            <td width="16.6%">
                                <%-- 经办人--%>
                                <div id="_xform_fdAgentId" _xform_type="address">
                                    <xform:address propertyId="fdAgentId" propertyName="fdAgentName" orgType="ORG_TYPE_PERSON" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdContractDept')}
                            </td>
                            <td width="16.6%">
                                <%-- 承办部门--%>
                                <div id="_xform_fdContractDeptId" _xform_type="address">
                                    <xform:address propertyId="fdContractDeptId" propertyName="fdContractDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdExecuteDept')}
                            </td>
                            <td width="16.6%">
                                <%-- 执行部门--%>
                                <div id="_xform_fdExecuteDeptId" _xform_type="address">
                                    <xform:address propertyId="fdExecuteDeptId" propertyName="fdExecuteDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdCurrency')}
                            </td>
                            <td width="16.6%">
                                <%-- 币种--%>
                                <div id="_xform_fdCurrencyId" _xform_type="dialog">
                                    <xform:dialog propertyId="fdCurrencyId" propertyName="fdCurrencyName" showStatus="view" style="width:95%;">
                                        dialogSelect(false,'fssc_base_currency_fdCurrency','fdCurrencyId','fdCurrencyName');
                                    </xform:dialog>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdContractAmount')}
                            </td>
                            <td width="16.6%">
                                <%-- 合同金额--%>
                                <div id="_xform_fdContractAmount" _xform_type="text">
                                	<kmss:showNumber value="${fsscLedgerContractForm.fdContractAmount}" pattern="0.00"/>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdPerforBond')}
                            </td>
                            <td width="16.6%">
                                <%-- 履约保证金--%>
                                <div id="_xform_fdPerforBond" _xform_type="text">
                                	<kmss:showNumber value="${fsscLedgerContractForm.fdPerforBond}" pattern="0.00"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdPayedAmount')}
                            </td>
                            <td width="16.6%">
                                <%-- 合同已付--%>
                                <div id="_xform_fdPayedAmount" _xform_type="text">
                                	<c:choose>
                                		<c:when test="${not empty  fsscLedgerContractForm.fdPayedAmount}">
                                			<kmss:showNumber value="${fsscLedgerContractForm.fdPayedAmount}" pattern="0.00"/>
                                		</c:when>
                                		<c:otherwise>
                                			<kmss:showNumber value="${fsscLedgerContractForm.fdInitPayedAmount}" pattern="0.00"/>
                                		</c:otherwise>
                                	</c:choose>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdUnpayAmount')}
                            </td>
                            <td width="16.6%">
                                <%-- 合同未付--%>
                                <div id="_xform_fdUnpayAmount" _xform_type="text">
                                	<kmss:showNumber value="${fsscLedgerContractForm.fdUnpayAmount}" pattern="0.00"/>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdPayingAmount')}
                            </td>
                            <td width="16.6%">
                                <%-- 付款中--%>
                                <div id="_xform_fdPayingAmount" _xform_type="text">
                                	<c:choose>
                                		<c:when test="${not empty  fsscLedgerContractForm.fdPayingAmount}">
                                			<kmss:showNumber value="${fsscLedgerContractForm.fdPayingAmount}" pattern="0.00"/>
                                		</c:when>
                                		<c:otherwise>
                                			<kmss:showNumber value="${fsscLedgerContractForm.fdInitPayingAmount}" pattern="0.00"/>
                                		</c:otherwise>
                                	</c:choose>
                                </div>
                            </td>
                        </tr>
                        <tr  class="div1" style="display:none;">
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdPrice')}
                            </td>
                            <td colspan="5" width="83.4%">
                                <%-- 单价--%>
                                <div id="_xform_fdPrice" _xform_type="text">
                                	<kmss:showNumber value="${fsscLedgerContractForm.fdPrice}" pattern="0.00"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdContractSubject')}
                            </td>
                            <td colspan="5" width="83.0%">
                                <%-- 合同标的--%>
                                <div id="_xform_fdContractSubject" _xform_type="textarea">
                                    <xform:textarea property="fdContractSubject" showStatus="view" style="width:95%" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdReason')}
                            </td>
                            <td colspan="5" width="83.0%">
                                <%-- 变更原因--%>
                                <div id="_xform_fdReason" _xform_type="textarea">
                                    <xform:textarea property="fdReason" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </ui:content>
                <c:import url="/fssc/ledger/fssc_ledger_contract_clause/fsscLedgerContractClause_view.jsp"></c:import>
                <!-- 使用记录 -->
                <c:if test="${fdIsPayment eq true}">
                	<c:import url="/fssc/ledger/fssc_ledger_contract/fsscLedgerContract_use.jsp" charEncoding="UTF-8" />
                </c:if>
            </ui:tabpage>
            <script>
	            if(window.navigator.userAgent.toLowerCase().indexOf("msie")>-1
	        			||window.navigator.userAgent.toLowerCase().indexOf("trident")>-1){//IE
	        		setTimeout(function(){initData();},3000);
	        	}else{//非IE
	        		$(document).ready(function(){
	        			initData();
	        		});
	        	};
	        	
	        	function initData(){
	        		var fdContractType=$("[name='fdContractType']").val();
	        		if(fdContractType == 1){
						$(".div1").prop("style","display:none;");
					} else {
						$(".div1").prop("style","");
					}
	        	}
            </script>
        </template:replace>

    </template:include>