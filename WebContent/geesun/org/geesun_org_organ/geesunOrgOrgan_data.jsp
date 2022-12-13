<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunOrgOrgan" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdDeptId" title="${lfn:message('geesun-org:geesunOrgOrgan.fdDeptId')}" />
        <list:data-column property="fdDeptName" title="${lfn:message('geesun-org:geesunOrgOrgan.fdDeptName')}" />
        <list:data-column property="fdParentId" title="${lfn:message('geesun-org:geesunOrgOrgan.fdParentId')}" />
        <list:data-column col="fdSetupDate" title="${lfn:message('geesun-org:geesunOrgOrgan.fdSetupDate')}">
            <kmss:showDate value="${geesunOrgOrgan.fdSetupDate}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column property="fdIsDel" title="${lfn:message('geesun-org:geesunOrgOrgan.fdIsDel')}" />
        <list:data-column col="fdNewDate" title="${lfn:message('geesun-org:geesunOrgOrgan.fdNewDate')}">
            <kmss:showDate value="${geesunOrgOrgan.fdNewDate}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-org:geesunOrgOrgan.docCreateTime')}">
            <kmss:showDate value="${geesunOrgOrgan.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
