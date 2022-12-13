<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<kmss:windowTitle
	subjectKey="km-vote:table.kmVoteCategory"
	moduleKey="km-vote:table.kmVoteCategory" />
<script language="JavaScript">
Com_IncludeFile("dialog.js");
</script>
<html:form action="/km/vote/km_vote_category/kmVoteCategory.do"
	onsubmit="return validateKmVoteCategoryForm(this);">
	<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_edit_button.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmVoteCategoryForm" />
	</c:import>


<!-- 投票分类 -->
<p class="txttitle"><bean:message  bundle="km-vote" key="table.kmVoteCategory" /></p>
</br>
<center>
	<table
		class="tb_normal"
		width="95%">
		<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_edit_body.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmVoteCategoryForm" />
			<c:param name="requestURL" value="km/vote/km_vote_category/kmVoteCategory.do?method=add" />
			<c:param name="fdModelName" value="${param.fdModelName}" />
		</c:import> 
	</table>
</center>

<html:hidden property="fdId" />
<html:hidden property="method_GET" />
</html:form>
<html:javascript formName="kmVoteCategoryForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>