<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<template:include ref="default.view" sidebar="no" showQrcode="false">
	 <template:replace name="head">
		<style type="text/css">
			@media print {
				.com_goto{
					display: none;
				}
				#toolBarDiv{
					display: none;
				}
			}
		</style>
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmAssetApplyInForm.docSubject} - ${ lfn:message('km-asset:module.km.asset')}"></c:out>
	</template:replace>
	<template:replace name="content">
<div style="padding-top:50px">
<p class="txttitle">${txttitle}</p>
	<div class="lui_form_content_frame">
	<table class="tb_normal" width=100%>
				<tr>
					<%-- 标题 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
					</td>
					<td colspan="3">
						<xform:text property="docSubject" style="width:85%" />
					</td>
				</tr>
				
				<tr>
					<%--类别--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyInForm.fdApplyTemplateName}" />
					</td>
					<%--入库单编号--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
					</td>
					<td width=35%>
						<c:out value="${kmAssetApplyInForm.fdNo}" />
					</td>
				</tr>
							
				<tr>
					<%--拟单人--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyInForm.fdCreatorName}" />
					</td>
					<%--拟单时间--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
					</td>
					<td width="35%">
						<xform:datetime property="fdCreateDate" dateTimeType="datetime"/>
					</td>
				</tr>
				
				<%-- 入库明细--%>	
				<%@include file="/km/asset/km_asset_apply_in_list/kmAssetApplyInList_view.jsp"%>
				
				<%-- 分隔符 --%>
				<tr><td colspan="4">&nbsp;</td></tr>		
				
				<tr>
					<%-- 附件 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyStock.attachment"/>
					</td>
					<td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="kmAssetApplyIn"/>
							<c:param name="formBeanName" value="kmAssetApplyInForm"/>
						</c:import>
					</td>
				</tr>
				
				<tr>
					<%--说明 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
					</td>
					<td colspan="3">
					    <kmss:showText value="${kmAssetApplyInForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>		
				
						
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyIn.fdIsCreateCard"/>
					</td>
					<td colspan="3">
						<xform:radio property="fdIsCreateCard">
							<xform:enumsDataSource enumsType="km_asset_apply_in_fd_is_create_card"/>
						</xform:radio>
					</td>
				</tr>
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyIn.fdIsUnpickByNums"/>
					</td>
					<td colspan="3">
						<xform:radio property="fdIsUnpickByNums">
							<xform:enumsDataSource enumsType="km_asset_apply_in_fd_is_unpick_by_nums"/>
						</xform:radio>
					</td>
				</tr>
				
			</table>
		<br/>
			<table class="tb_normal" width="100%">
			   <tr>
			   		<td class="td_normal_title" width="100%" align="center">
					    审批记录
					</td>
				</tr>
				<tr>
					<td width="100%">
					    <c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyInForm" />
						</c:import>
					</td>
				</tr>
			</table>
			<div id="toolBarDiv" style="padding-top:20px;text-align:right;">
			      <input type="button" class="lui_form_button"  value="<bean:message key='button.print' />"  onclick="window.print();"  style="width:100px;height:60px;font-size:18px"/>
		    </div>
	</div>
</div>
	</template:replace>
</template:include>
