<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div data-dojo-type="mui/query/QueryList" data-dojo-props="topHeight:!{topHeight}">
	<div data-dojo-type="mui/query/QueryListItem"
		data-dojo-mixins="mui/search/SearchBarDialogMixin" 
		data-dojo-props="label:'${lfn:message("button.search") }',icon:'mui mui-search', 
		modelName:'com.landray.kmss.km.asset.model.KmAssetApplyInventory'">
	</div>
	<div data-dojo-type="mui/query/QueryListItem"
		data-dojo-mixins="mui/query/CommonQueryDialogMixin" 
		data-dojo-props="label:'${lfn:message("list.search") }',icon:'mui mui-query',
			redirectURL:'/km/asset/km_asset_apply_inventory/mobile/index.jsp?moduleName=!{text}&filter=1',
			store:[{'text':'${lfn:message("list.create") }','dataURL':'/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=data&q.mydoc=create'},
			{'text':'${lfn:message("list.approval") }','dataURL':'/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=data&q.mydoc=approval'},
			{'text':'${lfn:message("list.approved") }','dataURL':'/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=data&q.mydoc=approved'}
			]">
	</div>
</div>
