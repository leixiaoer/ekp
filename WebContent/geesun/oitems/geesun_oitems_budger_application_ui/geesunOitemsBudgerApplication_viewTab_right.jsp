<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<script>
	seajs.use(['sys/ui/js/dialog'], function(dialog) {
		window.dialog=dialog;
	});
	function Receive(){
	    	dialog.confirm("${lfn:message('geesun-oitems:geesunOitems.receive.message')}",function(flag){
		    	if(flag==true){
		    		  var url="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=checkListing"; 
		    			 $.ajax({     
		    	    	     type:"post",     
		    	    	     url:url,    
		    	    	     data:{fdId:"${param.fdId}"},  
		    	    	     async:false,    //用同步方式 
		    	    	     success:function(data){
		    	    	 	    var results =  eval("("+data+")");
		    	    		    if(results['isMore'] == 'false'){
		    	    		    	dialog.alert(results['names']+" "+"${lfn:message('geesun-oitems:geesunOitemsShoppingTrolley.fdApplicationNumberRunout')}");
		    	    		    	return false;
		    	    			}else{
		    	    				Com_OpenWindow('geesunOitemsBudgerApplication.do?method=receive&fdId=${JsParam.fdId}','_self');
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
		    		Com_OpenWindow('geesunOitemsBudgerApplication.do?method=delete&fdId=${JsParam.fdId}','_self');
		    	}else{
		    		return false;
			    }
		    },"warn");
	}
</script>
<p class="txttitle">
<c:if test="${geesunOitemsBudgerApplicationForm.fdType == '1' }">
<bean:message  bundle="geesun-oitems" key="geesunOitems.tree.dept.application"/>
</c:if>
<c:if test="${geesunOitemsBudgerApplicationForm.fdType == '2' }">
<bean:message  bundle="geesun-oitems" key="geesunOitems.tree.person.application"/>
</c:if>
</p>
	
		<div class="lui_form_content_frame" style="padding-top:5px">
			<table class="tb_normal" width=100%>
			<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docSubject"/>
					</td>
					<td width=85% colspan="4">
						<c:out value="${geesunOitemsBudgerApplicationForm.docSubject}" />
					</td>
				</tr>
				<tr>
				   <td class="td_normal_title" width=15%>
						<c:if test="${geesunOitemsTempletForm.fdTempletType=='1'}">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicants.deptId"/>
						</c:if>
						<c:if test="${geesunOitemsTempletForm.fdTempletType!='1'}">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicantsId"/>
						</c:if>
					</td>
					<td width=35%>
						<c:out value="${geesunOitemsBudgerApplicationForm.fdApplicantsName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<c:choose>
							<c:when test="${geesunOitemsTempletForm.fdTempletType!='1'}">
								<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.creator.dept"/>
							</c:when>
							<c:otherwise>
								<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docNumber" />
							</c:otherwise>
						</c:choose>
					</td>
					<td width=35%>
					  <c:choose>
						  <c:when test="${geesunOitemsTempletForm.fdTempletType!='1'}">
							 <c:out value="${geesunOitemsBudgerApplicationForm.docDeptName}" />
						  </c:when>
						  <c:otherwise>
						  	 <c:out value="${geesunOitemsBudgerApplicationForm.docNumber}" />
						  </c:otherwise>
					  </c:choose>
					</td>
				</tr>
				<tr>
				 <td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-oitems" key="table.geesunOitemsTemplet"/>
					</td>
					<c:choose>
						<c:when test="${geesunOitemsTempletForm.fdTempletType eq '1'}">
							<td  width=85% colspan="4">
								<c:out value="${geesunOitemsBudgerApplicationForm.fdTemplateName}" />
							</td>
						</c:when>
						<c:otherwise>
							<td>
								<c:out value="${geesunOitemsBudgerApplicationForm.fdTemplateName}" />
							</td>
							<td class="td_normal_title" width=15%>
								<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docNumber" />
							</td>
							<td>
								<c:if test="${geesunOitemsBudgerApplicationForm.docStatus==10 || geesunOitemsBudgerApplicationForm.docStatus==null || geesunOitemsBudgerApplicationForm.docStatus=='' }">
							 	 	<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.no.per" />
							 	</c:if>
							 	<c:out value="${geesunOitemsBudgerApplicationForm.docNumber}" />
							</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td colspan="4">
					    <center><b><bean:message  bundle="geesun-oitems" key="geesunOitems.list"/></b></center>
						<table class="tb_normal" width=100% style="table-layout:fixed;margin-top:8px">
							<tr>
								<td class="td_normal_title" style="width:5%"><bean:message key="page.serial"/></td>
								<td class="td_normal_title" ><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/></td>
								<td class="td_normal_title" style="width:20%"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/></td>
								<td class="td_normal_title" ><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/></td>
								<td class="td_normal_title" ><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/></td>
								<td class="td_normal_title" ><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/></td>
								<td class="td_normal_title" ><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/></td>
								<td class="td_normal_title" ><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/></td>
								<td class="td_normal_title" ><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/></td>
								<td class="td_normal_title" ><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.number"/></td>
							</tr>
							<c:forEach items="${geesunOitemsBudgerApplicationForm.geesunOitemsShoppingTrolleyFormList}" var="geesunOitemsShoppingTrolleyForm" varStatus="vstatus">
								<tr>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;">${vstatus.index+1 }</td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${geesunOitemsShoppingTrolleyForm.fdNo }"><c:out value="${geesunOitemsShoppingTrolleyForm.fdNo}" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${geesunOitemsShoppingTrolleyForm.fdName }"><c:out value="${geesunOitemsShoppingTrolleyForm.fdName }" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${geesunOitemsShoppingTrolleyForm.fdCategoryName }"><c:out value="${geesunOitemsShoppingTrolleyForm.fdCategoryName }" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${geesunOitemsShoppingTrolleyForm.fdSpecification }"><c:out value="${geesunOitemsShoppingTrolleyForm.fdSpecification }" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${geesunOitemsShoppingTrolleyForm.fdBrand }"><c:out value="${geesunOitemsShoppingTrolleyForm.fdBrand }" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${geesunOitemsShoppingTrolleyForm.fdUnit }"><c:out value="${geesunOitemsShoppingTrolleyForm.fdUnit }" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="<kmss:showNumber value="${geesunOitemsShoppingTrolleyForm.fdReferencePrice}" pattern="###,##0.00"/>">
									  <input type="text" name="fdReferencePrice" style="border: none;" value="<kmss:showNumber value="${geesunOitemsShoppingTrolleyForm.fdReferencePrice}" pattern="###,##0.00"/>" >
									</td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" title="${geesunOitemsShoppingTrolleyForm.fdCurNum}"><c:out value="${geesunOitemsShoppingTrolleyForm.fdCurNum}" /></td>
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;">
										<c:choose>
											<c:when test="${geesunOitemsShoppingTrolleyForm.fdCurNum - geesunOitemsShoppingTrolleyForm.fdApplicationNumber < 0 && geesunOitemsBudgerApplicationForm.docStatus != '31'}">
												<font color="red"><c:out value="${geesunOitemsShoppingTrolleyForm.fdApplicationNumber}" /></font>
											</c:when>
											<c:otherwise>
												<c:out value="${geesunOitemsShoppingTrolleyForm.fdApplicationNumber}" />
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</table>
						<div style="padding-top: 15px;float: right;font-weight:bold;"><bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdTotalAmount"/>：
						<span style="margin-right:20px">
						<input type="text" name="fdTotalAmount" style="border: none;font-size:18px;color:#868686;" value="<kmss:showNumber value="${geesunOitemsBudgerApplicationForm.fdTotalAmount}" pattern="###,##0.00"/>" >
						</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdReason"/>
					</td><td colspan="3">
					<kmss:showText value="${geesunOitemsBudgerApplicationForm.fdReason}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdDesc"/>
					</td><td colspan="3">
					<kmss:showText value="${geesunOitemsBudgerApplicationForm.fdDesc}" />
					</td>
				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%><bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.attachment"/></td>
					<td colspan="3"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="formBeanName" value="geesunOitemsBudgerApplicationForm" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" />
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docCreatorId"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsBudgerApplicationForm.docCreatorName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docCreateTime"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsBudgerApplicationForm.docCreateTime}" />
					</td>
				</tr>
			</table>
		</div>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
		
			<c:choose>
				<c:when test="${param.approveModel eq 'right'}">
					<c:choose>
						<c:when test="${geesunOitemsBudgerApplicationForm.docStatus>='30' || geesunOitemsBudgerApplicationForm.docStatus=='00'}">
							
									<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
										<c:param name="fdKey" value="geesunOitemsTemplet" />
										<c:param name="showHistoryOpers" value="true" />
										<c:param name="isExpand" value="true" />
										<c:param name="approveType" value="right" />
										<c:param name="needInitLbpm" value="true" />
									</c:import>
								
						</c:when>
						<c:otherwise>
									<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
										<c:param name="fdKey" value="geesunOitemsTemplet" />
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
								<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
								<c:param name="fdKey" value="geesunOitemsTemplet" />
							</c:import>
						
				</c:otherwise>
			</c:choose>


			<ui:content title="${lfn:message('sys-right:right.moduleName')}">
				<table class="tb_normal" width=100%>
					<tr>
						<td width="14%" class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitems.authReaders"/></td>
						<td width="86%" colspan="3">
						<c:if test="${not empty geesunOitemsBudgerApplicationForm.authReaderNames}">
						<c:out value="${geesunOitemsBudgerApplicationForm.authReaderNames}" />
						</c:if>
						<c:if test="${empty geesunOitemsBudgerApplicationForm.authReaderNames}">
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
				<c:when test="${geesunOitemsBudgerApplicationForm.docStatus>='30' || geesunOitemsBudgerApplicationForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/geesun/oitems/geesun_oitems_budger_application_ui/geesunOitemsBudgerApplication_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
						
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
						<%-- 流程 --%>
							
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
							<c:param name="fdKey" value="geesunOitemsTemplet" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
						<!-- 审批记录 -->
						<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
							<c:param name="fdModelId" value="${geesunOitemsBudgerApplicationForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" />
						</c:import>
						<!-- 关联配置 -->
						<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
							<c:param name="approveType" value="right" />
							<c:param name="needTitle" value="true" />
						</c:import>
						<!-- 基本信息-->
						<c:import url="/geesun/oitems/geesun_oitems_budger_application_ui/geesunOitemsBudgerApplication_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
					</ui:tabpanel>
				</c:otherwise>
			</c:choose>
		</template:replace>
	</c:if>
	


