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
		<c:out value="${kmAssetApplyChangeForm.docSubject} - ${ lfn:message('km-asset:module.km.asset')}"></c:out>
	</template:replace>
	<template:replace name="content">
	<div style="padding-top:50px">
    <p class="txttitle">${txttitle}</p>
	<div class="lui_form_content_frame">
	<table class="tb_normal" width=100%>
		<tr>
			<!--标题-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
			<td colspan="5"><xform:text property="docSubject"
				style="width:85%" /></td>
		</tr>
		<tr>
			<!--所属模板 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
					<td width="19%">
					  <c:out value="${kmAssetApplyChangeForm.fdApplyTemplateName}"/></td>
			<!--申请单编号 -->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
			<td colspan="3"><xform:text property="fdNo" style="width:85%" />
			</td>
		</tr>

		<tr>
			<!--申请人-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
			<td width="19%"><c:out
			value="${kmAssetApplyChangeForm.fdCreatorName}" /></td>
			<!--申请部门-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
			<td width="19%">
			             <c:out value="${kmAssetApplyChangeForm.fdDeptName}" />
			</td>
			<!--申请日期-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
			<td width="19%"><xform:datetime property="fdCreateDate"  style="width:85%" dateTimeType="datetime"/></td>
		</tr>

                 	<!-- 变更单明细 -->
		<tr>
			<td class="td_normal_title" width="100%" colspan="6" align="center"><bean:message
					bundle="km-asset" key="table.kmAssetApplyChangeList" /></td>
		</tr>
          <tr>
			<td width="100%" colspan="6">
				<c:import url="/km/asset/km_asset_apply_change_list/kmAssetApplyChangeList_view.jsp" charEncoding="UTF-8">
				</c:import>
				<c:if test="${fn:length(myCards) > 0}">
					<c:import url="/km/asset/km_asset_card/kmAssetCard_mycard_import.jsp" charEncoding="UTF-8">
					</c:import>
				</c:if>
			</td>
		</tr>  
      
		<tr>
			<!--事由-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdReason" /></td>
			<td colspan="5"><kmss:showText value="${kmAssetApplyChangeForm.fdReason}"/></td>
		</tr>
		
		
	<tr>
			<!--附件机制-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
			<td colspan="5">
        <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="attachment"/>
			<c:param name="fdModelId" value="${param.fdId }" />
			<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyChange" />
        </c:import>
			</td>
		</tr>
     		
		<tr>	
		  <!--说明-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
			<td colspan="5">
			   <kmss:showText value="${kmAssetApplyChangeForm.fdExplain}"></kmss:showText> 
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
				<c:param name="formName" value="kmAssetApplyChangeForm" />
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
