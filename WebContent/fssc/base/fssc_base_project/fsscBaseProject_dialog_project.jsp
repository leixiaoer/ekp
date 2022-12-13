<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseProject" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseProject.fdName')}" escape="false" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseProject.fdCode')}" escape="false" />
        <list:data-column col="fdParent.name" title="${lfn:message('fssc-base:fsscBaseProject.fdParent')}" escape="false">
            <c:out value="${fsscBaseProject.fdParent.fdName}" />
        </list:data-column>
        <list:data-column col="fdType.name" title="${lfn:message('fssc-base:fsscBaseProject.fdType')}">
            <sunbor:enumsShow value="${fsscBaseProject.fdType}" enumsType="fssc_base_project_type" />
        </list:data-column>
        <list:data-column col="fdType">
            <c:out value="${fsscBaseProject.fdType}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseProject.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseProject.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseProject.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseProject.fdCompany')}" escape="false">
            <c:out value="${fsscBaseProject.fdCompany.fdName}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
