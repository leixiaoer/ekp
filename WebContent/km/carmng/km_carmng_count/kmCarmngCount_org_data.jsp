<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="context" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <c:if test="${param.type =='dept' }">
	        <list:data-column col="fdOrg" title="${lfn:message('km-carmng:kmCarmngUserFeeInfo.fdDeptIds')}" escape="false">
	        	<span class="com_subject"><c:out value="${context.fdApplicationDept }" /></span>
	        </list:data-column>
        </c:if>
          <c:if test="${param.type =='person' }">
	        <list:data-column col="fdOrg" title="${lfn:message('km-carmng:kmCarmngRegisterInfo.fdUser')}" escape="false">
	        	<span class="com_subject"><c:out value="${context.fdUser }" /></span>
	        </list:data-column>
        </c:if>
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