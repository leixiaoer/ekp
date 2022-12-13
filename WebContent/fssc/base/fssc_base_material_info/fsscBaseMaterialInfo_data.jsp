<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseMaterialInfo" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseMaterialInfo.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseMaterialInfo.fdCode')}" />
        <list:data-column col="fdType.name" title="${lfn:message('fssc-base:fsscBaseMaterialInfo.fdType')}" escape="false">
            <c:out value="${fsscBaseMaterialInfo.fdType.fdName}" />
        </list:data-column>
        <list:data-column col="fdType.id" escape="false">
            <c:out value="${fsscBaseMaterialInfo.fdType.fdId}" />
        </list:data-column>
        <list:data-column property="fdUnit" title="${lfn:message('fssc-base:fsscBaseMaterialInfo.fdUnit')}" />
        <list:data-column property="fdPrice" title="${lfn:message('fssc-base:fsscBaseMaterialInfo.fdPrice')}" />
        <list:data-column col="fdStatus.name" title="${lfn:message('fssc-base:fsscBaseMaterialInfo.fdStatus')}">
            <sunbor:enumsShow value="${fsscBaseMaterialInfo.fdStatus}" enumsType="fssc_base_material_status" />
        </list:data-column>
        <list:data-column col="fdStatus">
            <c:out value="${fsscBaseMaterialInfo.fdStatus}" />
        </list:data-column>
        <list:data-column col="fdIsInventory.name" title="${lfn:message('fssc-base:fsscBaseMaterialInfo.fdIsInventory')}">
            <sunbor:enumsShow value="${fsscBaseMaterialInfo.fdIsInventory}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsInventory">
            <c:out value="${fsscBaseMaterialInfo.fdIsInventory}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
