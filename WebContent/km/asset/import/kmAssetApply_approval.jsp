<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple">
	<template:replace name="body">
	<div style="width:100%;">
		  <ui:tabpanel layout="sys.ui.tabpanel.list">
		 <ui:content title="${lfn:message('km-asset:kmAssetApply.approval.my') }">
		 	  <ui:iframe id="bank" src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase_new.jsp?mydoc=approval&except=docStatus:00_30"></ui:iframe>
		  </ui:content>
		  <ui:content title="${lfn:message('km-asset:kmAssetApply.approved.my') }">
		 	  <ui:iframe id="bank" src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase_new.jsp?mydoc=approved&except=docStatus:00"></ui:iframe>
		  </ui:content>
		</ui:tabpanel>
	  </div> 
	</template:replace>
</template:include>