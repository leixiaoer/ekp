<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseVehicle" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseVehicle.fdName')}"  escape="false"/>
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseVehicle.fdCode')}"  escape="false"/>
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseVehicle.fdCompany')}" escape="false">
            <c:out value="${fsscBaseVehicle.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseVehicle.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdLevel.name" title="${lfn:message('fssc-base:fsscBaseVehicle.fdLevel')}">
            <sunbor:enumsShow value="${fsscBaseVehicle.fdLevel}" enumsType="fssc_base_berth_level" />
        </list:data-column>
        <list:data-column col="fdLevel">
            <c:out value="${fsscBaseVehicle.fdLevel}" />
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
