<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<head>
<STYLE type=text/css>
.fontBlue{
	color:#0066FF
}
.fontGray { 
 	color:#999
}
.option { width:95%;margin-bottom: -2px; overflow:hidden; display:inline-block; white-space:nowrap; word-wrap:normal; text-overflow:ellipsis;}
</STYLE>
<script type="text/javascript">
Com_IncludeFile("vote.css", "style/"+Com_Parameter.Style+"/vote/");
Com_IncludeFile("portal.css", "style/"+Com_Parameter.Style+"/portal/");
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
		window.frameElement.style.height = (document.getElementById('portlet_content').offsetHeight + 15)+"px";
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

</head>
<div id="portlet_content" style="margin-left:10px;">
	<c:if test="${empty kmVoteMainForm.docSubject}">
		<div class="tip"><bean:message bundle="km-vote" key="message.noNewVote" /></div>
	</c:if>
	<c:if test="${not empty kmVoteMainForm.docSubject}">
	<div class="f12">
		<!-- 主题 -->
		<button class="icon_portlet_vote">&nbsp;</button>
		<font color="c0">
			<bean:message bundle="km-vote" key="kmVoteMain.subject" />
		</font>
		<a href="#" style="text-decoration: none" 
			onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />?method=view&fdId=${kmVoteMainForm.fdId}', '_blank');">
			<span class="c3"><b><c:out value="${kmVoteMainForm.docSubject}" /></b></span>
		</a>
		<span class="tip">
			(<bean:message bundle="km-vote" key="error.select.required" />
			<c:if test="${kmVoteMainForm.fdMaxSelectNum != '0'}">
				<bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />
					<c:out value="${kmVoteMainForm.fdMaxSelectNum}" />
				<bean:message bundle="km-vote" key="kmVoteMain.item" />
			</c:if>)
		</span><br />
		<c:if test="${kmVoteMainForm.fdVoteStatus == '1'}">
			<span>&nbsp;</span><font color="red"><bean:message bundle="km-vote" key="message.voteStatus.notStarted" /></font>
		</c:if>
		<c:if test="${kmVoteMainForm.fdVoteStatus == '2'}">
			<span>&nbsp;</span><font color="red"><bean:message bundle="km-vote" key="message.voteStatus.end" /></font>
		</c:if>
		<c:if test="${kmVoteMainForm.fdIsVoted == 'true' && kmVoteMainForm.fdVoteStatus != '2'}">
			<span>&nbsp;</span><font color="red"><bean:message bundle="km-vote" key="message.has.voted" /></font>
		</c:if>
	</div>
	<c:if test="${kmVoteMainForm.fdVoteStatus == '1' && kmVoteMainForm.fdVoteStatus == '2' && kmVoteMainForm.fdIsVoted == 'true'}">
		<br>
	</c:if>
	<div>
		<html:form action="/km/vote/km_vote_main/kmVoteMain.do" method="GET">
		<html:hidden property="method" value="participatedVote" />
		<html:hidden property="fdId" value="${kmVoteMainForm.fdId}" />
		<html:hidden property="type" value="portlet" />
		<html:hidden property="current" value="${currentNum}" />
			
		<table style="table-layout:fixed;" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<c:forEach items="${kmVoteMainForm.fdVoteItems}" var="kmVoteMainItemForm" varStatus="vstatus">
			<tbody>
				<tr>
					<td style="height: 25px">
						<label>
							<c:set var="isAllowVote" value="false" />
							<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
								<c:set var="isAllowVote" value="true" />
							</kmss:auth>
							
							<c:if test="${kmVoteMainForm.fdIsRadio == 'true'}">
								<input type="radio" name="fdVoteItemIds" value="${kmVoteMainItemForm.fdId}" 						
									<c:choose>
										<c:when test="${kmVoteMainForm.fdIsVoted == 'false' && isAllowVote == 'true' && kmVoteMainForm.fdVoteStatus == '0'}">
										</c:when>
										<c:otherwise>
											<c:if test="${fn:contains(requestScope.ids,kmVoteMainItemForm.fdId)}">
												checked ="checked"
											</c:if>
											disabled="true"
										</c:otherwise>
									</c:choose>
									/>
							</c:if>
							<c:if test="${kmVoteMainForm.fdIsRadio == 'false'}">
								<input type="checkbox" name="fdVoteItemIds" value="${kmVoteMainItemForm.fdId}" onclick="checkMaxSecletNum(this);" 
									<c:choose>
										<c:when test="${kmVoteMainForm.fdIsVoted == 'false' && isAllowVote == 'true' && kmVoteMainForm.fdVoteStatus == '0'}">
										</c:when>
										<c:otherwise>
											<c:if test="${fn:contains(requestScope.ids,kmVoteMainItemForm.fdId)}">
												checked ="checked"
											</c:if>
											disabled="true"
										</c:otherwise>
									</c:choose>
									/>
							</c:if>
							<span class="option" style="width:auto;" title="<c:out value='${kmVoteMainItemForm.fdName}' />"><c:out value="${kmVoteMainItemForm.fdName}" />
							</span>
						</label>
					</td>
				</tr>
				</tbody>
			</c:forEach>
		</table> 
	
	<c:if test="${(kmVoteMainForm.fdVoteStatus == '0' && kmVoteMainForm.fdIsVoted != 'true') || kmVoteMainForm.fdVoteStatus != '1'}">
	</c:if>
	<%-----评论-----%>
	<c:if test="${kmVoteMainForm.fdIsAllowSay=='true'&& kmVoteMainForm.fdVoteStatus == '0'&& kmVoteMainForm.fdIsVoted != 'true'}">  
		<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=participatedVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
		 <table width="98%">
		 	<tr>
		 	 <td width="2%">&nbsp;</td> 
			 <td width="98%">
				 <html:textarea property="docContent" value="" style="height: 45;width:100%" 
				  onfocus="onfocusClear(this)"  onblur="onblurClear(this)"/>
    		</td></tr>
    	 </table> 
    	 </kmss:auth>
	 </c:if>  
	 </html:form>
	 </div>
	<div class="f12"> 
	    <center>
		<!-- 我也投一票 -->
			<c:if test="${kmVoteMainForm.fdVoteStatus == '0' && kmVoteMainForm.fdIsVoted != 'true'}">
				<span style="padding-top: 5px; padding-bottom: 5px">&nbsp;</span>
				<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=participatedVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
					<a href="#" class="c3" onclick="validateData();">
						<bean:message bundle="km-vote" key="button.iVote" />
					</a>
				</kmss:auth>
			</c:if>
			<span class="w15">&nbsp;</span>
			
			<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=viewResult&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
				<a href="#" class="c3" onclick="Com_OpenWindow('kmVoteMain.do?method=viewResult&fdId=${kmVoteMainForm.fdId}', '_blank');">
					<bean:message bundle="km-vote" key="button.viewResult" />
				</a>
			</kmss:auth>
		</center>
	</div>
	</c:if>
	<div class="f12" style="text-align: center">
		<!-- 发起投票 -->
		<span>&nbsp;</span>
		<!-- 上一条 -->
		<c:if test="${previous == 'previous' }">
		<a href="#" class="c3" onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=getLatestVote&fdCategoryId=${JsParam.fdCategoryId}&current=${currentNum-1}" />', '_self');">
			<bean:message bundle="km-vote" key="kmVoteMain.previous" />
		</a>&nbsp;|&nbsp;
		</c:if>
		<!-- 下一条 -->
		<c:if test="${next == 'next' }">
		<a href="#" class="c3" onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=getLatestVote&fdCategoryId=${JsParam.fdCategoryId}&current=${currentNum+1}" />', '_self');">
			<bean:message bundle="km-vote" key="kmVoteMain.next" />
		</a>&nbsp;|&nbsp;
		</c:if>
		<!-- 更多投票 -->
		<a href="${KMSS_Parameter_ContextPath}km/vote#cri.q=fdVoteCategory:${HtmlParam.fdCategoryId};fdVoteStatus:0" class="c3" target="_blank">
			<bean:message bundle="km-vote" key="button.moreVote" />
			(<c:out value="${sessionScope.votingCount}" />)
		</a>
	</div>
</div>