<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSuperviseBack" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
        <%-- 督办类型 --%>
		<list:data-column headerClass="width100" col="fdSupervise.docTemplate.name" title="${lfn:message('km-supervise:kmSuperviseMain.type')}" escape="false">
            <c:out value="${kmSuperviseBack.fdSupervise.docTemplate.fdName}" />
        </list:data-column>
		<%-- 督办事项 --%>
        <list:data-column col="fdSupervise.docSubject" title="${lfn:message('km-supervise:kmSupervise.items')}" escape="false">
        	<span class="com_subject"><c:out value="${kmSuperviseBack.fdSupervise.docSubject}" /></span>
        </list:data-column>
        <%-- 开始时间 --%>
        <list:data-column headerClass="width100" col="fdSupervise.fdStartTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdStartTime')}">
            <kmss:showDate value="${kmSuperviseBack.fdSupervise.fdStartTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 结束时间 --%>
        <list:data-column headerClass="width100" col="fdSupervise.fdFinishTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}">
            <kmss:showDate value="${kmSuperviseBack.fdSupervise.fdFinishTime}" type="date"></kmss:showDate>
        </list:data-column>
		
        <%-- 最新反馈时间--%>
		<list:data-column headerClass="width100" col="fdFeedbackTime" title="${lfn:message('km-supervise:kmSuperviseBack.fdFeedbackTime')}" escape="false">
            <kmss:showDate value="${kmSuperviseBack.fdFeedbackTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 反馈人 --%>
		<list:data-column headerClass="width100" col="fdPerson.name" title="${lfn:message('km-supervise:kmSuperviseBack.fdPerson')}" escape="false">
            <c:out value="${kmSuperviseBack.fdPerson.fdName}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
