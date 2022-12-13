<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="com.landray.kmss.fssc.expense.model.FsscExpenseCategory,com.landray.kmss.fssc.expense.service.IFsscExpenseCategoryService"%>
<link rel="stylesheet" href="<c:url value="/fssc/base/resource/css/print.css"/>" />
<title>${lfn:message('button.print')}</title>
<style type="text/css">
	.tb_normal TD{
		border:1px #000 solid;
	}
	.tb_normal{
		border:1px #000 solid;
	}
	.tb_noborder{
	border:0px;
	}
	.tb_noborder TD{
	border:0px;
	}
	table td {
		color: #000;
	}
	.tb_normal > tbody > tr > td{
		border: 1px #000 solid !important;
	}
</style>
<style media="print" type="text/css">
	#S_OperationBar{display:none !important;}
</style>
<script>
Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);
$(document).ready(function(){
	$("input[name='fdTotalStandaryMoney']").each(function(i,obj){
		if(obj.value){
			$("#fdTotalStandaryUpperMoney"+i).html(FSSC_MenoyToUppercase(obj.value));
		}
	});
	$("input[name='fdTotalApprovedMoney']").each(function(i,obj){
		if(obj.value){
			$("#fdTotalApprovedUpperMoney"+i).html(FSSC_MenoyToUppercase(obj.value));
		}
	});
});
</script>
<!-- 批量打印页面 -->
<div id="optBarDiv">
	<%--打印 --%>
	<input type="button" value="${lfn:message('button.print') }" onclick="javascript:print();">
	<input type="button" value="${lfn:message('button.close') }" onclick="Com_CloseWindow();">
