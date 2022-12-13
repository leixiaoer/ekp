<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSuperviseMainStop" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
        <%-- 督办类型 --%>
		<list:data-column headerClass="width100" col="kmSuperviseMain.docTemplate.name" title="${lfn:message('km-supervise:kmSuperviseMain.type')}" escape="false">
            <c:out value="${kmSuperviseMainStop.kmSuperviseMain.docTemplate.fdName}" />
        </list:data-column>
		<%-- 督办事项 --%>
        <list:data-column col="kmSuperviseMain.docSubject" title="${lfn:message('km-supervise:kmSupervise.items')}" escape="false">
        	<span class="com_subject"><c:out value="${kmSuperviseMainStop.kmSuperviseMain.docSubject}" /></span>
        </list:data-column>
        <%-- 开始时间 --%>
        <list:data-column headerClass="width100" col="kmSuperviseMain.fdStartTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdStartTime')}">
            <kmss:showDate value="${kmSuperviseMainStop.kmSuperviseMain.fdStartTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 结束时间 --%>
        <list:data-column headerClass="width100" col="kmSuperviseMain.fdFinishTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}">
            <kmss:showDate value="${kmSuperviseMainStop.kmSuperviseMain.fdFinishTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 终止时间--%>
		<list:data-column headerClass="width100" col="fdStopTime" title="${lfn:message('km-supervise:kmSuperviseMainStop.fdStopTime')}" escape="false">
            <kmss:showDate value="${kmSuperviseMainStop.fdStopTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 终止人 --%>
		<list:data-column headerClass="width100" col="fdOperator.name" title="${lfn:message('km-supervise:kmSuperviseMainStop.fdOperator')}" escape="false">
            <c:out value="${kmSuperviseMainStop.fdOperator.fdName}" />
        </list:data-column>
        <%-- 终止原因 --%>
		<list:data-column headerClass="width200" col="fdStopDesc" title="${lfn:message('km-supervise:kmSuperviseMainStop.fdStopDesc')}" escape="false">
            <c:out value="${kmSuperviseMainStop.fdStopDesc}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
