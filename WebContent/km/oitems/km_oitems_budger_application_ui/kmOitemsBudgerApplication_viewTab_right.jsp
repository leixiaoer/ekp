<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<script>
	seajs.use(['sys/ui/js/dialog'], function(dialog) {
		window.dialog=dialog;
	});
	function Receive(){
	    	dialog.confirm("${lfn:message('km-oitems:kmOitems.receive.message')}",function(flag){
		    	if(flag==true){
		    		  var url="${KMSS_Parameter_ContextPath}km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=checkListing"; 
		    			 $.ajax({     
		    	    	     type:"post",     
		    	    	     url:url,    
		    	    	     data:{fdId:"${param.fdId}"},  
		    	    	     async:false,    //用同步方式 
		    	    	     success:function(data){
		    	    	 	    var results =  eval("("+data+")");
		    	    		    if(results['isMore'] == 'false'){
		    	    		    	dialog.alert(results['names']+" "+"${lfn:message('km-oitems:kmOitemsShoppingTrolley.fdApplicationNumberRunout')}");
		    	    		    	return false;
		    	    			}else{
		    	    				Com_OpenWindow('kmOitemsBudgerApplication.do?method=receive&fdId=${JsParam.fdId}','_self');
			    	    		}
		    	    		}    
		    	        });
		    	}else{
		    		return;
			    }
		    },"warn");
	}
	
	function Delete(){
	    	dialog.confirm("${lfn:message('page.comfirmDelete')}",function(flag){
		    	if(flag==true){
		    		Com_OpenWindow('kmOitemsBudgerApplication.do?method=delete&fdId=${JsParam.fdId}','_self');
		    	}else{
		    		return false;
			    }
		    },"warn");
	}
