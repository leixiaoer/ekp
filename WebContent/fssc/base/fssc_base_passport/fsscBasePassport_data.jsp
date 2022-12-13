<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBasePassport" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBasePassport.fdName')}" />
        <list:data-column col="fdPerson.name" title="${lfn:message('fssc-base:fsscBasePassport.fdPerson')}" escape="false">
            <c:out value="${fsscBasePassport.fdPerson.fdName}" />
        </list:data-column>
        <list:data-column col="fdPerson.id" escape="false">
            <c:out value="${fsscBasePassport.fdPerson.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBasePassport.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBasePassport.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBasePassport.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docAlteror.name" title="${lfn:message('fssc-base:fsscBasePassport.docAlteror')}" escape="false">
            <c:out value="${fsscBasePassport.docAlteror.fdName}" />
        </list:data-column>
        <list:data-column col="docAlteror.id" escape="false">
            <c:out value="${fsscBasePassport.docAlteror.fdId}" />
        </list:data-column>
        <list:data-column col="docAlterTime" title="${lfn:message('fssc-base:fsscBasePassport.docAlterTime')}">
            <kmss:showDate value="${fsscBasePassport.docAlterTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
