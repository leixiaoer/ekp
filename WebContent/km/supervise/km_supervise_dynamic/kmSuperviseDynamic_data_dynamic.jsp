<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
	<list:data-columns var="kmSuperviseDynamic" list="${queryPage.list}" varIndex="index">
	    <list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index" title="${ lfn:message('page.serial') }">
			${index+1}
		</list:data-column>
		
<list:data-column col="docCreator.name" title="${lfn:message('km-supervise:kmSuperviseDynamic.docCreator')}" escape="false">
<c:out value="${kmSuperviseDynamic.docCreator.fdName}" />
</list:data-column>
<list:data-column col="docCreator.id" escape="false">
<c:out value="${kmSuperviseDynamic.docCreator.fdId}" />
</list:data-column>
<list:data-column col="docCreateTime" title="${lfn:message('km-supervise:kmSuperviseDynamic.docCreateTime')}" >
<kmss:showDate value="${kmSuperviseDynamic.docCreateTime}" type="datetime"></kmss:showDate>
</list:data-column>
<list:data-column property="fdContent" title="${lfn:message('km-supervise:kmSuperviseDynamic.fdContent')}" />
<list:data-column col="fdSupervise.name" title="${lfn:message('km-supervise:kmSuperviseDynamic.fdSupervise')}" escape="false">
<c:out value="${kmSuperviseDynamic.fdSupervise.docSubject}" />
</list:data-column>
<list:data-column col="fdSupervise.id" escape="false">
<c:out value="${kmSuperviseDynamic.fdSupervise.fdId}" />
</list:data-column>
		
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }"></list:data-paging>
	
</list:data>