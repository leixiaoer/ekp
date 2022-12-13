<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fssc" uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld"%>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBasePayment" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdModelId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdModelName" title="${lfn:message('fssc-base:fsscBasePayment.fdModelName')}">
        	<fssc:showModelName modelName="${fsscBasePayment.fdModelName }"/>
        </list:data-column>
        <list:data-column property="fdSubject" title="${lfn:message('fssc-base:fsscBasePayment.fdSubject')}" />
        <list:data-column property="fdModelNumber" title="${lfn:message('fssc-base:fsscBasePayment.fdModelNumber')}" />
        <list:data-column property="fdPaymentMoney" title="${lfn:message('fssc-base:fsscBasePayment.fdPaymentMoney')}" />
        <list:data-column col="fdPaymentTime" title="${lfn:message('fssc-base:fsscBasePayment.fdPaymentTime')}">
            <kmss:showDate value="${fsscBasePayment.fdPaymentTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column col="fdStatus.name" title="${lfn:message('fssc-base:fsscBasePayment.fdStatus')}">
            <sunbor:enumsShow value="${fsscBasePayment.fdStatus}" enumsType="fssc_base_payment_status" />
        </list:data-column>
        <list:data-column col="fdStatus">
            <c:out value="${fsscBasePayment.fdStatus}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
