<%@ page import="com.landray.kmss.fssc.loan.model.FsscLoanMain" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
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
            		docStatus:'${fsscLoanMainForm.docStatus}',
            		approveModel:'${param.approveModel}',
            };
            var messageInfo = {

            };
            //右侧审批模式下，隐藏底部栏
            if('${param.approveModel}'=='right'){
            	LUI.ready(function(){
    				setTimeout(function(){
    					$(".lui_tabpage_frame").prop("style","display:none;");
    				},100)
    			})
            }
            LUI.ready(function(){
            	 initSAP();//初始化SAP字段
			})
            Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            Com_IncludeFile("controlView.js", "${LUI_ContextPath}/fssc/common/resource/js/", "js", true);
            Com_IncludeFile("fsscLoanMain_view.js", "${LUI_ContextPath}/fssc/loan/fssc_loan_main/", "js", true);
            Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);
        </script>
    </template:replace>
    <template:replace name="title">
        <c:out value="${fsscLoanMainForm.docSubject} - " />
        <c:out value="${ lfn:message('fssc-loan:table.fsscLoanMain') }" />
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
                basePath: '/fssc/loan/fssc_loan_main/fsscLoanMain.do',
                customOpts: {

                    ____fork__: 0
                }
            };
            
            seajs.use(['lui/dialog'],function(dialog){
              	<c:if test="${fsscLoanMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.paymentVariant eq 'true' }">
        			Com_Parameter.event.submit.push(function(){
        			var pass = true;
            		$.ajax({
            			url:'${LUI_ContextPath}/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=checkPayment',
            			data:{fdId:'${fsscLoanMainForm.fdId}'},
            			dataType:'json',
            			async:false,
            			success:function(rtn){
            				var oprGroup = $('input:radio[name="oprGroup"]:checked').val();
            				if(rtn.result == 'success'){
            					if( oprGroup =='handler_pass:通过'){
            						if(!confirm("${lfn:message('fssc-loan:tips.confirmPayment')}")){
	                            		pass = false;
	            					}else{
	            						 $.ajax({
	            	            			url:'${LUI_ContextPath}/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=paymentToBank',
	            	            			data:{fdId:'${fsscLoanMainForm.fdId}'},
	            	            			dataType:'json',
	            	            			async:false,
	            	            			success:function(rtn){
	            	            				//未启用银企直联
	            	            				if(rtn.result == 'success'){
  	            	            					dialog.alert(rtn.message);
  	            	            				}else if(rtn.result == 'isCloseAuth'){
  	            	            					dialog.alert(rtn.message);
  	            	            				}else if(rtn.result == 'noHave'){//无模块不做处理
  	            	            					pass = true;
  	            	            				}else{
  	            	            					dialog.alert(rtn.message);
  	            	            					pass = false;
  	            	            				}
	            	            			}
	            	            		});
	            					}  
            					}
            				}else{
            					dialog.alert(rtn.message);
            					pass = false;
            				}
            			}
            		});
            		return pass;
        		})
        	</c:if>
            });

            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
        </script>
        <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="5">
        <!-- 右侧流程按钮 -->
        <c:if test="${param.approveModel eq 'right'}">
            <c:if test="${ fsscLoanMainForm.docStatus=='10' || fsscLoanMainForm.docStatus=='11'}">
                <!--edit-->
                <kmss:auth requestURL="/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscLoanMain.do?method=edit&fdId=${param.fdId}','_self');"  styleClass="lui_widget_btn_primary" isForcedAddClass="true" order="2" />
                </kmss:auth>
            </c:if>
            <c:if test="${ fsscLoanMainForm.docStatus=='30'}">
                <!--还款登记-->
                <kmss:auth requestURL="/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=repayment&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('fssc-loan:table.fsscLoanRepayment')}" onclick="loanToRepayment();" order="2" />
                </kmss:auth>
            </c:if>
            <!--重新制证-->
            <kmss:auth requestURL="/fssc/voucher/fssc_voucher_main/fsscVoucherMain.do?method=refreshVoucher&fdId=${param.fdId}&fdModelName=com.landray.kmss.fssc.loan.model.FsscLoanMain">
	            <c:if test="${not empty fsscLoanMainForm.fdVoucherStatus }">
	                <ui:button text="${lfn:message('fssc-loan:button.refresh.voucher')}" id="bookkeepingButton" onclick="refreshVoucher();"  styleClass="lui_widget_btn_primary" isForcedAddClass="true" order="2" />
	            </c:if>
            </kmss:auth>
            <c:if test="${fsscLoanMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.voucherVariant=='true'}">
                <%--制证节点--%>
                <c:if test="${empty fsscLoanMainForm.fdBookkeepingStatus || fsscLoanMainForm.fdBookkeepingStatus == '10' || fsscLoanMainForm.fdBookkeepingStatus == '11'}" >
                    <!--记账-->
                    <ui:button text="${lfn:message('fssc-loan:button.bookkeeping')}" id="bookkeepingButton" onclick="bookkeeping();"  styleClass="lui_widget_btn_primary" isForcedAddClass="true" order="2" />
                </c:if>
            </c:if>
            <c:if test="${ fsscLoanMainForm.docStatus=='30'}">
            	<kmss:auth requestURL="/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=openUpdateFdOffsetters&fdId=${param.fdId}">
	                <!--修改可冲销者-->
	                <ui:button text="${lfn:message('fssc-loan:fsscLoanMain.updateFdOffsetters.botton')}" onclick="updateFdOffsetters();"  styleClass="lui_widget_btn_primary" isForcedAddClass="true" order="2" />
            	</kmss:auth>
            </c:if>
           	<kmss:auth requestURL="/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=print&fdId=${param.fdId}">
	            <ui:button text="${lfn:message('button.print')}" onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}fssc/loan/fssc_loan_main/fsscLoanMain.do?method=print&fdId=${param.fdId}&fdType=1');"  styleClass="lui_widget_btn_primary" isForcedAddClass="true" />
	            <ui:button text="${lfn:message('fssc-loan:fsscLoanMain.print')}" onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}fssc/loan/fssc_loan_main/fsscLoanMain.do?method=print&fdId=${param.fdId}&fdType=2');"  styleClass="lui_widget_btn_primary" isForcedAddClass="true" />
            </kmss:auth>
            <!--delete-->
            <kmss:auth requestURL="/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=delete&fdId=${param.fdId}">
                <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('fsscLoanMain.do?method=delete&fdId=${param.fdId}');"  styleClass="lui_widget_btn_primary" isForcedAddClass="true" order="4" />
            </kmss:auth>
        </c:if>
        <!-- 旧版按钮 -->
        <c:if test="${param.approveModel ne 'right'}">
            <c:if test="${ fsscLoanMainForm.docStatus=='10' || fsscLoanMainForm.docStatus=='11'}">
                <!--edit-->
                <kmss:auth requestURL="/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscLoanMain.do?method=edit&fdId=${param.fdId}','_self');"   order="2" />
                </kmss:auth>
            </c:if>
            <c:if test="${ fsscLoanMainForm.docStatus=='30'}">
                <!--还款登记-->
                <kmss:auth requestURL="/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=repayment&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('fssc-loan:table.fsscLoanRepayment')}" onclick="loanToRepayment();" order="2" />
                </kmss:auth>
            </c:if>
            <!--重新制证-->
            <kmss:auth requestURL="/fssc/voucher/fssc_voucher_main/fsscVoucherMain.do?method=refreshVoucher&fdId=${param.fdId}&fdModelName=com.landray.kmss.fssc.loan.model.FsscLoanMain">
                <ui:button text="${lfn:message('fssc-loan:button.refresh.voucher')}" id="bookkeepingButton" onclick="refreshVoucher();"   order="2" />
            </kmss:auth>
            <c:if test="${fsscLoanMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.voucherVariant=='true'}">
                <%--制证节点--%>
                <c:if test="${empty fsscLoanMainForm.fdBookkeepingStatus || fsscLoanMainForm.fdBookkeepingStatus == '10' || fsscLoanMainForm.fdBookkeepingStatus == '11'}" >
                    <!--记账-->
                    <ui:button text="${lfn:message('fssc-loan:button.bookkeeping')}" id="bookkeepingButton" onclick="bookkeeping();"   order="2" />
                </c:if>
            </c:if>
            <c:if test="${ fsscLoanMainForm.docStatus=='30'}">
            	<kmss:auth requestURL="/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=openUpdateFdOffsetters&fdId=${param.fdId}">
	                <!--修改可冲销者-->
	                <ui:button text="${lfn:message('fssc-loan:fsscLoanMain.updateFdOffsetters.botton')}" onclick="updateFdOffsetters();"   order="2" />
            	</kmss:auth>
            </c:if>
           	<kmss:auth requestURL="/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=print&fdId=${param.fdId}">
	            <ui:button text="${lfn:message('button.print')}" onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}fssc/loan/fssc_loan_main/fsscLoanMain.do?method=print&fdId=${param.fdId}&fdType=1');"   />
	            <ui:button text="${lfn:message('fssc-loan:fsscLoanMain.print')}" onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}fssc/loan/fssc_loan_main/fsscLoanMain.do?method=print&fdId=${param.fdId}&fdType=2');"   />
            </kmss:auth>
            <!--delete-->
            <kmss:auth requestURL="/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=delete&fdId=${param.fdId}">
                <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('fsscLoanMain.do?method=delete&fdId=${param.fdId}');"   order="4" />
            </kmss:auth>
            </c:if>
            <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />

        </ui:toolbar>
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
            <ui:menu-item text="${ lfn:message('fssc-loan:table.fsscLoanMain') }" href="/fssc/loan/fssc_loan_main/" target="_self" />
             <ui:menu-item text="${docTemplateName }"  />
        </ui:menu>
    </template:replace>
    <template:replace name="content">
        <!-- 流程状态标识 -->
		<c:import url="/fssc/base/resource/jsp/fssc_banner.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="fsscLoanMainForm" />
			<c:param name="approveType" value="${param.approveModel}" />
		</c:import>
        <ui:tabpage expand="false" var-navwidth="90%">
            <div class='lui_form_title_frame'>
                <div class='lui_form_subject'>
                    ${fsscLoanMainForm.docSubject}
                </div>
                <%--条形码--%>
          		<div id="barcodeTarget" style="float:right;margin-right:10px;margin-top: -20px;" ></div>
            </div>
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.docSubject')}
                    </td>
                    <td colspan="5" width="83.0%">
                        <%-- 标题  style="width:45%;text-align:center;font-size:25px;" --%>
                        <xform:text property="docSubject" style="width:95%;" showStatus="view" />
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.fdLoanPerson')}
                    </td>
                    <td width="16.6%">
                        <%-- 借款人--%>
                        <div id="_xform_fdLoanPersonId" _xform_type="address">
                            <xform:address propertyId="fdLoanPersonId" propertyName="fdLoanPersonName" orgType="ORG_TYPE_PERSON" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.fdLoanDept')}
                    </td>
                    <td width="16.6%">
                        <%-- 借款人部门--%>
                        <div id="_xform_fdLoanDeptId" _xform_type="address">
                            <xform:address propertyId="fdLoanDeptId" propertyName="fdLoanDeptName" orgType="ORG_TYPE_ORGORDEPT" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.docCreateTime')}
                    </td>
                    <td width="16.6%">
                        <%-- 创建时间--%>
                        <div id="_xform_docCreateTime" _xform_type="datetime">
                            <xform:datetime property="docCreateTime" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.fdCompany')}
                    </td>
                    <td colspan="3" width="50.0%">
                        <%-- 费用归属公司--%>
                        <div id="_xform_fdCompanyId" _xform_type="dialog">
                            <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="view" style="width:95%;">
                                dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
                            </xform:dialog>
                        </div>
                    </td>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.fdCostCenter')}
                    </td>
                    <td width="16.6%">
                        <%-- 费用承担部门--%>
                        <div id="_xform_fdCostCenterId" _xform_type="dialog">
                            <xform:dialog propertyId="fdCostCenterId" propertyName="fdCostCenterName" showStatus="view" style="width:95%;">
                                dialogSelect(false,'fssc_base_cost_center_selectCostCenter','fdCostCenterId','fdCostCenterName');
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <kmss:ifModuleExist path="/fssc/fee">
                <c:if test="${fdIsRequiredFee==true}">
                <tr>
                    <td class="td_normal_title" width="16.6%">
                        <span class="tempClass" style="display:none;">${lfn:message('fssc-loan:fsscLoanMain.fdFeeMainName')}</span>
                    </td>
                    <td colspan="5" width="83.0%">
                        <%-- 关联事前申请--%>
                        <span class="tempClass" style="display:none;">
                        <a target="_blank" href="<c:url value="/fssc/fee/fssc_fee_main/fsscFeeMain.do"/>?method=view&fdId=${fsscLoanMainForm.fdFeeMainId}">
                           <div style="color:#83C2EB" id="_xform_fdOffsetterIds" _xform_type="address">
                               <xform:address propertyId="fdFeeMainId" propertyName="fdFeeMainName" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="view" subject="${lfn:message('fssc-loan:fsscLoanMain.fdFeeMainName')}" style="width:95%;" />
                           </div>
                        </a>
                        </span>
                    </td>
                </tr>
                </c:if>
                </kmss:ifModuleExist>
                <tr>
                <c:if test="${fdIsProject==true}">
	                 <td class="td_normal_title" width="16.6%">
	                            ${lfn:message('fssc-loan:fsscLoanMain.fdBaseProject')}
	                    </td>
	                    <td width="16.6%" class="fdBaseProjectContent" colspan="5">
	                            <%-- 项目--%>
                        <div id="_xform_fdBaseProjectId" _xform_type="dialog">
                            <xform:dialog propertyId="fdBaseProjectId" propertyName="fdBaseProjectName" showStatus="view" subject="${lfn:message('fssc-loan:fsscLoanMain.fdBaseProject')}" style="width:95%;">
                                dialogSelect(false,'fssc_base_project_project','fdBaseProjectId','fdBaseProjectName');
                            </xform:dialog>
                        </div>
                    </td>
                 </c:if>
                   <td class="td_normal_title fdBaseWbs" width="16.6%" style="display: none;">
                            ${lfn:message('fssc-loan:fsscLoanMain.fdBaseWbs')}
                    </td>
                    <c:if test="${fdIsProject == 'true'}">
                    <td width="16.6%" class="fdBaseWbs" id="fdBaseWbss" style="display: none;">
                            <%-- WBS号--%>
                        <div id="_xform_fdBaseWbsId" _xform_type="dialog">
                            <xform:dialog propertyId="fdBaseWbsId" propertyName="fdBaseWbsName" showStatus="view" subject="${lfn:message('fssc-loan:fsscLoanMain.fdBaseWbs')}" style="width:95%;">
                                dialogSelect(false,'fssc_base_wbs_fdWbs','fdBaseWbsId','fdBaseWbsName',null,{'fdCompanyId':$('[name=fdCompanyId]').val(),'fdProjectId':$('[name=fdBaseProjectId]').val(),'selectType':'person'});
                            </xform:dialog>
                        </div>
                    </td>
                    </c:if>
                    <c:if test="${fdIsProject == 'false'}">
                    <td width="16.6%" class="fdBaseWbs" id="fdBaseWbss" style="display: none;">
                            <%-- WBS号--%>
                        <div id="_xform_fdBaseWbsId" _xform_type="dialog">
                            <xform:dialog propertyId="fdBaseWbsId" propertyName="fdBaseWbsName" showStatus="view" subject="${lfn:message('fssc-loan:fsscLoanMain.fdBaseWbs')}" style="width:95%;">
                                dialogSelect(false,'fssc_base_wbs_fdWbs','fdBaseWbsId','fdBaseWbsName',null,{'fdCompanyId':$('[name=fdCompanyId]').val(),'selectType':'person'});
                            </xform:dialog>
                        </div>
                    </td>
                    </c:if>
                    <td class="td_normal_title fdBaseInnerOrder" width="16.6%" style="display: none;">
                            ${lfn:message('fssc-loan:fsscLoanMain.fdBaseInnerOrder')}
                    </td>
                    <td width="16.6%" class="fdBaseInnerOrder" id="fdBaseInnerOrders" style="display: none;">
                            <%-- 内部订单--%>
                        <div id="_xform_fdBaseInnerOrderId" _xform_type="dialog">
                            <xform:dialog propertyId="fdBaseInnerOrderId" propertyName="fdBaseInnerOrderName" showStatus="view" subject="${lfn:message('fssc-loan:fsscLoanMain.fdBaseInnerOrder')}" style="width:95%;">
                                dialogSelect(false,'fssc_base_inner_order_fdInnerOrder','fdBaseInnerOrderId','fdBaseInnerOrderName',null,{'fdCompanyId':$('[name=fdCompanyId]').val(),'selectType':'person'});
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <c:if test="${fn:indexOf(fdExtendFields,'3')>-1 }">
                     <tr>
                         <td class="td_normal_title" width="16.6%">
                             ${lfn:message('fssc-loan:fsscLoanMain.fdBaseProjectAccounting')}
                         </td>
                         <td colspan="5" width="83.0%">
                             <div id="_xform_fdBaseProjectAccountingId" _xform_type="dialog">
                                 <xform:dialog propertyName="fdBaseProjectAccountingName" propertyId="fdBaseProjectAccountingId" style="width:95%;" required="true" subject="${lfn:message('fssc-loan:fsscLoanMain.fdBaseProjectAccounting')}">
                                 	dialogSelect(false,'fssc_base_project_project','fdBaseProjectAccountingId','fdBaseProjectAccountingName');
                                 </xform:dialog>
                             </div>
                         </td>
                     </tr>
                 </c:if>
                <tr>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.fdLoanMoney')}
                    </td>
                    <td width="16.6%">
                        <%-- 借款金额--%>
                        <div id="_xform_fdLoanMoney" _xform_type="text">
                            &nbsp;<kmss:showNumber value="${fsscLoanMainForm.fdLoanMoney}" pattern="#,##0.00"></kmss:showNumber><br/>
                            <xform:text property="fdLoanMoney" showStatus="noShow"></xform:text>
                            <div id="fdLoanUpperMoney" style="padding-left:4px;"></div>
                        </div>
                    </td>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.fdExpectedDate')}
                    </td>
                    <td width="16.6%">
                        <%-- 预计还款日期--%>
                        <div id="_xform_fdExpectedDate" _xform_type="datetime">
                            <xform:datetime property="fdExpectedDate" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.fdBaseCurrency')}
                    </td>
                    <td width="16.6%">
                        <%-- 币种--%>
                        <div id="_xform_fdOffsetterIds" _xform_type="address">
                            <xform:dialog propertyId="fdBaseCurrencyId" propertyName="fdBaseCurrencyName" showStatus="view" subject="${lfn:message('fssc-loan:fsscLoanMain.fdBaseCurrency')}" style="width:95%;">
                            </xform:dialog>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="16.6%">
                            ${lfn:message('fssc-loan:fsscLoanMain.fdTotalLoanMoney')}
                    </td>
                    <td width="16.6%">
                            <%-- 累计借款金额--%>
                        <div id="_xform_fdTotalLoanMoney" _xform_type="text">
                            <kmss:showNumber value="${fsscLoanMainForm.fdTotalLoanMoney}" pattern="###,##0.00"></kmss:showNumber>
                        </div>
                    </td>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.fdTotalRepaymentMoney')}
                    </td>
                    <td width="16.6%">
                        <%-- 累计已还款金额--%>
                        <div id="_xform_fdTotalRepaymentMoney" _xform_type="text">
                            <kmss:showNumber value="${fsscLoanMainForm.fdTotalRepaymentMoney}" pattern="###,##0.00"></kmss:showNumber>
                        </div>
                    </td>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.fdTotalNotRepaymentMoney')}
                    </td>
                    <td width="16.6%">
                        <%-- 累计未还款金额--%>
                        <div id="_xform_fdTotalNotRepaymentMoney" _xform_type="text">
                            <kmss:showNumber value="${fsscLoanMainForm.fdTotalNotRepaymentMoney}" pattern="###,##0.00"></kmss:showNumber>
                        </div>
                    </td>
                </tr>
                <c:if test="${fdIsErasable==true}">
	                <tr>
	                    <td class="td_normal_title" width="16.6%">
	                        ${lfn:message('fssc-loan:fsscLoanMain.fdOffsetters')}
	                    </td>
	                    <td colspan="5" width="83.0%">
	                        <%-- 可冲销者--%>
	                        <div id="_xform_fdOffsetterIds" _xform_type="address">
	                            <xform:address propertyId="fdOffsetterIds" propertyName="fdOffsetterNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="view" subject="${lfn:message('fssc-loan:fsscLoanMain.fdOffsetters')}" style="width:95%;" />
	                        </div>
	                    </td>
	                </tr>
                </c:if>
                <tr>
                    <td class="td_normal_title" width="16.6%">
                        ${lfn:message('fssc-loan:fsscLoanMain.fdReason')}
                    </td>
                    <td colspan="5" width="83.0%">
                        <%-- 借款事由--%>
                        <div id="_xform_fdReason" _xform_type="textarea">
                            <xform:textarea property="fdReason" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                  <tr>
				        <td class="td_normal_title" width="16.6%">
				            ${lfn:message('fssc-loan:fsscLoanMain.attPayment')}
				        </td>
				        <td colspan="5" width="83.0%">
				            <%-- 附件--%>
				            <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
				                <c:param name="fdKey" value="attPayment" />
				                <c:param name="formBeanName" value="fsscLoanMainForm" />
				                <c:param name="fdMulti" value="true" />
				            </c:import>
				        </td>
				 </tr>
            </table>
            <div class="lui_paragraph_title">
                <span class="lui_icon_s lui_icon_s_icon_18"></span>${ lfn:message('fssc-loan:py.ShouKuanZhangHuXin') }
            </div>
            <table class="tb_normal" width="100%">
                 <tr>
                     <td class="td_normal_title" width="8%" align="center">
                         ${lfn:message('fssc-loan:fsscLoanMain.fdBasePayWay')}
                     </td>
                     <td class="td_normal_title" width="8%" align="center">
                         ${lfn:message('fssc-loan:fsscLoanMain.fdAccPayeeName')}
                     </td>
                                 <td class="td_normal_title" width="8%" align="center">
                         ${lfn:message('fssc-loan:fsscLoanMain.fdPayeeBank')}
                     </td>
                      <fssc:checkUseBank fdBank="BOC">
                     	<td class="td_normal_title" width="8%" align="center">
                          ${lfn:message('fssc-loan:fsscLoanMain.fdBankAccountNo')}
                   	 </td>
                     </fssc:checkUseBank>
                     <fssc:checkUseBank fdBank="CMB">
                     	<td class="td_normal_title" width="8%" align="center">
                          ${lfn:message('fssc-loan:fsscLoanMain.fdAccountAreaName')}
                   	 </td>
                     </fssc:checkUseBank>
                      <td class="td_normal_title" width="8%" align="center">
                         ${lfn:message('fssc-loan:fsscLoanMain.fdPayeeAccount')}
                     </td>
          
                   </tr>
                   <tr>
                    <td width="12%" align="center">
                        <%-- 付款方式--%>
                        <div id="_xform_fdBasePayWayId" _xform_type="dialog">
                            <xform:dialog propertyId="fdBasePayWayId" propertyName="fdBasePayWayName" showStatus="view" style="width:95%;">
                                dialogSelect(false,'fssc_base_pay_way_getPayWay','fdBasePayWayId','fdBasePayWayName');
                            </xform:dialog>
                        </div>
                    </td>
                    <td width="12%" align="center">
                        <%-- 收款账户名--%>
                        <div id="_xform_fdAccPayeeName" _xform_type="text">
                            <xform:text property="fdAccPayeeName" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                     <td width="12%" align="center">
                        <%-- 收款人开户行--%>
                        <div id="_xform_fdPayeeBank" _xform_type="text">
                            <xform:text property="fdPayeeBank" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                    <fssc:checkUseBank fdBank="BOC">
                     <td width="12%" align="center">
                     	<div id="_xform_fdBankAccountNo" _xform_type="text">
                            <xform:text property="fdBankAccountNo" showStatus="view" style="width:95%;" />
                        </div>
                       </td>
                    </fssc:checkUseBank>
                     <fssc:checkUseBank  fdBank="CMB">
					 	<td   width="12%" align="center">
		                     	<div id="_xform_fdAccountAreaName" _xform_type="dialog">
		                         <xform:dialog propertyId="" propertyName="fdAccountAreaName" required="true" showStatus="view"  subject="${lfn:message('fssc-loan:fsscLoanMain.fdAccountAreaCode')}" validators=" maxLength(200)" style="width:85%;"  >
		                         dialogSelect(false,'fssc_cmb_account_area','fdAccountAreaCode','fdAccountAreaName',null,null,selectFdAccountAreaCallback);
		                         </xform:dialog>
		                         <input name="fdAccountAreaCode" type="hidden" value="${fsscLoanMainForm.fdAccountAreaCode }"/>
		                     	</div>
		               </td>
		            </fssc:checkUseBank>
                    
                    <td width="12%" align="center">
                        <%-- 收款人账户--%>
                        <div id="_xform_fdPayeeAccount" _xform_type="text">
                            <xform:text property="fdPayeeAccount" showStatus="view" style="width:95%;" />
                        </div>
                    </td>
                   
                </tr>
            </table>
            <c:if test="${not empty fsscLoanMainForm.fdRemind }">
                <div class="lui_paragraph_title">
                    <span class="lui_icon_s lui_icon_s_icon_18"></span>${ lfn:message('fssc-loan:fsscLoanMain.fdRemind') }
                </div>
                <table class="tb_normal" width="100%" >
                    <tr>
                        <td width="100%">
                            <%-- 提示信息--%>
                            <div id="_xform_fdRemind" _xform_type="dialog">
                                <span class="txtstrong">${fsscLoanMainForm.fdRemind }</span>
                            </div>
                        </td>
                    </tr>
                </table>
            </c:if>
            <c:if test="${param.approveModel ne 'right'}">
             <c:if test="${fsscLoanMainForm.docUseXform == 'true' || empty fsscLoanMainForm.docUseXform}">
					<ui:content title="${lfn:message('fssc-loan:py.BiaoDanNeiRong')}" expand="true">
						<c:import url="/sys/xform/include/sysForm_view.jsp"
							charEncoding="UTF-8">
							<c:param name="formName" value="fsscLoanMainForm" />
							<c:param name="fdKey" value="fsscLoanMain" />
							<c:param name="useTab" value="false" />
						</c:import>
					</ui:content>
				</c:if>
            	<c:import url="/fssc/loan/fssc_loan_main/fsscLoanMain_view_content_import.jsp" charEncoding="UTF-8"></c:import>
	            <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="fsscLoanMainForm" />
					<c:param name="fdKey" value="fsscLoanMain" />
					<c:param name="isExpand" value="true" />
				</c:import>
				 <%--关联机制 --%>
	             <template:replace name="nav">
					<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="fsscLoanMainForm" />
					</c:import>
				</template:replace>
	            <%--传阅 --%>
	             <c:import url="/sys/circulation/import/sysCirculationMain_view.jsp" charEncoding="UTF-8">
	                  <c:param name="formName" value="fsscLoanMainForm" />
	                  <c:param name="isNew" value="true" />
	             </c:import>
	             <%--权限 --%>
	            <c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
	                        <c:param name="formName" value="fsscLoanMainForm" />
	                        <c:param name="moduleModelName" value="com.landray.kmss.fssc.loan.model.FsscLoanMain" />
	            </c:import> 
			</c:if>
            <c:if test="${param.approveModel eq 'right'}">
            <ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'>
             <c:if test="${fsscLoanMainForm.docUseXform == 'true' || empty fsscLoanMainForm.docUseXform}">
					<ui:content title="${lfn:message('fssc-loan:py.BiaoDanNeiRong')}" expand="true">
						<c:import url="/sys/xform/include/sysForm_view.jsp"
							charEncoding="UTF-8">
							<c:param name="formName" value="fsscLoanMainForm" />
							<c:param name="fdKey" value="fsscLoanMain" />
							<c:param name="useTab" value="false" />
						</c:import>
					</ui:content>
				</c:if>
            	<c:import url="/fssc/loan/fssc_loan_main/fsscLoanMain_view_content_import.jsp" charEncoding="UTF-8"></c:import>
            	<c:choose>
            	<c:when test="${fsscLoanMainForm.docStatus>='30' || fsscLoanMainForm.docStatus=='00'}">
		            <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="fsscLoanMainForm" />
						<c:param name="fdKey" value="fsscLoanMain" />
						<c:param name="isExpand" value="true" />
						<c:param name="approveType" value="right" />
						<c:param name="needInitLbpm" value="true" />
					</c:import>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="fsscLoanMainForm" />
						<c:param name="fdKey" value="fsscLoanMain" />
						<c:param name="isExpand" value="true" />
						<c:param name="approveType" value="right" />
					</c:import>
				</c:otherwise>
				</c:choose>
				 <%--传阅 --%>
          		<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp" charEncoding="UTF-8">
                 <c:param name="formName" value="fsscLoanMainForm" />
                  <c:param name="isNew" value="true" />
          		</c:import>
          		 <%--权限 --%>
	            <c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
	                 <c:param name="formName" value="fsscLoanMainForm" />
	                 <c:param name="moduleModelName" value="com.landray.kmss.fssc.loan.model.FsscLoanMain" />
	            </c:import> 
			</ui:tabpanel>
			</c:if>
            <script type="text/javascript">
                function reinitIframe(iframe) {
                    var iframe = document.getElementById(iframe);
                    try {
                        var bHeight = iframe.contentWindow.document.body.scrollHeight;
                        var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                        var height = Math.max(bHeight,
                            dHeight);
                        if (height < 244) {
                            iframe.height = 244;
                        } else {
                            iframe.height = height;
                        }

                    } catch (ex) {
                    }
                }
            </script>
            <html:hidden property="fdIsChechedSAP" value="${fdIsChechedSAP }"/>
            <html:hidden property="fdExtendFields" value="${fdExtendFields }"/>
            <html:hidden property="fdIsProject" value="${fdIsProject }"/>
            <html:hidden property="fdIsRequiredFee" value="${fdIsRequiredFee }"/>
            <script>
                
                $(function () {
                    setTimeout(function(){
                      	 if('${fdIsRequiredFee}'=='true'){
                           	//设置事前申请必填
                           	$(".tempClass").attr("style","display:block;");
                           }
                      },600);
                });
                //初始化SAP字段
                function initSAP(){
                	 var fdIsChechedSAP = $("input[name='fdIsChechedSAP']").val();
                	    var fdExtendFields = $("input[name='fdExtendFields']").val();
                	    var fdIsProject  = $("input[name='fdIsProject']").val();
                	    if(fdIsProject=='true' && fdIsChechedSAP=="true" ){
                	    	if(fdExtendFields.indexOf("2;1")>-1 || fdExtendFields.indexOf("1;2")>-1){
                	    		 $(".fdBaseProjectContent").attr("colspan", "1");
                	             $(".fdBaseWbs").show();
                	             $(".fdBaseInnerOrder").show();
                	    	}else if(fdExtendFields .indexOf("1")>-1){
                	    	 	 $(".fdBaseProjectContent").attr("colspan", "3");
                	             $(".fdBaseWbs").show();
                	             $(".fdBaseInnerOrder").hide();
                	    	}else if(fdExtendFields .indexOf("2")>-1){
                	    		$(".fdBaseProjectContent").attr("colspan", "3");
                	       	 	$(".fdBaseWbs").hide();
                	       	 	$(".fdBaseInnerOrder").show();
                	    	}else{
                	    	    $(".fdBaseProjectContent").attr("colspan", "5");
                		        $(".fdBaseWbs").hide();
                		        $(".fdBaseInnerOrder").hide();
                	    	}
                	    }else if(fdIsProject=='false' && fdIsChechedSAP=="true"){
                	    	   
                	    	if(fdExtendFields.indexOf("2;1")>-1 || fdExtendFields.indexOf("1;2")>-1){
                	            $(".fdBaseWbs").show();
                	            $(".fdBaseInnerOrder").show();
                	            $("#fdBaseInnerOrders").after("<td colspan='2'></td>");
                		   	}else if(fdExtendFields .indexOf("1")>-1){
                		        $(".fdBaseWbs").show();
                		        $(".fdBaseInnerOrder").hide();
                		        $("#fdBaseInnerOrders").after("<td colspan='4'></td>");
                		   	}else if(fdExtendFields .indexOf("2")>-1){
                		      	$(".fdBaseWbs").hide();
                		      	$(".fdBaseInnerOrder").show();
                		        $("#fdBaseInnerOrders").after("<td colspan='4'></td>");
                		   	}else{
                			    $(".fdBaseWbs").hide();
                			    $(".fdBaseInnerOrder").hide();
                		   	}
                	    }else{
                	    	 $(".fdBaseWbs").hide();
                	         $(".fdBaseInnerOrder").hide();
                	    }
                	}

                //修改可冲销者
                function updateFdOffsetters(){
                    seajs.use(['lui/jquery','lui/dialog'], function($, dialog){
                        dialog.iframe('/fssc/loan/fssc_loan_main/fsscLoanMain.do?method=openUpdateFdOffsetters&fdId=${param.fdId}',
                            '<bean:message key="fsscLoanMain.updateFdOffsetters.botton" bundle="fssc-loan"/>',
                            function( val ) {
                                window.location.reload();//刷新页面
                            },{"width": 800, "height": 360});
                    });
                }

            </script>
        </ui:tabpage>
         <%-- 条形码公共页面 --%>
        <c:import url="/fssc/base/resource/jsp/barcode.jsp" charEncoding="UTF-8">
        	<c:param name="docNumber">${fsscLoanMainForm.docNumber }</c:param>
        </c:import>
    </template:replace>
    <c:if test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
			<!-- 发布后废弃右侧不显示流程信息 -->
			<c:if test="${fsscLoanMainForm.docStatus<'30' && fsscLoanMainForm.docStatus!='00'}">
				<%--流程--%>
				<c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="fsscLoanMainForm" />
					<c:param name="fdKey" value="fsscLoanMain" />
					<c:param name="isExpand" value="true" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 审批记录 -->
				<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="fsscLoanMainForm" />
					<c:param name="fdModelId" value="${fsscLoanMainForm.fdId}" />
					<c:param name="fdModelName" value="com.landray.kmss.fssc.loan.model.FsscLoanMain" />
				</c:import>
				</c:if>
				<!-- 基本信息-->
				<c:import url="/fssc/loan/fssc_loan_main/fsscLoanMain_viewBaseInfoContent.jsp" charEncoding="UTF-8">
				</c:import>
				<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="fsscLoanMainForm" />
				<c:param name="approveType" value="right" />
				</c:import>
			</ui:tabpanel>
		</template:replace>
	</c:if>	