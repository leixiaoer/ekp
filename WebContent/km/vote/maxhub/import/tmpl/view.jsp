<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<div data-dojo-type="dojox/mobile/View"  class="mhVoteView">
	<h2 class="mhVoteViewTitle">{title}</h2>
	<div class="mhVoteViewDetail">
		<span class="mhVoteViewCreator">
			<bean:message bundle="km-vote" key="kmVoteMain.docCreatorId"/> : {creator}
		</span>
		<span class="mhVoteViewExpireTime">
			<bean:message bundle="km-vote" key="kmVoteMain.fdExpireTime"/> : {expireTime}
		</span>
	</div>
	<div class="mhVoteViewQRContainer">
		<div class="mhVoteViewQRTitle">
			手机扫一扫投票
		</div>
		<div class="mhVoteViewQRCode qRNode"></div>
		<div class="mhVoteViewCount">{count}</div>
	</div>
	<div data-dojo-type="mhui/toolbar/Toolbar" class="mhVoteToolbar">
		<div data-dojo-type="mhui/toolbar/ToolbarItem" data-dojo-props="align:'left'">
			<div data-dojo-type="mhui/toolbar/ToolbarIconButton" class="mhBackNode"
				data-dojo-props="icon:'mui mui-arrow-left',text:'返回'"></div>		
		</div>
		<div data-dojo-type="mhui/toolbar/ToolbarItem">
			<div data-dojo-type="mhui/toolbar/ToolbarButton" class="mhResultNode"
				data-dojo-props="text:'查看结果',type:'primary',size:'lg'"></div>
			<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=terminateVote&fdId={fdId}" requestMethod="GET">	
				<div data-dojo-type="mhui/toolbar/ToolbarButton" class="mhFinishNode"
					data-dojo-props="text:'结束投票',type:'danger',size:'lg'"></div>
			</kmss:auth>	
		</div>
		<div data-dojo-type="mhui/toolbar/ToolbarItem"
				data-dojo-props="align:'right'"></div>
	</div>
</div>