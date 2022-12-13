<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.carmng.model.KmCarmngApplication"%>
<%@ page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@ page import="com.landray.kmss.km.carmng.service.IKmCarmngEvaluationService"%>
<%@ page import="com.landray.kmss.km.carmng.model.KmCarmngEvaluation"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngApplication" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column  col="docSubject" title="${ lfn:message('km-carmng:kmCarmngApplication.docSubject') }" escape="false" style="text-align:center;min-width:180px">
			<span class="com_subject"><c:out value="${kmCarmngApplication.docSubject}"/></span>
		</list:data-column>
		<list:data-column headerClass="width180" col="fdApplicationPath" title="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationPath')}" style="text-align:center;" escape="false">
			<c:if test="${not empty kmCarmngApplication.fdDeparture}">
				<c:out value="${kmCarmngApplication.fdDeparture}"/>
			</c:if>
			<c:if test="${not empty kmCarmngApplication.fdDestination}">
				- <c:out value="${kmCarmngApplication.fdDestination}"/>
			</c:if>
			<c:forEach items="${kmCarmngApplication.fdPaths}" var="fdPath">
				- <c:out value="${fdPath.fdDestination}"/>
			</c:forEach>
		</list:data-column>
		<list:data-column headerClass="width160" col="fdStartTime" title="${ lfn:message('km-carmng:kmCarmng.fdUseTime')}" escape="false">
				<kmss:showDate value="${kmCarmngApplication.fdStartTime}"></kmss:showDate>
			<bean:message bundle="km-carmng" key="kmCarmng.message.title0"/>
				<kmss:showDate value="${kmCarmngApplication.fdEndTime}" ></kmss:showDate>
		</list:data-column>
		<list:data-column headerClass="width40" col="fdUserNumber" title="${ lfn:message('km-carmng:kmCarmngApplication.fdUserNumber')}" escape="false">
			<c:out value="${kmCarmngApplication.fdUserNumber}"/>
		</list:data-column>
		<list:data-column headerClass="width40" col="fdNo" title="${ lfn:message('km-carmng:kmCarmngMotorcadeSet.fdNo')}" escape="false">
			<c:out value="${kmCarmngApplication.fdNo}"/>
		</list:data-column>
		<list:data-column headerClass="width80" col="fdApplicationPerson.fdName" title="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationPerson')}" escape="false">
			<ui:person personId="${kmCarmngApplication.fdApplicationPerson.fdId}" personName="${kmCarmngApplication.fdApplicationPerson.fdName}"></ui:person>
		</list:data-column>
		<list:data-column headerClass="width160" col="docCreateTime" title="${ lfn:message('km-carmng:kmCarmngApplication.docCreateTime')}" escape="false">
			<kmss:showDate value="${kmCarmngApplication.docCreateTime}"></kmss:showDate>
		</list:data-column>
		<%--用车结束时间--%>
		<list:data-column headerStyle="width120" col="fdEndTime" title="${ lfn:message('km-carmng:kmCarmngUserFeeInfo.fdUseEndTime') }">
		    <kmss:showDate value="${kmCarmngApplication.fdEndTime}" />
		</list:data-column>
		<%--车队名称--%>
		<list:data-column  col="fdMotorcadeId" title="${ lfn:message('km-carmng:kmCarmngApplication.fdMotorcadeId') }" escape="false" >
			<c:out value="${kmCarmngApplication.fdMotorcade.fdName}"/>
		</list:data-column>
		<list:data-column headerClass="width60" col="docStatus" title="${ lfn:message('km-carmng:kmCarmngApplication.docStatus')}" escape="false">
			<c:if test="${kmCarmngApplication.docStatus < 30 }">
				<sunbor:enumsShow value="${kmCarmngApplication.docStatus}" enumsType="common_status"/>
			</c:if>	
			<%--通过--%>
			<c:if test="${kmCarmngApplication.docStatus == 30 && kmCarmngApplication.fdIsDispatcher != 2  && kmCarmngApplication.fdIsDispatcher != 3 && kmCarmngApplication.fdIsDispatcher != 4}">	
				<bean:message bundle="km-carmng" key="kmCarmng.tree.publish"/>
			</c:if>
			<%--发车--%>
			<c:if test="${kmCarmngApplication.fdIsDispatcher == 2 }">	
				<bean:message bundle="km-carmng" key="kmCarmng.tree.publish2"/>
			</c:if>
			<%--完成--%>
			<c:if test="${kmCarmngApplication.fdIsDispatcher == 3 || kmCarmngApplication.fdIsDispatcher == 4 }">	
				<bean:message bundle="km-carmng" key="kmCarmng.tree.publish3"/>
			</c:if>
		</list:data-column>
		<%-- 评价状态 --%>
		<list:data-column headerClass="width60" col="evaluationStatus" title="${lfn:message('km-carmng:kmCarmngApplication.evaluationStatus') }" escape="false">
			<c:choose>
				<c:when test="${kmCarmngApplication.fdIsDispatcher == 3 }">
					<%
						KmCarmngApplication fdApplication = (KmCarmngApplication)pageContext.getAttribute("kmCarmngApplication");
						IKmCarmngEvaluationService kmCarmngEvaluationService = (IKmCarmngEvaluationService)SpringBeanUtil.getBean("kmCarmngEvaluationService");
						KmCarmngEvaluation kmCarmngEvaluation = kmCarmngEvaluationService.findByApplication(fdApplication);
						if(kmCarmngEvaluation != null)
							pageContext.setAttribute("fdEvaluationScore", kmCarmngEvaluation.getFdEvaluationScore());
						else
							pageContext.setAttribute("fdEvaluationScore", 0);
					%>
					<sunbor:enumsShow value="${fdEvaluationScore}" bundle="km-carmng" enumsType="kmCarmngEvaluation_score" />
				</c:when>
				<c:otherwise>
					<bean:message bundle="km-carmng" key="kmCarmng.tree.publish4"/>
				</c:otherwise>
			</c:choose>
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>