<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/resource/jsp/view_top.jsp" %>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>	

<html>
<body height="100%">
	<table class="tb_normal" id="Label_Tabel" width="95%" height="100%">
		<tr LKS_LabelName="全部资产" >
			<td>
				<iframe width=100% height=100%  frameborder=0 marginheight=0 src="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=list&fdTaskId=${JsParam.fdTaskId}&inventoryType=todoInventory">
				</iframe>
				
			</td>
		</tr>
		
		<tr LKS_LabelName="我负责的资产">
			<td>
				<iframe id='todoInventory'  width=100% height=100%  frameborder=0 marginheight="0" src="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=list&fdTaskId=${JsParam.fdTaskId}&inventoryType=todoInventory&criteriaType=my">
				</iframe>
			</td>
		</tr>
	</table>
	</body>
	</html>
