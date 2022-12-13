<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmReviewTemplate" list="${queryPage.list }" varIndex="status">
		<%--ID--%>
		<list:data-column property="fdId"></list:data-column>
		<%--序号--%>
		<list:data-column col="index">${status+1 }</list:data-column>
		<%--模板名称--%>
		<list:data-column property="fdName" title="${ lfn:message('km-review:kmReviewTemplate.fdName') }" style="text-align:left">
		</list:data-column>
		<%--分类名称--%>
		<list:data-column property="creategoryFullName" title="${ lfn:message('km-review:kmReviewMain.fdCatoryName') }">
		</list:data-column>
		<%--创建人--%>
		<list:data-column headerStyle="width:120px;"  col="docCreator" title="${ lfn:message('sys-doc:sysDocBaseInfo.docCreator') }" escape="false">
			<ui:person personId="${kmReviewTemplate.docCreator.fdId}" personName="${kmReviewTemplate.docCreator.fdName}"></ui:person>
		</list:data-column>
		<%--创建时间--%>
		<list:data-column  headerStyle="width:120px;" property="docCreateTime" title="${ lfn:message('km-review:kmReviewTemplate.docCreateTime') }">
			<kmss:showDate value="${kmReviewTemplate.docCreateTime}" type="date" />
		</list:data-column>
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>