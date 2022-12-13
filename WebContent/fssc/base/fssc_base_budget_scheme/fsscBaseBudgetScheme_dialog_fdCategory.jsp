<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseBudgetScheme" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdName')}" />
         <list:data-column col="fdDimension.name" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdDimension')}">
        	<c:set value="${ fn:split(fsscBaseBudgetScheme.fdDimension, ';') }" var="array"></c:set>
        	<c:forEach items="${array}" var="fdDimension" varStatus="status">
        		<c:if test="${status.index!=0}">+</c:if>
        		<sunbor:enumsShow value="${fdDimension}" enumsType="fssc_base_budget_dimension" />
        	</c:forEach>
        </list:data-column>
        <list:data-column col="fdDimension">
            <c:out value="${fsscBaseBudgetScheme.fdDimension}" />
        </list:data-column>
        <list:data-column col="fdType.name" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdType')}">
            <sunbor:enumsShow value="${fsscBaseBudgetScheme.fdType}" enumsType="fssc_base_dimension_type" />
        </list:data-column>
        <list:data-column col="fdType">
            <c:out value="${fsscBaseBudgetScheme.fdType}" />
        </list:data-column>
      <%--   <list:data-column col="fdTarget.name" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdTarget')}">
            <sunbor:enumsShow value="${fsscBaseBudgetScheme.fdTarget}" enumsType="fssc_base_dimension_target" />
        </list:data-column>
        <list:data-column col="fdTarget">
            <c:out value="${fsscBaseBudgetScheme.fdTarget}" />
        </list:data-column> --%>
         <list:data-column col="fdPeriod.name" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdPeriod')}">
            <c:set value="${ fn:split(fsscBaseBudgetScheme.fdPeriod, ';') }" var="array"></c:set>
        	<c:forEach items="${array}" var="fdPeriod" varStatus="status">
        		<c:if test="${status.index!=0}">;</c:if>
        		<sunbor:enumsShow value="${fdPeriod}" enumsType="fssc_base_budget_period" />
        	</c:forEach>
        </list:data-column>
        <list:data-column col="fdPeriod">
            <c:out value="${fsscBaseBudgetScheme.fdPeriod}" />
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