</script>
<p class="txttitle">
<c:if test="${kmOitemsBudgerApplicationForm.fdType == '1' }">
<bean:message  bundle="km-oitems" key="kmOitems.tree.dept.application"/>
</c:if>
<c:if test="${kmOitemsBudgerApplicationForm.fdType == '2' }">
<bean:message  bundle="km-oitems" key="kmOitems.tree.person.application"/>
</c:if>
</p>
	
		<div class="lui_form_content_frame" style="padding-top:5px">
			<table class="tb_normal" width=100%>
			<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.docSubject"/>
					</td>
					<td width=85% colspan="4">
						<c:out value="${kmOitemsBudgerApplicationForm.docSubject}" />
					</td>
				</tr>
				<tr>
				   <td class="td_normal_title" width=15%>
						<c:if test="${kmOitemsTempletForm.fdTempletType=='1'}">
							<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicants.deptId"/>
						</c:if>
						<c:if test="${kmOitemsTempletForm.fdTempletType!='1'}">
							<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicantsId"/>
						</c:if>
					</td>
					<td width=35%>
						<c:out value="${kmOitemsBudgerApplicationForm.fdApplicantsName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<c:choose>
							<c:when test="${kmOitemsTempletForm.fdTempletType!='1'}">
								<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.creator.dept"/>
							</c:when>
							<c:otherwise>
								<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.docNumber" />
							</c:otherwise>
						</c:choose>
					</td>
					<td width=35%>
					  <c:choose>
						  <c:when test="${kmOitemsTempletForm.fdTempletType!='1'}">
							 <c:out value="${kmOitemsBudgerApplicationForm.docDeptName}" />
						  </c:when>
						  <c:otherwise>
						  	 <c:out value="${kmOitemsBudgerApplicationForm.docNumber}" />
						  </c:otherwise>
					  </c:choose>
					</td>
				</tr>
				<tr>
				 <td class="td_normal_title" width=15%>
						<bean:message bundle="km-oitems" key="table.kmOitemsTemplet"/>
					</td>
					<c:choose>
						<c:when test="${kmOitemsTempletForm.fdTempletType eq '1'}">
							<td  width=85% colspan="4">
								<c:out value="${kmOitemsBudgerApplicationForm.fdTemplateName}" />
							</td>
						</c:when>
						<c:otherwise>
							<td>
								<c:out value="${kmOitemsBudgerApplicationForm.fdTemplateName}" />
							</td>
							<td class="td_normal_title" width=15%>
								<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.docNumber" />
							</td>
							<td>
								<c:if test="${kmOitemsBudgerApplicationForm.docStatus==10 || kmOitemsBudgerApplicationForm.docStatus==null || kmOitemsBudgerApplicationForm.docStatus=='' }">
							 	 	<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.no.per" />
							 	</c:if>
							 	<c:out value="${kmOitemsBudgerApplicationForm.docNumber}" />
							</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td colspan="4">
					    <center><b><bean:message  bundle="km-oitems" key="kmOitems.list"/></b></center>
						<table class="tb_normal" width=100% style="table-layout:fixed;margin-top:8px">
							<tr>
								<td class="td_normal_title" style="width:5%"><bean:message key="page.serial"/></td>
								<td class="td_normal_title" ><bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/></td>
								<td class="td_normal_title" style="width:20%"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/></td>
								<td class="td_normal_title" ><bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/></td>
								<td class="td_normal_title" ><bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/></td>
								<td class="td_normal_title" ><bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/></td>
								<td class="td_normal_title" ><bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/></td>
								<td class="td_normal_title" ><bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice"/></td>
								<td class="td_normal_title" ><bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/></td>
								<td class="td_normal_title" ><bean:message  bundle="km-oitems" key="kmOitemsListing.number"/></td>
							</tr>
							<c:forEach items="${kmOitemsBudgerApplicationForm.kmOitemsShoppingTrolleyFormList}" var="kmOitemsShoppingTrolleyForm" varStatus="vstatus">
								<tr>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;">${vstatus.index+1 }</td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${kmOitemsShoppingTrolleyForm.fdNo }"><c:out value="${kmOitemsShoppingTrolleyForm.fdNo}" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${kmOitemsShoppingTrolleyForm.fdName }"><c:out value="${kmOitemsShoppingTrolleyForm.fdName }" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${kmOitemsShoppingTrolleyForm.fdCategoryName }"><c:out value="${kmOitemsShoppingTrolleyForm.fdCategoryName }" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${kmOitemsShoppingTrolleyForm.fdSpecification }"><c:out value="${kmOitemsShoppingTrolleyForm.fdSpecification }" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${kmOitemsShoppingTrolleyForm.fdBrand }"><c:out value="${kmOitemsShoppingTrolleyForm.fdBrand }" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${kmOitemsShoppingTrolleyForm.fdUnit }"><c:out value="${kmOitemsShoppingTrolleyForm.fdUnit }" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="<kmss:showNumber value="${kmOitemsShoppingTrolleyForm.fdReferencePrice}" pattern="###,##0.00"/>">
									  <input type="text" name="fdReferencePrice" style="border: none;" value="<kmss:showNumber value="${kmOitemsShoppingTrolleyForm.fdReferencePrice}" pattern="###,##0.00"/>" >
									</td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${kmOitemsShoppingTrolleyForm.fdCurNum}"><c:out value="${kmOitemsShoppingTrolleyForm.fdCurNum}" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;">
										<c:choose>
											<c:when test="${kmOitemsShoppingTrolleyForm.fdCurNum - kmOitemsShoppingTrolleyForm.fdApplicationNumber < 0 && kmOitemsBudgerApplicationForm.docStatus != '31'}">
												<font color="red"><c:out value="${kmOitemsShoppingTrolleyForm.fdApplicationNumber}" /></font>
											</c:when>
											<c:otherwise>
												<c:out value="${kmOitemsShoppingTrolleyForm.fdApplicationNumber}" />
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</table>
						<div style="padding-top: 15px;float: right;font-weight:bold;"><bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdTotalAmount"/>：
						<span style="margin-right:20px">
						<input type="text" name="fdTotalAmount" style="border: none;font-size:18px;color:#868686;" value="<kmss:showNumber value="${kmOitemsBudgerApplicationForm.fdTotalAmount}" pattern="###,##0.00"/>" >
						</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdReason"/>
					</td><td colspan="3">
					<kmss:showText value="${kmOitemsBudgerApplicationForm.fdReason}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdDesc"/>
					</td><td colspan="3">
					<kmss:showText value="${kmOitemsBudgerApplicationForm.fdDesc}" />
					</td>
				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%><bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.attachment"/></td>
					<td colspan="3"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="formBeanName" value="kmOitemsBudgerApplicationForm" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication" />
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.docCreatorId"/>
					</td><td width=35%>
						<c:out value="${kmOitemsBudgerApplicationForm.docCreatorName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.docCreateTime"/>
					</td><td width=35%>
						<c:out value="${kmOitemsBudgerApplicationForm.docCreateTime}" />
					</td>
				</tr>
			</table>
		</div>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
		
			<c:choose>
				<c:when test="${param.approveModel eq 'right'}">
					<c:choose>
						<c:when test="${kmOitemsBudgerApplicationForm.docStatus>='30' || kmOitemsBudgerApplicationForm.docStatus=='00'}">
							
									<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
										<c:param name="fdKey" value="kmOitemsTemplet" />
										<c:param name="showHistoryOpers" value="true" />
										<c:param name="isExpand" value="true" />
										<c:param name="approveType" value="right" />
										<c:param name="needInitLbpm" value="true" />
									</c:import>
								
						</c:when>
						<c:otherwise>
									<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
										<c:param name="fdKey" value="kmOitemsTemplet" />
										<c:param name="showHistoryOpers" value="true" />
										<c:param name="isExpand" value="true" />
										<c:param name="approveType" value="right" />
									</c:import>
								
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<%-- 流程 --%>
					
							<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
								<c:param name="fdKey" value="kmOitemsTemplet" />
							</c:import>
						
				</c:otherwise>
			</c:choose>


			<ui:content title="${lfn:message('sys-right:right.moduleName')}">
				<table class="tb_normal" width=100%>
					<tr>
						<td width="14%" class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitems.authReaders"/></td>
						<td width="86%" colspan="3">
						<c:if test="${not empty kmOitemsBudgerApplicationForm.authReaderNames}">
						<c:out value="${kmOitemsBudgerApplicationForm.authReaderNames}" />
						</c:if>
						<c:if test="${empty kmOitemsBudgerApplicationForm.authReaderNames}">
						<bean:message bundle="sys-right" key="right.other.person" />
						</c:if>
						</td>
						
					</tr>
				</table>
			</ui:content>
			</ui:tabpanel>
	</template:replace>

	<c:if test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<c:choose>
				<c:when test="${kmOitemsBudgerApplicationForm.docStatus>='30' || kmOitemsBudgerApplicationForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/km/oitems/km_oitems_budger_application_ui/kmOitemsBudgerApplication_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
							
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
							<c:param name="fdKey" value="kmOitemsTemplet" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
							<c:param name="fdModelId" value="${kmOitemsBudgerApplicationForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication" />
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
							<c:param name="approveType" value="right" />
							<c:param name="needTitle" value="true" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/km/oitems/km_oitems_budger_application_ui/kmOitemsBudgerApplication_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
					</ui:tabpanel>
				</c:otherwise>
			</c:choose>
		</template:replace>
	</c:if>
	


