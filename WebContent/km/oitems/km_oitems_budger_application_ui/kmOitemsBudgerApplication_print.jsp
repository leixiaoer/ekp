<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.print" sidebar="no" showQrcode="false">
   <template:replace name="head">
		<style type="text/css">
			@media print {
				.com_goto{
					display: none;
				}
				#toolBarDiv{
					display: none !important;
				}
			}
		</style>
	</template:replace>
	<template:replace name="title">
		<c:out value="${ kmOitemsBudgerApplicationForm.docSubject } - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="optBarDiv" layout="sys.ui.toolbar.float" count="5">
			<!-- 打印 -->
			<ui:button text="${lfn:message('button.print')}" 
				onclick="window.print();">
			</ui:button>
			<c:import url="/sys/common/exportButton.jsp" charEncoding="UTF-8"></c:import>
			<!-- 关闭 -->
			<ui:button text="${lfn:message('button.close')}" 
				onclick="Com_CloseWindow();">
			</ui:button>			
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
<div id="lui_output_pdf_container" style="padding:1px 20px;">
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
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;">
										<c:if test="${kmOitemsShoppingTrolleyForm.fdAmount - kmOitemsShoppingTrolleyForm.fdApplicationNumber < 0}">
										<font color="red"><c:out value="${kmOitemsShoppingTrolleyForm.fdApplicationNumber}" /></font>
										</c:if>
										<c:if test="${kmOitemsShoppingTrolleyForm.fdAmount - kmOitemsShoppingTrolleyForm.fdApplicationNumber >= 0}">
										<c:out value="${kmOitemsShoppingTrolleyForm.fdApplicationNumber}" />
										</c:if>
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
			<br/>
			<table class="tb_normal" width="100%">
			   <tr>
			   		<td class="td_normal_title" width="100%" align="center">
					    <bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.approval.records"/>
					</td>
				</tr>
				<tr>
					<td width="100%">
					    <c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
						</c:import>
					</td>
				</tr>
			</table>
			<%-- <div id="toolBarDiv" style="padding-top:20px;text-align:right;">
			    <input type="button" class="lui_form_button"  value="<bean:message key='button.print' />"  onclick="window.print();" />
				<c:import url="/sys/common/exportButton.jsp">
					<c:param name="oldStyle" value="true"></c:param>
				</c:import>
			</div> --%>
		</div>
	 </div>
	 <script>
	function outputMHT() {
		seajs.use(['lui/export/export'],function(exp) {
			exp.exportMht({
				title:'${ kmOitemsBudgerApplicationForm.docSubject }'
			});
		});
	}
	function outputPDF() {
		seajs.use(['lui/jquery','lui/export/export'],function($,exp) {
			$("#toolBarDiv").hide();
			exp.exportPdf(document.getElementById('lui_output_pdf_container'),{
				title:'${ kmOitemsBudgerApplicationForm.docSubject }',
				callback:function() {
					$("#toolBarDiv").show();
				}
			});
		});
	}
	</script>
	</template:replace>
</template:include>