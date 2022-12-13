<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
    <list:data-columns var="kmSuperviseInstruction" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
        <%-- 创建者 --%>
		<list:data-column col="docCreatorName">
            <c:out value="${kmSuperviseInstruction.docCreator.fdName}" />
        </list:data-column>
        <%-- 头像--%>
		<list:data-column col="icon" escape="false">
			<person:headimageUrl personId="${kmSuperviseInstruction.docCreator.fdId}" size="m" contextPath="true"/>
		</list:data-column>
        <%-- 创建时间 --%>
        <list:data-column col="docCreateTime">
            <kmss:showDate value="${kmSuperviseInstruction.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <%-- 批示内容 --%>
        <list:data-column col="docContent">
            <c:out value="${kmSuperviseInstruction.docContent}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
