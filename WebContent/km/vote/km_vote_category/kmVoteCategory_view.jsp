<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
		<kmss:auth requestURL="/km/vote/km_vote_category/kmVoteCategory.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<!-- 编辑 -->
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmVoteCategory.do?method=edit&fdId=${param.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/vote/km_vote_category/kmVoteCategory.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<!-- 删除 -->
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmVoteCategory.do?method=delete&fdId=${param.fdId}','_self');">
		</kmss:auth>
	<!-- 关闭 -->
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-vote" key="table.kmVoteCategory"/></p>

<center>
<%--内容--%>
<table
	id="Label_Tabel"
	width="95%">
	<%--模板信息---%>		
		<c:import url="/sys/simplecategory/include/sysCategoryMain_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmVoteCategoryForm" />
			<c:param name="fdModelName" value="com.landray.kmss.km.vote.model.KmVoteCategory" />
			<c:param name="fdKey" value="mainDoc" />
		</c:import>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>