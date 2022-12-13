<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<STYLE type=text/css>
.fontBlue{  
    color:#0066FF
}
.fontGray { 
 	color:#999
}
</STYLE>
<script type="text/javascript">
Com_IncludeFile("vote.css", "style/"+Com_Parameter.Style+"/vote/"); 

function SetWinHeight(obj)
{   
    var win=obj;
    if (document.getElementById)
    {
        if (win && !window.opera)
        { 
        	 if (win.contentDocument) {
                if(win.contentDocument.body.offsetHeight) {
	            	//oIframe.style.height = oWin.document.body.scrollHeight + "px";
	                win.height = win.contentDocument.body.offsetHeight ; 
                }else if(win.contentDocument.body.scrollHeight){
                    win.style.height = win.contentDocument.body.scrollHeight;
                }
            }else if(win.document && win.document.body.scrollHeight)
                win.height = win.Document.body.scrollHeight ;
        }
    } 
}
function showComment(){
	var iframe = document.getElementById("iframeComment");  
	if(iframe!=null){
		if(iframe.getAttribute("src")==""){
			var url=""; 
			url="<c:url value='/km/vote/km_vote_comment/kmVoteComment.do?method=list&fdVoteMainId=' />"+'${param.fdId}';
			iframe.src=url;
		}
	}
}

 

window.onload = function(){
	var returnInfo = "${returnInfo}";
	if (returnInfo != null && returnInfo != ""){
		alert(returnInfo);
	}  
	showComment();
	onloadCommentMsg(); 
}

function confirmDelete(msg){
	var del = confirm('<bean:message key="message.delete.vote.confirm" bundle="km-vote" />');
	return del;
}
function confirmTerminate(msg){
	var del = confirm('<bean:message key="message.terminate.this.vote.confirm" bundle="km-vote" />');
	return del;
}
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
<div id="optBarDiv">
	<!-- 编辑投票 -->
	<c:if test="${kmVoteMainForm.fdVoteStatus=='0' || kmVoteMainForm.fdVoteStatus=='1'||kmVoteMainForm.docStatus=='10'}">
	<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button" value="<bean:message bundle="km-vote" key="button.editVote"/>"
			onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	</c:if>
	<c:if test="${kmVoteMainForm.fdVoteStatus=='0'&&kmVoteMainForm.docStatus !='10'}">
	<!-- 终止投票 -->
	<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=terminateVote&fdId=${param.fdId}" requestMethod="GET">
		<input type="button" value="<bean:message bundle="km-vote" key="button.terminateVote"/>"
			onclick="if(!confirmTerminate())return;Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />?method=terminateVote&fdId=${param.fdId}', '_self');">
	</kmss:auth>
	<!-- 催办投票 -->
	<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=remindVote&fdId=${param.fdId}" requestMethod="GET">
		<input type="button" value="<bean:message bundle="km-vote" key="button.remindVote"/>"
			onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />?method=remindVote&fdId=${param.fdId}', '_self');">
	</kmss:auth>
	</c:if>
	<!-- 删除 -->
	<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button" value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth> 
	<!-- 关闭 -->
	<input type="button" value="<bean:message key="button.close"/>" 
	onclick="Com_CloseWindow();">
