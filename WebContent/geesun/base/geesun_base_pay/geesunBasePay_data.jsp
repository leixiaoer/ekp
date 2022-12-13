<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="geesunBasePay" list="${queryPage.list}" varIndex="status" custom="false">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>
		<list:data-column property="fdOrderId" title="${lfn:message('geesun-base:geesunBasePay.fdOrderId')}">
        </list:data-column>
        <list:data-column col="fdYwDate" title="${lfn:message('geesun-base:geesunBasePay.fdYwDate')}">
            <kmss:showDate value="${geesunBasePay.fdYwDate}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column col="fdPayDate" title="${lfn:message('geesun-base:geesunBasePay.fdPayDate')}">
            <kmss:showDate value="${geesunBasePay.fdPayDate}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column col="fdPeriod" title="${lfn:message('geesun-base:geesunBasePay.fdPeriod')}" >
        	<kmss:showPeriod value="${geesunBasePay.fdPeriod}"/>
        </list:data-column>
        <list:data-column property="fdPayBank3" title="${lfn:message('geesun-base:geesunBasePay.fdPayBank3')}" />
        <list:data-column property="fdAccountName" title="${lfn:message('geesun-base:geesunBasePay.fdAccountName')}" />
        <list:data-column property="fdPayMoney" title="${lfn:message('geesun-base:geesunBasePay.fdPayMoney')}" />
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-base:geesunBasePay.docCreateTime')}">
            <kmss:showDate value="${geesunBasePay.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
