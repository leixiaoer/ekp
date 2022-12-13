<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSuperviseMainFinish" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
		<list:data-column col="docSubject" title="${lfn:message('km-supervise:kmSuperviseMainFinish.docSubject')}" escape="false">
            <c:out value="${kmSuperviseMainFinish.docSubject}" />
        </list:data-column>
        <%-- 办结时间--%>
		<list:data-column col="fdRealFinishTime" title="${lfn:message('km-supervise:kmSuperviseMainFinish.fdRealFinishTime')}" escape="false">
            <kmss:showDate value="${kmSuperviseMainFinish.fdRealFinishTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 办结人 --%>
		<list:data-column col="fdOperatorName" title="${lfn:message('km-supervise:kmSuperviseMainFinish.fdOperator')}" escape="false">
            <c:out value="${kmSuperviseMainFinish.fdOperator.fdName}" />
        </list:data-column>
        <%-- 办结情况 --%>
		<list:data-column col="fdFinishDesc" title="${lfn:message('km-supervise:kmSuperviseMainFinish.fdFinishDesc')}" escape="false">
            <c:out value="${kmSuperviseMainFinish.fdFinishDesc}" />
        </list:data-column>
        <list:data-column col="href" escape="false">
			/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish.do?method=view&fdId=${kmSuperviseMainFinish.fdId}
		</list:data-column>
		
		<list:data-column col="docStatus" title="${lfn:message('km-supervise:kmSuperviseMainFinish.docStatus')}">
			<c:choose>
				<c:when test="${kmSuperviseMainFinish.docStatus=='10' }">
					<bean:message key="status.draft"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMainFinish.docStatus=='20' }">
					<bean:message key="status.examine"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMainFinish.docStatus=='11' }">
					<bean:message key="status.refuse"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMainFinish.docStatus=='30' || kmSuperviseMain.docStatus=='40' }">
					<bean:message key="status.publish"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMainFinish.docStatus=='00' }">
					<bean:message key="status.discard"></bean:message>
				</c:when>
			</c:choose>
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
