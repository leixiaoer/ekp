<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/sys/ui/jsp/common.jsp"%>
[	
	{
		'text':'${lfn:message("list.create") }',
		'url':'/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=data&q.mydoc=create',
		selected : true 
	},
	{
		'text':'${lfn:message("list.approval") }',
		'url':'/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=data&q.mydoc=approval'
	},
	{
		'text':'${lfn:message("list.approved") }',
		'url':'/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=data&q.mydoc=approved'
	}
]