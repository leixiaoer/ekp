<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple">
	<template:replace name="body">
	<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	<div style="width:100%;">
		  <ui:tabpanel layout="sys.ui.tabpanel.list">
		 <ui:content title="${lfn:message('km-asset:kmAsset.abandom.card') }">
		 	  <ui:iframe id="card" src="${LUI_ContextPath }/km/asset/km_asset_card_ui/kmAssetApplyCard_base.jsp?fdAssetStatus=5&j_path=/kmAsset_abandom"></ui:iframe>
		  </ui:content>
		  <ui:content title="${lfn:message('km-asset:kmAsset.abandom.apply') }">
		 	  <ui:iframe id="apply" src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase_new.jsp?docStatus=00"></ui:iframe>
		  </ui:content>
		</ui:tabpanel>
	  </div> 
	</template:replace>
</template:include>