<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSuperviseMainFinish" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
        <%-- 督办类型 --%>
		<list:data-column headerClass="width100" col="kmSuperviseMain.docTemplate.name" title="${lfn:message('km-supervise:kmSuperviseMain.type')}" escape="false">
            <c:out value="${kmSuperviseMainFinish.kmSuperviseMain.docTemplate.fdName}" />
        </list:data-column>
		<%-- 督办事项 --%>
        <list:data-column  col="kmSuperviseMain.docSubject" title="${lfn:message('km-supervise:kmSupervise.items')}" escape="false">
        	<span class="com_subject"><c:out value="${kmSuperviseMainFinish.kmSuperviseMain.docSubject}" /></span>
        </list:data-column>
        <%-- 开始时间 --%>
        <list:data-column headerClass="width100" col="kmSuperviseMain.fdStartTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdStartTime')}">
            <kmss:showDate value="${kmSuperviseMainFinish.kmSuperviseMain.fdStartTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 结束时间 --%>
        <list:data-column headerClass="width100" col="kmSuperviseMain.fdFinishTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}">
            <kmss:showDate value="${kmSuperviseMainFinish.kmSuperviseMain.fdFinishTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 办结时间--%>
		<list:data-column headerClass="width100" col="fdRealFinishTime" title="${lfn:message('km-supervise:kmSuperviseMainFinish.fdRealFinishTime')}" escape="false">
            <kmss:showDate value="${kmSuperviseMainFinish.fdRealFinishTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 办结人 --%>
		<list:data-column headerClass="width100" col="fdOperator.name" title="${lfn:message('km-supervise:kmSuperviseMainFinish.fdOperator')}" escape="false">
            <c:out value="${kmSuperviseMainFinish.fdOperator.fdName}" />
        </list:data-column>
        <%-- 办结情况 --%>
		<list:data-column headerClass="width200" col="fdFinishDesc" title="${lfn:message('km-supervise:kmSuperviseMainFinish.fdFinishDesc')}" escape="false">
            <c:out value="${kmSuperviseMainFinish.fdFinishDesc}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