</div>
<div class="mainBody">
	<div class="container">
		<div id="vote_main">
			<div class="header">
				<button class="icon_vote">&nbsp;</button>
				<b class="f14"><bean:message bundle="km-vote" key="table.kmVoteMain" /></b>
			</div>
			<div class="l tal mlr42 c6">
				<bean:message bundle="km-vote" key="kmVoteMain.docCreateTime" />:&nbsp;<c:out value="${kmVoteMainForm.docCreateTime}" /><br />
				<bean:message bundle="km-vote" key="kmVoteMain.fdEffectTime" />:&nbsp;<c:out value="${kmVoteMainForm.fdEffectTime}" /><br />
				<bean:message bundle="km-vote" key="kmVoteMain.fdVoteNum" />:&nbsp;<c:out value="${kmVoteMainForm.fdVoteNum}" /><br />
				<c:if test="${not empty kmVoteMainForm.fdShouldVoteNum}">
					<bean:message bundle="km-vote" key="kmVoteMain.fdShouldVoteNum" />:&nbsp;<c:out value="${kmVoteMainForm.fdShouldVoteNum}" /><br />
					<bean:message bundle="km-vote" key="kmVoteMain.fdVoteRate" />:&nbsp;<c:out value="${kmVoteMainForm.fdVoteRate}" /><br />
				</c:if>
				<bean:message bundle="km-vote" key="kmVoteMain.fdExpireTime" />:&nbsp;<c:out value="${kmVoteMainForm.fdExpireTime}" /><br />
				<c:if test="${kmVoteMainForm.fdVoteStatus == '1'}">
					<font color="red"><bean:message bundle="km-vote" key="message.voteStatus.notStarted" /></font>
				</c:if>
				<c:if test="${kmVoteMainForm.fdVoteStatus == '2'}">
					<font color="red"><bean:message bundle="km-vote" key="message.voteStatus.end" /></font>
				</c:if>
				<c:if test="${kmVoteMainForm.fdIsVoted == 'true' && kmVoteMainForm.fdVoteStatus != '2'}">
					<font color="red"><bean:message bundle="km-vote" key="message.has.voted" /></font>
				</c:if>
			</div>
			<div class="c"></div>
			<div class="ml20 title">
				<button class="icon_title">&nbsp;</button>
				<c:out value="${kmVoteMainForm.docSubject}" />
				<span class="tip">
					(<bean:message bundle="km-vote" key="error.select.required" />
					<c:if test="${kmVoteMainForm.fdMaxSelectNum != '0'}">
						<bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />
							<c:out value="${kmVoteMainForm.fdMaxSelectNum}" />
						<bean:message bundle="km-vote" key="kmVoteMain.item" />
					</c:if>)
				</span>
			</div>
			<c:if test="${not empty kmVoteMainForm.fdDescription}">
				<div class="l tal mlr42 c6">
					<c:out value="${kmVoteMainForm.fdDescription}" />
				</div>
			</c:if>
			<div class="c"></div>
			<div class="mlr42 content">
				<html:form action="/km/vote/km_vote_main/kmVoteMain.do" method="GET">
				<html:hidden property="method" value="participatedVote" />
				<html:hidden property="fdId" value="${param.fdId}" />
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<c:forEach items="${kmVoteMainForm.fdVoteItems}" var="kmVoteMainItemForm" varStatus="vstatus">
					<tbody>
						<tr>
							<td width="3%">
								<label>
									<c:if test="${kmVoteMainForm.fdIsRadio == 'true'}">
										<input type="radio" name="fdVoteItemIds" value="${kmVoteMainItemForm.fdId}" 
											<c:if test="${kmVoteMainForm.fdVoteStatus != '0' || requestScope.showResult == 'true'}">
												disabled="true"
											</c:if>
											/>
									</c:if>
									<c:if test="${kmVoteMainForm.fdIsRadio == 'false'}">
										<input type="checkbox" name="fdVoteItemIds" value="${kmVoteMainItemForm.fdId}" onclick="checkMaxSecletNum(this);" 
											<c:if test="${kmVoteMainForm.fdVoteStatus != '0' || requestScope.showResult == 'true'}">
												disabled="true"
											</c:if>
											/>
									</c:if>
								</label>
							</td>
							<td width="40%">
								<span class="option" id="abc">
									<script type="text/javascript">
										document.write(filter('<c:out value="${kmVoteMainItemForm.fdName}" />'));
									</script>
								</span>
							</td>
							<td width="25%">
								<c:if test="${requestScope.showResult == 'true'}">
									<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=viewResult&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
										<div class="l tpbg" style="width: 200px">
											<div class="l vbg${kmVoteMainItemForm.fdColor}" style="height:10px;width: <c:out value="${kmVoteMainItemForm.fdVoteItemRate}" />"></div>
										</div>
									</kmss:auth>
								</c:if>
							</td>
							<td width="15%">
								<c:if test="${requestScope.showResult == 'true'}">
									<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=viewResult&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
				                    	<div class="w100 l">
				                    		<c:out value="${kmVoteMainItemForm.fdVoteItemNum}" />
				                    		(<c:out value="${kmVoteMainItemForm.fdVoteItemRate}" />)
				                    	</div>
			                    	</kmss:auth>
		                    	</c:if>
		                    </td>
		                    <td width="17%">&nbsp;</td>
						</tr>
					</tbody>
					</c:forEach>
				</table>
				<br> 
				<%---提交评论---%>
				<c:if test="${kmVoteMainForm.docStatus !=10}">  
					<c:if test="${kmVoteMainForm.fdIsAllowSay=='true'&& kmVoteMainForm.fdVoteStatus == '0'&& kmVoteMainForm.fdIsVoted != 'true' && requestScope.showResult != 'true'}">  
				       <TEXTAREA   style="height: 50;width:40%"   name='docContent'  onfocus="onfocusClear(this)"  onblur="onblurClear(this)"></TEXTAREA>  
				     </c:if>
			     </c:if>
				<br>
				<div class="mlr42 p20">
					<c:if test="${kmVoteMainForm.fdVoteStatus == '0' && kmVoteMainForm.fdIsVoted != 'true' && requestScope.showResult == 'true' && requestScope.isViewer != 'true'}">
						<input class="btn" type="button" value='<bean:message bundle="km-vote" key="button.returnVote" />' onclick="Com_OpenWindow('kmVoteMain.do?method=view&fdId=${kmVoteMainForm.fdId}', '_self');" />
						<span class="w15">&nbsp;</span>
					</c:if>
				<c:if test="${kmVoteMainForm.docStatus !=10}"> 
					<c:if test="${kmVoteMainForm.fdVoteStatus == '0' && kmVoteMainForm.fdIsVoted != 'true' && requestScope.showResult != 'true'}">
						<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=participatedVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
							<input class="btn" type="button" value='<bean:message bundle="km-vote" key="button.submitVote" />' onclick="validateData();" />
							<span class="w15">&nbsp;</span>
						</kmss:auth>
					</c:if>
					<c:if test="${kmVoteMainForm.fdVoteStatus != '1' && requestScope.showResult != 'true'}">
						<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=viewResult&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
							<input class="btn" type="button" value='<bean:message bundle="km-vote" key="button.viewResult" />' onclick="Com_OpenWindow('kmVoteMain.do?method=viewResult&fdId=${kmVoteMainForm.fdId}', '_self');" />
						</kmss:auth>
					</c:if>
				</c:if>
				</div> 
				
				<c:if test="${kmVoteMainForm.fdVoteStatus == '0'&& kmVoteMainForm.fdIsVoted != 'true' && requestScope.showResult != 'true'}">  
				     <div> <%---投票样式---%>
				</c:if>
				<c:if test="${kmVoteMainForm.fdVoteStatus != '0'|| kmVoteMainForm.fdIsVoted == 'true' || requestScope.showResult == 'true'}">  
					 <div style="margin-top: -30px"> <%---结果样式---%>
				</c:if>
				<%--所有评论--%>  
				<table width=100% height=100%>  
				     <tr>
				     	<td>
					     	<iframe id="iframeComment" src="" width="100%" height="100%" frameborder=0 scrolling=no  onload="Javascript:SetWinHeight(this)">
							</iframe>
				     	</td>
				     </tr> 
				 	 <tr>  
						<c:import url="/km/vote/km_vote_main/kmVoteMain_more_iframe.jsp" charEncoding="UTF-8">
							<c:param name="fdId" value="${kmVoteMainForm.fdId}" />
						</c:import> 
					 </tr>
				</table> 
				</div> 
				</html:form>
			</div>
		</div>
	</div>

<%@ include file="/resource/jsp/view_down.jsp"%>