<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script type="text/javascript">
	seajs.use(['theme!module']);	
</script>

<link href="${LUI_ContextPath}/km/vote/resource/css/vote.css" rel="stylesheet" type="text/css" />
 <ui:dataview>
<%-- 	<ui:source type = "AjaxJson">
		{url:'/km/vote/km_vote_main/kmVoteMain.do?method=portlet&myVote=${JsParam.myVote}&rowsize=${JsParam.rowsize}&fdCategoryId=${JsParam.cateid }&orderby=${JsParam.orderby} '}
	</ui:source> --%>
	<c:choose>
     <c:when test="${not empty JsParam.myVote}">
	     <%-- 我的... --%>
	     <ui:source type = "AjaxJson">
	      {url:'/km/vote/km_vote_main/kmVoteMain.do?method=portlet&myVote=${JsParam.myVote}&rowsize=${JsParam.rowsize}&fdCategoryId=${JsParam.cateid } '}
	    </ui:source>
     </c:when>
     <c:otherwise>
	     <%-- 最新、最热 --%>
	     <ui:source type = "AjaxXml">
	      {url:'/sys/common/dataxml.jsp?s_bean=kmVoteMainPortletService&rowsize=${JsParam.rowsize}&fdCategoryId=${JsParam.cateid }&orderby=${JsParam.orderby}'}
	    </ui:source>
     </c:otherwise>
   </c:choose>
	<ui:render type="Template">
		var getColDataRender = function (datas){
			var result = [];
			for(var i =0;i< datas.length;i++){
				var records = datas[i];
				var item ={};
				for(var k = 0;k < records.length;k++){
					item[records[k].col]=records[k].value;
				}
				result.push(item);
			}
			return result;
		};
		var compareDate= function(fdTimeStr){
			fdTimeStr = $.trim(fdTimeStr);
			var dateTimeObj = Com_GetDate(fdTimeStr,'datetime');
			if(dateTimeObj.getTime() > new Date().getTime()) {
				return -1;
			} else if(dateTimeObj.getTime() == new Date().getTime()) {
				return 0;
			} else {
				return 1;
			}
		};
		
		var viewVote = function(fdId){
			window.open("${LUI_ContextPath}/km/vote/km_vote_main/kmVoteMain.do?method=view&fdId=" + fdId, "_blank");
		};
		window.viewVote =viewVote;
		
		var changeStandardHumpdata = function(oldJsonDataList){
		    var newJsonDataList = [];
		    for(var k = 0; k < oldJsonDataList.length; k++){
		         var json = {};
		         json["fdId"] =  oldJsonDataList[k]["fdid"];
		         json["docSubject"] =  oldJsonDataList[k]["docsubject"];
		         json["fdVoteNum"] =  oldJsonDataList[k]["fdvotenum"];
		         json["docCreator"] =  oldJsonDataList[k]["doccreator"];
		         json["docCreateTime"] =  oldJsonDataList[k]["doccreatetime"];
		         json["fdIsStart"] =  oldJsonDataList[k]["fdisstart"];
		         json["fdEffectTime"] =  oldJsonDataList[k]["fdeffecttime"];
		         json["fdExpireTime"] =  oldJsonDataList[k]["fdexpiretime"];
		         json["fdIsVoted"] =  oldJsonDataList[k]["fdisvoted"];
		         json["fdAuthVoteFlag"] =  oldJsonDataList[k]["fdauthvoteflag"];
		         newJsonDataList.push(json);
		    }
		
		    return newJsonDataList;
		}
		
		var datas = [];
		if(typeof data.datas == "undefined"){
		       //最新,热门数据通过dataxml获取数据后格式为netJson为小写key,需要转化为统一标准格式
		       datas = changeStandardHumpdata(data);
		}else{
		       //我的投票-原json格式，col-key转化为标准格式
		       datas = getColDataRender(data.datas);
		}
		
		for(var i=0;i<datas.length;i++){
			{$
			<li style="margin-bottom:10px;list-style-type:none;margin-left:5px;">	
				<div style="position:relative;">
					<div class="enroll_counts">
						<p class="enroll_nums">
							<em>{%datas[i].fdVoteNum%}</em>
						</p>
						<p ><bean:message key="kmVoteMain.fdJoinNum" bundle="km-vote"/></p>
					</div>
					<div class="titleInfo" style="padding-left:68px;padding-right:1rem;">
						<h2>
							<a href="javascript:;" onclick="viewVote('{%datas[i].fdId%}');" title="{%datas[i].docSubject%}"><c:out value="{%datas[i].docSubject%}"></c:out></a>
						</h2>					
							<span style="color:#9e9e9e;margin-right:12px;">{%datas[i].docCreator%}</span><span style="color:#9e9e9e;">{%datas[i].docCreateTime%}</span>		
					<div class="btnItem">				
					
			$}
				var fdIsStart = compareDate($.trim(datas[i].fdEffectTime));
				var isVoted = datas[i].fdIsVoted == 'true';
				var  deadLine = datas[i].fdExpireTime;
				var fdAuthVoteFlag = datas[i].fdAuthVoteFlag == 'true';
				if(deadLine == null || deadLine == ''){
					isEnd = -1;
				}else{
					isEnd = compareDate($.trim(deadLine));
				}
				if(fdIsStart < 0){
				//未开始
				{$
					<div class="lui_vote_btn_grayS_noHover">
						<div class="lui_vote_btnC">
							<bean:message key="kmVoteMain.noStart" bundle="km-vote" />
						</div>
					</div>
			
				$}
				}else{
					if(isEnd > 0){
					//已结束
						{$
							<div class="lui_vote_btn_grayS_noHover">
								<div class="lui_vote_btnC">
									<bean:message key="kmVoteMain.ended.tip" bundle="km-vote" />
								</div>
							</div>
							
						$}
					
					}else{
						if(isVoted){
						//已投票
							{$
								<div class="lui_vote_btn_grayS_noHover">
									<div class="lui_vote_btnC">
										<bean:message key="kmVoteMain.Voted" bundle="km-vote" />
									</div>
								</div>
							$}
						}else{
							if(fdAuthVoteFlag){
							{$
								<div class=" lui_vote_btn_defS" onclick="viewVote('{%datas[i].fdId%}');">
									<div class=" lui_vote_btnC" >
										<bean:message key="kmVoteMain.join" bundle="km-vote" />
									</div>
								</div>
							$}
							}else{							
								{$								
									<div class=" lui_vote_btn_grayS_noHover">
										<div class=" lui_vote_btnC" >
											<bean:message key="kmVoteMain.joining" bundle="km-vote" />
										</div>
									</div>
								$}
							}
						}
					}
					
				}
				{$
							</div>
						</div>
						<div style="clear:both;" />
					</div>
				</li>
				$}
		}
			
	</ui:render>
 </ui:dataview>
