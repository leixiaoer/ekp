<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.edit">
	<template:replace name="head">
        <script type="text/javascript">
	        Com_IncludeFile("security.js|common.js");
	        Com_IncludeFile("domain.js");
	        Com_IncludeFile("form.js");
            Com_IncludeFile("form.js");
            Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/fssc/budget/resource/js/", 'js', true);
            Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/budget/fssc_budget_report/", 'js', true);
            Com_IncludeFile("fsscBudgetReport.js", "${LUI_ContextPath}/fssc/budget/fssc_budget_report/", 'js', true);
        </script>
        <script>
		     var validation = $KMSSValidation();
		     if (document.addEventListener) {//如果是Firefox      
		         document.addEventListener("keypress", otherHandler, true);  
		        } else {  
		            document.attachEvent("onkeypress", ieHandler);  
		        }  
		      function otherHandler(evt) { 
		          if (evt.keyCode == 13) {  
		         	 FS_Search();  
		           }  
		       }  
		        function ieHandler(evt) {  
		          if (evt.keyCode == 13) {  
		         	 FS_Search();  
		            }  
		       }
     </script>
    </template:replace>
    <template:replace name="content">
    <html:form action="/fssc/budget/fssc_budget_data/fsscBudgetData.do" method="get" target="searchIframe">
    	<center>
			<p class="txttitle">
				<p class="txttitle"><bean:message bundle="fssc-budget" key="message.budget.execute.ledger"/></p>
			</p>
			<table class="tb_normal" style="width:100%">
					<!-- 预算方案 -->
					<tr>
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdBudgetScheme')}
						</td>
						<td  style="width:70%;" >
                             <xform:dialog showStatus="edit" required="true" propertyName="fdSchemeName" propertyId="fdSchemeId" subject="${lfn:message('fssc-budget:fsscBudgetData.fdBudgetScheme')}" style="width:95%;">
                              	dialogSelect(false,'fssc_base_fdBudgetScheme','fdSchemeId','fdSchemeName',function(data){displaySearch(data);});
                              </xform:dialog>
                              <xform:text property="fdDimension" showStatus="noShow"></xform:text>
						</td>
					</tr>
					<!-- 公司组 -->
					<tr id="fdDimension1" style="display:none;">
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdCompanyGroup')}
						</td>
						<td  style="width:70%;" >
                             <xform:dialog showStatus="edit" propertyName="fdCompanyGroupName" propertyId="fdCompanyGroupId" subject="${lfn:message('fssc-budget:fsscBudgetData.fdCompanyGroup')}"  style="width:95%;">
                              	dialogSelect(false,'fssc_base_company_group_fdGroup','fdCompanyGroupId','fdCompanyGroupName');
                              </xform:dialog>
						</td>
					</tr>
					<!-- 公司 -->
					<tr id="fdDimension2" style="display:none;">
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdCompany')}
						</td>
						<td  style="width:70%;" >
                             <xform:dialog showStatus="edit" propertyName="fdCompanyName" propertyId="fdCompanyId" subject="${lfn:message('fssc-budget:fsscBudgetData.fdCompany')}" style="width:95%;">
                              	dialogSelect(false,'fssc_base_fdCompany','fdCompanyId','fdCompanyName',function(data){changeCompany(data);});
                              </xform:dialog>
						</td>
					</tr>
					<!-- 成本中心组 -->
					<tr id="fdDimension3" style="display:none;">
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdCostCenterGroup')}
						</td>
						<td  style="width:70%;" >
                             <xform:dialog showStatus="edit" propertyName="fdCostCenterGroupName" propertyId="fdCostCenterGroupId" subject="${lfn:message('fssc-budget:fsscBudgetData.fdCostCenterGroup')}" style="width:95%;">
                              	selectCostCenterGroup();
                              </xform:dialog>
						</td>
					</tr>
					<!-- 成本中心 -->
					<tr id="fdDimension4" style="display:none;">
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdCostCenter')}
						</td>
						<td  style="width:70%;" >
                             <xform:dialog showStatus="edit" propertyName="fdCostCenterName" propertyId="fdCostCenterId" subject="${lfn:message('fssc-budget:fsscBudgetData.fdCostCenter')}" style="width:95%;">
                             	selectCostCenter();
                              </xform:dialog>
						</td>
					</tr>
					<!-- 项目 -->
					<tr id="fdDimension5" style="display:none;">
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdProject')}
						</td>
						<td  style="width:70%;" >
                             <xform:dialog showStatus="edit" propertyName="fdProjectName" propertyId="fdProjectId"  subject="${lfn:message('fssc-budget:fsscBudgetData.fdProject')}" style="width:95%;">
                             	selectProject();
                              </xform:dialog>
						</td>
					</tr>
					<!-- WBS -->
					<tr id="fdDimension6" style="display:none;">
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdWbsCode')}
						</td>
						<td  style="width:70%;" >
                             <xform:dialog showStatus="edit" propertyName="fdWbsName" propertyId="fdWbsId" subject="${lfn:message('fssc-budget:fsscBudgetData.fdWbsCode')}" style="width:95%;">
                             	selectWbs();
                              </xform:dialog>
						</td>
					</tr>
					<!-- 内部订单 -->
					<tr id="fdDimension7" style="display:none;">
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdInnerOrder')}
						</td>
						<td  style="width:70%;" >
                             <xform:dialog showStatus="edit" propertyName="fdInnerOrderName" propertyId="fdInnerOrderId" subject="${lfn:message('fssc-budget:fsscBudgetData.fdInnerOrder')}" style="width:95%;">
                             	selectInnerOrder();
                              </xform:dialog>
						</td>
					</tr>
					<!-- 预算科目 -->
					<tr id="fdDimension8" style="display:none;">
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdBudgetItem')}
						</td>
						<td  style="width:70%;" >
                             <xform:dialog showStatus="edit" propertyName="fdBudgetItemName" propertyId="fdBudgetItemId" subject="${lfn:message('fssc-budget:fsscBudgetData.fdBudgetItem')}" style="width:95%;">
                             	selectBudgetItem();
                              </xform:dialog>
						</td>
					</tr>
					<!-- 部门 -->
					<tr id="fdDimension11" style="display:none;">
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdDept')}
						</td>
						<td  style="width:70%;" >
                             <xform:address showStatus="edit" propertyName="fdDeptName" propertyId="fdDeptId" orgType="ORG_TYPE_DEPT" style="width:95%;"></xform:address>
						</td>
					</tr>
					<!-- 人员 -->
					<tr id="fdDimension10" style="display:none;">
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdPerson')}
						</td>
						<td  style="width:70%;" >
                             <xform:address showStatus="edit" propertyName="fdPersonName" propertyId="fdPersonId" orgType="ORG_TYPE_PERSON" style="width:95%;"></xform:address>
						</td>
					</tr>
					<tr>
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdYear')}
						</td>
						<td  style="width:70%;" >
							<xform:select property="fdYear" showStatus="edit" showPleaseSelect="false" >
					   		</xform:select>
						</td>
					</tr>
					<tr>
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdPeriod')}
						</td>
						<td  style="width:70%;" >
							<xform:radio property="fdPeriodType"  showStatus="edit"  htmlElementProperties="onclick=\"FS_ChangePeriodType(this.value)\"">
								<xform:enumsDataSource enumsType="fssc_budget_period_type_report" />
							</xform:radio>
							<span id="periodSpan"></span>
						</td>
					</tr>
					<tr>
						<td style="width:20%;" class="td_normal_title">
							${lfn:message('fssc-budget:fsscBudgetData.fdBudgetStatus')}
						</td>
						<td  style="width:70%;" >
							<xform:select property="fdBudgetStatus"  showStatus="edit" showPleaseSelect="false">
								<xform:enumsDataSource enumsType="fssc_budget_status" />
							</xform:select>
						</td>
					</tr>
			  </table>
		<br>
		<ui:button text="${ lfn:message('button.search') }" onclick="FSSC_Search();" />
		<ui:button text="${ lfn:message('button.reset') }"  onclick="FSSC_Reset();" />
		<ui:button text="${ lfn:message('button.export') }" onclick="exportResult();" />
</center>
</html:form>
<div>
    <iframe src="" name="searchIframe" id="searchIframe" align="top" onload="this.height=searchIframe.document.body.scrollHeight;" width="97%"  Frameborder=No Border=0 Marginwidth=0 Marginheight=0 Scrolling=No>
    </iframe>
</div>
</template:replace>
</template:include>