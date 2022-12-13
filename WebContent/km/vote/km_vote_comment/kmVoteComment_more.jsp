<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<script type="text/javascript">
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("docutil.js|optbar.js"); 
var flag=false;
function openMore(){ 
	if(!flag){
		document.getElementById("moreComment").style.display=""; 
		document.getElementById("tenComment").style.display="none"; 
		 document.getElementById("moreImg").src="${KMSS_Parameter_StylePath}vote/back.gif";
		flag=true;
	} 
	else if(flag){
		flag=false;
		document.getElementById("moreComment").style.display="none"; 
		document.getElementById("tenComment").style.display=""; 
		 document.getElementById("moreImg").src="${KMSS_Parameter_StylePath}vote/more.gif";
	}
	var iframe = parent.document.getElementById("iframeComment");  
	parent.SetWinHeight(iframe); //重新设置ifrmae大小 此页面不要了
}  
</script>  
<html>
<body>
<c:if test="${queryPage.totalrows>0}">
<table>
	<tr>
		<td>
			<b><bean:message  bundle="km-vote" key="kmVoteMain.commentAll"/></b> 
		</td>
		<td>
			<c:if test="${queryPage.totalrows>fdShowNum}">
			  <img id='moreImg' src='${KMSS_Parameter_StylePath}vote/more.gif' style="cursor: hand;"  onclick="openMore()"/>
		   </c:if>			
		</td>
	</tr> 
	<tr>
		<td colspan="2">
		<%---只显示fdShowNum条---%>
		<div id='tenComment'>
			<table>
			  <c:forEach items="${queryPage.list}" var="kmVoteComemnt" varStatus="vstatus">
				<c:if test='${vstatus.index<fdShowNum}'>
				   <tr>
				      <td style="color: #666666">
					    ${vstatus.index+1}. 
						<c:out value="${kmVoteComemnt.docContent}" /> 
				     </td>
				   </tr>
				</c:if>  
			  </c:forEach>
			</table>
		</div> 
		<%---显示所有评论---%>
		 <div id='moreComment' style="display: none">
		  	<table>
		  		<c:forEach items="${queryPage.list}" var="kmVoteComemnt" varStatus="vstatus"> 
					<tr>
						<td style="color: #666666"> 
						   ${vstatus.index+1}. 
						   <c:out value="${kmVoteComemnt.docContent}" /> 
						</td>
					</tr>
		  		</c:forEach> 
		  </table>
		 </div>
		</td>
	</tr>
</table>
</c:if>   
</body> 
</html>