<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple">
	<template:replace name="body">
	<div style="width:100%;">
		  <ui:tabpanel layout="sys.ui.tabpanel.list">
		 <ui:content title="${lfn:message('km-asset:kmAssetApply.create.my') }">
		 	  <ui:iframe id="create" src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase_new.jsp?mydoc=create&except=docStatus:00&status=create"></ui:iframe>
		  </ui:content>
		  <ui:content title="${lfn:message('km-asset:kmAssetApply.approval.my') }">
		 	  <ui:iframe id="approval" src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase_new.jsp?mydoc=approval&except=docStatus:00_30"></ui:iframe>
		  </ui:content>
		  <ui:content title="${lfn:message('km-asset:kmAssetApply.approved.my') }">
		 	  <ui:iframe id="approved" src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase_new.jsp?mydoc=approved&except=docStatus:00"></ui:iframe>
		  </ui:content>
		  <ui:content title="${lfn:message('km-asset:kmAsset.drafts') }">
		 	  <ui:iframe id="drafts" src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase_new.jsp?mydoc=create&docStatus=10&status=draft"></ui:iframe>
		  </ui:content>
		</ui:tabpanel>
	  </div> 
	</template:replace>
</template:include>