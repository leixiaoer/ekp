<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSuperviseMain" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
		<%-- 督办事项 --%>
        <list:data-column property="docSubject" title="${lfn:message('km-supervise:kmSupervise.items')}" />
        <%-- 督办类型 --%>
		<list:data-column headerClass="width100" col="docTemplate.name" title="${lfn:message('km-supervise:kmSuperviseMain.type')}" escape="false">
            <c:out value="${kmSuperviseMain.docTemplate.fdName}" />
        </list:data-column>
		<%-- 主办部门 --%>
		<list:data-column headerClass="width100" col="fdSysUnit.name" title="${lfn:message('km-supervise:kmSuperviseMain.fdSysUnit')}" escape="false">
            <c:out value="${kmSuperviseMain.fdSysUnit.fdName}" />
        </list:data-column>
        <%-- 完成时限 --%>
        <list:data-column col="fdFinishTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdFinishTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 文档状态 --%>
        <list:data-column col="docStatus" title="${lfn:message('km-supervise:kmSuperviseMain.docStatus')}">
        	<c:if test="${kmSuperviseMain.docStatus=='10' }">${lfn:message('status.draft') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='20' }">${lfn:message('status.examine') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='11' }">${lfn:message('status.refuse') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='30' || kmSuperviseMain.docStatus=='40' }">${lfn:message('km-supervise:status.publish') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='00' }">${lfn:message('status.discard') }</c:if>
        </list:data-column>
		<list:data-column headerStyle="width:60px;" col="operate"  escape="false" title="${ lfn:message('km-supervise:kmSuperviseMain.operate')}">
			<kmss:authShow roles="ROLE_KMSUPERVISE_DELETE">
				<a class="com_btn_link" onclick="del(event,'<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=delete&fdId=${kmSuperviseMain.fdId}"/>');"><bean:message key="button.delete"/></a>
			</kmss:authShow>
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>