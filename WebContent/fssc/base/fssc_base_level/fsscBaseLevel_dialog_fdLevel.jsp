<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseLevel" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseLevel.fdName')}" escape="false" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseLevel.fdCode')}" escape="false" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseLevel.fdCompany')}" escape="false">
            <c:out value="${fsscBaseLevel.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseLevel.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdPersonList" title="${lfn:message('fssc-base:fsscBaseLevel.fdPersonList')}" >
        	<c:forEach items="${fsscBaseLevel.fdPersonList }" var="person">
        		${person.fdName};
        	</c:forEach>
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
