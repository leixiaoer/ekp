<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="context" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        
        <list:data-column col="fdCarNo" title="${lfn:message('km-carmng:kmCarmngMaintenanceInfo.fdVehiclesInfoId')}" escape="false">
        	<span class="com_subject"><c:out value="${context.fdCarNo}" /></span>
        </list:data-column>
        <list:data-column col="fdCarName" title="${lfn:message('km-carmng:kmCarmngInfomation.docSubject')}" escape="false">
        	<span class="com_subject"><c:out value="${context.fdCarName}" /></span>
        </list:data-column>
         <list:data-column col="fdVehichesType" title="${lfn:message('km-carmng:kmCarmngDriversInfo.fdMotorcadeId')}" escape="false">
        	<span class="com_subject"><c:out value="${context.fdVehichesType}" /></span>
        </list:data-column>
         <list:data-column col="fdCarCategoryName" title="${lfn:message('km-carmng:kmCarmngInfomation.fdVehichesType')}" escape="false">
        	<span class="com_subject"><c:out value="${context.fdCarCategoryName}" /></span>
        </list:data-column>
        <list:data-column col="fdUseCount" title="${lfn:message('km-carmng:kmCarmngInfomation.fdUseCount')}" escape="false">
        	<span class="com_subject"><c:out value="${context.fdUseCount}" /></span>
        </list:data-column>
        <list:data-column col="fdMileageNumber" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdMileageNumber')}" escape="false">
        	<span class="com_subject"><kmss:showNumber value="${context.fdMileageNumber}" pattern="#.##"/></span>
        </list:data-column>
         <list:data-column col="fdUseTime" title="${lfn:message('km-carmng:kmCarmngInfomation.fdUseTime')}" escape="false">
        	<span class="com_subject"><c:out value="${context.fdUseTime}" /></span>
        </list:data-column>
        <list:data-column col="fdStopFee" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdStopFee')}" escape="false">
        	<span class="com_subject"><kmss:showNumber value="${context.fdStopFee}" pattern="#.##"/></span>
        </list:data-column>
        <list:data-column col="fdTurnpikeFee" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdTurnpikeFee')}" escape="false">
        	<span class="com_subject"><kmss:showNumber value="${context.fdTurnpikeFee}" pattern="#.##"/></span>
        </list:data-column>
        <list:data-column col="fdFuelFee" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdFuelFee')}" escape="false">
        	<span class="com_subject"><kmss:showNumber value="${context.fdFuelFee}" pattern="#.##"/></span>
        </list:data-column>
        <list:data-column col="fdCarwashFee" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdCarwashFee')}" escape="false">
        	<span class="com_subject"><kmss:showNumber value="${context.fdCarwashFee}" pattern="#.##"/></span>
        </list:data-column>
          <list:data-column col="fdOtherFee" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdOtherFee')}" escape="false">
        	<span class="com_subject"><kmss:showNumber value="${context.fdOtherFee}" pattern="#.##"/></span>
        </list:data-column>
          <list:data-column col="total" title="${lfn:message('km-carmng:kmCarmng.fdTotalFee')}" escape="false">
        	<span class="com_subject"><kmss:showNumber value="${context.total}" pattern="#.##"/></span>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>