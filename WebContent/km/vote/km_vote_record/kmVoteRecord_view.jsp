<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/vote/km_vote_record/kmVoteRecord.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmVoteRecord.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/vote/km_vote_record/kmVoteRecord.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmVoteRecord.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-vote" key="table.kmVoteRecord"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteRecord.docCreateTime"/>
		</td><td width="35%">
			<xform:datetime property="docCreateTime" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteRecord.fdMainItemIds"/>
		</td><td width="35%">
			<xform:text property="fdMainItemIds" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteRecord.docCreator"/>
		</td><td width="35%">
			<c:out value="${kmVoteRecordForm.docCreatorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteRecord.kmVoteMain"/>
		</td><td width="35%">
			<c:out value="${kmVoteRecordForm.kmVoteMainName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteRecord.kmVoteComment"/>
		</td><td width="35%">
			<c:out value="${kmVoteRecordForm.kmVoteCommentName}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>