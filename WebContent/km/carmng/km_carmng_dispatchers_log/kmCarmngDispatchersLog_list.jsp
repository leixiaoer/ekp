<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmCarmngDispatchersLog" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="content" title="${lfn:message('km-carmng:kmCarmngDispatchersLog.content')}" style="width:75%;word-wrap:break-word;">
        	<c:choose>
        		<c:when test="${kmCarmngDispatchersLog.fdIsCar}">
        			<kmss:message bundle="km-carmng" key="kmCarmngDispatchersLog.car" /><c:out value="${kmCarmngDispatchersLog.fdCarNames}" />;调度时间：<kmss:showDate value="${kmCarmngDispatchersLog.fdStartTime}" type="dateTime"></kmss:showDate>~<kmss:showDate value="${kmCarmngDispatchersLog.fdEndTime}" type="dateTime"></kmss:showDate>
        		</c:when>
        		<c:otherwise>
        			<kmss:message bundle="km-carmng" key="kmCarmngDispatchersLog.no.car" /><c:out value="${kmCarmngDispatchersLog.fdRemark}" />
        		</c:otherwise>
        	</c:choose>
        </list:data-column>
        <list:data-column col="docCreator.fdName" title="${lfn:message('km-carmng:kmCarmngDispatchersLog.docCreator')}">
            <c:out value="${kmCarmngDispatchersLog.docCreator.fdName}" />
        </list:data-column>
        <list:data-column property="fdDispatchersTime" title="${lfn:message('km-carmng:kmCarmngDispatchersLog.fdDispatchersTime')}">
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
