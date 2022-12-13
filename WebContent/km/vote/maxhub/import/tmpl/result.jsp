<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<div data-dojo-type="dojox/mobile/View"  class="mhVoteResultView">
	<h2 class="mhVoteViewTitle">{title}</h2>
	<div class="mhVoteViewDetail">
		<span class="mhVoteViewCreator">
			<bean:message bundle="km-vote" key="kmVoteMain.docCreatorId"/> : {creator}
		</span>
		<span class="mhVoteViewExpireTime">
			<bean:message bundle="km-vote" key="kmVoteMain.fdExpireTime"/> : {expireTime}
		</span>
	</div>
	<ul
		data-dojo-type="mui/list/JsonStoreList"
		data-dojo-props="url:'/km/vote/km_vote_main/kmVoteMain.do?method=viewitem&fdId={fdId}',lazy:false"
		data-dojo-mixins="km/vote/maxhub/import/js/KmVoteResultItemListMixin" class="mhVoteResultList">
	</ul>
	<div data-dojo-type="mhui/toolbar/Toolbar" class="mhVoteToolbar">
		<div data-dojo-type="mhui/toolbar/ToolbarItem" data-dojo-props="align:'left'">
			<div data-dojo-type="mhui/toolbar/ToolbarIconButton" class="mhBackNode"
				data-dojo-props="icon:'mui mui-arrow-left',text:'返回'"></div>		
		</div>
		<div data-dojo-type="mhui/toolbar/ToolbarItem"></div>
		<div data-dojo-type="mhui/toolbar/ToolbarItem"
				data-dojo-props="align:'right'"></div>
	</div>
</div>