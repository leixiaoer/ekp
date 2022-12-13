<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="context" list="${queryPage.list}" varIndex="status">
        <list:data-column col="fdName" title="${lfn:message('km-carmng:kmCarmngInfomation.fdDriverId')}" escape="false">
        	<span class="com_subject"><c:out value="${context.fdName}" /></span>
        </list:data-column>
         <list:data-column col="fdUseCount" title="${lfn:message('km-carmng:kmCarmngInfomation.driver.fdUseCount')}" escape="false">
        	<span class="com_subject"><c:out value="${context.fdUseCount}" /></span>
        </list:data-column>
        <list:data-column col="fdMileageNumber" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdMileageNumber')}" escape="false">
        	<span class="com_subject"><kmss:showNumber value="${context.fdMileageNumber}" pattern="#.##"/></span>
        </list:data-column>
        <list:data-column col="fdUseTime" title="${lfn:message('km-carmng:kmCarmngInfomation.fdUseTime')}" escape="false">
        	<span class="com_subject"><c:out value="${context.fdUseTime}" /></span>
        </list:data-column>
        <list:data-column col="fdStopFee" title="${lfn:message('km-carmng:kmCarmngInfomation.infringeCount')}" escape="false">
        	<span class="com_subject"><c:out value="${context.infringeCount}" /></span>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>