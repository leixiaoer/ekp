<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
	<list:data-columns var="kmSuperviseBack" list="${queryPage.list}" varIndex="index">
	    <list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index" title="${ lfn:message('page.serial') }">
			${index+1}
		</list:data-column>
		
<list:data-column col="fdPerson.name" title="${lfn:message('km-supervise:kmSuperviseBack.fdPerson')}" escape="false">
<c:out value="${kmSuperviseBack.fdPerson.fdName}" />
</list:data-column>
<list:data-column col="fdPerson.id" escape="false">
<c:out value="${kmSuperviseBack.fdPerson.fdId}" />
</list:data-column>
<list:data-column col="fdFeedbackTime" title="${lfn:message('km-supervise:kmSuperviseBack.fdFeedbackTime')}" >
<kmss:showDate value="${kmSuperviseBack.fdFeedbackTime}" type="datetime"></kmss:showDate>
</list:data-column>
<list:data-column col="fdProgress" title="${lfn:message('km-supervise:kmSuperviseBack.fdProgress')}" escape="false" style="width: 113px;height: 7px;">
	<style>
		.pro_barline{width: 113px;height: 7px;background: #e5e4e1;border: 1px solid #d2d1cc;text-align: left;border-radius: 4px;}
		.pro_barline .complete{height: 7px;background: #00a001;border-radius: 3px;}
		.pro_barline .uncomplete{height: 7px;background: #ff8b00;border-radius: 3px;}
	</style>
	<c:out value="${kmSuperviseBack.fdProgress}" />%
	<div class='pro_barline'>
		<c:if test="${kmSuperviseBack.fdProgress=='100' }">
			<div class='complete' style="width:${kmSuperviseBack.fdProgress}%"></div>
		</c:if>
		<c:if test="${kmSuperviseBack.fdProgress!='100' }">
			<div class='uncomplete' style="width:${kmSuperviseBack.fdProgress}%"></div>
		</c:if>
	</div>
</list:data-column>
<list:data-column property="fdResult" title="${lfn:message('km-supervise:kmSuperviseBack.fdResult')}" />
<list:data-column col="operations" title="${ lfn:message('list.operation') }" escape="false">
	<a class="btn_txt" onclick="feedBackDel(event,'${kmSuperviseBack.fdId}');"><bean:message key="button.delete" /></a>
</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }"></list:data-paging>
	
</list:data>