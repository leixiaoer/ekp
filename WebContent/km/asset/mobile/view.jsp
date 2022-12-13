<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.km.asset.util.AssetMobileUtil,java.util.Map"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%
	String _mainFormName = request.getParameter("_formName");
	Map viewInfo = AssetMobileUtil.getViewInfo(_mainFormName);
	pageContext.setAttribute("_viewInfo",viewInfo);
%>
<template:include ref="mobile.view" compatibleMode="true">
	<c:set var="_mainFormName" value="${param._formName}"></c:set>
	<c:set var="_mainForm" value="${requestScope[param._formName]}"></c:set>
	<c:set var="_mainiModelName" value="${_mainForm.modelClass.name}" />
	<template:replace name="loading">
			<c:import url="/km/asset/mobile/view_banner.jsp"
				charEncoding="UTF-8">
				<c:param name="loading" value="true"></c:param>
			</c:import>
	</template:replace>
	<template:replace name="title">
		<c:out value="${_mainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
		<%@include file="/km/asset/resource/chinaValue.jsp"%>
			  <script type="text/javascript">
	   	require(["dojo/store/Memory","dojo/topic"],function(Memory, topic){
	   		window._narStore = new Memory({data:[{'text':'<bean:message bundle="sys-mobile" key="mui.mobile.info" />',
	   			'moveTo':'_contentView','selected':true},{'text':'<bean:message  bundle="sys-mobile" key="mui.mobile.review.record" />',
	   			'moveTo':'_noteView'}]});
	   		topic.subscribe("/mui/navitem/_selected",function(evtObj){
	   			setTimeout(function(){topic.publish("/mui/list/resize");},150);
	   		});
	   	});
	   </script>
	</template:replace>
	<template:replace name="content">
	
		<div id="scrollView" 
			data-dojo-type="mui/view/DocScrollableView">
			<c:import url="/km/asset/mobile/view_banner.jsp" charEncoding="UTF-8">
			</c:import>
			<div data-dojo-type="mui/fixed/Fixed" id="fixed">
				<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowFixedItem">
					<div data-dojo-type="mui/nav/NavBarStore"
						data-dojo-props="store:_narStore"></div>
				</div>
			</div>
		<div data-dojo-type="dojox/mobile/View" id="_contentView">
			<div data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false">
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${_viewInfo.baseInfoTitle }',icon:'mui-ul'">
					<div class="muiFormContent">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject" />
								</td><td>
									<c:out value="${_viewInfo.baseInfoTitle }"></c:out>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator" />
								</td><td>
									<c:out value="${_mainForm.fdCreatorName}"></c:out>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetApplyBase.fdDept"/>
								</td><td>
									<c:out value="${_mainForm.fdDeptName}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
								</td><td>
									<c:out value="${_mainForm.fdCreateDate}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
								</td><td style="vertical-align: middle;">
									<c:out value="${_mainForm.fdNo}" />
								</td>
							</tr>
							<c:if test="${_mainFormName=='kmAssetApplyBuyForm'}">
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdIsPlan"/>
									</td><td style="vertical-align: middle;">
										<xform:radio property="fdIsPlan" mobile="true">
											<xform:enumsDataSource enumsType="km_asset_apply_buy_fd_is_plan" />
										</xform:radio>
									</td>
								</tr>
							</c:if>
							<c:if test="${_mainFormName=='kmAssetApplyBuyForm' || _mainFormName=='kmAssetApplyStockForm'}">
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdTotalMoney"/>
									</td><td>
										<input type="hidden"  name="fdTotalMoney" value="${_mainForm.fdTotalMoney}" />
										<kmss:showNumber value="${_mainForm.fdTotalMoney}" pattern="###,##0.00"/>
										<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
										<span id="chinaValue"></span>
									</td>
								</tr>
							</c:if>
							<c:if test="${_mainFormName=='kmAssetApplyRepairForm'}">
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyRepair.fdTotalMoney" />
									</td><td>
										<input type="hidden"  name="fdTotalMoney" value="${_mainForm.fdTotalMoney}" />
										<kmss:showNumber value="${_mainForm.fdTotalMoney}" pattern="###,##0.00"/>
										<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
										<span id="chinaValue"></span>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyRepair.fdStartDate"/>
									</td><td>
										<c:out value="${_mainForm.fdStartDate}" />
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyRepair.fdEndDate"/>
									</td><td>
										<c:out value="${_mainForm.fdEndDate}" />
									</td>
								</tr>
							</c:if>
							<c:if test="${_mainFormName=='kmAssetApplyDealForm'}">
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyDeal.fdOldTotalMoney"/>
									</td><td>
										<input type="hidden"  name="fdOldTotalMoney" value="${_mainForm.fdOldTotalMoney}" />
										<kmss:showNumber value="${_mainForm.fdOldTotalMoney}" pattern="###,##0.00"/>
										<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
										<span id="fdOldChinaValue"></span>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyDeal.fdNewTotalMoney"/>
									</td><td style="vertical-align: middle;">
										<input type="hidden"  name="fdTotalMoney" value="${_mainForm.fdNewTotalMoney}" />
										<kmss:showNumber value="${_mainForm.fdNewTotalMoney}" pattern="###,##0.00"/>
										<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
										<span id="chinaValue"></span>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyDeal.fdIsDealSubjoin"/>
									</td><td style="vertical-align: middle;">
										<xform:select property="fdIsDealSubjoin" mobile="true">
											<xform:enumsDataSource enumsType="common_yesno" />
										</xform:select>
									</td>
								</tr>
							</c:if>
							<c:if test="${_mainFormName=='kmAssetApplyRentForm'}">
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyRent.fdStartDate"/>
									</td><td style="vertical-align: middle;">
										<c:out value="${_mainForm.fdStartDate}" />
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyRent.fdEndDate"/>
									</td><td style="vertical-align: middle;">
										<c:out value="${_mainForm.fdEndDate}" />
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyRent.fdDays"/>
									</td><td>
										<c:out value="${_mainForm.fdDays}" />
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyRent.fdForeignBranch"/>
									</td><td>
										<c:out value="${_mainForm.fdForeignBranch}" />
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyRent.fdForeignDept"/>
									</td><td>
										<c:out value="${_mainForm.fdForeignDept}" />
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyRent.fdRentBranch"/>
									</td><td>
										<c:out value="${_mainForm.fdRentBranchName}" />
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyRent.fdRentDept"/>
									</td><td>
										<c:out value="${_mainForm.fdRentDeptName}" />
									</td>
								</tr>
							</c:if>
							
							<c:if test="${_mainFormName !='kmAssetApplyStockForm' && _mainFormName !='kmAssetApplyInForm' }">
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyBase.fdReason"/>
									</td><td>
										<xform:textarea property="fdReason" mobile="true"/>
									</td>
								</tr>
							</c:if>
							<c:if test="${_mainFormName=='kmAssetApplyStockForm' }">
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyStock.fdStockMatter"/>
									</td><td>
										<xform:textarea property="fdStockMatter" mobile="true" />
									</td>
								</tr>
							</c:if>
							<c:if test="${_mainFormName=='kmAssetApplyBuyForm' }">
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdStyle"/>
									</td><td>
										<xform:radio property="fdStyle" mobile="true">
											<xform:enumsDataSource enumsType="km_asset_apply_buy_fd_style"/>
										</xform:radio>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										<bean:message bundle="km-asset" key="kmAssetApplyBuy.fdMoneyIdea"/>
									</td><td style="vertical-align: middle;">
										<xform:textarea property="fdMoneyIdea" mobile="true" />
									</td>
								</tr>
							</c:if>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetApplyBase.docStatus"/>
								</td><td>
									<sunbor:enumsShow value="${_mainForm.docStatus}" enumsType="common_status" />
								</td>
							</tr>
							<c:set var="attForms" value="${_mainForm.attachmentForms[_viewInfo.attaFdKey]}" />
							<c:if test="${attForms!=null && fn:length(attForms.attachments)>0}">
								<tr>
									<td class="muiTitle" colspan="2">
										<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
									       <c:param name="fdKey" value="${_viewInfo.attaFdKey }"/>
									       <c:param name="formName" value="${_mainFormName}"/>
										</c:import>
									</td>
								</tr>
							</c:if>
						</table>
					</div>
				</div>

				<%--明细 --%>
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${_viewInfo.billTitle }',icon:'mui-ul'" style="padding: 10px;">
					<c:import url="/km/asset/mobile/detail/${_mainFormName}_detail.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="${_mainFormName}"/>
					</c:import>
				</div>
			</div>
		</div>
			<div data-dojo-type="dojox/mobile/View" id="_noteView">
				<div class="muiFormContent muiFlowInfoW">
					<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
						<c:param name="fdModelId" value="${_mainForm.fdId }"/>
						<c:param name="fdModelName" value="${_mainiModelName}"/>
						<c:param name="formBeanName" value="${_mainFormName}"/>
					</c:import>
			   </div>
			</div>
				
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
							editUrl="javascript:window.building();"
							formName="${_mainFormName}"
							viewName="lbpmView"
							allowReview="true">
				<template:replace name="flowArea">
					<c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
					  	<c:param name="formName" value="${_mainFormName}"/>
					  	<c:param name="showOption" value="label"></c:param>
					</c:import>
				</template:replace>
				<template:replace name="publishArea">
					<c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="${_mainFormName}"/>
				  		 <c:param name="showOption" value="label"></c:param>
				  	</c:import>
				</template:replace>			
			</template:include>
		</div>
		<!-- 钉钉图标 -->
		<kmss:ifModuleExist path="/third/ding">
			<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="${_mainFormName}" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/lding">
			<c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="${_mainFormName}" />
			</c:import>
		</kmss:ifModuleExist>
		<!-- 钉钉图标 end -->
		
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="${_mainFormName}" />
			<c:param name="fdKey" value="${_viewInfo.lbpmFdKey }" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
		</c:import>
		<script>
			require(['dojo/ready'],function(ready){
				 ready(function(){
					var totalMoney=document.getElementsByName("fdTotalMoney")[0];
					if(!totalMoney){
							return ;
					}
					//更新中文数字
					var chinaValue=document.getElementById("chinaValue");
					chinaValue.innerHTML=showChinaValue(totalMoney.value);
					var modelName = "${_mainFormName}";
					if(modelName=='kmAssetApplyDealForm'){
						var _totalMoney=document.getElementsByName("fdOldTotalMoney")[0];
						var _chinaValue=document.getElementById("fdOldChinaValue");
						_chinaValue.innerHTML=showChinaValue(_totalMoney.value);
					}
			     });
			});
		</script>
	</template:replace>
</template:include>
