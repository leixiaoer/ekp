<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/vote/maxhub/import/css/view.css?s_cache=${MUI_Cache}"></link>
<div id="kmVoteView_${JsParam.fdModelId}">
	<ul
		data-dojo-type="mui/list/JsonStoreList" class="mhVoteItemList"
		data-dojo-props="url:'/km/vote/km_vote_main/kmVoteMainIndex.do?method=listChildren&modelName=${JsParam.fdModelName}&modelId=${JsParam.fdModelId}',lazy:false"
		data-dojo-mixins="km/vote/maxhub/import/js/KmVoteItemListMixin">
	</ul>
	<div style="margin-top: 16px; font-size: 14px; color: #999999; text-align: center;">—— 已经到底了 ——</div>
</div>