</div>
<center>
	<c:forEach items="${expenseMainFormList}" var="fsscExpenseMainForm" varStatus="vstatus">
	<c:set var="fsscExpenseMainForm" value="${fsscExpenseMainForm}" scope="request"/>
	<c:set var="docTemplateId" value="${fsscExpenseMainForm.docTemplateId}" scope="request"/>
	<% 
		ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext());
		IFsscExpenseCategoryService fsscExpenseCategoryService = (IFsscExpenseCategoryService) ctx.getBean("fsscExpenseCategoryService");
		String docTemplateId = (String)request.getAttribute("docTemplateId");
		FsscExpenseCategory cate = (FsscExpenseCategory) fsscExpenseCategoryService.findByPrimaryKey(docTemplateId);
		request.setAttribute("docTemplate", cate);
	%>
		 <div class='lui_form_title_frame'>
	         <div class='lui_form_subject'>
	            <p class="txttitle"><c:out value="${fsscExpenseMainForm.docTemplateName}" /></p>
	         </div>
	     </div> 
     	 <table class="tb_normal" style="width:95%">
			<tr>
			    <!-- 主题  -->
				<td class="td_normal_title" width=12%>
					${lfn:message('fssc-expense:fsscExpenseMain.docSubject')}
				</td>
				<td width="15%" colspan="3">
					${fsscExpenseMainForm.docSubject}
				</td>
			    <!-- 单据编号 -->
				<td class="td_normal_title" width=12%>
					${lfn:message('fssc-expense:fsscExpenseMain.docNumber')}
				</td>
				<td width="15%">
					${fsscExpenseMainForm.docNumber}
			    </td>
			</tr>  
			<tr>
				<!-- 报销人 -->
				<td class="td_normal_title" width=12%>
					${lfn:message('fssc-expense:fsscExpenseMain.fdClaimant')}
				</td>
				<td width="15%">
					${fsscExpenseMainForm.fdClaimantName}
				</td>
				<!-- 报销人部门 -->
				<td class="td_normal_title" width=12%>
					${lfn:message('fssc-expense:fsscExpenseMain.fdClaimantDept')}
				</td>
				<td width="15%">
					${fsscExpenseMainForm.fdClaimantDeptName}
				</td>
				<!-- 归属部门  -->
				<td class="td_normal_title" width=12%>
					${lfn:message('fssc-expense:fsscExpenseMain.fdCostCenter')}
				</td>
				<td width="15%" >
					${fsscExpenseMainForm.fdCostCenterName}
				</td>	
			</tr> 
			<tr>
				<!-- 记帐公司  -->
				<td class="td_normal_title" width=12%>
					${lfn:message('fssc-expense:fsscExpenseMain.fdCompany')}
				</td>
				<td width="15%" colspan="3">
					${fsscExpenseMainForm.fdCompanyName}
				</td>
				<!-- 归属项目  -->
				<td class="td_normal_title" width=12%>
					${lfn:message('fssc-expense:fsscExpenseMain.fdProject')}
				</td>
				<td width="15%" >
					${fsscExpenseMainForm.fdProjectName}
				</td>
			</tr>
			<c:if test="${fsscExpenseMain.docTemplate.fdIsFee=='true' }">
		         <tr>
		             <td class="td_normal_title" width="16.6%">
		                 ${lfn:message('fssc-expense:fsscExpenseMain.fdFeeNames')}
		             </td>
		             <td colspan="5" width="83.0%">
		                 ${fsscExpenseMainForm.fdFeeNames}
		             </td>
		         </tr>
	         </c:if>
	         <c:if test="${fn:indexOf(fsscExpenseMain.docTemplate.fdExtendFields,'8')>-1 }">
	             <tr>
	                 <td class="td_normal_title" width="16.6%">
	                     ${lfn:message('fssc-expense:fsscExpenseMain.fdProjectAccounting')}
	                 </td>
	                 <td colspan="5" width="83.0%">
	                     ${fsscExpenseMainForm.fdProjectAccountingName}
	                 </td>
	             </tr>
	        </c:if>
	        <tr>
			   <td  class="td_normal_title" width=12%>
					${lfn:message('fssc-expense:fsscExpenseMain.fdContent')}
				</td>
				<td colspan="5" width="15%">
					${fsscExpenseMainForm.fdContent}
				</td>
			</tr>
	        <tr>
	            <td class="td_normal_title" width="16.6%">
	                ${lfn:message('fssc-expense:fsscExpenseMain.fdAttNumber')}
	            </td>
	            <td width="16.6%">
	                ${fsscExpenseMainForm.fdAttNumber}
	            </td>
	            <td class="td_normal_title" width="16.6%">
	                ${lfn:message('fssc-expense:fsscExpenseMain.fdTotalStandaryMoney')}
	            </td>
	            <td width="16.6%">
	                <kmss:showNumber value="${fsscExpenseMainForm.fdTotalStandaryMoney }" pattern="###,##0.00"/><br/>
					<xform:text property="fdTotalStandaryMoney" showStatus="noShow" value="${fsscExpenseMainForm.fdTotalStandaryMoney }"></xform:text>
                    <div id="fdTotalStandaryUpperMoney${vstatus.index}"></div>
	            </td>
	            <td class="td_normal_title" width="16.6%">
	                ${lfn:message('fssc-expense:fsscExpenseMain.fdTotalApprovedMoney')}
	            </td>
	            <td width="16.6%">
	                <kmss:showNumber value="${fsscExpenseMainForm.fdTotalApprovedMoney }" pattern="###,##0.00"/><br/>
					<xform:text property="fdTotalApprovedMoney" showStatus="noShow" value="${fsscExpenseMainForm.fdTotalApprovedMoney }"></xform:text>
               	 	<div id="fdTotalApprovedUpperMoney${vstatus.index}"></div>
	            </td>
	        </tr>
			<c:if test="${docTemplate.fdExpenseType eq '2' and docTemplate.fdIsTravelAlone eq 'true'}">
			<tr class="td_normal_title accountDetail" >
				<td  colspan="6">${lfn:message('fssc-expense:table.fsscExpenseTravelDetail') }</td>
			</tr>
			<!-- 行程明细 -->
			<tr class="accountDetail">
				<td  colspan="6" width="100%">
					<table class="tb_normal" width="100%" id="TABLE_DocList_fdTravelList_Form" align="center">
					  <tr align="center" class="tr_normal_title">
					      <td width="5%">
					          ${lfn:message('page.serial')}
					      </td>
					      <td width="50px">
					          ${lfn:message('fssc-expense:fsscExpenseTravelDetail.fdSubject')}
					      </td>
					      <td width="10%">
					          ${lfn:message('fssc-expense:fsscExpenseTravelDetail.fdBeginDate')}
					      </td>
					      <td width="10%">
					          ${lfn:message('fssc-expense:fsscExpenseTravelDetail.fdEndDate')}
					      </td>
					      <td width="50px">
					          ${lfn:message('fssc-expense:fsscExpenseTravelDetail.fdTravelDays')}
					      </td>
					      <td width="15%">
					          ${lfn:message('fssc-expense:fsscExpenseTravelDetail.fdPersonList')}
					      </td>
					      <td width="10%">
					          ${lfn:message('fssc-expense:fsscExpenseTravelDetail.fdStartPlace')}
					      </td>
					      <td width="10%">
					          ${lfn:message('fssc-expense:fsscExpenseTravelDetail.fdArrivalPlace')}
					      </td>
					      <fssc:checkVersion version="true">
	                      <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'6')>-1  }">
					      <td width="10%">
					          ${lfn:message('fssc-expense:fsscExpenseTravelDetail.fdBerth')}
					      </td>
					     </c:if>
	                     </fssc:checkVersion>
					  </tr>
					  <c:forEach items="${fsscExpenseMainForm.fdTravelList_Form}" var="fdTravelList_FormItem" varStatus="vTravel">
					      <tr KMSS_IsContentRow="1">
					          <td align="center">
					              ${vTravel.index+1}
					          </td>
					          <td align="center">
					             ${fdTravelList_FormItem.fdSubject }
					          </td>
					          <td align="center">
					              ${fdTravelList_FormItem.fdBeginDate}
					          </td>
					          <td align="center">
					              ${fdTravelList_FormItem.fdEndDate}
					          </td>
					          <td align="center">
					              <c:out value="${fdTravelList_FormItem.fdTravelDays}"></c:out>
					          </td>
					          <td align="center">
				                  ${fdTravelList_FormItem.fdPersonListNames}
					          </td>
					          <td align="center">
					              ${fdTravelList_FormItem.fdStartPlace}
					          </td>
					          <td align="center">
					              ${fdTravelList_FormItem.fdArrivalPlace}
					          </td>
					          <fssc:checkVersion version="true">
	                          <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'6')>-1  }">
					          <td align="center">
					               ${fdTravelList_FormItem.fdBerthName}
					          </td>
					         </c:if>
	                         </fssc:checkVersion>
					      </tr>
					  </c:forEach>
					</table>
				</td>
			</tr>
			</c:if>
			<!-- 费用明细 -->
			<tr class="td_normal_title accountDetail" >
						<td colspan="6">${lfn:message('fssc-expense:table.fsscExpenseDetail') }</td>
					</tr>
					<tr class="accountDetail">
						<td  colspan="6" width="100%">
							<table class="tb_normal" width="100%" id="TABLE_DocList_fdDetailList_Form" align="center">
							    <tr align="center" class="tr_normal_title">
							        <td width="5%">
							            ${lfn:message('page.serial')}
							        </td>
							        <c:if test="${docTemplate.fdAllocType=='2' }">
							        <td width="5%">
							            ${lfn:message('fssc-expense:fsscExpenseDetail.fdCostCenter')}
							        </td>
							        </c:if>
							        <td width="5%">
							            ${lfn:message('fssc-expense:fsscExpenseDetail.fdExpenseItem')}
							        </td>
							        <td width="4%">
							            ${lfn:message('fssc-expense:fsscExpenseDetail.fdRealUser')}
							        </td>
							        <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'7')>-1 }">
								        <td  style="width:6%">
								            ${lfn:message('fssc-expense:fsscExpenseDetail.fdDept')}
								        </td>
							        </c:if>
							        <fssc:configEnabled property="fdFinancialSystem" value="SAP">
			                           <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'4')>-1 }">
			                             <td  style="width:6%">
			                                ${lfn:message('fssc-expense:fsscExpenseDetail.fdWbs')}
			                             </td>	
			                           </c:if>
				                       <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'3')>-1 }">
				                            <td  style="width:6%">
				                                ${lfn:message('fssc-expense:fsscExpenseDetail.fdInnerOrder')}
				                            </td>
				                        </c:if>
			                        </fssc:configEnabled>
							         <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'5')>-1 }">
			                            <td  style="width:5%">
			       		                  ${lfn:message('fssc-expense:fsscExpenseDetail.fdStartDate')}
			                          	</td>
			                     	 </c:if>
							        <td width="5%">
							           <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'5')>-1 }">
			        	                	${lfn:message('fssc-expense:fsscExpenseTravelDetail.fdEndDate')}
			        	              </c:if>
			                          <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'5')==-1 }">
			        	                	${lfn:message('fssc-expense:fsscExpenseDetail.fdHappenDate')}
			        	              </c:if>  
							        </td>
							        <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'5')>-1 }">
			                            <td  style="width:2%">
			       	 	                	${lfn:message('fssc-expense:fsscExpenseDetail.fdTravelDays')}
			                       		</td>
			                       	</c:if>
			                       	<c:if test="${docTemplate.fdExpenseType eq '2' and docTemplate.fdIsTravelAlone eq 'false'}">
			                           <td  style="width:5%">
			       	                     	${lfn:message('fssc-expense:fsscExpenseDetail.fdStartPlace')}
			                           </td>
			                       	 	<td  style="width:5%">
			       	 	                    ${lfn:message('fssc-expense:fsscExpenseDetail.fdArrivalPlace')}
			                      		</td>
				                       	<fssc:checkVersion version="true">
				       	                     <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'6')>-1 }">
				                                <td  style="width:4%">
				       	                      	${lfn:message('fssc-expense:fsscExpenseDetail.fdBerth')}
				                            	</td>
				                           	</c:if>
				                     	</fssc:checkVersion>
			                     	</c:if>
			                        <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'1')>-1 }">
			                            <td  style="width:2%">
			                                ${lfn:message('fssc-expense:fsscExpenseDetail.fdPersonNumber')}
			                            </td>
			                         </c:if>
							        <td width="5%">
							            ${lfn:message('fssc-expense:fsscExpenseDetail.fdApplyMoney')}
							        </td>
							        <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'2')>-1 }">
			                          <td  width="5%">
			                                ${lfn:message('fssc-expense:fsscExpenseDetail.fdInvoiceMoney')}
			                              </td>
			                         </c:if>
			                         <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'9')>-1 }">
			                              <td  width="4%">
			                                ${lfn:message('fssc-expense:fsscExpenseDetail.fdNonDeductMoney')}
			                              </td>
			                        </c:if>
			                         <td  width="4%">
			                                ${lfn:message('fssc-expense:fsscExpenseDetail.fdApprovedApplyMoney')}
			                         </td>
			                        <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'2')>-1 }">
			                               <td  width="4%">
			                                    ${lfn:message('fssc-expense:fsscExpenseDetail.fdInputTaxMoney')}
			                              </td>
			                               <td  width="4%">
			                                    ${lfn:message('fssc-expense:fsscExpenseDetail.fdNoTaxMoney')}
			                              </td>
			                        </c:if>
							        <c:if test="${docTemplate.fdIsForeign=='true' }">
							        <td width="4%">
							            ${lfn:message('fssc-expense:fsscExpenseDetail.fdCurrency')}/${lfn:message('fssc-expense:fsscExpenseDetail.fdExchangeRate')}
							        </td>
							        <td width="6%">
							            ${lfn:message('fssc-expense:fsscExpenseDetail.fdStandardMoney')}
							        </td>
							        </c:if>
							        <td width="6%">
							            ${lfn:message('fssc-expense:fsscExpenseDetail.fdUse')}
							        </td>
							        <c:if test="${docTemplate.fdExpenseType eq '2' and docTemplate.fdIsTravelAlone eq 'true'}">
							        <td width="6%">
										${lfn:message('fssc-expense:fsscExpenseDetail.fdTravel')}
							        </td>
							        </c:if>
							    </tr>
							    <c:forEach items="${fsscExpenseMainForm.fdDetailList_Form}" var="fdDetailList_FormItem" varStatus="vDetail">
							        <tr KMSS_IsContentRow="1">
							            <td align="center">
							                ${vDetail.index+1}
							            </td>
							        	<c:if test="${docTemplate.fdAllocType=='2' }">
							            <td align="center">
							                ${fdDetailList_FormItem.fdCostCenterName}
							            </td>
							            </c:if>
							            <td align="center">
								            ${fdDetailList_FormItem.fdExpenseItemName}
								        </td>
							            <td align="center">
							                 ${fdDetailList_FormItem.fdRealUserName}
							            </td>
								        <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'7')>-1 }">
								            <td align="center">
									            ${fdDetailList_FormItem.fdDeptName}
									        </td>
								        </c:if>
									    <fssc:configEnabled property="fdFinancialSystem" value="SAP">
			                             <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'4')>-1 }">
			                                 <td  style="width:120px">
			                                     ${fdDetailList_FormItem.fdWbsName}
			                                 </td>	
			                              </c:if>
			                             <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'3')>-1 }">
			                                   <td  style="width:120px">
			                                    ${fdDetailList_FormItem.fdInnerOrderName}
			                                   </td>	
			                              </c:if>
			                            </fssc:configEnabled>
									    <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'5')>-1 }">
			                             <td  align="center">
			       		                      ${fdDetailList_FormItem.fdStartDate}
			                           	</td>
			                            </c:if>
							            <td align="center">
								            ${fdDetailList_FormItem.fdHappenDate}
								        </td>
								        <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'5')>-1 }">
			                            <td align="center">
			       	 	                   ${fdDetailList_FormItem.fdTravelDays}
			                          	</td>
			                          	</c:if>
			                           	<c:if test="${docTemplate.fdExpenseType eq '2' and docTemplate.fdIsTravelAlone eq 'false'}">
			                            <td align="center">
			       	                        ${fdDetailList_FormItem.fdStartPlace}
			                         	</td>
			                        	<td align="center">
			       	                        ${fdDetailList_FormItem.fdArrivalPlace}
			                         	</td>
			                         	<fssc:checkVersion version="true">
			            	            <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'6')>-1 }">
			                                <td  align="center">
			       	 	                     ${fdDetailList_FormItem.fdBerthName}
			                                </td>
			                        	 </c:if>
			                        	 </fssc:checkVersion>
			                        	 </c:if>
			                             <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'1')>-1 }">
			                                 <td align="center">
			                                     ${fdDetailList_FormItem.fdPersonNumber}
			                                 </td>
			                            </c:if> 
							            <td align="center">
						                    <kmss:showNumber value="${fdDetailList_FormItem.fdApplyMoney }" pattern="###,##0.00"/>
							            </td>
							             <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'2')>-1 }">
			                               <td  align="center">
			                                 <kmss:showNumber value="${fdDetailList_FormItem.fdInvoiceMoney}" pattern="###,##0.00"/>
			                               </td>
			                              </c:if>
			                            <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'9')>-1 }">
			                                <td  align="center">
			                                 <kmss:showNumber value="${fdDetailList_FormItem.fdNonDeductMoney}" pattern="###,##0.00"/>
			                                </td>
			                            </c:if>
			                             <td align="center">
			                                 <kmss:showNumber value="${fdDetailList_FormItem.fdApprovedApplyMoney}" pattern="###,##0.00"/>
			                             </td>
			                             <c:if test="${fn:indexOf(docTemplate.fdExtendFields,'2')>-1 }">
			                               <td  align="center">
			                               <kmss:showNumber value="${fdDetailList_FormItem.fdInputTaxMoney}" pattern="###,##0.00"/>
			                              </td>
			                               <td  align="center">
			                                  <kmss:showNumber value="${fdDetailList_FormItem.fdNoTaxMoney}" pattern="###,##0.00"/>
			                              </td>
			                            </c:if>
							            <c:if test="${docTemplate.fdIsForeign=='true' }">
							            <td align="center">
							                ${fdDetailList_FormItem.fdCurrencyName}&nbsp;<kmss:showNumber value="${fdDetailList_FormItem.fdExchangeRate }" pattern="0.0#####"/>
							            </td>
							            <td align="center">
						                	<kmss:showNumber value="${fdDetailList_FormItem.fdStandardMoney }" pattern="###,##0.00"/>
							            </td>
							            </c:if>
							            <td align="center">
							                ${fdDetailList_FormItem.fdUse}
							            </td>
							            <c:if test="${docTemplate.fdExpenseType eq '2'  and docTemplate.fdIsTravelAlone eq 'true'}">
								        <td align="center">
											${fdDetailList_FormItem.fdTravel}
								        </td>
								        </c:if>
							        </tr>
							    </c:forEach>
							</table>
						</td>
					</tr>
					<c:if test="${(fsscExpenseMainForm.fdAmortizeList_Form)!= null && fn:length(fsscExpenseMainForm.fdAmortizeList_Form) > 0}">
					<!-- 摊销明细 -->
					<tr class="td_normal_title accountDetail" >
						<td  colspan="6">${lfn:message('fssc-expense:table.fsscExpenseAmortize') }</td>
					</tr>
					<tr class="amortizeDetail">
						<td  colspan="6" width="100%" id="account_detail_of_message">
							<table class="tb_normal" width="100%">
				            	<tr>
				            		<td class="td_normal_title" width="10">${lfn:message('fssc-expense:fsscExpenseMain.fdAmortizeArea') }</td>
				            		<td width="23%">
				            			<xform:text showStatus="view" style="width:40%" property="fdAmortizeBegin" validators="checkAmortizeMonth" subject="${lfn:message('fssc-expense:fsscExpenseMain.fdAmortizeBegin') }" htmlElementProperties="id='fdAmortizeBegin'"></xform:text>
				            			~
				            			<xform:text showStatus="view" style="width:40%" property="fdAmortizeEnd" validators="checkAmortizeMonth" subject="${lfn:message('fssc-expense:fsscExpenseMain.fdAmortizeEnd') }" htmlElementProperties="id='fdAmortizeEnd'"></xform:text>
				            		</td>
				            		<td class="td_normal_title" width="10">${lfn:message('fssc-expense:fsscExpenseMain.fdAmortizeMonth') }</td>
				            		<td width="23%">
				            			<xform:text property="fdAmortizeMonth" showStatus="view"/>
				            		</td>
				            		<td class="td_normal_title" width="10">${lfn:message('fssc-expense:fsscExpenseMain.fdAmortizeMoney') }</td>
				            		<td width="23%">
				            			<xform:text property="fdAmortizeMoney" showStatus="readOnly"/>
				            		</td>
				            	</tr>
				            	<tr>
				            		<td colspan="6">
				            		<table class="tb_normal" width="100%" id="TABLE_DocList_Amortize">
				            			<tr align="center" class="tr_normal_title">
									        <td width="5%">
									            ${lfn:message('page.serial')}
									        </td>
									        <td width="35%">
									            ${lfn:message('fssc-expense:fsscExpenseAmortize.fdMonth')}
									        </td>
									        <td width="30%">
									            ${lfn:message('fssc-expense:fsscExpenseAmortize.fdPercent')}(%)
									        </td>
									        <td width="30%">
									            ${lfn:message('fssc-expense:fsscExpenseAmortize.fdMoney')}
									        </td>
									    </tr>
									    <c:forEach items="${fsscExpenseMainForm.fdAmortizeList_Form}" var="fdAmortizeList_FormItem" varStatus="vAmortize">
								        <tr KMSS_IsContentRow="1">
								            <td align="center">
								                ${vAmortize.index+1}
								            </td>
								            <td align="center">
								            	${fdAmortizeList_FormItem.fdMonth}
									        </td>
									        <td align="center">
									        	${fdAmortizeList_FormItem.fdPercent}
									        </td>
									        <td align="center">
									        	${fdAmortizeList_FormItem.fdMoney}
									        </td>
								        </tr>
								        </c:forEach>
				            		</table>
				            		</td>
				            	</tr>
				            </table>
						</td>
					</tr>
					</c:if>
					<c:if test="${(fsscExpenseMainForm.fdInvoiceList_Form)!= null && fn:length(fsscExpenseMainForm.fdInvoiceList_Form) > 0}">
					<!-- 发票明细 -->
					<tr class="td_normal_title accountDetail" >
						<td  colspan="6">${lfn:message('fssc-expense:table.fsscExpenseInvoiceDetail') }</td>
					</tr>
					<tr class="accountDetail">
						<td  colspan="6" width="100%" id="account_detail_of_message">
							<table class="tb_normal" width="100%" id="TABLE_DocList_fdInvoiceList_Form" align="center" >
							    <tr align="center" class="tr_normal_title">
							        <td width="5%">
							            ${lfn:message('page.serial')}
							        </td>
							        <td width="10%">
							            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceType')}
							        </td>
							        <td width="10%">
							            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceNumber')}
							        </td>
							        
							        <td width="10%">
							            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceCode')}
							        </td>
							        <td width="10%">
							            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceDate')}
							        </td>
							        <td width="8%">
							            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdInvoiceMoney')}
							        </td>
							        <td width="8%">
							            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdTax')}
							        </td>
							        <td width="8%">
							            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdTaxMoney')}
							        </td>
							        <td width="8%">
							            ${lfn:message('fssc-expense:fsscExpenseInvoiceDetail.fdNoTaxMoney')}
							        </td>
							    </tr>
							    <c:forEach items="${fsscExpenseMainForm.fdInvoiceList_Form}" var="fdInvoiceList_FormItem" varStatus="vInvoice">
							        <tr KMSS_IsContentRow="1">
							            <td align="center">
							                ${vInvoice.index+1}
							            </td>
							            <td align="center">
							            	<sunbor:enumsShow value="${fdInvoiceList_FormItem.fdInvoiceType}" enumsType="fssc_invoice_type" />
								        </td>
							            <td align="center">
								            ${fdInvoiceList_FormItem.fdInvoiceNumber}
								        </td>
								        <td align="center">
								            ${fdInvoiceList_FormItem.fdInvoiceCode}
								        </td>
								        <td align="center">
								            ${fdInvoiceList_FormItem.fdInvoiceDate}
								        </td>
								        <td align="center">
								            <kmss:showNumber value="${fdInvoiceList_FormItem.fdInvoiceMoney }" pattern="0.00"/>
								        </td>
								        <td align="center">
							                <kmss:showNumber value="${fdInvoiceList_FormItem.fdTax }" pattern="0.0#"/>%
								        </td>
								        <td align="center">
							                <kmss:showNumber value="${fdInvoiceList_FormItem.fdTaxMoney }" pattern="0.00"/>
								        </td>
								        <td align="center">
							                <kmss:showNumber value="${fdInvoiceList_FormItem.fdNoTaxMoney }" pattern="0.00"/>
								        </td>
							        </tr>
							    </c:forEach>
							</table>
						</td>
					</tr>
					</c:if>
					<c:if test="${(fsscExpenseMainForm.fdOffsetList_Form)!= null && fn:length(fsscExpenseMainForm.fdOffsetList_Form) > 0}">
					<!-- 借款明细 -->
					<tr class="td_normal_title accountDetail" >
						<td colspan="6">${lfn:message('fssc-expense:table.fsscExpenseOffsetLoan')}</td>
					</tr>
					<tr>
						<td  colspan="6" width="100%" id="account_detail_of_message">
							<table class="tb_normal" width="100%" id="TABLE_DocList_fdOffsetList_Form" align="center">
							    <tr align="center" class="tr_normal_title">
							        <td style="width:40px;">
							            ${lfn:message('page.serial')}
							        </td>
							        <td>
							            ${lfn:message('fssc-expense:fsscExpenseOffsetLoan.docSubject')}
							        </td>
							        <td>
							            ${lfn:message('fssc-expense:fsscExpenseOffsetLoan.fdNumber')}
							        </td>
							        <td>
							            ${lfn:message('fssc-expense:fsscExpenseOffsetLoan.fdLoanMoney')}
							        </td>
							        <td>
							            ${lfn:message('fssc-expense:fsscExpenseOffsetLoan.fdCanOffsetMoney')}
							        </td>
							        <td>
							            ${lfn:message('fssc-expense:fsscExpenseOffsetLoan.fdOffsetMoney')}
							        </td>
							        <td>
							            ${lfn:message('fssc-expense:fsscExpenseOffsetLoan.fdLeftMoney')}
							        </td>
							    </tr>
							    <c:forEach items="${fsscExpenseMainForm.fdOffsetList_Form}" var="fdOffsetList_FormItem" varStatus="vOffset">
							    	<tr KMSS_IsContentRow="1">
							            <td align="center">
							                ${vOffset.index+1}
							            </td>
							            <td align="center">
							                ${fdOffsetList_FormItem.docSubject}
							            </td>
							            <td align="center">
							                ${fdOffsetList_FormItem.fdNumber}
							            </td>
							            <td align="center">
							                <kmss:showNumber value="${fdOffsetList_FormItem.fdLoanMoney }" pattern="0.00"/>
							            </td>
							            <td align="center">
						                    <kmss:showNumber value="${fdOffsetList_FormItem.fdCanOffsetMoney }" pattern="0.00"/>
							            </td>
							            <td align="center">
						                    <kmss:showNumber value="${fdOffsetList_FormItem.fdOffsetMoney }" pattern="0.00"/>
							            </td>
							            <td align="center">
						                    <kmss:showNumber value="${fdOffsetList_FormItem.fdLeftMoney }" pattern="0.00"/>
							            </td>
							        </tr>
							    </c:forEach>
							</table>
						</td>
					</tr>
					</c:if>
					<c:if test="${(fsscExpenseMainForm.fdAccountsList_Form)!= null && fn:length(fsscExpenseMainForm.fdAccountsList_Form) > 0}">
					<!-- 收款账户 -->
					<tr class="td_normal_title accountDetail" >
						<td colspan="6">${lfn:message('fssc-expense:table.fsscExpenseAccounts')}</td>
					</tr>
					<tr>
						<td  colspan="6" width="100%" id="account_detail_of_message">
							<table class="tb_normal" width="100%" id="TABLE_DocList_fdAccountsList_Form" align="center">
							    <tr align="center" class="tr_normal_title">
							        <td width="5%">
							            ${lfn:message('page.serial')}
							        </td>
							        <fssc:checkVersion version="true">
							        <td width="12%">
							            ${lfn:message('fssc-expense:fsscExpenseAccounts.fdCurrency')}
							        </td>
							        </fssc:checkVersion>
							        <td width="12%">
							            ${lfn:message('fssc-expense:fsscExpenseAccounts.fdAccountName')}
							        </td>
							        <td width="12%">
							            ${lfn:message('fssc-expense:fsscExpenseAccounts.fdBankName')}
							        </td>
							        <td width="12%">
							            ${lfn:message('fssc-expense:fsscExpenseAccounts.fdBankAccount')}
							        </td>
							        <td width="12%">
							            ${lfn:message('fssc-expense:fsscExpenseAccounts.fdMoney')}
							        </td>
							    </tr>
							    <c:forEach items="${fsscExpenseMainForm.fdAccountsList_Form}" var="fdAccountsList_FormItem" varStatus="vAccount">
							        <tr KMSS_IsContentRow="1">
							            <td align="center">
							                ${vAccount.index+1}
							            </td>
							            <fssc:checkVersion version="true">
								        <td align="center">
							        	  	${fdAccountsList_FormItem.fdCurrencyName }
								        </td>
								        </fssc:checkVersion>
							            <td align="center">
							                ${fdAccountsList_FormItem.fdAccountName }
							            </td>
							            <td align="center">
						                	${fdAccountsList_FormItem.fdBankName }
							            </td>
							            <td align="center">
							                ${fdAccountsList_FormItem.fdBankAccount }
							            </td>
							            <td align="center">
							                <kmss:showNumber value="${fdAccountsList_FormItem.fdMoney }" pattern="###,##0.00"></kmss:showNumber> 
							            </td>
							        </tr>
							    </c:forEach>
							</table>
						</td>
					</tr>
					</c:if>
					<c:if test="${fsscExpenseMainForm.docUseXform == 'true' || empty fsscExpenseMainForm.docUseXform}">
					<tr>
						<td class="td_normal_title" colspan="6">${lfn:message('fssc-expense:py.BiaoDanNeiRong')}</td>
					</tr>
					<tr>
						<td colspan="6">
							<c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="fsscExpenseMainForm" />
								<c:param name="fdKey" value="fsscExpenseMain" />
								<c:param name="useTab" value="false" />
							</c:import>
						</td>
					</tr>
					</c:if>
					<tr>
						<td class="td_normal_title"  colspan="6">
							<bean:message bundle="sys-lbpmservice" key="lbpmProcess.history.description.show" />
						</td>
					</tr>
					<tr>
						<td colspan="6">
							<c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="fsscExpenseMainForm" />
							</c:import>
						</td>
					</tr>
			</table>
          <c:if test="${fn:length(expenseMainFormList) != vstatus.count}">
          	  <div style='height：300px;page-break-after:always'></div>
          </c:if>
	 </c:forEach>			
</center>
<script type="text/javascript">
	Com_IncludeFile("jquery.js");
</script>
<%@ include file="/resource/jsp/view_down.jsp"%>