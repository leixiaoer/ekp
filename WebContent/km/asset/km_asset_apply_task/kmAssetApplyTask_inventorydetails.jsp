<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>	

<style type="text/css">
	.td_label {
	    border-left-style: solid!important;
	    border-left-width: 1px!important;
	}
</style>

<script type="text/javascript">
	function showIframe(){
		var todoInventory = document.getElementById('todoInventory');
		var myInventory = document.getElementById('myInventory');
		var radioValue = $('input[name="inventory"]:checked').val(); 
		if(radioValue == 'all'){
			todoInventory.style.display = "block";
			myInventory.style.display = "none";
		}else{
			todoInventory.style.display="none";
			myInventory.style.display = "block";
		}
	}
</script>
<table id="Label_Tabel"  width="100%" style="height:380px !important;" >
	<c:if test="${param.taskStatus ne '3' }">
		<tr LKS_LabelName="<bean:message bundle='km-asset' key='enumeration_km_asset_apply_task_detail_fd_status_1'/>（${param.todoNumber }）">
			<td height="100%">
				<div style="margin-top: 2%;margin-left: 2%;">
					<label><input type="radio" name="inventory" value='all' checked="checked" onclick="showIframe();"/><bean:message bundle="km-asset" key="mobile.kmAssetApplyTask.criteria.all"/></label>
					<label><input type="radio" name="inventory" value="my" onclick="showIframe();"/><bean:message bundle="km-asset" key="mobile.kmAssetApplyTask.criteria.my"/></label>		
				</div>
				<iframe id='todoInventory'  width=100% height=90%  frameborder=0 marginheight="0"
					src="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=list&fdTaskId=${kmAssetApplyTaskForm.fdId}&inventoryType=todoInventory">
			    </iframe>
			    <iframe id='myInventory'  width=100% height=90%  frameborder=0 marginheight="0" style="display: none;"
					src="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=list&fdTaskId=${kmAssetApplyTaskForm.fdId}&inventoryType=todoInventory&criteriaType=my&fdAssignUser=${param.fdAssignUser}&personnelIds=${param.personnelIds}&taskCreator=${param.taskCreator}">
			    </iframe>
			    
			  <%--   <iframe id='todoInventory'  width=100% height=100%  frameborder=0 marginheight="0"
					src="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task/kmAssetApplyTask_todoInventory.jsp?fdTaskId=${kmAssetApplyTaskForm.fdId}">
			    </iframe> --%>
			</td>
		</tr>
	</c:if>
	<tr LKS_LabelName="<bean:message bundle='km-asset' key='kmAssetApplyTask.hasBeenInventroied'/>（${param.hasdoNumber }）">
		<td height="100%">
			<iframe  id='hasBeenInventory'  width=100% height=100%  frameborder=0 marginheight="0"
				src="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=list&fdTaskId=${kmAssetApplyTaskForm.fdId}&inventoryType=hasBeenInventory">
	    	</iframe> 
		</td>
	</tr>
	<tr LKS_LabelName="<bean:message bundle='km-asset' key='enumeration_km_asset_apply_task_detail_fd_status_2'/>（${param.doNumber }）">
		<td height="100%">
			<iframe  id='Overage'  width=100% height=100%  frameborder=0 marginheight="0"
				src="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=list&fdTaskId=${kmAssetApplyTaskForm.fdId}&inventoryType=Overage">
	   		</iframe> 
		</td>
	</tr>
	<c:if test="${param.taskStatus eq '3' }">
		<tr LKS_LabelName="<bean:message bundle='km-asset' key='kmAssetApplyTask.noInventory'/>（${param.todoNumber }）">
			<td>
				<iframe id='todoInventory'  width=100% height=100%  frameborder=0 marginheight="0"
					src="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=list&fdTaskId=${kmAssetApplyTaskForm.fdId}&inventoryType=todoInventory">
			    </iframe>
			</td>
		</tr>
	</c:if>
</table>