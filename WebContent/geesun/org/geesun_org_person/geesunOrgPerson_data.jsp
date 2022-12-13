<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunOrgPerson" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdEmpNo" title="${lfn:message('geesun-org:geesunOrgPerson.fdEmpNo')}" />
        <list:data-column property="fdEmpName" title="${lfn:message('geesun-org:geesunOrgPerson.fdEmpName')}" />
        <list:data-column property="fdSex" title="${lfn:message('geesun-org:geesunOrgPerson.fdSex')}" />
        <list:data-column property="fdRank" title="${lfn:message('geesun-org:geesunOrgPerson.fdRank')}" />
        <list:data-column property="fdWorkState" title="${lfn:message('geesun-org:geesunOrgPerson.fdWorkState')}" />
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
