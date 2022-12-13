<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngApplication" list="${queryPage.list }" custom="false">
		<list:data-column property="fdId">
		</list:data-column>

		<list:data-column  col="docSubject"  title="${ lfn:message('km-carmng:kmCarmngApplication.docSubject') }" escape="false" style="text-align:center;min-width:180px">
			<c:out value="${kmCarmngApplication.docSubject}"/>
		</list:data-column>
		<list:data-column headerClass="width180" col="fdApplicationPath" title="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationPath')}" style="width:15%"  escape="false">
			<c:if test="${not empty kmCarmngApplication.fdDeparture}">
				<c:out value="${kmCarmngApplication.fdDeparture}"/>-
			</c:if>
			<c:if test="${not empty kmCarmngApplication.fdApplicationPath}">
				<c:out value="${kmCarmngApplication.fdApplicationPath}"/>-
			</c:if>
			<c:if test="${not empty kmCarmngApplication.fdDestination}">
				<c:out value="${kmCarmngApplication.fdDestination}"/>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width160" col="fdStartTime" title="${ lfn:message('km-carmng:kmCarmng.fdUseTime')}" style="width:30%"  escape="false">
			<kmss:showDate value="${kmCarmngApplication.fdStartTime}" type="datetime"></kmss:showDate>
				<bean:message  bundle="km-carmng" key="kmCarmng.message.title0"/>
			<kmss:showDate value="${kmCarmngApplication.fdEndTime}" type="datetime"></kmss:showDate>
		</list:data-column>
		<list:data-column headerClass="width100" col="fdUserPersons" title="${ lfn:message('km-carmng:kmCarmngUserFeeInfo.fdUserId')}" style="width:8%"  escape="false">
			<kmss:joinListProperty value="${kmCarmngApplication.fdUserPersons}" properties="fdName"  split=";" />
		</list:data-column>
		<list:data-column headerClass="width40" col="fdUserNumber" title="${ lfn:message('km-carmng:kmCarmngApplication.fdUserNumber')}" style="width:5%"  escape="false">
			<c:out value="${kmCarmngApplication.fdUserNumber}" />
		</list:data-column>
		<list:data-column headerClass="width140" col="fdMotorcade.fdName" title="${ lfn:message('km-carmng:kmCarmngApplication.fdMotorcadeId')}" style="width:8%"  escape="false">
			<c:out value="${kmCarmngApplication.fdMotorcade.fdName}" />	
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>