<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunBaseBxsj" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdTwoAccountName" title="${lfn:message('geesun-base:geesunBaseBxsj.fdTwoAccountName')}" />
        <list:data-column property="fdTwoAccountCode" title="${lfn:message('geesun-base:geesunBaseBxsj.fdTwoAccountCode')}" />
        <list:data-column property="fdRelateName" title="${lfn:message('geesun-base:geesunBaseBxsj.fdRelateName')}" />
        <list:data-column property="fdRelateCode" title="${lfn:message('geesun-base:geesunBaseBxsj.fdRelateCode')}" />
        <list:data-column col="fdRelateType.name" title="${lfn:message('geesun-base:geesunBaseBxsj.fdRelateType')}">
            <sunbor:enumsShow value="${geesunBaseBxsj.fdRelateType}" enumsType="geesun_base_type" />
        </list:data-column>
        <list:data-column col="fdRelateType">
            <c:out value="${geesunBaseBxsj.fdRelateType}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
