<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<body>
<script type="text/javascript">
		seajs.use(['theme!module']);	
	</script>
<link rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/vote/resource/css/vote_portlet.css" />
<html:form action="/km/vote/km_vote_main/kmVoteMain.do" method="GET">
<html:hidden property="method" value="participatedVote" />
<html:hidden property="fdId" value="${kmVoteMainForm.fdId}" />
<html:hidden property="type" value="portlet" />
<html:hidden property="current" value="${currentNum}" />
	<div id="portlet_content" class="lui_vote_portlet_slideContainer" style="width:100%;">
		<div class="vote_slide_hd">
		<!-- 上一条 -->
			<c:if test="${previous == 'previous' }">
				<span class="vote_slide_prev" onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=getLatestVote&fdCategoryId=${JsParam.fdCategoryId}&current=${currentNum-1}" />', '_self');"></span>
			</c:if>
			<!-- 下一条 -->
			<c:if test="${next == 'next' }">
				<span class="vote_slide_next" onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=getLatestVote&fdCategoryId=${JsParam.fdCategoryId}&current=${currentNum+1}" />', '_self');"></span>
			</c:if>
		</div>
		<div class="vote_slide_bd">
			<!-- 投票页面 -->
			<div class="vote_container">
				<p class="vote_title">
				<c:if test="${empty kmVoteMainForm.docSubject}">
					<bean:message bundle="km-vote" key="message.noNewVote" />
				</c:if>
				<c:if test="${not empty kmVoteMainForm.docSubject}">
						<a href="#" style="text-decoration: none" onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />?method=view&fdId=${kmVoteMainForm.fdId}', '_blank');">
							<bean:message bundle="km-vote" key="kmVoteMain.subject" /><c:out value="${kmVoteMainForm.docSubject}" />
						</a>
						(<bean:message bundle="km-vote" key="error.select.required" />
						<c:if test="${kmVoteMainForm.fdMaxSelectNum != '0'}">
							<bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />
								<c:out value="${kmVoteMainForm.fdMaxSelectNum}" />
							<bean:message bundle="km-vote" key="kmVoteMain.item" />
						</c:if>)
						<br/>
						<c:if test="${kmVoteMainForm.fdVoteStatus == '1'}">
							<span>&nbsp;</span><font color="red"><bean:message bundle="km-vote" key="message.voteStatus.notStarted" /></font>
						</c:if>
						<c:if test="${kmVoteMainForm.fdVoteStatus == '2'}">
							<span>&nbsp;</span><font color="red"><bean:message bundle="km-vote" key="message.voteStatus.end" /></font>
						</c:if>
				</c:if>
				</p>
					 <c:set var="viewResult" value="false"></c:set>
					 <c:choose>
                      		<%-- 当投票可查看，而且有设置例外人员时，要判断当前用户是否在例外人员之中，在则不显示，不在则正常显示 --%>
                      	<c:when test="${not empty kmVoteMainForm.fdViewerIds and (fn:contains(KMSS_Parameter_CurrentUserId,kmVoteMainForm.fdViewerIds))}">
	                      	<c:set var="viewResult" value="true"></c:set>
                      	</c:when>
                      	<c:otherwise>
                      		 <c:if test="${(kmVoteMainForm.fdIsVoted  eq 'true' and kmVoteMainForm.fdVoterViewFlag == true)}">
                            	 <c:set var="viewResult" value="true"></c:set>
                  		 	</c:if>
                  		 	<c:if test="${(kmVoteMainForm.fdVoterViewFlag == false and  (KMSS_Parameter_CurrentUserId eq kmVoteMainForm.docCreatorId)) }">
                            	 <c:set var="viewResult" value="true"></c:set>
                  		 	</c:if>
                    	</c:otherwise>
                    </c:choose>
					<div class="vote_content">
						<ul class="vote_result_list  <c:if test="${kmVoteMainForm.fdIsVoted == 'true' && kmVoteMainForm.fdVoteStatus == '0'}">vote_result_voted</c:if>" >
							<c:forEach items="${kmVoteMainForm.fdVoteItems}" var="kmVoteMainItemForm" varStatus="vstatus">
								<c:choose>
									<c:when test="${fn:contains(requestScope.ids,kmVoteMainItemForm.fdId)}">
										<li>
									</c:when>
									<c:otherwise>
										<li>
									</c:otherwise>
								</c:choose>
									<div class="vote_result_title">
										<div class="vote_opt_name">
										<label>
											<div class = "vote_radio">
											<c:if test="${kmVoteMainForm.fdIsRadio == 'false'}">
			                              		<c:if test="${kmVoteMainForm.fdIsVoted != 'true' &&kmVoteMainForm.fdVoteStatus == '0'}">
				                              		<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
														<input type="checkbox"  name="fdVoteItemIds" value="${kmVoteMainItemForm.fdId}" onclick="checkMaxSecletNum(this);"  /><i class="item_checkbox"></i>
													</kmss:auth>
												</c:if>		
											</c:if>
											<c:if test="${kmVoteMainForm.fdIsRadio == 'true'}">
												<c:if test="${kmVoteMainForm.fdIsVoted != 'true' &&kmVoteMainForm.fdVoteStatus == '0'}">
													<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
														<input type="radio" name="fdVoteItemIds" value="${kmVoteMainItemForm.fdId}"/><i class="item_radio"></i>
													</kmss:auth>
												</c:if>
											</c:if>
											</div>
											<div class="vote_item">
												<c:out value="${kmVoteMainItemForm.fdName}" />
												<c:if test="${viewResult}"><em>(<c:out value="${kmVoteMainItemForm.fdVoteItemNum}"/>票)</em></c:if>
											</div>
										</label>
										</div>
										<c:if test="${viewResult}"><div class="vote_opt_num"><c:out value="${kmVoteMainItemForm.fdVoteItemRate}" /></div></c:if>
									</div>
									<c:if test="${viewResult}"><div class="barline color_style_${kmVoteMainItemForm.fdColor}"><span style="width:${kmVoteMainItemForm.fdVoteItemRate}"></span></div></c:if>
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="vote_btn_bar">
						<c:if test="${kmVoteMainForm.fdVoteStatus == '0' && kmVoteMainForm.fdIsVoted != 'true'}">
							<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=participatedVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
								<a href="javascript:void(0)" class="vote_btn" onclick="validateData();">投票</a>
							</kmss:auth>
						</c:if>
						<c:if test="${kmVoteMainForm.docStatus !=10 && kmVoteMainForm.fdVoteStatus == '0'&& kmVoteMainForm.fdIsVoted == 'true'}">  
						   <div class="lui_vote_portlet_voted_box">
						   		<span class="lui_vote_portlet_voted_tip"><i></i><span><bean:message bundle="km-vote" key="kmVoteMain.voted.tip" /></span></span>
						   </div>
					    </c:if>
					</div>
					
			</div>
		</div>
	</div>
