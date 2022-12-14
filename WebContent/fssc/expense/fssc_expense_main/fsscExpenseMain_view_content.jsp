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
            	docStatus:'${fsscExpenseMainForm.docStatus}',
            	approveModel:'${param.approveType}',
            	fdExpenseMainId:'${param.fdId}',
            };
            LUI.ready(function(){
          		var arrayId, arrayName;
            	var fdFeeIds = '${fsscExpenseMainForm.fdFeeIds}';
            	var fdFeeNames = '${fsscExpenseMainForm.fdFeeNames}';
            	arrayId = fdFeeIds.split(";");
            	arrayName = fdFeeNames.split(";");
            	if("" == fdFeeIds) return;
            	for (var i = 0; i < arrayId.length; i++) {
					var id = arrayId[i];
					var name =arrayName[i];
					$("#fdFeeList").append("<a href='${LUI_ContextPath}/fssc/fee/fssc_fee_main/fsscFeeMain.do?method=view&fdId="+id+"' target='_blank'>"+name+";</a>");
				}
            })
            var messageInfo = {

            };
            Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/fssc/expense/resource/js/", 'js', true);
            Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);
            Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/expense/fssc_expense_main/", 'js', true);
            Com_IncludeFile("doclist.js");
            Com_IncludeFile("controlView.js", "${LUI_ContextPath}/fssc/common/resource/js/", "js", true);
            Com_IncludeFile("fsscExpenseMain_view.js", "${LUI_ContextPath}/fssc/expense/fssc_expense_main/", "js", true);
        </script>
    </template:replace>
    <template:replace name="title">
        <c:out value="${fsscExpenseMainForm.docSubject} - " />
        <c:out value="${ lfn:message('fssc-expense:table.fsscExpenseMain') }" />
    </template:replace>
    <template:replace name="path">
       <ui:menu layout="sys.ui.menu.nav">
        <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
		<ui:menu-item text="${ lfn:message('fssc-expense:table.fsscExpenseMain') }" href="/fssc/expense/fssc_expense_main/" target="_self" />
	    <ui:menu-item text="${docTemplateName }"  />
	</ui:menu>
    </template:replace>
    <template:replace name="toolbar">
    <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine=='true'||fsscExpenseMainForm.docStatus=='11' }">
    	<script src="${LUI_ContextPath }/fssc/expense/fssc_expense_main/fsscExpenseMain_submitEvent.js"></script>
    </c:if>
    	<script src="${LUI_ContextPath }/fssc/common/resource/js/Number.js"></script>
        <script>
        	seajs.use(['lui/dialog','lui/util/env'], function(dialog,env) {
        		 /**
              	  * ??????????????????
              	  */
              	 window.checkInvoice=function(){
              		 var index=DocListFunc_GetParentByTagName("TR").rowIndex-1;
              		 var params={"fdDetailId":$("[name='fdInvoiceList_Form["+index+"].fdId']").val(),"fdInvoiceNumber":$("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").val(),"fdInvoiceCode":$("[name='fdInvoiceList_Form["+index+"].fdInvoiceCode']").val()};
                       $.ajax( {
                       	url: env.fn.formatUrl("/fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=checkInvoice"),  
                           type: 'POST', 
                           dataType:"json",
                           data:params,
                           async:false,    
                           success:function(data){
                               if(data.result == "success"){
                                   dialog.success("${lfn:message('return.optSuccess')}");
                                   setTimeout(function(){
                                       window.location.reload();//????????????
                                   },2500);
                               }else if(data.result == "error"){
                                   	dialog.failure(data.error);
                                    }else{
                              	 console.log(data.error);
                              	dialog.failure("${lfn:message('return.optFailure')}");
                               }
                           }
                       });
              	 }
        	});
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
                basePath: '/fssc/expense/fssc_expense_main/fsscExpenseMain.do',
                customOpts: {

                    ____fork__: 0
                }
            };
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
            
            seajs.use(['lui/dialog'],function(dialog){
            	//????????????????????????
            	window.FSSC_GetLeftMoney = function(v,e){
            		var index = e.name.replace(/\S+\[(\d+)\]\S+/g,'$1');
            		var fdOffsetMoney = $("[name='fdOffsetList_Form["+index+"].fdOffsetMoney']").val();
            		var fdCanOffsetMoney = $("[name='fdOffsetList_Form["+index+"].fdCanOffsetMoney']").val();
            		var fdLeftMoney = numSub(fdCanOffsetMoney,fdOffsetMoney)*1;
            		if(isNaN(fdLeftMoney)){
            			return;
            		}
            		$("[name='fdOffsetList_Form["+index+"].fdLeftMoney']").val(fdLeftMoney.toFixed(2));
            		$("[id='_xform_fdOffsetList_Form["+index+"].fdLeftMoney']").html(fdLeftMoney.toFixed(2))
            		var totalStandardMoney = 0;
            		$("[name$=fdApprovedStandardMoney]").each(function(){
            			totalStandardMoney = numAdd(this.value,totalStandardMoney);
            		});
            		if(isNaN(totalStandardMoney)){
            			return;
            		}
            		var len = $("#TABLE_DocList_fdAccountsList_Form>tbody>tr:gt(0)").length;
            		if(len==1){//??????????????????????????????????????????????????????
            			var tr = $("#TABLE_DocList_fdAccountsList_Form>tbody>tr:eq(1)");
            			$("[name$=fdOffsetMoney]").each(function(){
            				if(!isNaN(this.value)){
            					totalStandardMoney = numSub(totalStandardMoney,this.value);
            				}
            			})
            			var fdRate = tr.find("[name$=fdExchangeRate]").val()*1;
            			if(!isNaN(fdRate)&&fdRate!=0){
            				tr.find("[name$=fdMoney]").val(divPoint(totalStandardMoney,fdRate));
            			}
            		}
            	}
            	//??????????????????????????????
            	<c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine=='true' }">
            	Com_AddEventListener(window,'load',function(){
            		var fdId = Com_GetUrlParameter(window.location.href,'fdId');
            		$("#LoanTable").html("");
            		$.post(
            			Com_Parameter.ContextPath+'fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=getLoanData',
            			{fdId:fdId,fdPersonId:'${fsscExpenseMainForm.fdClaimantId}',flag:'edit',fdCompanyId:$("[name=fdCompanyId]").val()},
            			function(rtn){
            				$("#LoanTable").html(rtn);
            			}
            		);
            	})
            	</c:if>
            	window.downloadBankFile = function(){
            		var dia = dialog.loading();
                	$.ajax({
                		url:'${LUI_ContextPath}/fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=checkDownloadBank',
                		data:{ids:'${param.fdId}'},
                		dataType:'json',
                		async:false,
                		success:function(rtn){
                			dia.hide();
                			if(rtn.result=='failure'){
                				dialog.alert(rtn.message);
                			}else{
                				Com_OpenWindow('${LUI_ContextPath}/fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=downloadBankFile&ids=${param.fdId}','_self');
                			}
                		}
                	});
                }
            	
            	//?????????????????????
            	window.reMakePaymentDetail = function(){
            		refreshPaymentForm('${param.fdId}',
            				'TABLE_DocList_fdAccountsList_Form',
            				'1',
            				'fdPayWayId;2',
            				"fdBankId;1",
            				"fdCurrencyId;3",
            				"fdExchangeRate;4",
            				"fdAccountName;5",
            				"fdBankName;7",
            				"fdBankAccount;6",
            				"fdMoney;8"
            				);
                }
            	//????????????????????????
            	window.FSSC_ChangeIsAmortize = function(v,e){
            		var fdIsAmortize = '${fsscExpenseMainForm.fdIsAmortize}';
            		if(fdIsAmortize=='true'){
            			$("#AmortizeInfo").show();
            		}else{
            			$("#AmortizeInfo").hide();
            		}
            	}
            	//????????????????????????????????????????????????
            	$(function(){
            		var fdIsAmortize = '${fsscExpenseMainForm.fdIsAmortize}';
            		if(fdIsAmortize=='true'){
            			$("#AmortizeInfo").show();
            		}else{
            			$("#AmortizeInfo").hide();
            		}
            		var fdIsOffsetLoan = '${fsscExpenseMainForm.fdIsOffsetLoan}';
            		if(fdIsOffsetLoan=='true'){
            			$("#LoanTable").show();
            		}else{
            			$("#LoanTable").hide();
            		}
            	});
            	<c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.confirmPayment eq 'true' }">
            		Com_Parameter.event.submit.push(function(){
            			var pass = true;
                		$.ajax({
                			url:'${LUI_ContextPath}/fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=checkPayment',
                			data:{fdId:'${fsscExpenseMainForm.fdId}'},
                			dataType:'json',
                			async:false,
                			success:function(rtn){
                				var oprGroup = $('input:radio[name="oprGroup"]:checked').val();
                				if(rtn.result == 'success'){
                					if( oprGroup =='handler_pass:??????'){
                						if(!confirm("${lfn:message('fssc-expense:tips.confirmPayment')}")){
											                							
    	                            		pass = false;
    	            					}else{
    	            						$.ajax({
    	            	            			url:'${LUI_ContextPath}/fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=paymentToBank',
    	            	            			data:{fdId:'${fsscExpenseMainForm.fdId}'},
    	            	            			dataType:'json',
    	            	            			async:false,
    	            	            			success:function(rtn){
    	            	            				//?????????????????????
      	            	            				if(rtn.result == 'success'){
      	            	            					dialog.alert(rtn.message);
      	            	            				}else if(rtn.result == 'isCloseAuth'){
      	            	            					dialog.alert(rtn.message);
      	            	            				}else if(rtn.result == 'noHave'){//?????????????????????
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
            		
           		
            })
            
            function seeCheckMsg(){
            	layui.use('layer', function(){
		            	layui.layer.open({
		            		  type: 2,
	            			  offset: 'r',
	            			  title: false,
		            		  area: ['480px', '100%'],
		            		  fixed: false, //?????????
		            		  scrollbar: false,
		            		  shadeClose:true,
		            		  closeBtn: 0,
		            		  maxmin: false,
		            		  anim:5,
		            		  content: '${LUI_ContextPath}/fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=viewMsg&fdExpenseId=${fsscExpenseMainForm.fdId}'
		      	      });   
            	});
            }
            
        </script>
        <!-- ??????????????????????????????????????????????????????????????????????????? -->
        <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine=='true' }">
        	<script>
        		$(document).ready(function(){
        			var len=$("#TABLE_DocList_fdDetailList_Form").find("input[name*='fdInputTaxMoney']").length;
        			for(var n=0;n<len;n++){
        				var inputTaxMoney=$("input[name='fdDetailList_Form["+n+"].fdInputTaxMoney']").val();
        				if(!inputTaxMoney){
        					var validator=$("input[name='fdDetailList_Form["+n+"].fdInputTaxMoney']").attr("validate");
        					if(validator){
        						$("input[name='fdDetailList_Form["+n+"].fdInputTaxMoney']").attr("validate",validator.replace('required',''));
        					}
        				}
        			}
        		});
        	</script>
        </c:if>
        <link rel="stylesheet" href="../resource/layui/css/layui.css"  media="all">
        <script src="../resource/layui/layui.js" charset="utf-8"></script>
        <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="7">
			<c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.payment eq 'true' and (empty fsscExpenseMainForm.fdIsExportBank or fsscExpenseMainForm.fdIsExportBank eq '1')}">
                <kmss:auth requestURL="/fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=downloadBankFile&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('fssc-expense:button.exportBankFile')}" onclick="downloadBankFile()" order="2" />
                </kmss:auth>
            </c:if>
             <c:if test="${fsscExpenseMainForm.docStatus=='20' || fsscExpenseMainForm.docStatus=='30' }">
            	<ui:button text="${lfn:message('fssc-expense:fssc.expense.msg.40')}" onclick="seeCheckMsg();" order="2" />
            </c:if>
            <c:if test="${ fsscExpenseMainForm.docStatus=='10' || fsscExpenseMainForm.docStatus=='11' || fsscExpenseMainForm.docStatus=='20' }">
                <!--edit-->
                <kmss:auth requestURL="/fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscExpenseMain.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
            </c:if>
            <!--????????????-->
            <kmss:auth requestURL="/fssc/voucher/fssc_voucher_main/fsscVoucherMain.do?method=refreshVoucher&fdId=${param.fdId}&fdModelName=com.landray.kmss.fssc.expense.model.FsscExpenseMain">
                <c:if test="${not empty fsscExpenseMainForm.fdVoucherStatus }">
                	<ui:button text="${lfn:message('fssc-expense:button.refresh.voucher')}" id="bookkeepingButton" onclick="refreshVoucher();" order="2" />
                </c:if>
            </kmss:auth>
            <!--?????????????????????-->
             <kmss:auth requestURL="/fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=refreshPaymentForm&fdId=${param.fdId}">
                <ui:button text="${lfn:message('fssc-expense:button.refresh.paymentForm')}" id="paymentFormButton" onclick="reMakePaymentDetail();" order="3" />
            </kmss:auth>
            <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.voucherVariant=='true'}">
                <c:if test="${empty fsscExpenseMainForm.fdBookkeepingStatus || fsscExpenseMainForm.fdBookkeepingStatus == '10' || fsscExpenseMainForm.fdBookkeepingStatus == '11'}" >
                    <!--??????-->
                    <ui:button text="${lfn:message('fssc-expense:button.bookkeeping')}" id="bookkeepingButton" onclick="bookkeeping();" order="2" />
                </c:if>
            </c:if>
            <!--???????????????-->
            <ui:button text="${lfn:message('fssc-expense:button.print.sticky.note')}" onclick="Com_OpenWindow('fsscExpenseMain.do?method=print&type=stickyNote&fdId=${param.fdId}', '_self');" order="4" />
            <!--???????????????-->
            <ui:button text="${lfn:message('fssc-expense:button.print.expense.note')}" onclick="Com_OpenWindow('fsscExpenseMain.do?method=print&type=expenseNote&fdId=${param.fdId}', '_self');" order="5" />
            <!--delete-->
            <kmss:auth requestURL="/fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=delete&fdId=${param.fdId}">
                <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('fsscExpenseMain.do?method=delete&fdId=${param.fdId}');" order="6" />
            </kmss:auth>
            <ui:button text="${lfn:message('button.close')}" order="7" onclick="Com_CloseWindow();" />
        </ui:toolbar>
    </template:replace>
    <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
            <ui:menu-item text="${ lfn:message('fssc-expense:table.fsscExpenseMain') }" href="/fssc/expense/fssc_expense_main/" target="_self" />
             <ui:menu-item text="${docTemplateName }"  />
        </ui:menu>
    </template:replace>
    <template:replace name="content">
    <c:import url="/sys/recycle/import/redirect.jsp">
		<c:param name="formBeanName" value="fsscExpenseMainForm"></c:param>
	</c:import>
    <!-- ?????????????????? -->
	<c:import url="/fssc/base/resource/jsp/fssc_banner.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="fsscExpenseMainForm" />
		<c:param name="approveType" value="${param.approveType}" />
	</c:import>
<c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine=='true' && param.approveType ne 'right' }">
	<form action="${LUI_ContextPath }/fssc/expense/fssc_expense_main/fsscExpenseMain.do" name="fsscExpenseMainForm"  method="post">
</c:if>
            <ui:tabpage expand="false" collapsed="true" var-navwidth="90%" id="reviewTabPage">
            <c:if test="${param.approveType eq 'right'}">
            <script>
					LUI.ready(function(){
						setTimeout(function(){
							var reviewTabPage = LUI("reviewTabPage");
							if(reviewTabPage!=null){
								reviewTabPage.element.find(".lui_tabpage_float_collapse").hide();
								reviewTabPage.element.find(".lui_tabpage_float_navs_mark").hide();
							}
						},100)
					})
				</script>
				</c:if>
                    <div class='lui_form_title_frame'>
                        <div class='lui_form_subject'>
                            <c:if test="${empty fsscExpenseMainForm.docSubject }">
                          		${ docTemplate.fdName}
                          	</c:if>
                          	<c:if test="${not empty fsscExpenseMainForm.docSubject }">
                          		${ fsscExpenseMainForm.docSubject}
                          	</c:if>
                        </div>
                        <%--?????????--%>
		                <div id="barcodeTarget" style="float:right;margin-right:10px;margin-top: -20px;" ></div>
                    </div>
                    <table class="tb_normal" width="100%">
                    	<tr>
                        	<td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-expense:fsscExpenseMain.docSubject')}
                            </td>
                            <td colspan="5">
                                <div id="_xform_docSubject" _xform_type="address">
                                    <xform:text property="docSubject" style="width:95%"></xform:text>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-expense:fsscExpenseMain.fdClaimant')}
                            </td>
                            <td width="16.6%">
                                <div id="_xform_fdClaimantId" _xform_type="address">
                                    <xform:address propertyId="fdClaimantId" propertyName="fdClaimantName" orgType="ORG_TYPE_PERSON" showStatus="view" style="width:95%;" />
                                    <xform:text property="fdClaimantId" showStatus="noShow"></xform:text>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-expense:fsscExpenseMain.fdCompany')}
                            </td>
                            <td width="16.6%">
                                <div id="_xform_fdCompanyId" _xform_type="dialog">
                                    <xform:dialog propertyId="fdCompanyId" propertyName="fdCompanyName" showStatus="view" style="width:95%;">
                                        dialogSelect(false,'fssc_base_company_fdCompany','fdCompanyId','fdCompanyName');
                                    </xform:dialog>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-expense:fsscExpenseMain.fdCostCenter')}
                            </td>
                            <td width="16.6%">
                                <div id="_xform_fdCostCenterId" _xform_type="dialog">
                                    <xform:dialog propertyId="fdCostCenterId" propertyName="fdCostCenterName" showStatus="view" style="width:95%;">
                                        dialogSelect(false,'fssc_base_cost_center_selectCostCenter','fdCostCenterId','fdCostCenterName');
                                    </xform:dialog>
                                </div>
                            </td>
                        </tr>
                        <c:if test="${docTemplate.fdIsFee=='true' }">
                            <tr>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-expense:fsscExpenseMain.fdFeeNames')}
                                </td>
                                <td colspan="5" width="83.0%">
                                	<div style="color:#83C2EB" id="_xform_fdContent" _xform_type="textarea">
                                    	<span id="fdFeeList"></span>
                                        <span id="closeFeeMain" style="color:#000;">
										&nbsp &nbsp
										<c:if test="${fsscExpenseMainForm.fdIsCloseFee=='true'}">
											<input disabled="disabled" type="checkbox" checked/>${lfn:message('fssc-expense:fsscExpenseMain.fdIsCloseFee')}
										</c:if>
										</span>
										<xform:text property="fdFeeIds" showStatus="noShow"></xform:text>
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                        <c:if test="${docTemplate.fdIsProapp=='true' }">
                            <tr>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-expense:fsscExpenseMain.fdProappName')}
                                </td>
                                <td colspan="5" width="83.0%">
                                	<div style="color:#83C2EB" id="_xform_fdContent" _xform_type="textarea">
                                    	<a target="_blank" href="${LUI_ContextPath }/fssc/proapp/fssc_proapp_main/fsscProappMain.do?method=view&fdId=${fsscExpenseMainForm.fdProappId}">${fsscExpenseMainForm.fdProappName }</a>
                                    	<input type="hidden" name="fdProappId" value="${fsscExpenseMainForm.fdProappId }">
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${docTemplate.fdIsAmortize=='true' }">
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-expense:fsscExpenseMain.fdIsAmortize')}
                            </td>
                            <td colspan="5" width="83.0%">
                                <div id="_xform_fdContent" _xform_type="textarea">
                                    <xform:radio property="fdIsAmortize" onValueChange="FSSC_ChangeIsAmortize" required="true">
                                    	<xform:enumsDataSource enumsType="common_yesno"/>
                                    </xform:radio>
                                </div>
                            </td>
                        </tr>
                        </c:if>
                        <c:if test="${docTemplate.fdIsProject=='true'&&(docTemplate.fdIsProjectShare=='false' or empty docTemplate.fdIsProjectShare) }">
                            <tr>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-expense:fsscExpenseMain.fdProject')}
                                </td>
                                <td colspan="5" width="83.0%">
                                    <div id="_xform_fdContent" _xform_type="textarea">
                                        <xform:dialog propertyName="fdProjectName" propertyId="fdProjectId" style="width:85%;" required="true" subject="${lfn:message('fssc-expense:fsscExpenseMain.fdProject')}">
                                        	dialogSelect(false,'fssc_base_project_project','fdProjectId','fdProjectName',null,{'fdCompanyId':$('[name=fdCompanyId]').val()});
                                        </xform:dialog>
                                        <xform:text property="fdProjectId" value="${fsscExpenseMainForm.fdProjectId}" showStatus="noShow"></xform:text>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'8')>-1 }">
                            <tr>
                                <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-expense:fsscExpenseMain.fdProjectAccounting')}
                                </td>
                                <td colspan="5" width="83.0%">
                                    <div id="_xform_fdContent" _xform_type="textarea">
                                        <xform:dialog propertyName="fdProjectAccountingName" propertyId="fdProjectAccountingId" style="width:85%;" required="true" subject="${lfn:message('fssc-expense:fsscExpenseMain.fdProjectAccounting')}">
                                        	dialogSelect(false,'fssc_base_project_project','fdProjectAccountingId','fdProjectAccountingName',null,{'fdCompanyId':$('[name=fdCompanyId]').val()});
                                        </xform:dialog>
                                    </div>
                                </td>
                            </tr>
                        </c:if>   
                        <tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-expense:fsscExpenseMain.fdContent')}
                            </td>
                            <td colspan="5" width="83.0%">
                                <div id="_xform_fdContent" _xform_type="textarea">
                                    <xform:textarea property="fdContent" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
						<tr>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-expense:fsscExpenseMain.fdAttNumber')}
                            </td>
                            <td width="16.6%">
                                <div id="_xform_fdTotalApprovedMoney" _xform_type="text">
                                    <xform:text property="fdAttNumber" required="true" style="width:85%;" validators="digits min(0)"/>
                                </div>
                            </td>
                        <%--#128275 ????????????--%>
                            <td class="td_normal_title" width="16.6%">
                                ${lfn:message('fssc-expense:fsscExpenseMain.fdTotalStandaryMoney')} 
                            </td>
                            <td width="16.6%">
                                <div id="_xform_fdTotalStandary" _xform_type="text">
                                    &nbsp;<kmss:showNumber value="${fsscExpenseMainForm.fdTotalStandaryMoney }" pattern="###,##0.00"/>
                                    <xform:text property="fdTotalStandaryMoney" showStatus="noShow"></xform:text>
                            		<div id="fdTotalStandaryUpperMoney" style="padding-left:4px;"></div>
                                </div>
                            </td>
                            <td class="td_normal_title" width="16.6%">
                                    ${lfn:message('fssc-expense:fsscExpenseMain.fdTotalApprovedMoney')}
                            </td>
                            <td width="16.6%">
                                <div id="_xform_fdTotalApprovedMoney" _xform_type="text">
                                    <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine=='true' }">
                                    	<input name="fdTotalApprovedMoney" value="<kmss:showNumber value="${fsscExpenseMainForm.fdTotalApprovedMoney }" pattern="#####0.00"/>" readonly="readonly" class="inputsgl" style="color:#333;" />
                            		</c:if>
                                	<c:if test="${empty fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine}">
                                    	<kmss:showNumber value="${fsscExpenseMainForm.fdTotalApprovedMoney }" pattern="###,##0.00"/>
                                    	<xform:text property="fdTotalApprovedMoney" showStatus="noShow"></xform:text>
                            		</c:if>
                            		<div id="fdTotalApprovedUpperMoney" style="padding-left:4px;"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width=15%>
                                    ${lfn:message('fssc-expense:fsscExpenseMain.attachment')}
                            </td>
                            <td  colspan="5" width="83.0%">
                                <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
                                    <c:param name="fdKey" value="invoice"/>
                                    <c:param name="formBeanName" value="fsscExpenseMainForm" />
                                </c:import>
                            </td>
                        </tr>
                    </table>
               	<c:if test="${param.approveType ne 'right'}">
                <c:if test="${docTemplate.fdExpenseType eq '2' and docTemplate.fdIsTravelAlone eq 'true'}">
                <c:import url="/fssc/expense/fssc_expense_travel_detail/fsscExpenseTravelDetail_view_include.jsp"></c:import>
                </c:if>
                <c:import url="/fssc/expense/fssc_expense_detail/fsscExpenseDetail_view_include.jsp"></c:import>
                <!-- ????????????????????????????????????????????????????????? -->
                <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine eq 'true' or not empty fsscExpenseMainForm.fdInvoiceList_Form }">
                <c:import url="/fssc/expense/fssc_expense_invoice_detail/fsscExpenseInvoiceDetail_view_include.jsp"></c:import>
                </c:if>
                <!-- ????????????????????????????????????????????????????????? -->
                <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine eq 'true' or not empty fsscExpenseMainForm.fdOffsetList_Form }">
                <kmss:ifModuleExist path="/fssc/loan">
                <c:import url="/fssc/expense/fssc_expense_offset_detail/fsscExpenseOffsetDetail_view_include.jsp"></c:import>
                </kmss:ifModuleExist>
                </c:if>
                <!-- ??????????????????????????????????????????????????????????????? -->
                <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine eq 'true' or not empty fsscExpenseMainForm.fdAccountsList_Form }">
                <c:import url="/fssc/expense/fssc_expense_accounts_detail/fsscExpenseAccountsDetail_view_include.jsp"></c:import>
                </c:if>
                <c:if test="${fsscExpenseMainForm.docUseXform == 'true' || empty fsscExpenseMainForm.docUseXform}">
					<ui:content title="${lfn:message('fssc-expense:py.BiaoDanNeiRong')}" expand="true">
						<c:import url="/sys/xform/include/sysForm_view.jsp"
							charEncoding="UTF-8">
							<c:param name="formName" value="fsscExpenseMainForm" />
							<c:param name="fdKey" value="fsscExpenseMain" />
							<c:param name="useTab" value="false" />
						</c:import>
					</ui:content>
				</c:if>
				<c:import url="/fssc/expense/fssc_expense_main/fsscExpenseMain_provision_include.jsp"></c:import>
                <c:import url="/fssc/expense/fssc_expense_main/fsscExpenseMain_baseInfo.jsp"></c:import>
                <c:if test="${not empty fsscExpenseMainForm.fdPaymentStatus }">
                <kmss:ifModuleExist path="/fssc/cashier/">
                	<fssc:auth authType="staff" fdCompanyId="${fsscExpenseMainForm.fdCompanyId}">
                		<c:set var="cashier_auth" value="true"></c:set>
                	</fssc:auth>
                	<kmss:authShow roles="ROLE_FSSCCASHIER_DEFAULT">
	            		<c:set var="cashier_default" value="true"></c:set>
	            	</kmss:authShow>
	            	
                	<c:if test="${cashier_auth || cashier_default}">
		                <ui:content title="${lfn:message('fssc-cashier:table.fsscCashierPaymentDetail')}" expand="true" id="paymentDetail_content">
							<div>
								<list:listview id="listview_paymentDetail" channel="paymentDetail">
									<ui:source type="AjaxJson">
										{url:'/fssc/cashier/fssc_cashier_payment_detail/fsscCashierPaymentDetail.do?method=detailData&fdModelId=${fsscExpenseMainForm.fdId}&fdModelName=com.landray.kmss.fssc.expense.model.FsscExpenseMain'}
									</ui:source>
									<c:if test="${cashier_auth}">
									<list:colTable rowHref="/fssc/cashier/fssc_cashier_payment/fsscCashierPayment.do?method=view&fdId=!{docMain.fdId}" layout="sys.ui.listview.listtable">
										<list:col-auto props="fdCompany.name;fdBasePayBank.name;fdBasePayWay.name;fdBaseCurrency.name;fdRate;fdPayeeName;fdPayeeAccount;fdPayeeBankName;fdPaymentMoney;fdStatus.name;fdPlanPaymentDate;" ></list:col-auto>
									</list:colTable>
									</c:if>
									<c:if test="${!cashier_auth && cashier_default}">
									<list:colTable rowHref="" layout="sys.ui.listview.listtable">
										<list:col-auto props="fdCompany.name;fdBasePayBank.name;fdBasePayWay.name;fdBaseCurrency.name;fdRate;fdPayeeName;fdPayeeAccount;fdPayeeBankName;fdPaymentMoney;fdStatus.name;fdPlanPaymentDate;" ></list:col-auto>
									</list:colTable>
									</c:if>
								</list:listview>
								<list:paging></list:paging>
							</div>
						</ui:content>
					</c:if>
				<script src="${LUI_ContextPath }/fssc/cashier/fssc_cashier_payment_detail/fsscCashierPaymentDetail.js"></script>
                </kmss:ifModuleExist>
                </c:if>
                <c:if test="${not empty fsscExpenseMainForm.fdVoucherStatus }">
                <kmss:ifModuleExist path="/fssc/voucher/">
                <c:set var="voucherView"  value="false"></c:set>
	            <!-- ?????????????????? -->
	            <kmss:authShow roles="ROLE_FSSCVOUCHER_VIEW">
	            	<c:set var="voucherView"  value="true"></c:set>
	            </kmss:authShow>
	            <!-- ???????????? -->
	            <fssc:auth authType="staff" fdCompanyId="${fsscExpenseMainForm.fdCompanyId}">
	            	<c:set var="voucherView"  value="true"></c:set>
	            </fssc:auth>
	            <!-- ?????????????????? -->
	            <kmss:auth requestURL="/fssc/voucher/fssc_voucher_main/fsscVoucherMain.do?method=refreshVoucher&fdId=${param.fdId}&fdModelName=com.landray.kmss.fssc.expense.model.FsscExpenseMain">
	            	<c:set var="voucherView"  value="true"></c:set>
	            </kmss:auth>
	            <c:if test="${voucherView=='true'}">
                    <ui:content title="${lfn:message('fssc-voucher:fsscVoucherMain.title.message')}" expand="true">
                        <c:import url="/fssc/voucher/fssc_voucher_main/fsscVoucherMain_modelView.jsp" charEncoding="UTF-8">
                            <c:param name="fdModelId" value="${fsscExpenseMainForm.fdId}" />
                            <c:param name="fdModelName" value="com.landray.kmss.fssc.expense.model.FsscExpenseMain" />
                            <c:param name="fdModelNumber" value="${fsscExpenseMainForm.docNumber}" />
                            <c:param name="fdBookkeepingStatus" value="${fsscExpenseMainForm.fdBookkeepingStatus}" />
                            <c:param name="fdIsVoucherVariant" value="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.voucherVariant}" />
                        </c:import>
                    </ui:content>
                </c:if>
                </kmss:ifModuleExist>
                </c:if>
                <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine=='true' }">
                <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="fsscExpenseMainForm" />
                    <c:param name="fdKey" value="fsscExpenseMain" />
                    <c:param name="isExpand" value="true" />
                    <c:param name="approveType" value="${approveType }" />
                    <c:param name="onClickSubmitButton" value="Com_Submit(document.fsscExpenseMainForm,'publishDraft');" />
                </c:import>
                </c:if>
                <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine!='true' }">
                <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="fsscExpenseMainForm" />
                    <c:param name="fdKey" value="fsscExpenseMain" />
                    <c:param name="approveType" value="${approveType }" />
                    <c:param name="isExpand" value="true" />
                </c:import>
                </c:if>
                 <%--?????? --%>
	                <c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
	                        <c:param name="formName" value="fsscExpenseMainForm" />
	                        <c:param name="moduleModelName" value="com.landray.kmss.fssc.expense.model.FsscExpenseMain" />
	                </c:import>
                <%--???????????? --%>
                <c:import url="/sys/circulation/import/sysCirculationMain_view.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="fsscExpenseMainForm" />
                    <c:param name="isNew" value="true" />
                </c:import>
                </c:if>
                <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.payment == 'true' }">
                <c:import url="/fssc/base/fssc_base_payment/fsscBasePayment_include.jsp">
                	<c:param name="fdModelName" value="com.landray.kmss.fssc.expense.model.FsscExpenseMain"/>
                	<c:param name="fdModelId" value="${fsscExpenseMainForm.fdId }"/>
                </c:import>
                </c:if>
                <c:if test="${param.approveType eq 'right'}">
				<ui:tabpanel suckTop="false" layout="sys.ui.tabpanel.sucktop" var-count="10" var-average='false' var-useMaxWidth='true'>
					<c:if test="${docTemplate.fdExpenseType eq '2' and docTemplate.fdIsTravelAlone eq 'true'}">
	                <c:import url="/fssc/expense/fssc_expense_travel_detail/fsscExpenseTravelDetail_view_include.jsp"></c:import>
	                </c:if>
	                <c:import url="/fssc/expense/fssc_expense_detail/fsscExpenseDetail_view_include.jsp"></c:import>
	                <c:import url="/fssc/expense/fssc_expense_invoice_detail/fsscExpenseInvoiceDetail_view_include.jsp"></c:import>
	                <kmss:ifModuleExist path="/fssc/loan">
	                <c:import url="/fssc/expense/fssc_expense_offset_detail/fsscExpenseOffsetDetail_view_include.jsp"></c:import>
	                </kmss:ifModuleExist>
	                <c:import url="/fssc/expense/fssc_expense_accounts_detail/fsscExpenseAccountsDetail_view_include.jsp"></c:import>
	                <c:import url="/fssc/expense/fssc_expense_main/fsscExpenseMain_provision_include.jsp"></c:import>
	                <c:if test="${fsscExpenseMainForm.docUseXform == 'true' || empty fsscExpenseMainForm.docUseXform}">
						<ui:content title="${lfn:message('fssc-expense:py.BiaoDanNeiRong')}" expand="true">
							<c:import url="/sys/xform/include/sysForm_view.jsp"
								charEncoding="UTF-8">
								<c:param name="formName" value="fsscExpenseMainForm" />
								<c:param name="fdKey" value="fsscExpenseMain" />
								<c:param name="useTab" value="false" />
							</c:import>
						</ui:content>
					</c:if>
	                <c:import url="/fssc/expense/fssc_expense_main/fsscExpenseMain_baseInfo.jsp"></c:import>
	                <c:if test="${not empty fsscExpenseMainForm.fdPaymentStatus }">
		                <kmss:ifModuleExist path="/fssc/cashier/">
		                	<fssc:auth authType="staff" fdCompanyId="${fsscExpenseMainForm.fdCompanyId}">
		                		<c:set var="cashier_auth" value="true"></c:set>
		                	</fssc:auth>
		                	<kmss:authShow roles="ROLE_FSSCCASHIER_DEFAULT">
			            		<c:set var="cashier_default" value="true"></c:set>
			            	</kmss:authShow>
			            	
		                	<c:if test="${cashier_auth || cashier_default}">
				                <ui:content title="${lfn:message('fssc-cashier:table.fsscCashierPaymentDetail')}" expand="true" id="paymentDetail_content">
									<div>
										<list:listview id="listview_paymentDetail" channel="paymentDetail">
											<ui:source type="AjaxJson">
												{url:'/fssc/cashier/fssc_cashier_payment_detail/fsscCashierPaymentDetail.do?method=detailData&fdModelId=${fsscExpenseMainForm.fdId}&fdModelName=com.landray.kmss.fssc.expense.model.FsscExpenseMain'}
											</ui:source>
											<c:if test="${cashier_auth}">
											<list:colTable rowHref="/fssc/cashier/fssc_cashier_payment/fsscCashierPayment.do?method=view&fdId=!{docMain.fdId}" layout="sys.ui.listview.listtable">
												<list:col-auto props="fdCompany.name;fdBasePayBank.name;fdBasePayWay.name;fdBaseCurrency.name;fdRate;fdPayeeName;fdPayeeAccount;fdPayeeBankName;fdPaymentMoney;fdStatus.name;fdPlanPaymentDate;" ></list:col-auto>
											</list:colTable>
											</c:if>
											<c:if test="${!cashier_auth && cashier_default}">
											<list:colTable rowHref="" layout="sys.ui.listview.listtable">
												<list:col-auto props="fdCompany.name;fdBasePayBank.name;fdBasePayWay.name;fdBaseCurrency.name;fdRate;fdPayeeName;fdPayeeAccount;fdPayeeBankName;fdPaymentMoney;fdStatus.name;fdPlanPaymentDate;" ></list:col-auto>
											</list:colTable>
											</c:if>
										</list:listview>
										<list:paging></list:paging>
									</div>
								</ui:content>
							</c:if>
							<script src="${LUI_ContextPath }/fssc/cashier/fssc_cashier_payment_detail/fsscCashierPaymentDetail.js"></script>
		                </kmss:ifModuleExist>
	                </c:if>
	                <c:if test="${not empty fsscExpenseMainForm.fdVoucherStatus }">
		                <kmss:ifModuleExist path="/fssc/voucher/">
			                <c:set var="voucherView"  value="false"></c:set>
				            <!-- ?????????????????? -->
				            <kmss:authShow roles="ROLE_FSSCVOUCHER_VIEW">
				            	<c:set var="voucherView"  value="true"></c:set>
				            </kmss:authShow>
				            <!-- ???????????? -->
				            <fssc:auth authType="staff" fdCompanyId="${fsscExpenseMainForm.fdCompanyId}">
				            	<c:set var="voucherView"  value="true"></c:set>
				            </fssc:auth>
				            <!-- ?????????????????? -->
				            <kmss:auth requestURL="/fssc/voucher/fssc_voucher_main/fsscVoucherMain.do?method=refreshVoucher&fdId=${param.fdId}&fdModelName=com.landray.kmss.fssc.expense.model.FsscExpenseMain">
				            	<c:set var="voucherView"  value="true"></c:set>
				            </kmss:auth>
				            <c:if test="${voucherView=='true'}">
			                    <ui:content title="${lfn:message('fssc-voucher:fsscVoucherMain.title.message')}" expand="true">
			                        <c:import url="/fssc/voucher/fssc_voucher_main/fsscVoucherMain_modelView.jsp" charEncoding="UTF-8">
			                            <c:param name="fdModelId" value="${fsscExpenseMainForm.fdId}" />
			                            <c:param name="fdModelName" value="com.landray.kmss.fssc.expense.model.FsscExpenseMain" />
			                            <c:param name="fdModelNumber" value="${fsscExpenseMainForm.docNumber}" />
			                            <c:param name="fdBookkeepingStatus" value="${fsscExpenseMainForm.fdBookkeepingStatus}" />
			                            <c:param name="fdIsVoucherVariant" value="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.voucherVariant}" />
			                        </c:import>
			                    </ui:content>
			                </c:if>
		                </kmss:ifModuleExist>
	                </c:if>
					<%--??????--%>
					<c:if test="${ fsscExpenseMainForm.docStatus eq '30' or fsscExpenseMainForm.docStatus eq '00' }">
					<c:import url="/sys/workflow/import/sysWfProcess_view.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="fsscExpenseMainForm" />
						<c:param name="fdKey" value="fsscExpenseMain" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="isExpand" value="true" />
						<c:param name="approveType" value="right" />
						<c:param name="needInitLbpm" value="true" />
					</c:import>
					</c:if>
					<c:if test="${ fsscExpenseMainForm.docStatus ne '30' and fsscExpenseMainForm.docStatus ne '00' }">
	                <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine=='true' }">
	                <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
	                    <c:param name="formName" value="fsscExpenseMainForm" />
	                    <c:param name="fdKey" value="fsscExpenseMain" />
	                    <c:param name="isExpand" value="true" />
	                    <c:param name="approveType" value="${param.approveType }" />
	                </c:import>
	                </c:if>
	                <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine!='true' }">
	                <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
	                    <c:param name="formName" value="fsscExpenseMainForm" />
	                    <c:param name="fdKey" value="fsscExpenseMain" />
	                    <c:param name="approveType" value="${param.approveType }" />
	                    <c:param name="isExpand" value="true" />
	                </c:import>
	                </c:if>
	                </c:if>
	                <%--?????? --%>
	                <c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
	                        <c:param name="formName" value="fsscExpenseMainForm" />
	                        <c:param name="moduleModelName" value="com.landray.kmss.fssc.expense.model.FsscExpenseMain" />
	                </c:import>
	                <%--???????????? --%>
	                <c:import url="/sys/circulation/import/sysCirculationMain_view.jsp" charEncoding="UTF-8">
	                    <c:param name="formName" value="fsscExpenseMainForm" />
	                    <c:param name="isNew" value="true" />
	                    <c:param name="order" value="10" />
	                </c:import>
				</ui:tabpanel>
			</c:if>
            </ui:tabpage>
            <html:hidden property="fdBudgetShowType" value="${docTemplate.fdBudgetShowType }"/>
            <html:hidden property="docTemplateId" value="${docTemplate.fdId }"/>
            <html:hidden property="fdCompanyId" value="${fsscExpenseMainForm.fdCompanyId }"/>
            <html:hidden property="fdExpenseType" value="${docTemplate.fdExpenseType }"/>
            <html:hidden property="fdAllocType" value="${docTemplate.fdAllocType }"/>
            <input type="hidden" name="fdIsTravelAlone" value="${docTemplate.fdIsTravelAlone }"/>
            <html:hidden property="method_GET" value="${fsscExpenseMainForm.method_GET }"/>
            <input type="hidden" name="fdDeduFlag" value="${fdDeduFlag}" />
            <fssc:checkVersion version="true">
            <html:hidden property="checkVersion" value="true"/>
            </fssc:checkVersion>
            <input name="feeLedgerObj" value='${feeLedgerObj}' type="hidden" />
			<input name="budgetObj" value='${budgetObj}'  type="hidden" />
        <%-- ????????????????????? --%>
        <c:import url="/fssc/base/resource/jsp/barcode.jsp" charEncoding="UTF-8">
        	<c:param name="docNumber">${fsscExpenseMainForm.docNumber }</c:param>
        </c:import>
        <c:if test="${fsscExpenseMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.examine=='true' and param.approveType ne 'right' }">
			</form>
		</c:if>
    </template:replace>
    <c:if test="${param.approveType eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
				<c:if test="${ fsscExpenseMainForm.docStatus ne '30' and fsscExpenseMainForm.docStatus ne '00' }">
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="fsscExpenseMainForm" />
					<c:param name="fdKey" value="fsscExpenseMain" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
					<c:param name="onClickSubmitButton" value="Com_Submit(document.fsscExpenseMainForm,'publishDraft');" />
				</c:import>
				</c:if>
				<c:import url="/fssc/expense/fssc_expense_main/fsscExpenseMain_baseInfo_right.jsp"></c:import>
				<!-- ???????????? -->
				<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="fsscExpenseMainForm" />
					<c:param name="approveType" value="right" />
				</c:import>
			</ui:tabpanel>
		</template:replace>
	</c:if>
    <c:if test="${param.approveType ne 'right'}">
		<template:replace name="nav">
			<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="fsscExpenseMainForm" />
			</c:import>
		</template:replace>
	</c:if>