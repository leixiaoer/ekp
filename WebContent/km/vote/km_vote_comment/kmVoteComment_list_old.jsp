<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@ include file="../km_vote_main/list_top.jsp"%> 
<%@ page import="com.sunbor.web.tag.Page" %> 
 <script type="text/javascript">
Com_IncludeFile("vote_comment.css", "style/"+Com_Parameter.Style+"/vote/");
function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
function delComment(id){ 
	if(!confirmDelete())return;
	var url="<c:url value='/km/vote/km_vote_comment/kmVoteComment.do' />?method=delete&fdId="+id;
	Com_OpenWindow(url,'_self');
}
function delAllComment(id){
	if(!confirmDelete())return; 
	var url="<c:url value='/km/vote/km_vote_comment/kmVoteComment.do' />?method=deleteall&fdId="+id;
	Com_OpenWindow(url,'_self');
}
</script>
<html>
<body>
<c:if test="${queryPage.totalrows>0}"> 
<table >  
	<tr>
		<td colspan=2>
			<b><bean:message  bundle="km-vote" key="kmVoteMain.commentAll"/></b>			
		</td>
		<td> <%---删除所有评论---%>
		   <kmss:auth requestURL="/km/vote/km_vote_comment/kmVoteComment.do?method=deleteall&fdId=${fdVoteMainId}" requestMethod="GET">
			    <img id='moreImg' src='${KMSS_Parameter_StylePath}icons/delete.gif' 
				 style="cursor: hand;"  onclick="delAllComment('${fdVoteMainId}');" 
				 title='<bean:message  bundle="km-vote" key="kmVoteComment.delAll"/>' />
			 </kmss:auth>
		 </td>
	</tr>
	<tr><td colspan=2></td></tr>
	 <c:forEach items="${queryPage.list}" var="kmVoteComment" varStatus="vstatus">
		<tr >
			<td  >
				${vstatus.index+1}.  
				<span style="color: #666666">
				${kmVoteComment.docContent}</span>
			</td>				 
			<td ><%---删除评论---%>
			 <kmss:auth requestURL="/km/vote/km_vote_comment/kmVoteComment.do?method=delete&fdId=${kmVoteComment.fdId}" requestMethod="GET">
				 <img id='moreImg' src='${KMSS_Parameter_StylePath}icons/delete.gif'
				  style="cursor: hand;"  onclick="delComment('${kmVoteComment.fdId}')" 
				  title='<bean:message  bundle="km-vote" key="kmVoteComment.del"/>' />
			 </kmss:auth>
			 </td>
		</tr>
	</c:forEach>
</table> 
</c:if> 
<c:if test="${queryPage.totalrows>1}">
 	<DIV class="pages" style="float: left;margin-top:9px"> 
		<span class="postPages" >
			<sunbor:page name="queryPage" pagenoText="pagenoText1" pageListSize="10" pageListSplit="">
				<sunbor:leftPaging><b>&lt;<bean:message key="page.thePrev"/></b></sunbor:leftPaging>
				{11}
				<sunbor:rightPaging><b><bean:message key="page.theNext"/>&gt;</b></sunbor:rightPaging>
				<% if (((Page)request.getAttribute("queryPage")).getTotal() > 1){ %>
					<span style="margin-top:-1px;height: 20px;">{9}</span>
					<img src="${KMSS_Parameter_StylePath}icons/go.gif" border=0 title="<bean:message key="page.changeTo"/>"
					 	onclick="{10}" style="cursor:pointer">
				<% } %>
			</sunbor:page>
		</span> 
	</DIV>  
</c:if>   
</body>
</html>
<%@ include file="/resource/jsp/list_down.jsp"%>
