<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngEvaluation" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="type" escape="false">
		   evaluate
		</list:data-column>
		<list:data-column  col="fdAppNames"  title="${ lfn:message('km-carmng:kmCarmngEvaluation.fdAppNames') }" escape="false" >
			 <c:out value="${kmCarmngEvaluation.fdApplication.docSubject}"/>
		</list:data-column>
		 <%-- 评价--%>
		<list:data-column col="creator" title="${ lfn:message('km-carmng:kmCarmngEvaluation.fdEvaluator')}" >
		         <c:out value="${kmCarmngEvaluation.fdEvaluator.fdName}"/>
		</list:data-column>
		<%-- 评价时间--%>
		<list:data-column col="created" title="${ lfn:message('km-carmng:kmCarmngEvaluation.fdEvaluationTime')}"  escape="false">
			<kmss:showDate value="${kmCarmngEvaluation.fdEvaluationTime}" />
		</list:data-column>	
		<list:data-column col="fdEvaluationScore" title="${ lfn:message('km-carmng:kmCarmngEvaluation.fdEvaluationScore')}"  escape="false">
			<c:out value="${kmCarmngEvaluation.fdEvaluationScore}" />
		</list:data-column>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl contextPath="true" personId="${kmCarmngEvaluation.fdEvaluator.fdId}" size="m" />
		</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		   /km/carmng/km_carmng_evaluation/kmCarmngEvaluation.do?method=view&fdId=${kmCarmngEvaluation.fdId}
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>