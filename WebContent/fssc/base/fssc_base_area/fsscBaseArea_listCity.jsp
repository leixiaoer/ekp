<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="data" list="${queryPage.list}" varIndex="status">
        <list:data-column col="fdId">
        	${data['fdId']}
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>
		<list:data-column col="fdType" title="${lfn:message('fssc-base:fsscBaseArea.fdType') }">
        	<sunbor:enumsShow value="${data['fdType']}" enumsType="fssc_base_area_type"/>
        </list:data-column>
        <list:data-column col="fdArea" title="${lfn:message('fssc-base:fsscBaseArea.fdArea') }">
        	${data['fdArea']}
        </list:data-column>
        <list:data-column col="fdCity" title="${lfn:message('fssc-base:fsscBaseArea.fdCity') }">
        	${data['fdCity']}
        </list:data-column>
        
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
