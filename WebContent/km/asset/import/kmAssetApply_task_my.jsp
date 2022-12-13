<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple">
	<template:replace name="body">
	<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	<div style="width:100%;">
		  <ui:tabpanel layout="sys.ui.tabpanel.list">
		 <ui:content title="${lfn:message('km-asset:kmAssetApply.create.my') }">
		 	  <ui:iframe id="task" src="${LUI_ContextPath }/km/asset/km_asset_apply_task/kmAssetApplyTask_new.jsp?except=docStatus:00&mydoc=create"></ui:iframe>
		  </ui:content>
		  <ui:content title="${lfn:message('km-asset:kmAssetApply.approval.my') }">
		 	  <ui:iframe id="task" src="${LUI_ContextPath }/km/asset/km_asset_apply_task/kmAssetApplyTask_new.jsp?except=docStatus:00&mydoc=approval"></ui:iframe>
		  </ui:content>
		  <ui:content title="${lfn:message('km-asset:kmAssetApply.approved.my') }">
		 	  <ui:iframe id="task" src="${LUI_ContextPath }/km/asset/km_asset_apply_task/kmAssetApplyTask_new.jsp?except=docStatus:00&mydoc=approved"></ui:iframe>
		  </ui:content>
		  <ui:content title="${lfn:message('km-asset:kmAsset.drafts') }">
		 	  <ui:iframe id="task" src="${LUI_ContextPath }/km/asset/km_asset_apply_task/kmAssetApplyTask_new.jsp?docStatus=10"></ui:iframe>
		  </ui:content>
		</ui:tabpanel>
	  </div> 
	</template:replace>
</template:include>