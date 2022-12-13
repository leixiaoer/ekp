<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<script type="text/javascript">
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("docutil.js|optbar.js");
window.onload = function(){
	var parentTbObj = parent.document.getElementById("moreVoting");
	//parentTbObj.style.height = document.body.scrollHeight + 'px';
	parent.SetWinHeight(parentTbObj);
}
</script>
<script type="text/javascript">
//打开附件
var tbObjHeight;
function onloadHeight(){
	tbObjHeight = document.body.scrollHeight+5;
}
</script>
<html>
<head>
<STYLE type=text/css>
A:link {
 	FONT-SIZE:12px;
    TEXT-DECORATION: none;
	COLOR:#666666;
	CURSOR: hand;
}
A:hover {
	FONT-SIZE:12px;
	COLOR: #0052C2; 
	TEXT-DECORATION: underline;
}
</STYLE>
</head>
<body>
<table id="votingView">
	<tr>
		<td>
			<b>
				<bean:message  bundle="km-vote" key="kmVoteMain.moreVoting"/>				
			</b>
		</td>
	</tr>
	<tr><td></td></tr>
	<c:if test="${queryPage.totalrows>0}">
		<c:forEach items="${queryPage.list}" var="kmVoteMain" varStatus="vstatus">
			<tr>
				<td >
					${vstatus.index+1}.
					<a href="#" onclick="Com_OpenWindow('<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />?method=view&fdId=${kmVoteMain.fdId}','_top');" >
						<c:out value="${kmVoteMain.docSubject}" />
					</a> 
				</td>
			</tr>
		</c:forEach>
	</c:if>
	<tr>
		<td>
			<a href="#" onclick="Com_OpenWindow('<c:url value="/km/vote.index" />','_top');" >
			……
			</a>
		</td>
	</tr>
</table>
<script type="text/javascript">
onloadHeight();
</script>
</body>
</html>