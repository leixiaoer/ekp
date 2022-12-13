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
		<c:out value="${ geesunOitemsBudgerApplicationForm.docSubject } - ${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>
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
									<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;">
										<c:if test="${geesunOitemsShoppingTrolleyForm.fdAmount - geesunOitemsShoppingTrolleyForm.fdApplicationNumber < 0}">
										<font color="red"><c:out value="${geesunOitemsShoppingTrolleyForm.fdApplicationNumber}" /></font>
										</c:if>
										<c:if test="${geesunOitemsShoppingTrolleyForm.fdAmount - geesunOitemsShoppingTrolleyForm.fdApplicationNumber >= 0}">
										<c:out value="${geesunOitemsShoppingTrolleyForm.fdApplicationNumber}" />
										</c:if>
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
			<br/>
			<table class="tb_normal" width="100%">
			   <tr>
			   		<td class="td_normal_title" width="100%" align="center">
					    <bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.approval.records"/>
					</td>
				</tr>
				<tr>
					<td width="100%">
					    <c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
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
				title:'${ geesunOitemsBudgerApplicationForm.docSubject }'
			});
		});
	}
	function outputPDF() {
		seajs.use(['lui/jquery','lui/export/export'],function($,exp) {
			$("#toolBarDiv").hide();
			exp.exportPdf(document.getElementById('lui_output_pdf_container'),{
				title:'${ geesunOitemsBudgerApplicationForm.docSubject }',
				callback:function() {
					$("#toolBarDiv").show();
				}
			});
		});
	}
	</script>
	</template:replace>
</template:include>