<script type="text/javascript">
function checkMaxSecletNum(thisObj) {
	var num=0;
	var obj = document.getElementsByName("fdVoteItemIds");
	var maxNum = ${kmVoteMainForm.fdMaxSelectNum};
	for (var i=0; i<obj.length; i++) {
		if (obj[i].checked) {
			num++;
			if (maxNum != 0 && num > maxNum) {
				alert('<bean:message bundle="km-vote" key="error.maxSelect" arg0="${kmVoteMainForm.fdMaxSelectNum}" />');
				thisObj.checked = false;
				break;
			}
		}
	}
}

function validateData(){
	var thisObj = document.getElementsByName("fdVoteItemIds");
	for (var i=0; i<thisObj.length; i++) {
		if (thisObj[i].checked) { 
			var docContent=document.getElementsByName("docContent")[0]; 
			var msg='<bean:message bundle="km-vote" key="kmVoteMain.commentDocContent" />';
			if(docContent!=null&&docContent.value==msg){  
				document.getElementsByName("docContent")[0].value="";				
			 }  
			document.kmVoteMainForm.action='<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />';
			document.kmVoteMainForm.submit();
			//去掉投票成功之后还打开view页面，没必要
			//var url='<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />?method=view&fdId=${kmVoteMainForm.fdId}';
			//setTimeOut("Com_OpenWindow(url)",500);
			return true;
		}
	}
	alert('<bean:message bundle="km-vote" key="error.item.required" />');
	return false;
}
function onfocusClear(obj){ 
	var msg='<bean:message bundle="km-vote" key="kmVoteMain.commentDocContent" />';
	if(obj.value==msg){
		document.getElementsByName("docContent")[0].value="";
		document.getElementsByName("docContent")[0].className="fontBlue";
	}
}

function onblurClear(obj){ 
	var msg='<bean:message bundle="km-vote" key="kmVoteMain.commentDocContent" />';
	if(obj.value==""){
		document.getElementsByName("docContent")[0].value=msg;
		document.getElementsByName("docContent")[0].className="fontGray";
	}
}
function onloadCommentMsg(){ 
	var msg='<bean:message bundle="km-vote" key="kmVoteMain.commentDocContent" />';
	var docContent = document.getElementsByName("docContent")[0];
	 if(docContent!=null){
		 document.getElementsByName("docContent")[0].value=msg;
		 document.getElementsByName("docContent")[0].className="fontGray";
	 }	 
}
window.onload = function(){
	onloadCommentMsg();
	if (window.frameElement != null && window.frameElement.tagName == "IFRAME") {
		window.frameElement.style.height = (document.getElementById('portlet_content').offsetHeight + 30)+"px";
	}
}
function filter(str){
	str = str.replace(/&lt;/g, "<");
	str = str.replace(/&gt;/g, ">");
	str = str.replace(/&amp;/g, "&");
	str = str.replace(/&quot;/g, "\"");
	str = str.replace(/&#034;/g, "\"");
	str = str.replace(/&#39;/g, "<");
	str = str.replace(/&lt;/g, "'");
	str = str.replace(/&#039;/g, "'");
	return str;
}
</script>
</html:form>
</body>