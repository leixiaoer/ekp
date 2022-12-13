<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/fssc/base/resource/jsp/jshead.jsp" %>
<%@ include file="/resource/jsp/edit_top.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc"%>
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
    	.div_whole{
    		width:95%;
    		border:1px solid #e8e8e8;
    	}
    	.div_title{
    		height:40px;
    		text-align: left;
    		line-height:40px; 
    		background-color: rgb(243,243,244);
    		cursor: pointer;
    	}
    	.div_title > span{
    		margin-left:10px;
    	}
    	.hideClass{
    		display: none;
    	}
    	.arrow{
    		float:right;
    		margin-right:10px;
    	}
</style>
<script type="text/javascript">
    var formInitData = {

    };
    var messageInfo = {
	"fssc.base.public.message":"${lfn:message('fssc-base:fssc.base.public.message')}",
	"fssc.base.switch.openOrClose.tips":"${lfn:message('fssc-base:fssc.base.switch.openOrClose.tips')}",
	"button.edit":"${lfn:message('button.edit')}",
	"fssc.base.switch.packup":"${lfn:message('fssc-base:fssc.base.switch.packup')}"
    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js|doclist.js");
    Com_IncludeFile("form.js");
    Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/fssc/base/fssc_base_switch/", 'js', true);
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/base/fssc_base_switch/", 'js', true);
    Com_IncludeFile("fsscSwitch.js", "${LUI_ContextPath}/fssc/base/fssc_base_switch/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

    <p class="txttitle">${ lfn:message('fssc-base:table.fsscBaseSwitch') }</p>
    <center>
	<html:form action="/fssc/base/fssc_base_switch/fsscBaseSwitch.do" styleId="fsscBaseSwitchForm">
       <kmss:authShow roles="ROLE_FSSCBASE_SWITCH_BASE">
        <div class="div_whole">
           <div class="div_title">
	       		<span>${ lfn:message('fssc-base:base.switch') }</span>
	       		<span class="arrow">${lfn:message('fssc-base:fssc.base.switch.packup') }</span>
	       	</div>
	       	<div style="margin-bottom:10px;">
	           <table class="tb_normal" id="base" width="98%" style="margin-top:10px;">
	               <tr>
	               	<td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.fdShowType')}
	                   </td>
	                   <td>
	                       <div id="_xform_fdValue" _xform_type="text">
	                       	<xform:radio property="fdShowType" value="${fromName.fdShowType}">
								<xform:enumsDataSource enumsType="fssc_base_switch_data_type"></xform:enumsDataSource>
							</xform:radio>
	                       </div>
	                   </td>
	                 </tr>
	               <%-- <tr>
	               	<td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.fdIsOpenIssued')}
	                   </td>
	                   <td>
	                       <div id="_xform_fdValue" _xform_type="text">
	                       	<xform:radio property="fdIsOpenIssued" value="${fromName.fdIsOpenIssued}">
								<xform:enumsDataSource enumsType="common_yesno_number"></xform:enumsDataSource>
							</xform:radio>
	                       </div>
	                   </td>
	                 </tr> --%>
	                 <%-- <fssc:checkVersion version="true">
	               	 <tr>
	                   <td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.companyGroupModule.isEnable')}
	                   </td>
	                   <td>
	                       <div id="_xform_fdValue" _xform_type="text">
	                       	<xform:radio property="fdCompanyGroup" value="${fromName.fdCompanyGroup}">
								<xform:enumsDataSource enumsType="common_yesno_number"></xform:enumsDataSource>
							</xform:radio>
	                       </div>
	                   </td>
	                 </tr>
	                 </fssc:checkVersion> --%>
	                 <kmss:ifModuleExist path="/fssc/project">
	                 <tr>
	                   <td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.projectModule.isEnable')}
	                   </td>
	                   <td>
	                       <div id="_xform_fdText" _xform_type="text">
							<xform:radio property="fdProject" value="${fromName.fdProject}">
								<xform:enumsDataSource enumsType="common_yesno_number"></xform:enumsDataSource>
							</xform:radio>
	                       </div>
	                   </td>
	               </tr>
	               </kmss:ifModuleExist>
	               <kmss:ifModuleExist path="/fssc/contract">
	               <tr>
	                   <td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.contractModule.isEnable')}
	                   </td>
	                   <td>
	                       <div id="_xform_fdProperty" _xform_type="text">
	                           <xform:radio property="fdContract" value="${fromName.fdContract}">
								<xform:enumsDataSource enumsType="common_yesno_number"></xform:enumsDataSource>
							</xform:radio>
	                       </div>
	                   </td>
	               </tr>
	               </kmss:ifModuleExist>
	               <kmss:ifModuleExist path="/fssc/budget">
	               <tr>
	                   <td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.budgetScope.isEnable')}
	                   </td>
	                   <td>
	                       <div id="_xform_fdProperty" _xform_type="text" style="width:85%;">
							<span id="fdOrg">
	                        	<xform:address subject="${lfn:message('fssc-base:fsscBaseSwitch.budgetScope.isEnable')}" orgType="ORG_TYPE_ORG|ORG_TYPE_DEPT|ORG_TYPE_PERSON"  style="width:95%;" propertyName="fdBudgetScopeNames" nameValue="${fromName.fdBudgetScopeNames}" propertyId="fdBudgetScopeIds" idValue="${fromName.fdBudgetScopeIds}" textarea="true" mulSelect="true"></xform:address>
	                        </span>
	                       </div>
	                   </td>
	               </tr>
	               <tr>
	                   <td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.budgetWarn')}
	                   </td>
	                   <td>
	                       <div id="_xform_fdProperty" _xform_type="text">
	                           <xform:text property="fdBudgetWarn" value="${fromName.fdBudgetWarn}" style="width:35%;" validators="number"></xform:text>%
	                       </div>
	                   </td>
	               </tr>
	               </kmss:ifModuleExist>
	               <%-- <tr>
	                   <td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.isContain.costCenter')}
	                   </td>
	                   <td>
	                       <div id="_xform_fdProperty" _xform_type="text">
	                           <xform:radio property="fdIsContain" value="${fromName.fdIsContain}">
	                           	<xform:enumsDataSource enumsType="fssc_base_switch_is_enable"></xform:enumsDataSource>
	                           </xform:radio>
	                       </div>
	                   </td>
	               </tr> --%>
	               <%-- <tr>
	                   <td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.paymentNotify.isEnable')} 
	                   </td>
	                   <td>
	                       <div id="_xform_fdProperty" _xform_type="text">
	                           <xform:checkbox property="fdPaymentNotify" value="${fromName.fdPaymentNotify}">
	                           	<c:if test="${todo}">
	                           		<xform:simpleDataSource value="todo">${lfn:message('fssc-base:enums.switch.paymentIntegration_type1')}</xform:simpleDataSource>
	                           	</c:if>
	                           	<c:if test="${email}">
	                           		<xform:simpleDataSource value="email">${lfn:message('fssc-base:enums.switch.paymentIntegration_type2')}</xform:simpleDataSource>
	                           	</c:if>
	                           	<c:if test="${mobile}">
	                           		<xform:simpleDataSource value="mobile">${lfn:message('fssc-base:enums.switch.paymentIntegration_type3')}</xform:simpleDataSource>
	                           	</c:if>
	                           </xform:checkbox>
	                           <span> ${lfn:message('fssc-base:fsscBaseSwitch.fdPaymentNotifyContent')} </span>
	                           <xform:text property="fdPaymentNotifyContent" style="width:55%;"  value="${fromName.fdPaymentNotifyContent}" />
	                       </div>
	                   </td>
	               </tr> --%>
	               <fssc:checkVersion version="true">
		               <kmss:ifModuleExist path="/fssc/baiwang">
		               <%-- <tr>
		                   <td class="td_normal_title" width="15%">
		                       ${lfn:message('fssc-base:fsscBaseSwitch.fdIsAutoCheck')} 
		                   </td>
		                   <td>
		                       <div id="_xform_fdIsAutoCheck" _xform_type="text">
		                           <xform:radio property="fdIsAutoCheck" value="${fromName.fdIsAutoCheck}">
		                           	<xform:enumsDataSource enumsType="common_yesno_number"></xform:enumsDataSource>
		                           </xform:radio>
		                       </div>
		                   </td>
		               </tr> --%>
		               </kmss:ifModuleExist>
	               </fssc:checkVersion>
	               <%-- <tr>
	                   <td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.fdIsAuthorize')} 
	                   </td>
	                   <td>
	                       <div id="_xform_fdIsAuthorize" _xform_type="text">
	                           <xform:radio property="fdIsAuthorize" value="${fromName.fdIsAuthorize}">
	                           	<xform:enumsDataSource enumsType="common_yesno_number"></xform:enumsDataSource>
	                           </xform:radio>
	                           &nbsp;&nbsp;&nbsp;<span class="com_help">${lfn:message('fssc-base:fssc.base.switch.authorize.tips')} </span>
	                       </div>
	                   </td>
	               </tr> --%>	               
	               <tr>
				     <td colspan="2" align="center">
					     <ui:button text="${lfn:message('button.save') }" order="2" onclick="updateSwitch();"></ui:button>
				     </td>						
				   </tr>
	           </table>
	          </div>
	        <html:hidden property="fdId" />
			<html:hidden property="method_GET" />
    	</div>
    	</kmss:authShow>
    	<kmss:authShow roles="ROLE_FSSCBASE_SWITCH_SERVICE">
    		<c:set var="service_auth" value="true"></c:set>
    	</kmss:authShow>
    	<kmss:authShow roles="ROLE_FSSCBASE_SWITCH_SERVICE_OTHER">
    		<c:set var="service_auth" value="true"></c:set>
    	</kmss:authShow>
    	<c:if test="${service_auth=='true'}">
    	<div class="div_whole">
        	<div class="div_title">
        		<span>${ lfn:message('fssc-base:service.switch') }</span>
        		<span class="arrow">${lfn:message('button.edit') }</span>
        	</div>
        	<div style="margin-bottom:10px;"  class="hideClass">
        	<%-- <kmss:authShow roles="ROLE_FSSCBASE_SWITCH_SERVICE">
	            <table class="tb_normal" width="98%" style="margin-top:10px;" id="TABLE_DocList" align="center" tbdraggable="true">
	            	 <tr><td colspan="7"><p class="txttitle" style="font-size:14px;">${ lfn:message('fssc-base:fsscBaseSwitch.accounts.config') }</p></td></tr>
	                 <tr align="center" class="tr_normal_title">
	                     <td width="3%"></td>
	                     <td width="3%">
	                         ${lfn:message('page.serial')}
	                     </td>
	                     <td width="17%">
	                    	 ${lfn:message('fssc-base:fsscBaseSwitch.fdModule')}
	                     </td>
	                     <td width="30%">
	                       	 ${lfn:message('fssc-base:fsscBaseSwitch.fdCompany')}
	                     </td>
	                     <td  width="17%">
	                       	  ${lfn:message('fssc-base:fsscBaseSwitch.fdDate')}
	                     </td>
	                     <td width="8%">
	                         ${lfn:message('list.operation')}
	                     </td>
	                 </tr>
	                 <tr KMSS_IsReferRow="1" style="display:none;">
	                     <td align="center">
	                         <input type='checkbox' name='DocList_Selected' />
	                     </td>
	                     <td align="center" KMSS_IsRowIndex="1">
	                         !{index}
	                     </td>
	                     <td align="center">
	                 		<xform:dialog propertyName="fdDetail.!{index}.fdModuleName" propertyId="fdDetail.!{index}.fdModule" subject="${lfn:message('fssc-base:fsscBaseSwitch.fdModule')}" showStatus="edit">
							 	FSSC_SelectModule();
							 </xform:dialog>
	                     </td>
	                     <td align="center">
							<xform:dialog propertyName="fdDetail.!{index}.fdCompanyName" propertyId="fdDetail.!{index}.fdCompanyId" subject="${lfn:message('fssc-base:fsscBaseSwitch.fdRuleCompany')}" showStatus="edit">
							 	FSSC_SelectCompany2();
							 </xform:dialog>
	                     </td>
	                     <td align="center">
							<xform:datetime property="fdDetail.!{index}.fdDate" dateTimeType="date" style="width:55%;" showStatus="edit"/>
							<xform:radio property="fdDetail.!{index}.fdType" showStatus="edit">
	                 			<xform:enumsDataSource enumsType="fssc_base_open_close_type"></xform:enumsDataSource>
	                 		</xform:radio>
	                     </td>
	                     <td align="center">
	                         <a href="javascript:void(0);" onclick="DocList_CopyRow();" title="${lfn:message('doclist.copy')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_del.png" border="0" />
	                         </a>
	                     </td>
	                 </tr>
	                 <c:forEach items="${fromList}" var="fdDetail" varStatus="vstatus">
	                     <tr KMSS_IsContentRow="1">
	                         <td align="center">
	                             <input type="checkbox" name="DocList_Selected" />
	                         </td>
	                         <td align="center">
	                             ${vstatus.index+1}
	                         </td>
	                         <td align="center">
		                 		<xform:dialog idValue="${fdDetail.fdModule}" nameValue="${fdDetail.fdModuleName}" propertyName="fdDetail.${vstatus.index}.fdModuleName" propertyId="fdDetail.${vstatus.index}.fdModule" subject="${lfn:message('fssc-base:fsscBaseSwitch.fdModule')}" showStatus="edit">
								 	FSSC_SelectModule();
								 </xform:dialog>
		                     </td>
		                     <td align="center">
								<xform:dialog idValue="${fdDetail.fdCompanyId}" nameValue="${fdDetail.fdCompanyName}" propertyName="fdDetail.${vstatus.index}.fdCompanyName" propertyId="fdDetail.${vstatus.index}.fdCompanyId" subject="${lfn:message('fssc-base:fsscBaseSwitch.fdRuleCompany')}" showStatus="edit">
								 	FSSC_SelectCompany2();
								 </xform:dialog>
		                     </td>
		                     <td align="center">
		                 		<xform:datetime property="fdDetail.${vstatus.index}.fdDate" dateTimeType="date" value="${fdDetail.fdDate}" style="width:55%;" showStatus="edit"/>
		                 		<xform:radio property="fdDetail.${vstatus.index}.fdType" value="${fdDetail.fdType}"  showStatus="edit">
		                 			<xform:enumsDataSource enumsType="fssc_base_open_close_type"></xform:enumsDataSource>
		                 		</xform:radio>
		                     </td>
	                         <td align="center">
	                             <a href="javascript:void(0);" onclick="DocList_CopyRow();" title="${lfn:message('doclist.copy')}">
	                                 <img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png" border="0" />
	                             </a>
	                             &nbsp;
	                             <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
	                                 <img src="${KMSS_Parameter_StylePath}/icons/icon_del.png" border="0" />
	                             </a>
	                         </td>
	                     </tr>
	                 </c:forEach>
	                 <tr type="optRow" class="tr_normal_opt" invalidrow="true">
	                     <td colspan="7">
	                         <a href="javascript:void(0);" onclick="DocList_AddRow();" title="${lfn:message('doclist.add')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_add.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(-1);" title="${lfn:message('doclist.moveup')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_up.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(1);" title="${lfn:message('doclist.movedown')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_down.png" border="0" />
	                         </a>
	                         &nbsp;
	                     </td>
	                 </tr>
	            </table>
	            </kmss:authShow> --%>
	            <kmss:authShow roles="ROLE_FSSCBASE_SWITCH_SERVICE_OTHER">
	            <table class="tb_normal" width="98%" style="margin-top:10px;" id="TABLE_DocList_budgetRule" align="center" tbdraggable="true">
	            	 <tr><td colspan="5"><p class="txttitle" style="font-size:14px;">${ lfn:message('fssc-base:fsscBaseSwitch.importBudget.rule') }</p></td></tr>
	                 <tr align="center" class="tr_normal_title">
	                     <td width="10%"></td>
	                     <td width="20%">
	                         ${lfn:message('page.serial')}
	                     </td>
	                     <td width="30%">
	                    	 ${lfn:message('fssc-base:fsscBaseSwitch.importBudget.rule')}
	                     </td>
	                     <td width="30%">
	                       	 ${lfn:message('fssc-base:enums.budget_dimension.2')}
	                     </td>
	                     <td width="10%">
	                         ${lfn:message('list.operation')}
	                     </td>
	                 </tr>
	                 <tr KMSS_IsReferRow="1" style="display:none;">
	                     <td align="center">
	                         <input type='checkbox' name='DocList_Selected' />
	                     </td>
	                     <td align="center" KMSS_IsRowIndex="1">
	                         !{index}
	                     </td>
	                     <td align="center">
                            <xform:checkbox property="fdBudgetRuleDetail.!{index}.fdRulePeriod" showStatus="edit" onValueChange="changeValue">
                                <xform:enumsDataSource enumsType="fssc_base_budget_rule_period" />
                            </xform:checkbox>
	                     </td>
	                     <td align="center">
							<xform:dialog propertyName="fdBudgetRuleDetail.!{index}.fdRuleCompanyName" propertyId="fdBudgetRuleDetail.!{index}.fdRuleCompanyId" subject="${lfn:message('fssc-base:fsscBaseSwitch.fdRuleCompany')}" showStatus="edit">
							 	FSSC_SelectCompany('fdBudgetRuleDetail.!{index}.fdRuleCompanyId','fdBudgetRuleDetail.!{index}.fdRuleCompanyName');
							 </xform:dialog>
	                     </td>
	                     <td align="center">
	                         <a href="javascript:void(0);" onclick="DocList_CopyRow();" title="${lfn:message('doclist.copy')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_del.png" border="0" />
	                         </a>
	                     </td>
	                 </tr>
	                 <c:forEach items="${budgetRuleList}" var="fdBudgetRuleDetail" varStatus="vstatus">
	                     <tr KMSS_IsContentRow="1">
	                         <td align="center">
	                             <input type="checkbox" name="DocList_Selected" />
	                         </td>
	                         <td align="center">
	                             ${vstatus.index+1}
	                         </td>
		                      <td align="center">
	                            <xform:checkbox property="fdBudgetRuleDetail.${vstatus.index}.fdRulePeriod" showStatus="edit" value="${fdBudgetRuleDetail.fdRulePeriod}" onValueChange="changeValue">
	                                <xform:enumsDataSource enumsType="fssc_base_budget_rule_period" />
	                            </xform:checkbox>
		                     </td>
		                     <td align="center">
								<xform:dialog idValue="${fdBudgetRuleDetail.fdRuleCompanyId}" nameValue="${fdBudgetRuleDetail.fdRuleCompanyName}" propertyName="fdBudgetRuleDetail.${vstatus.index}.fdRuleCompanyName" propertyId="fdBudgetRuleDetail.${vstatus.index}.fdRuleCompanyId" subject="${lfn:message('fssc-base:fsscBaseSwitch.fdRuleCompany')}" showStatus="edit">
								 	FSSC_SelectCompany('fdBudgetRuleDetail.${vstatus.index}.fdRuleCompanyId','fdBudgetRuleDetail.${vstatus.index}.fdRuleCompanyName');
								 </xform:dialog>
		                     </td>
	                         <td align="center">
	                             <a href="javascript:void(0);" onclick="DocList_CopyRow();" title="${lfn:message('doclist.copy')}">
	                                 <img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png" border="0" />
	                             </a>
	                             &nbsp;
	                             <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
	                                 <img src="${KMSS_Parameter_StylePath}/icons/icon_del.png" border="0" />
	                             </a>
	                         </td>
	                     </tr>
	                 </c:forEach>
	                 <tr type="optRow" class="tr_normal_opt" invalidrow="true">
	                     <td colspan="7">
	                         <a href="javascript:void(0);" onclick="DocList_AddRow();" title="${lfn:message('doclist.add')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_add.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(-1);" title="${lfn:message('doclist.moveup')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_up.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(1);" title="${lfn:message('doclist.movedown')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_down.png" border="0" />
	                         </a>
	                         &nbsp;
	                     </td>
	                 </tr>
	            </table>
	            <table class="tb_normal" width="98%" style="margin-top:10px;" id="TABLE_DocList_deduBudgetRule" align="center" tbdraggable="true">
	            	 <tr><td colspan="5"><p class="txttitle" style="font-size:14px;">${ lfn:message('fssc-base:fsscBaseSwitch.deduction.rule') }</p></td></tr>
	                 <tr align="center" class="tr_normal_title">
	                     <td width="10%"></td>
	                     <td width="20%">
	                         ${lfn:message('page.serial')}
	                     </td>
	                     <td width="30%">
	                    	 ${lfn:message('fssc-base:fsscBaseSwitch.deduction.rule')}
	                     </td>
	                     <td width="30%">
	                       	 ${lfn:message('fssc-base:enums.budget_dimension.2')}
	                     </td>
	                     <td width="10%">
	                         ${lfn:message('list.operation')}
	                     </td>
	                 </tr>
	                 <tr KMSS_IsReferRow="1" style="display:none;">
	                     <td align="center">
	                         <input type='checkbox' name='DocList_Selected' />
	                     </td>
	                     <td align="center" KMSS_IsRowIndex="1">
	                         !{index}
	                     </td>
	                     <td align="center">
                            <xform:radio property="fdDeduBudgetRuleDetail.!{index}.fdDeduRule" showStatus="edit">
                                <xform:enumsDataSource enumsType="fssc_base_budget_dedu_rule" />
                            </xform:radio>
	                     </td>
	                     <td align="center">
							<xform:dialog propertyName="fdDeduBudgetRuleDetail.!{index}.fdRuleCompanyName" propertyId="fdDeduBudgetRuleDetail.!{index}.fdRuleCompanyId" subject="${lfn:message('fssc-base:fsscBaseSwitch.fdRuleCompany')}" showStatus="edit">
							 	FSSC_SelectCompany('fdDeduBudgetRuleDetail.!{index}.fdRuleCompanyId','fdDeduBudgetRuleDetail.!{index}.fdRuleCompanyName');
							 </xform:dialog>
	                     </td>
	                     <td align="center">
	                         <a href="javascript:void(0);" onclick="DocList_CopyRow();" title="${lfn:message('doclist.copy')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_del.png" border="0" />
	                         </a>
	                     </td>
	                 </tr>
	                 <c:forEach items="${deduBudgetList}" var="fdDeduBudgetRuleDetail" varStatus="vstatus">
	                     <tr KMSS_IsContentRow="1">
	                         <td align="center">
	                             <input type="checkbox" name="DocList_Selected" />
	                         </td>
	                         <td align="center">
	                             ${vstatus.index+1}
	                         </td>
		                     <td align="center">
	                            <xform:radio property="fdDeduBudgetRuleDetail.${vstatus.index}.fdDeduRule" showStatus="edit" value="${fdDeduBudgetRuleDetail.fdDeduRule}">
	                                <xform:enumsDataSource enumsType="fssc_base_budget_dedu_rule" />
	                            </xform:radio>
		                     </td>
		                     <td align="center">
								<xform:dialog idValue="${fdDeduBudgetRuleDetail.fdRuleCompanyId}" nameValue="${fdDeduBudgetRuleDetail.fdRuleCompanyName}" propertyName="fdDeduBudgetRuleDetail.${vstatus.index}.fdRuleCompanyName" propertyId="fdDeduBudgetRuleDetail.${vstatus.index}.fdRuleCompanyId" subject="${lfn:message('fssc-base:fsscBaseSwitch.fdRuleCompany')}" showStatus="edit">
								 	FSSC_SelectCompany('fdDeduBudgetRuleDetail.${vstatus.index}.fdRuleCompanyId','fdDeduBudgetRuleDetail.${vstatus.index}.fdRuleCompanyName');
								 </xform:dialog>
		                     </td>
	                         <td align="center">
	                             <a href="javascript:void(0);" onclick="DocList_CopyRow();" title="${lfn:message('doclist.copy')}">
	                                 <img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png" border="0" />
	                             </a>
	                             &nbsp;
	                             <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
	                                 <img src="${KMSS_Parameter_StylePath}/icons/icon_del.png" border="0" />
	                             </a>
	                         </td>
	                     </tr>
	                 </c:forEach>
	                 <tr type="optRow" class="tr_normal_opt" invalidrow="true">
	                     <td colspan="7">
	                         <a href="javascript:void(0);" onclick="DocList_AddRow();" title="${lfn:message('doclist.add')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_add.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(-1);" title="${lfn:message('doclist.moveup')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_up.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(1);" title="${lfn:message('doclist.movedown')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_down.png" border="0" />
	                         </a>
	                         &nbsp;
	                     </td>
	                 </tr>
	            </table>
	            <%-- <!-- 冲抵预提设置 -->
	            <table class="tb_normal" width="98%" style="margin-top:10px;" id="TABLE_DocList_deduProvisionRule" align="center" tbdraggable="true">
	            	 <tr><td colspan="5"><p class="txttitle" style="font-size:14px;">${ lfn:message('fssc-base:fsscBaseSwitch.deduction.provision.rule') }</p></td></tr>
	                 <tr align="center" class="tr_normal_title">
	                     <td width="10%"></td>
	                     <td width="20%">
	                         ${lfn:message('page.serial')}
	                     </td>
	                     <td width="30%">
	                    	 ${lfn:message('fssc-base:fsscBaseSwitch.deduction.provision.rule')}
	                     </td>
	                     <td width="30%">
	                       	 ${lfn:message('fssc-base:enums.budget_dimension.2')}
	                     </td>
	                     <td width="10%">
	                         ${lfn:message('list.operation')}
	                     </td>
	                 </tr>
	                 <tr KMSS_IsReferRow="1" style="display:none;">
	                     <td align="center">
	                         <input type='checkbox' name='DocList_Selected' />
	                     </td>
	                     <td align="center" KMSS_IsRowIndex="1">
	                         !{index}
	                     </td>
	                     <td align="center">
                            <xform:radio property="fdDeduProvisionRuleDetail.!{index}.fdProvisionRule" showStatus="edit">
                                <xform:enumsDataSource enumsType="fssc_base_budget_dedu_rule" />
                            </xform:radio>
	                     </td>
	                     <td align="center">
							<xform:dialog propertyName="fdDeduProvisionRuleDetail.!{index}.fdProvisionCompanyName" propertyId="fdDeduProvisionRuleDetail.!{index}.fdProvisionCompanyId" subject="${lfn:message('fssc-base:fsscBaseSwitch.fdRuleCompany')}" showStatus="edit">
							 	FSSC_SelectCompany('fdDeduProvisionRuleDetail.!{index}.fdProvisionCompanyId','fdDeduProvisionRuleDetail.!{index}.fdProvisionCompanyName');
							 </xform:dialog>
	                     </td>
	                     <td align="center">
	                         <a href="javascript:void(0);" onclick="DocList_CopyRow();" title="${lfn:message('doclist.copy')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_del.png" border="0" />
	                         </a>
	                     </td>
	                 </tr>
	                 <c:forEach items="${deduProvisionList}" var="fdDeduProvisionRuleDetail" varStatus="vstatus">
	                     <tr KMSS_IsContentRow="1">
	                         <td align="center">
	                             <input type="checkbox" name="DocList_Selected" />
	                         </td>
	                         <td align="center">
	                             ${vstatus.index+1}
	                         </td>
		                     <td align="center">
	                            <xform:radio property="fdDeduProvisionRuleDetail.${vstatus.index}.fdProvisionRule" showStatus="edit" value="${fdDeduProvisionRuleDetail.fdProvisionRule}">
	                                <xform:enumsDataSource enumsType="fssc_base_budget_dedu_rule" />
	                            </xform:radio>
		                     </td>
		                     <td align="center">
								<xform:dialog idValue="${fdDeduProvisionRuleDetail.fdProvisionCompanyId}" nameValue="${fdDeduProvisionRuleDetail.fdProvisionCompanyName}" propertyName="fdDeduProvisionRuleDetail.${vstatus.index}.fdProvisionCompanyName" propertyId="fdDeduProvisionRuleDetail.${vstatus.index}.fdProvisionCompanyId" subject="${lfn:message('fssc-base:fsscBaseSwitch.fdRuleCompany')}" showStatus="edit">
								 	FSSC_SelectCompany('fdDeduProvisionRuleDetail.${vstatus.index}.fdProvisionCompanyId','fdDeduProvisionRuleDetail.${vstatus.index}.fdProvisionCompanyName');
								 </xform:dialog>
		                     </td>
	                         <td align="center">
	                             <a href="javascript:void(0);" onclick="DocList_CopyRow();" title="${lfn:message('doclist.copy')}">
	                                 <img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png" border="0" />
	                             </a>
	                             &nbsp;
	                             <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
	                                 <img src="${KMSS_Parameter_StylePath}/icons/icon_del.png" border="0" />
	                             </a>
	                         </td>
	                     </tr>
	                 </c:forEach>
	                 <tr type="optRow" class="tr_normal_opt" invalidrow="true">
	                     <td colspan="7">
	                         <a href="javascript:void(0);" onclick="DocList_AddRow();" title="${lfn:message('doclist.add')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_add.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(-1);" title="${lfn:message('doclist.moveup')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_up.png" border="0" />
	                         </a>
	                         &nbsp;
	                         <a href="javascript:void(0);" onclick="DocList_MoveRowBySelect(1);" title="${lfn:message('doclist.movedown')}">
	                             <img src="${KMSS_Parameter_StylePath}/icons/icon_down.png" border="0" />
	                         </a>
	                         &nbsp;
	                     </td>
	                 </tr>
	            </table> --%>
	            <table class="tb_normal" width="98%" style="margin-top:10px;" id="TABLE_DocList_budgetRule" align="center" tbdraggable="true">
		            <kmss:ifModuleExist path="/fssc/budget">
		            <tr>
				     	<td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.fsscBudget.knots.isEnable')}
	                  </td>
                   	  <td>
	                       <div id="_xform_fdProperty" _xform_type="text" style="width:85%;">
	                       	<xform:radio property="fdKnots" value="${fromName.fdKnots}">
	                       		<xform:enumsDataSource enumsType="fssc_base_switch_is_enable"></xform:enumsDataSource>
	                       	</xform:radio>
	                       </div>
	                   </td>
				    </tr>
				    </kmss:ifModuleExist>
				    <kmss:ifModuleExist path="/fssc/budgeting">
		            <%-- <tr>
					     <td class="td_normal_title" width="15%">
		                       ${lfn:message('fssc-base:fsscBaseSwitch.fsscBudget.costcenter.to.account')}
		                  </td>
	                   	  <td>
		                       <div id="_xform_fdCostcenterToAccount" _xform_type="text" style="width:85%;">
		                       		<xform:checkbox property="fdCostcenterToAccount" value="${fromName.fdCostcenterToAccount}" showStatus="edit">
										<xform:simpleDataSource value="1" bundle="fssc-base" textKey="fsscBaseSwitch.fsscBudget.costcenter.to.account"></xform:simpleDataSource>
									</xform:checkbox>
		                       </div>
		                   </td>
				    </tr> --%>
				    
		            <tr>
					     <td class="td_normal_title" width="15%">
		                       ${lfn:message('fssc-base:fsscBaseSwitch.fsscBudget.Budgeting.type')}
		                  </td>
	                   	  <td>
		                       <div id="_xform_fdBudgetingType" _xform_type="text" style="width:85%;">
		                       		<xform:radio onValueChange="changeType" property="fdBudgetingType" value="${fromName.fdBudgetingType}" showStatus="edit">
										<xform:enumsDataSource enumsType="fssc_base_budgeting_type"></xform:enumsDataSource>
									</xform:radio>
									<ui:button style="float:right;display:none;" id="discardBudgeting" text="${lfn:message('fssc-base:button.one.key.discard')}" onclick="updateBudgetingStatus();"></ui:button>
		                       </div>
		                   </td>
				    </tr>
					</kmss:ifModuleExist>
					<%-- <fssc:checkVersion version="true">
					<kmss:ifModuleExist path="/fssc/expense">
		            <tr>
				     	<td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.fsscExpense.isNeedRebuget')}
	                  </td>
                   	  <td>
	                       <div id="_xform_fdRebudget" _xform_type="text" style="width:85%;">
	                       	<xform:radio property="fdRebudget" value="${fromName.fdRebudget}">
	                       		<xform:enumsDataSource enumsType="fssc_base_switch_is_enable"></xform:enumsDataSource>
	                       	</xform:radio>
	                       </div>
	                   </td>
				    </tr>
				    </kmss:ifModuleExist>
				    </fssc:checkVersion> --%>
				    <%-- <kmss:ifModuleExist path="/fssc/ledger">
		            <tr>
				     	<td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.fsscLedger.fdContractIsStart')}
	                  </td>
                   	  <td>
	                       <div id="_xform_fdContractIsStart" _xform_type="text" style="width:85%;">
	                       	<xform:radio property="fdContractIsStart" value="${fromName.fdContractIsStart}">
	                       		<xform:enumsDataSource enumsType="fssc_base_switch_is_enable"></xform:enumsDataSource>
	                       	</xform:radio>
	                       </div>
	                   </td>
				    </tr>
				    </kmss:ifModuleExist> --%>
				    <fssc:checkVersion version="true">
				   <%--  <tr>
				     	<td class="td_normal_title" width="15%">
	                       ${lfn:message('fssc-base:fsscBaseSwitch.fsscBase.isRateEnabled')}
	                  </td>
                   	  <td>
	                       <div id="_xform_fdRateEnabled" _xform_type="text" style="width:85%;">
	                       	<xform:radio property="fdRateEnabled" value="${fromName.fdRateEnabled}">
	                       		<xform:enumsDataSource enumsType="fssc_base_switch_is_enable"></xform:enumsDataSource>
	                       	</xform:radio>
	                       </div>
	                   </td>
				    </tr> --%>
				    <fssc:ifModuleExists path="/fssc/iqubic/;/fssc/ocr/">
				       <!-- ocr厂商 -->
		               <tr>
		                   <td class="td_normal_title" width="15%">
		                       ${lfn:message('fssc-base:fsscBaseSwitch.fdOcrCompany')} 
		                   </td>
		                   <td>
		                       <div id="_xform_fdOcrCompany" _xform_type="text">
		                           <xform:radio property="fdOcrCompany" value="${fromName.fdOcrCompany}">
		                           	<xform:enumsDataSource enumsType="fssc_base_fd_ocr_company"></xform:enumsDataSource>
		                           </xform:radio>
		                       </div>
		                   </td>
		               </tr>
				    </fssc:ifModuleExists>
				    
				    </fssc:checkVersion>
				   </table>
				   </kmss:authShow>
				   <br />
				   <table>
		                 <tr>
						     <td colspan="7" align="center">
							     <ui:button text="${lfn:message('button.save') }" order="2" onclick="if(validateService()){updateSwitch()};"></ui:button>
						     </td>						
					    </tr>
				   </table>
            </div>
       </div>
       </c:if>
       <%-- <kmss:authShow roles="ROLE_FSSCBASE_SWITCH_THIRD">
	    <div class="div_whole">
	        	<div class="div_title">
	        		<span>${ lfn:message('fssc-base:third.switch') }</span>
	        		<span class="arrow">${lfn:message('button.edit') }</span>
	        	</div>
	        	<div style="margin-bottom:10px;"  class="hideClass">
		            <table class="tb_normal" width="98%" style="margin-top:10px;">
		            	<fssc:checkVersion version="true">
		           		 <fssc:checkUseBank >
							<tr>
								<td class="td_normal_title" width="15%">
									${lfn:message('fssc-base:fsscBaseSwitch.useBank.isEnable')}
								</td>
								<td>
									<div id="_xform_fdUseBank" _xform_type="text">
										<xform:checkbox property="fdUseBank"  value="${fromName.fdUseBank}"  >
											<xform:enumsDataSource enumsType="fssc_base_switch_useBank"></xform:enumsDataSource>
										</xform:checkbox>
									</div>
								</td>
								<td class="td_normal_title" width="15%">
									${lfn:message('fssc-base:fsscBaseSwitch.useBank.passType')}
								</td>
								<td>
									<div id="_xform_fdPassType" _xform_type="text">
										<xform:radio property="fdPassType"  value="${fromName.fdPassType}"  >
											<xform:enumsDataSource enumsType="fssc_base_switch_passType"></xform:enumsDataSource>
										</xform:radio>
									</div>
								</td>
							</tr>
						  </fssc:checkUseBank>
						</fssc:checkVersion>
						<tr>
							<td class="td_normal_title" width="15%">
								${lfn:message('fssc-base:fsscBaseSwitch.financialSystem.isEnable')}
							</td>
							<td colspan="3">
								<div id="_xform_fdFinancialSystem" _xform_type="text">
									<xform:checkbox property="fdFinancialSystem" value="${fromName.fdFinancialSystem}" onValueChange="onChangeFdFinancialSystem()">
										<xform:enumsDataSource enumsType="fssc_base_switch_financialSystem"></xform:enumsDataSource>
									</xform:checkbox>
								</div>
							</td>
						</tr>
						
						<tr class="fdUEightUrl" style="display:none;">
							<td class="td_normal_title" width="15%">
								${lfn:message('fssc-base:fsscBaseSwitch.fdUEightUrl')}
							</td>
							<td colspan="3">
								<div id="_xform_fdUEightUrl" _xform_type="text">
									<xform:text property="fdUEightUrl" value="${fromName.fdUEightUrl}" style="width:95%;"></xform:text>
								</div>
							</td>
						</tr>
						<tr class="fdKUrl" style="display:none;">
							<td class="td_normal_title" width="15%">
								${lfn:message('fssc-base:fsscBaseSwitch.fdKUrl')}
							</td>
							<td colspan="3">
								<div id="_xform_fdKUrl" _xform_type="text">
									<xform:text property="fdKUrl" value="${fromName.fdKUrl}" style="width:95%;"></xform:text>
								</div>
							</td>
						</tr>
						<tr class="fdKUserName" style="display:none;">
							<td class="td_normal_title" width="15%">
								${lfn:message('fssc-base:fsscBaseSwitch.fdKUserName')}
							</td>
							<td colspan="3">
								<div id="_xform_fdKUserName" _xform_type="text">
									<xform:text property="fdKUserName" value="${fromName.fdKUserName}" style="width:95%;"></xform:text>
								</div>
							</td>
						</tr>
						<tr class="fdKPassWord" style="display:none;">
							<td class="td_normal_title" width="15%">
								${lfn:message('fssc-base:fsscBaseSwitch.fdKPassWord')}
							</td>
							<td colspan="3">
								<div id="_xform_fdKPassWord" _xform_type="text">
									<xform:text property="fdKPassWord" value="${fromName.fdKPassWord}" style="width:95%;"></xform:text>
								</div>
							</td>
						</tr>
						<fssc:checkVersion version="true">
							<fssc:ifModuleExists path="/fssc/mobile/;/fssc/wxcard/">
							<tr>
								<td class="td_normal_title" width="15%">
									${lfn:message('fssc-base:fsscBaseSwitch.useWeixin.isEnable')}
								</td>
								<td colspan="3">
									<div id="_xform_fdUseWeixin" _xform_type="text">
										appId:<xform:text property="fdAppId" value="${fromName.fdAppId}" style="width:45%;"></xform:text>&nbsp;&nbsp;
										secret:<xform:text property="fdSecret" value="${fromName.fdSecret}" style="width:45%;"></xform:text>
									</div>
								</td>
							</tr>
							</fssc:ifModuleExists>
						</fssc:checkVersion>
		               <tr>
					     <td colspan="4" align="center">
						     <ui:button text="${lfn:message('button.save') }" order="2" onclick="updateSwitch();"></ui:button>
					     </td>						
					   </tr>
		            </table>
	            </div>
	       </div>
	       </kmss:authShow> --%>
    	   <%-- <div class="div_whole">
        	<div class="div_title">
        		<span>${ lfn:message('fssc-base:data.switch') }</span>
        		<span class="arrow">${lfn:message('button.edit') }</span>
        	</div>
        	<div style="margin-bottom:10px;"  class="hideClass">
	            <table class="tb_normal" width="98%" style="margin-top:10px;">
	                
	            </table>
            </div>
       </div> --%>
    </html:form>
    </center>
    <script>
        $KMSSValidation();
        DocList_Info.push('TABLE_DocList_budgetRule');
        DocList_Info.push('TABLE_DocList_deduBudgetRule');
        DocList_Info.push('TABLE_DocList_deduProvisionRule');
    </script>
<%@ include file="/resource/jsp/edit_down.jsp" %>