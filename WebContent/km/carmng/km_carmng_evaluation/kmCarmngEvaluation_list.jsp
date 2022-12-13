<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngEvaluation" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column  col="fdApplication.docSubject" title="${ lfn:message('km-carmng:kmCarmngEvaluation.fdAppNames')}" escape="false" style="text-align:center;min-width:200px">
			<span class="com_subject"><c:out value="${kmCarmngEvaluation.fdApplication.docSubject}"/></span>
		</list:data-column>
		<list:data-column headerClass="width80" col="fdEvaluator.fdName" title="${ lfn:message('km-carmng:kmCarmngEvaluation.fdEvaluator')}" escape="false">
			<c:out value="${kmCarmngEvaluation.fdEvaluator.fdName}"/>
		</list:data-column>
		<list:data-column headerClass="width160" col="fdEvaluationTime" title="${ lfn:message('km-carmng:kmCarmngEvaluation.fdEvaluationTime')}" escape="false">
			<kmss:showDate value="${kmCarmngEvaluation.fdEvaluationTime}" type="datetime" />
		</list:data-column>
		<list:data-column headerClass="width100" col="fdEvaluationScore" title="${ lfn:message('km-carmng:kmCarmngEvaluation.fdEvaluationScore')}" escape="false">
			<sunbor:enumsShow value="${kmCarmngEvaluation.fdEvaluationScore}" bundle="km-carmng" enumsType="kmCarmngEvaluation_score" />
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>