<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunAnnualUse" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="docSubject" title="${lfn:message('geesun-annual:geesunAnnualUse.docSubject')}" />
        <list:data-column col="fdType" title="${lfn:message('geesun-annual:geesunAnnualUse.fdType')}">
            <sunbor:enumsShow value="${geesunAnnualUse.fdType}" enumsType="geesun_annual_use_fdType" />
        </list:data-column>
        <list:data-column property="fdModelId" title="${lfn:message('geesun-annual:geesunAnnualUse.fdModelId')}" />
        <list:data-column property="fdUse" title="${lfn:message('geesun-annual:geesunAnnualUse.fdUse')}" />
        <list:data-column col="docCreator.name" title="${lfn:message('geesun-annual:geesunAnnualUse.docCreator')}" escape="false">
            <c:out value="${geesunAnnualUse.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${geesunAnnualUse.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-annual:geesunAnnualUse.docCreateTime')}">
            <kmss:showDate value="${geesunAnnualUse.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column col="fdAnnual.name" title="${lfn:message('geesun-annual:geesunAnnualUse.fdAnnual')}" escape="false">
            <c:out value="${geesunAnnualUse.fdAnnual.fdOwnerNo}" />
        </list:data-column>
        <list:data-column col="fdAnnual.id" escape="false">
            <c:out value="${geesunAnnualUse.fdAnnual.fdId}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
