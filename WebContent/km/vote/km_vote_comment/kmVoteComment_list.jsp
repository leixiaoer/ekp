<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="fdVoteMainId" value="${param.fdVoteMainId}" />   
<c:set var="current_userId" value="<%=UserUtil.getUser().getFdId() %>" />
<div class="vote_comment_w">
     <!-- 点评选项卡 开始 -->
     <dl class="lui_com_record_dl" >
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/km/vote/km_vote_comment/kmVoteComment.do?method=list&fdVoteMainId=${fdVoteMainId}'}
			</ui:source>
			 
			
			<list:rowTable isDefault="true"  cfg-norecodeLayout="_">
				<list:row-template>
					{$
						<dd>
				           <div class="img">
				           	<img src="{%env.fn.formatUrl(row['creatorIcon'])%}" style="width:60px;height:60px;"/>
				       
				           </div>
				           <div class="txt">
				               <p class="p1">
				                   {%row['docCreator.fdName']%}<span>${lfn:message('km-vote:kmVoteMain.votePublishTimeAt')} {%row['docCreateTime']%}</span>
				                  <kmss:authShow roles="ROLE_KMVOTEMAIN_COMMENT_DEL">
				                   		<span class="lui_vote_content_delopt"><a href="javascript:void(0)" onclick='delComment("{%row['fdId']%}")'><bean:message bundle="km-vote" key="button.delete"/></a></span>
				                   		<c:set var="comment_del_auth" value="true" />
				                  </kmss:authShow>
				                   <c:if test="${comment_del_auth!='true'}">
				                $}
				                	var creatorId = row['docCreator.fdId'];
				                	var currentUserId = "${current_userId}";
				                	if(creatorId && creatorId==currentUserId){
				                		{$
				                			<span class="lui_vote_content_delopt"><a href="javascript:void(0)" onclick='delComment("{%row['fdId']%}")'><bean:message bundle="km-vote" key="button.delete"/></a></span>
				                		$}
				                	}
				                {$  		
				                   </c:if>
				               </p>
				               <div style="clear: both;"></div>
				               <p class="p2">
				                 	 {%env.fn.formatText(row['docContent'])%} 
				               </p>
				           </div>
				       </dd>
					$}
				</list:row-template>
			</list:rowTable>
			
		</list:listview>
		<list:paging></list:paging>
	 </dl>
</div>