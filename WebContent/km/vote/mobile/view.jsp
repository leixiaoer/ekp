<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ page import="com.landray.kmss.util.UserUtil,com.landray.kmss.sys.attachment.util.SysAttPicUtils" %>
<% 
	boolean isAdmin = false;
	if(UserUtil.getKMSSUser().isAdmin()){
		isAdmin = true;
	}
	request.setAttribute("isAdmin", isAdmin);
%>
<style type="text/css">
.muiVoteDesc {
   	font-size: 1.4rem;
   	color: #000;
   	padding: 0 1.3rem 0.5rem 1.5rem;
}
.muiVoteDescText {
	position: relative;
    line-height: 1.9rem;
    white-space: pre-wrap;
}
.descTextHidden {
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 3;
	overflow: hidden;
}
</style>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${kmVoteMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
	   	<mui:cache-file name="mui-km-vote-list.css" cacheType="md5"/>
		<mui:cache-file name="mui-km-vote-view.css" cacheType="md5"/>
	</template:replace>
	<template:replace name="content">		
		<div id="scrollView"
			data-dojo-type="mui/view/DocScrollableView">
			<div data-dojo-type="mui/panel/AccordionPanel">
				<div class="muiFlowInfoW">
					 <div class="muiFlowHeader">
					 	<div class="muiProcessRight">
					 	  <div style="display: inline-block;margin: 0px 20px;"> 
		                	<div class="muiProcessVoteNum">${kmVoteMainForm.fdVoteNum}</div>
		                	<div class="muiProcessVoteText">${lfn:message('km-vote:mui.kmVoteMain.fdVoteNum')}</div>
		                  </div>
		                  <c:if test="${kmVoteMainForm.fdAuthVoteFlag eq 'false'}"> 
		                  <div style="display:inline-block;">
		                	<div class="muiProcessVoteNum">${absentNum}</div>
		                	<div class="muiProcessVoteText">${lfn:message('km-vote:mui.kmVoteMain.absentNum')}</div>
		                  </div>
		                  </c:if>
		                </div>
		                <div class="muiProcessIcon">
		                    <img class="muiProcessImg" src='<person:headimageUrl  contextPath="true" personId="${kmVoteMainForm.docCreatorId}" size="m" />'/>
		                </div>		                		                
		                <div class="muiProcessCenter muiFontSizeM muiFontColorInfo">
		                	<div>${kmVoteMainForm.docCreatorName}</div>
		                	<div class="muiProcessBottom muiFontSizeS muiFontColorMuted">
			                	<span style="margin-right:1rem">${lfn:message('km-vote:mui.kmVoteMain.fdExpireTime')}</span>
			                	<span id="expireTime"></span>
		                	</div>
		                </div>
		            </div>
				</div>
				
				<!-- 投票详情 -->
				<div class="muiVoteDetail">
					<div class="muiVoteTitle muiFontSizeM muiFontColorInfo">
						<span style="color:#18b4ed;">【${kmVoteMainForm.fdCategoryName}】</span>
						<span>${kmVoteMainForm.docSubject}</span>
					</div>
					<div class="muiVoteDesc">
                    	<p class="muiVoteDescText descTextHidden" id="muiVoteDescText">${kmVoteMainForm.fdDescription}</p>
                    	<div class="descButtonDown" style="display: none;text-align: right;"><i class="mui mui-down-n"></i></div>
                    	<div class="descButtonUp" style="display: none;text-align: right;"><i class="mui mui-down-n mui-rotate-180"></i></div>
                   	</div>
					<div class="muiVoteText muiFontSizeS muiFontColorMuted">
						<c:if test="${kmVoteMainForm.fdIsRadio == 'false'}">    
	                    	<div style="float:left;width:6rem;height: inherit;">${lfn:message('km-vote:kmVoteMain.checkbox.description')}</div>
	                    	(<bean:message bundle="km-vote" key="kmVoteMain.checkbox.min" />
                            <c:choose>
	                           	<c:when test="${kmVoteMainForm.fdMinOption>0}">                    		
									<c:out value="${kmVoteMainForm.fdMinOption}" />
									<bean:message bundle="km-vote" key="kmVoteMain.item" />
	                           	</c:when>
	                           	<c:otherwise>
	                           		<bean:message bundle="km-vote" key="kmVoteMain.checkbox.msg" />
	                           	</c:otherwise>
                           	</c:choose>,
                           	<bean:message bundle="km-vote" key="kmVoteMain.checkbox.max" />    
                           	<c:choose>             	
	                           	<c:when test="${kmVoteMainForm.fdMaxOption>0}">							
									<c:out value="${kmVoteMainForm.fdMaxOption}" />
									<bean:message bundle="km-vote" key="kmVoteMain.item" />
								</c:when>
								<c:otherwise>
									<bean:message bundle="km-vote" key="kmVoteMain.checkbox.msg" />                         		
	                           	</c:otherwise>
                           	</c:choose>)
	                    </c:if>
						<c:if test="${kmVoteMainForm.fdIsRadio != 'false'}">    
							<div style="float:left"><bean:message bundle="km-vote" key="kmVoteMain.fdVoteItem" /></div>    
	                    	<div style="float:right;width:7rem;text-align:center">${lfn:message('km-vote:kmVoteMain.itemRadio')}</div>
	                    </c:if>
					</div>
					<html:form action="/km/vote/km_vote_main/kmVoteMain.do">
					<html:hidden property="fdId" value="${kmVoteMainForm.fdId}" />
						<div class="vote_tb_w">
							<ul  class='<c:if test="${kmVoteMainForm.fdIsVoted == 'true' ||kmVoteMainForm.fdVoteStatus != '0' }">vote_result_list </c:if>' >
                   		<c:forEach items="${kmVoteMainForm.fdVoteItems}" var="kmVoteMainItemForm" varStatus="vstatus">
						    <li>
						    <a href="javascript:void(0)">
								<c:if test="${kmVoteMainForm.fdIsRadio == 'false'}">
                              		<c:if test="${kmVoteMainForm.fdIsVoted != 'true' &&kmVoteMainForm.fdVoteStatus == '0'}">
	                              		<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
											<input type="checkbox" id="_fdVoteItemIds${vstatus.index+1}_" data-dojo-type="km/vote/mobile/js/VoteCheckBox" data-dojo-props="name:'fdVoteItemIds',value:'${kmVoteMainItemForm.fdId}',maxNum:'${kmVoteMainForm.fdMaxOption}'">
										</kmss:auth>
									</c:if>		
								</c:if>
								<c:if test="${kmVoteMainForm.fdIsRadio == 'true'}">
									<c:if test="${kmVoteMainForm.fdIsVoted != 'true' &&kmVoteMainForm.fdVoteStatus == '0'}">
										<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
											<input type="radio" id="_fdVoteItemIds${vstatus.index+1}_" data-dojo-type="mui/form/Radio" data-dojo-props="name:'fdVoteItemIds',value:'${kmVoteMainItemForm.fdId}'">
										</kmss:auth>
									</c:if>
								</c:if>
                           <c:choose>                         
	                           <c:when test="${not empty kmVoteMainItemForm.fdAttId}">  
	                           		<c:set var="__fdAttId" value="${kmVoteMainItemForm.fdAttId}"></c:set>
	                           		<%
	                           		String fdAttId = (String)pageContext.getAttribute("__fdAttId");
	                           		String viewPicHref = SysAttPicUtils.getPreviewUrl(request,fdAttId);
	    							request.setAttribute("viewPicHref", viewPicHref);
	                           		%>
		                           	<span class="vote_item_img"  onclick="previewImage(this);">	
			                      		<img src="${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?${LUI_Cache}&method=download&fdId=${kmVoteMainItemForm.fdAttId}" _src="${viewPicHref}" disabled=" "/>		                       		                       	 
			                       	</span>
		                      	</c:when>
		                      	<c:otherwise>
		                      		<span style="display:none;">		                      			
		                      		</span>
		                      	</c:otherwise>
	                     	</c:choose>
	                     	<span class="vote_item_txt" onclick="selectClick('_fdVoteItemIds${vstatus.index+1}_');">
		                        <c:out value="${kmVoteMainItemForm.fdName}"/>
		                        <span id="${kmVoteMainItemForm.fdId}">		                        																				
	                		    </span>
		                    </span>
		                    </a>                 
	                    <c:choose>
                    		<%-- 当投票可查看，而且有设置例外人员时，要判断当前用户是否在例外人员之中，在则不显示，不在则正常显示 --%>
                     		<c:when test="${not empty kmVoteMainForm.fdViewerIds and (fn:contains(kmVoteMainForm.fdViewerIds,KMSS_Parameter_CurrentUserId))}">
		                      	<%@ include file="/km/vote/mobile/kmVoteMain_result.jsp" %>
		                    </c:when>
		                    <c:otherwise>
		                    	<c:if test="${(kmVoteMainForm.fdIsVoted  eq 'true' and kmVoteMainForm.fdVoterViewFlag == true) or (kmVoteMainForm.fdVoterViewFlag == false and  KMSS_Parameter_CurrentUserId eq kmVoteMainForm.docCreatorId) }">
                           	 		<%@ include file="/km/vote/mobile/kmVoteMain_result.jsp" %>
                 		 		</c:if>
                   			</c:otherwise>
	                    </c:choose>	
	                    </li>	   		                    
                        </c:forEach>
                        </ul>
                        
                    <c:if test="${kmVoteMainForm.docStatus !=10 &&kmVoteMainForm.fdVoteStatus == '0' && kmVoteMainForm.fdIsAllowSay=='true' && kmVoteMainForm.fdIsVoted != 'true'}">
					<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
						<div class="comment-input muiFontSizeM muiFontColorInfo"><span class=" mui mui-pen"></span>${ lfn:message('km-vote:mui.kmVoteMain.enter.comment') }</div>
						<div style="margin-left:1.4rem;"  data-dojo-type='mui/form/Textarea' 
							data-dojo-props='"placeholder":"${ lfn:message('km-vote:mui.kmVoteMain.enter.comment') }",
							"name":"docContent","showStatus":"edit"' >
						</div>
					</kmss:auth>
					</c:if>
                    <c:if test="${kmVoteMainForm.fdIsAllowSay=='true'}">
						<div class="comment-input muiFontSizeM muiFontColorInfo"><span class=" mui mui-feedbackMsg"></span>${ lfn:message('km-vote:mui.kmVoteMain.commentAll') }</div>
						<ul data-dojo-type="mui/list/JsonStoreList" 
					    	data-dojo-mixins="km/vote/mobile/js/list/voteCommentListMixin"
					    	data-dojo-props="url:'/km/vote/km_vote_comment/kmVoteComment.do?method=list&fdVoteMainId=${param.fdId}',lazy:false">
						</ul>
					</c:if>
                   		<div style="height: 1px"></div>
                  		</html:form>
					</div>


				</div>
			</div>
		</div>
        	<c:if test="${kmVoteMainForm.docStatus !=10 &&kmVoteMainForm.fdVoteStatus == '0' && kmVoteMainForm.fdIsVoted != 'true'}">
        		<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				  	<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
				  		<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" data-dojo-props='colSize:2,href:"javascript:_submit();",transition:"slide"'>${lfn:message('km-vote:button.updateVote')}</li>
				  	</kmss:auth>
				</ul>        	
            </c:if>
	</template:replace>
</template:include>

<script type="text/javascript">
require(['mui/form/ajax-form',"mui/dialog/Tip","mui/i18n/i18n!sys-mobile"],function(formFunc,Tip,Msg){
	formFunc.ajaxForm("[name='kmVoteMainForm']", {
		success : function(result){
			var text = Msg["mui.return.success"];
			if(result.hasVote=='true'){
				text = '<bean:message key="kmVoteMain.voted.tip" bundle="km-vote" />';
			}
			Tip.success({
				text: text, 
				callback: function(){
					location.href = "";
				}, 
				cover: true
			});
		}
	});
});
require(['mui/dialog/Tip','dijit/registry','dojo/dom','dojo/ready', 'dojo/request','mui/util','dojo/query','dojo/dom-attr','mui/device/adapter',"dojo/on","dojo/touch"],
		function(Tip,registry,dom,ready,request,util,query,domAttr,adapter,on,touch){
	ready(function(){
		var expireTime = "${kmVoteMainForm.fdExpireTime}";
		if(expireTime != ""){
			var expireDate = new Date(expireTime.replace(/-/g, "/"));
			if(expireDate<new Date()){
				dom.byId("expireTime").innerHTML = "${ lfn:message('km-vote:kmVoteMain.Status.ended')}";						
			}else{
				dom.byId("expireTime").innerHTML = "${kmVoteMainForm.fdExpireTime}";	
			}			
		}else{
			dom.byId("expireTime").innerHTML = "${ lfn:message('km-vote:mui.kmVoteMain.unlimited')}";
		}
		
		var url = "/km/vote/km_vote_record/kmVoteRecord.do?method=queryRecord";
		var data ={};
		data["fdMainId"] = "${kmVoteMainForm.fdId}";
		if(${kmVoteMainForm.fdIsVoted}){
	    	request.post(util.formatUrl(url),{data:data,handleAs:'json'}).then(  
		        function(data){
			        var mainItemIds = data.mainItemIds;
			        var mainItemIdArray = mainItemIds.split(";");
		        	for(var i =0 ;i<mainItemIdArray.length;i++){
		        		dom.byId(mainItemIdArray[i].trim()).innerHTML = "${lfn:message('km-vote:mui.kmVoteMain.selected')}";
		        	}
		        },  
		        function(error){  
		        }  
		    );  
		} 	
		
		/* 获取段落行数，超过3行则省略 */
		var descTotalHeight = document.getElementById("muiVoteDescText").scrollHeight;
		var descLineHeight = $('.muiVoteDescText').css("line-height");
		var descLineHeight = parseInt(descLineHeight.substring(0, descLineHeight.length-2));
		if (descTotalHeight > descLineHeight * 3) {
			$('.descButtonDown').show();
		}
	});
	
	window._submit = function(){
   		var thisObj = document.getElementsByName("fdVoteItemIds"); 
   		var isVote = false;
   		var num=0;
   		for (var i=0; i<thisObj.length; i++) {
   			var widget = registry.byNode(thisObj[i]);
   			if (widget.checked) {
   				num++;
   				isVote = true;
   				thisObj[i].checked = true;
   			}else{
   				thisObj[i].checked = false;
   			}
   		}
   		if(isVote){
   			var minOption = '${kmVoteMainForm.fdMinOption}'==""?0:parseInt('${kmVoteMainForm.fdMinOption}');
			var maxOption = '${kmVoteMainForm.fdMaxOption}'==""?0:parseInt('${kmVoteMainForm.fdMaxOption}');		   				
			if (num<minOption && minOption!=0){
				Tip.fail({
					text:'<bean:message bundle="km-vote" key="error.select.min" arg0="${kmVoteMainForm.fdMinOption}" />'
				});
				return false;
			}
			if (num>maxOption && maxOption!=0){
				Tip.fail({
					text:'<bean:message bundle="km-vote" key="error.select.max" arg0="${kmVoteMainForm.fdMaxOption}" />'
				});
				return false;
			}
			
   			var url = util.setUrlParameter(document.forms[0].action,'forward','participateSucc');
   			document.forms[0].action=url;
			Com_Submit(document.forms[0],'participatedVote');	   	   		
   		}else{
	   		Tip.fail({
				text:'<bean:message bundle="km-vote" key="error.item.required" />'
			});
   		}
	};

	window.selectClick = function(id){
		registry.byId(id)._onClick();
	};
	
	window.previewImage = function(evt){
		var images = query('.vote_tb_w .vote_item_img img');
		var srcList = [];
		for(var i = 0;i < images.length;i++){
			var url = domAttr.get(images[i],'_src');
			srcList.push(util.formatUrl(url,true));
		}
		var curSrc = util.formatUrl(domAttr.get(query('img',evt)[0],'_src'),true);
		adapter.imagePreview({
			curSrc : curSrc, 
			srcList : srcList
		});
	}
		
	on(query('.muiVoteDesc')[0], touch.press, function(){
		if ($('.descButtonDown').css('display') != 'none') {
			$('.muiVoteDescText').removeClass('descTextHidden');
			$('.descButtonDown').hide();
			$('.descButtonUp').show();
		} else if ($('.descButtonUp').css('display') != 'none') {
			$('.muiVoteDescText').addClass('descTextHidden');
			$('.descButtonDown').show();
			$('.descButtonUp').hide();
		}
	});
});
</script>