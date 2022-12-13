<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>	
<%@ include file="/km/asset/km_asset_apply_task/kmAssetApplyTask_detail_js.jsp"%>
<table class="tb_normal" width=100%>
   <tr>
    <td>
           <input type=button class="lui_form_button" value="<bean:message  bundle='km-asset' key='kmAssetApplyTask.serachBtn' />" onclick="loadTaskDetail();">
    </td>
   </tr>
</table>
<table class="tb_normal" width=100% id="detailTB">
	<tr id="titleTr" >
	    <td  class="td_normal_title" align="center" width="5%"> 
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdOrder"/>
		</td>
		<!-- 资产状态-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="15%"> 
			<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width=20%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
		</td>
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="15%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
		</td>
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
		</td>
		<!-- 责任人 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
		</td>
		<!-- 链接 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.link"/>
		</td>
		<!-- 操作 -->
		<td class="td_normal_title" align="center" width="5%">
			<bean:message bundle="km-asset" key="kmAssetApplyTask.operate"/>
		</td>
	</tr>

<c:forEach items="${kmAssetApplyTaskForm.fdTaskDetailForms}" var="kmAssetApplyTaskDetailForm" varStatus="vstatus">
	<tr align="center">
	    <td>${vstatus.index+1}</td>
		<td>
		    <html:hidden property="fdTaskDetailForms[${vstatus.index}].fdTaskId" value="${kmAssetApplyTaskForm.fdId}"/>
		    <html:hidden property="fdTaskDetailForms[${vstatus.index}].fdAssetCardId" value="${kmAssetApplyTaskDetailForm.fdAssetCardId}"/>
		    <html:hidden property="fdTaskDetailForms[${vstatus.index}].fdId" value="${kmAssetApplyTaskDetailForm.fdId}"/>
		    <html:hidden property="fdTaskDetailForms[${vstatus.index}].fdStatus" value="${kmAssetApplyTaskDetailForm.fdStatus}"/>
		    <html:hidden styleClass="hiddenPerson" property="fdTaskDetailForms[${vstatus.index}].fdResponsiblePerson" value="${kmAssetApplyTaskDetailForm.fdResponsiblePerson}"/>
		    <!-- 资产状态  -->
			<xform:select property="fdTaskDetailForms[${vstatus.index}].fdAssetStatus" showStatus="view">
						<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
			</xform:select>
		 </td>
		 <td> 
		  <!--  编码  -->
		    <xform:text  style="width:80%" property="fdTaskDetailForms[${vstatus.index}].fdCode" value="${kmAssetApplyTaskDetailForm.fdCode}" showStatus="view"/>
		 </td>
		 
		 <td>   
		 <!-- 卡片名称 -->
		     <xform:text  style="width:80%" property="fdTaskDetailForms[${vstatus.index}].fdName" value="${kmAssetApplyTaskDetailForm.fdName}" showStatus="view"/>
		 </td>
		 
		 <td> 
		  <!--  资产类别  -->
	        <xform:text  style="width:80%" property="fdTaskDetailForms[${vstatus.index}].fdAssetCategory" value="${kmAssetApplyTaskDetailForm.fdAssetCategory}" showStatus="view"/>
		</td> 
		
		<td> 
		 <!--  规格型号  -->
		    <xform:text  style="width:80%" property="fdTaskDetailForms[${vstatus.index}].fdStandard" value="${kmAssetApplyTaskDetailForm.fdStandard}" showStatus="view"/>
		</td> 
		<td> 
			 <!--  责任人  -->
			 <xform:text  style="width:80%" property="fdTaskDetailForms[${vstatus.index}].fdResponsiblePerson" value="${kmAssetApplyTaskDetailForm.fdResponsiblePerson}" showStatus="view"/>
		</td> 	
		<!-- 链接 -->
		<td align="center" >
			<a  href="javascript:void(0);" onclick="openUrl('${kmAssetApplyTaskDetailForm.fdAssetCardId}');"><bean:message bundle="km-asset" key="kmAssetCard.detail"/></a>
		</td>
		<!-- 操作 -->
		<td align="center" >
			<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="DocList_DeleteRow(${vstatus.index});">
		</td>
	</tr>
	</c:forEach>
</table>