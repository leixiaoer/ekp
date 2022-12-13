<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="context" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <c:if test="${param.type =='dept' }">
	        <list:data-column col="fdOrg" title="用车部门" escape="false">
	        	<span class="com_subject"><c:out value="${context.fdApplicationDept }" /></span>
	        </list:data-column>
        </c:if>
          <c:if test="${param.type =='person' }">
	        <list:data-column col="fdOrg" title="用车人" escape="false">
	        	<span class="com_subject"><c:out value="${context.fdUser }" /></span>
	        </list:data-column>
        </c:if>
         <list:data-column col="fdApplicationName" title="${lfn:message('km-carmng:kmCarmngEvaluation.fdAppNames')}" escape="false">
        	<span class="com_subject"><c:out value="${fn:substring(context.fdApplicationName, 0, 8)}......" /></span>
        </list:data-column>
        <list:data-column col="fdMileageNumber" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdMileageNumber')}" escape="false">
        	<span class="com_subject"><kmss:showNumber value="${context.fdMileageNumber}" pattern="#.##"/></span>
        </list:data-column>
        <list:data-column col="fdStartTime" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdUseStartTime')}" escape="false">
        	 <kmss:showDate value="${context.fdStartTime}" type="date"></kmss:showDate>
        </list:data-column>
          <list:data-column col="fdEndTime" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdUseEndTime')}" escape="false">
        	 <kmss:showDate value="${context.fdEndTime}" type="date"></kmss:showDate>
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