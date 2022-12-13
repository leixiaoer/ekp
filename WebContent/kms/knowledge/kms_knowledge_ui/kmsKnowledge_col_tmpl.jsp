<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="kmsCategoryEnabled" value="false"></c:set>	
<c:set var="kmsKnowledgeBaseDocDocCategory" value="${lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.docCategory') }"></c:set>	
<%--抽取列表页模板，给个人中心用 --%>
<list:col-checkbox name="List_Selected" style="width:5%"></list:col-checkbox>
<list:col-serial title="${ lfn:message('page.serial') }" headerStyle="width:5%"></list:col-serial>
<list:col-html title="${ lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.docSubjects')}" headerStyle="width:40%" style="text-align:left;padding:0 8px">
	{$
		{%row['icon']%}
		<span class="com_subject">{%row['docSubject']%}</span>
	$}
</list:col-html>
<list:col-html title="${ lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.docAuthor')}" >
	{$
		<div class="lui_multi_author_wrap"><span>{%row['docAuthor.fdName']%}</span> </div>
	$}
</list:col-html>
<list:col-auto props="docPublishTime;fdTotalCount;docIntrCount;docEvalCount;docScore"/>
<list:col-html title="${lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.docCategory') }" 
				   style="width:15%" >
   		{$
			<span title="{%row['docCategory.fdName']%}">
				{% strutil.textEllipsis(row['docCategory.fdName'], 15) %}
			</span>
		$}	
 </list:col-html>
<c:if test="${isBorrowOpen}">
	<list:col-html title="${lfn:message('kms-knowledge-borrow:kmsKnowledgeBorrow.readStatus') }" >
	{$
		<div class="lui_multi_author_wrap"><span>{%row['docBorrowFlagName']%}</span> </div>
	$}
	</list:col-html>		
</c:if>