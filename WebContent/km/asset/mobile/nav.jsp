<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : "/km/asset/km_asset_index/kmAssetIndex.do?method=list&q.mydoc=approval&orderby=fdCreateDate&ordertype=down", 
		moveTo : "myApply", 
		text : "${ lfn:message('km-asset:kmAssetApply.my') }",
		selected : true 
	},
	{ 
		url : "/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&q.mycard=responsible&orderby=fdCode", 
		moveTo : "myCard", 
		text : "${ lfn:message('km-asset:kmAssetCard.page.my') }"
	},
	{
		url : "/km/asset/km_asset_index/kmAssetIndex.do?method=list&q.mydoc=approved&orderby=fdCreateDate&ordertype=down",
		moveTo : "cardSearch", 
		text : "${ lfn:message('km-asset:kmAssetCard.page.search') }"
	}
	
]
