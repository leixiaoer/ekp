<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.fssc.ledger.util.FsscLedgerUtil" %>
    
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
            <link href="${LUI_ContextPath}/fssc/common/resource/css/common.css"  rel="stylesheet" />
            <script type="text/javascript">
                var formInitData = {

                };
                var messageInfo = {

                    'fdDetailList': '${lfn:escapeJs(lfn:message("fssc-ledger:table.fsscLedgerContractClause"))}'
                };

                var initData = {
                    contextPath: '${LUI_ContextPath}',
                };
                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
                Com_IncludeFile("form.js");
                Com_IncludeFile("importDetail.js", "${LUI_ContextPath }/fssc/base/resource/js/", 'js', true);
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/ledger/fssc_ledger_contract/", 'js', true);
                Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/fssc/ledger/resource/js/", 'js', true);
                Com_IncludeFile("fsscLedgerContract_edit.js", "${LUI_ContextPath}/fssc/ledger/fssc_ledger_contract/", 'js', true);
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
                Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);
            </script>
        </template:replace>

        <template:replace name="title">
            <c:choose>
                <c:when test="${fsscLedgerContractForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('fssc-ledger:table.fsscLedgerContract') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${fsscLedgerContractForm.fdContractName} - " />
                    <c:out value="${ lfn:message('fssc-ledger:table.fsscLedgerContract') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ fsscLedgerContractForm.method_GET == 'edit' }">
                        <ui:button text="${ lfn:message('button.update') }" onclick="validateMoney(document.fsscLedgerContractForm, 'update');" />
                    </c:when>
                    <c:when test="${ fsscLedgerContractForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.save') }" onclick="validateMoney(document.fsscLedgerContractForm, 'save');" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" />
                <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerContract') }" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
            <html:form action="/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do">

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
	                                    <xform:text property="fdContractName" showStatus="edit" style="width:90%;" />
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
	                                    <xform:text property="fdContractCode" showStatus="edit" onValueChange="changeCode" style="width:90%;" />
	                                </div>
	                            </td>
	                            <td class="td_normal_title" width="16.6%">
	                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdErpNo')}
	                            </td>
	                            <td width="16.6%">
	                                <%-- ERP核算编号--%>
	                                <div id="_xform_fdErpNo" _xform_type="text">
	                                    <xform:text property="fdErpNo" showStatus="edit" style="width:95%;" />
	                                </div>
	                            </td>
	                            <td class="td_normal_title" width="16.6%">
	                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdParentContractNo')}
	                            </td>
	                            <td width="16.6%">
	                                <%-- 上游合同号--%>
	                                <div id="_xform_fdParentContractNo" _xform_type="text">
	                                    <xform:text property="fdParentContractNo" showStatus="edit" style="width:95%;" />
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
	                                    <xform:dialog required="true" propertyId="fdSupplierId" propertyName="fdSupplierName" showStatus="edit" subject="${lfn:message('fssc-ledger:fsscLedgerContract.fdSupplier')}" style="width:95%;">
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
	                                    <xform:datetime required="true" property="fdSignDate" showStatus="edit" dateTimeType="date" style="width:95%;" onValueChange="checkDate" />
	                                </div>
	                            </td>
	                            <td class="td_normal_title" width="16.6%">
	                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdEffectDate')}
	                            </td>
	                            <td width="16.6%">
	                                <%-- 合同生效日期--%>
	                                <div id="_xform_fdEffectDate" _xform_type="datetime">
	                                    <xform:datetime required="true" property="fdEffectDate" showStatus="edit" dateTimeType="date" style="width:95%;" onValueChange="checkDate" />
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
	                                    <xform:select required="true" property="fdContractType" htmlElementProperties="id='fdContractType'" showStatus="edit" onValueChange="Fs_fdContractTypeIsPrice(this.value);">
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
	                                    <xform:select required="true" property="fdContractStatus" htmlElementProperties="id='fdContractStatus'" value="${fsscLedgerContractForm.fdContractStatus}" showStatus="edit">
	                                        <xform:enumsDataSource enumsType="fssc_ledger_contract_status" />
	                                    </xform:select>
	                                </div>
	                            </td>
	                            <td class="td_normal_title" width="16.6%">
	                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdLedgerType')}
	                            </td>
	                            <td  width="16.6%">
	                                <%-- 合同类型--%>
	                                <div id="_xform_fdLedgerType" _xform_type="radio">
	                                    <xform:radio required="true" property="fdLedgerType" htmlElementProperties="id='fdLedgerType'" subject="${lfn:message('fssc-ledger:fsscLedgerContract.fdLedgerType')}" showStatus="edit" >
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
	                                    <xform:address required="true" propertyId="fdAgentId" propertyName="fdAgentName" orgType="ORG_TYPE_PERSON" showStatus="edit" style="width:95%;" />
	                                </div>
	                            </td>
	                            <td class="td_normal_title" width="16.6%">
	                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdContractDept')}
	                            </td>
	                            <td width="16.6%">
	                                <%-- 承办部门--%>
	                                <div id="_xform_fdContractDeptId" _xform_type="address">
	                                    <xform:address required="true" propertyId="fdContractDeptId" propertyName="fdContractDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="edit" style="width:95%;" />
	                                </div>
	                            </td>
	                            <td class="td_normal_title" width="16.6%">
	                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdExecuteDept')}
	                            </td>
	                            <td width="16.6%">
	                                <%-- 执行部门--%>
	                                <div id="_xform_fdExecuteDeptId" _xform_type="address">
	                                    <xform:address required="true" propertyId="fdExecuteDeptId" propertyName="fdExecuteDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="edit" style="width:95%;" />
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
	                           <xform:dialog propertyId="fdCurrencyId" propertyName="fdCurrencyName" showStatus="edit" required="true" subject="${lfn:message('fssc-ledger:fsscLedgerContract.fdCurrency')}" style="width:95%;">
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
	                                    <input name="fdContractAmount" value="<kmss:showNumber value="${fsscLedgerContractForm.fdContractAmount}" pattern="0.00"></kmss:showNumber>" onchange="FS_changeFdContractAmount();" validate="currency-dollar min(0) required" subject="${lfn:message('fssc-ledger:fsscLedgerContract.fdContractAmount')}" class="inputsgl" style="width:90%;"/>
	                                	<span class="class1" style="color:#FF0000;">*</span>
	                                </div>
	                            </td>
	                            <td class="td_normal_title" width="16.6%">
	                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdPerforBond')}
	                            </td>
	                            <td width="16.6%">
	                                <%-- 履约保证金--%>
	                                <div id="_xform_fdPerforBond" _xform_type="text">
	                                	<input name="fdPerforBond" value="<kmss:showNumber value="${fsscLedgerContractForm.fdPerforBond}" pattern="0.00"></kmss:showNumber>" validate="currency-dollar min(0)" subject="${lfn:message('fssc-ledger:fsscLedgerContract.fdPerforBond')}" class="inputsgl" style="width:95%;"/>
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
	                                	<c:set var="fdPayedAmount" value="${fsscLedgerContractForm.fdPayedAmount}"></c:set>
	                                	<c:if test="${empty fsscLedgerContractForm.fdPayedAmount}"><c:set var="fdPayedAmount" value="${fsscLedgerContractForm.fdInitPayedAmount}"></c:set></c:if>
	                                	<input name="fdPayedAmount" value="<kmss:showNumber value="${fdPayedAmount}" pattern="0.00"></kmss:showNumber>" validate="currency-dollar min(0)" readonly="readonly" class="inputsgl" style="width:95%;"/>
	                                </div>
	                            </td>
	                            <td class="td_normal_title" width="16.6%">
	                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdUnpayAmount')}
	                            </td>
	                            <td width="16.6%">
	                                <%-- 合同未付--%>
	                                <div id="_xform_fdUnpayAmount" _xform_type="text">
	                                	<input name="fdUnpayAmount" value="<kmss:showNumber value="${fsscLedgerContractForm.fdUnpayAmount}" pattern="0.00"></kmss:showNumber>" validate="currency-dollar min(0)" readonly="readonly" class="inputsgl" style="width:95%;"/>
	                                </div>
	                            </td>
	                            <td class="td_normal_title" width="16.6%">
	                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdPayingAmount')}
	                            </td>
	                            <td width="16.6%">
	                                <%-- 付款中--%>
	                                <div id="_xform_fdPayingAmount" _xform_type="text">
	                                	<c:set var="fdPayingAmount" value="${fsscLedgerContractForm.fdPayingAmount}"></c:set>
	                                	<c:if test="${empty fsscLedgerContractForm.fdPayingAmount}"><c:set var="fdPayingAmount" value="${fsscLedgerContractForm.fdInitPayingAmount}"></c:set></c:if>
	                                	<input name="fdPayingAmount" value="<kmss:showNumber value="${fdPayingAmount}" pattern="0.00"></kmss:showNumber>" validate="currency-dollar min(0)" readonly="readonly" class="inputsgl" style="width:95%;"/>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr class="div1" style="display:none;">
	                            <td class="td_normal_title" width="16.6%">
	                                ${lfn:message('fssc-ledger:fsscLedgerContract.fdPrice')}
	                            </td>
	                            <td colspan="5" width="83.4%">
	                                <%-- 单价--%>
	                                <div id="_xform_fdPrice" _xform_type="text">
	                                	<input name="fdPrice" value="<kmss:showNumber value="${fsscLedgerContractForm.fdPrice}" pattern="0.00"></kmss:showNumber>" validate="currency-dollar min(0)" subject="${lfn:message('fssc-ledger:fsscLedgerContract.fdPrice')}" class="inputsgl" style="width:95%;"/>
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
	                                    <xform:textarea property="fdContractSubject" showStatus="edit" style="width:95%" />
	                                </div>
	                            </td>
	                        </tr>
	                        <c:if test="${ fsscLedgerContractForm.method_GET == 'edit' }">
	                         <tr>
	                             <td class="td_normal_title" width="16.6%">
	                                 ${lfn:message('fssc-ledger:fsscLedgerContract.fdReason')}
	                             </td>
	                             <td colspan="5" width="83.0%">
	                                 <%-- 变更原因--%>
	                                 <div id="_xform_fdReason" _xform_type="textarea">
	                                     <xform:textarea property="fdReason" showStatus="edit" style="width:95%;" />
	                                 </div>
	                             </td>
	                         </tr>
	                        </c:if>
	                    </table>
	                </ui:content>
                    <c:import url="/fssc/ledger/fssc_ledger_contract_clause/fsscLedgerContractClause_edit.jsp"></c:import>
                </ui:tabpage>
                <html:hidden property="fdId" />
                <html:hidden property="method_GET" />
            </html:form>
            <script>
            	$KMSSValidation(document.forms['fsscLedgerContractForm']);
            	var validation = $KMSSValidation();
            	
    			validation.addValidator(
   					'validateFdPaymentRatio()',
   					'<bean:message bundle="fssc-ledger" key="message.import.error.fdPaymentRatio.isWrong"/>',
   					function(v,e,o) {
   						var total = 0;//计算付款比例
   						var table = document.getElementById("TABLE_DocList_fdDetailList_Form");
   						var rows1 = table.rows;
   						var trCount = rows1.length;
   						for ( var i = 0; i<trCount-1 ; i++) {
   							var fdPaymentRatio = Number($("input[name='fdDetailList_Form["+i+"].fdPaymentRatio']").val());
   							total = (total*1.0) + (fdPaymentRatio*1.0);
   						}
   						total = Number((total*1.0).toFixed(2));
   						if(0< v <= 100 && total <= 100) {
   							return true;
   						}
   						return false;
   					}
   				);
            </script>
        </template:replace>

    </template:include>