<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunOrgRecord" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdOrganType.name" title="${lfn:message('geesun-org:geesunOrgRecord.fdOrganType')}">
            <sunbor:enumsShow value="${geesunOrgRecord.fdOrganType}" enumsType="geesun_org_oran_type" />
        </list:data-column>
        <list:data-column col="fdOrganType">
            <c:out value="${geesunOrgRecord.fdOrganType}" />
        </list:data-column>
        <list:data-column property="stext" title="${lfn:message('geesun-org:geesunOrgRecord.stext')}" />
        <list:data-column property="nachn" title="${lfn:message('geesun-org:geesunOrgRecord.nachn')}" />
        <list:data-column property="pernr" title="${lfn:message('geesun-org:geesunOrgRecord.pernr')}" />
        <list:data-column property="objid" title="${lfn:message('geesun-org:geesunOrgRecord.objid')}" />
        <list:data-column property="orgeh" title="${lfn:message('geesun-org:geesunOrgRecord.orgeh')}" />
        <list:data-column property="zsfyx" title="${lfn:message('geesun-org:geesunOrgRecord.zsfyx')}" />
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-org:geesunOrgRecord.docCreateTime')}">
            <kmss:showDate value="${geesunOrgRecord.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
