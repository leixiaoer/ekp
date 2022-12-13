<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSuperviseMainStop" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
        <list:data-column col="docSubject" title="${lfn:message('km-supervise:kmSuperviseMainStop.docSubject')}" escape="false">
            <c:out value="${kmSuperviseMainStop.docSubject}" />
        </list:data-column>
        <%-- 终止时间--%>
		<list:data-column col="fdStopTime" title="${lfn:message('km-supervise:kmSuperviseMainStop.fdStopTime')}" escape="false">
            <kmss:showDate value="${kmSuperviseMainStop.fdStopTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 终止人 --%>
		<list:data-column col="fdOperatorName" title="${lfn:message('km-supervise:kmSuperviseMainStop.fdOperator')}" escape="false">
            <c:out value="${kmSuperviseMainStop.fdOperator.fdName}" />
        </list:data-column>
        <%-- 终止原因 --%>
		<list:data-column col="fdStopDesc" title="${lfn:message('km-supervise:kmSuperviseMainStop.fdStopDesc')}" escape="false">
            <c:out value="${kmSuperviseMainStop.fdStopDesc}" />
        </list:data-column>
        <list:data-column col="href" escape="false">
			/km/supervise/km_supervise_main_stop/kmSuperviseMainStop.do?method=view&fdId=${kmSuperviseMainStop.fdId}
		</list:data-column>
		
		<list:data-column col="docStatus" title="${lfn:message('km-supervise:kmSuperviseMainStop.docStatus')}">
			<c:choose>
				<c:when test="${kmSuperviseMainStop.docStatus=='10' }">
					<bean:message key="status.draft"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMainStop.docStatus=='20' }">
					<bean:message key="status.examine"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMainStop.docStatus=='11' }">
					<bean:message key="status.refuse"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMainStop.docStatus=='30' || kmSuperviseMain.docStatus=='40' }">
					<bean:message key="status.publish"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMainStop.docStatus=='00' }">
					<bean:message key="status.discard"></bean:message>
				</c:when>
			</c:choose>
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
