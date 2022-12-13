<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmSuperviseBack" list="${queryPage.list}"
		varIndex="index">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index" title="${ lfn:message('page.serial') }">
			${index+1}
		</list:data-column>
		<%-- 反馈人 --%>
		<list:data-column col="fdPersonName"
			title="${lfn:message('km-supervise:kmSuperviseBack.fdPerson')}"
			escape="false">
			<c:out value="${kmSuperviseBack.fdPerson.fdName}" />
		</list:data-column>
		<list:data-column col="fdPersonId" escape="false">
			<c:out value="${kmSuperviseBack.fdPerson.fdId}" />
		</list:data-column>
		<%-- 反馈时间--%>
		<list:data-column col="fdFeedbackTime"
			title="${lfn:message('km-supervise:kmSuperviseBack.fdFeedbackTime')}">
			<kmss:showDate value="${kmSuperviseBack.fdFeedbackTime}"
				type="datetime"></kmss:showDate>
		</list:data-column>
		<%-- 进度--%>
		<list:data-column col="fdProgress" title="${lfn:message('km-supervise:kmSuperviseBack.fdProgress')}">
			<c:out value="${kmSuperviseBack.fdProgress}" />
		</list:data-column>
		<list:data-column property="fdResult"
			title="${lfn:message('km-supervise:kmSuperviseBack.fdResult')}" />
		<list:data-column col="operations"
			title="${ lfn:message('list.operation') }" escape="false">
			<a class="btn_txt"
				onclick="feedBackDel(event,'${kmSuperviseBack.fdId}');"><bean:message
					key="button.delete" /></a>
		</list:data-column>
		<%--反馈人头像  --%>
		<list:data-column col="icon" escape="false" title="${ lfn:message('km-supervise:kmSuperviseBack.fdPerson') }" >
			<person:headimageUrl personId="${kmSuperviseBack.fdPerson.fdId }" size="m" />
		</list:data-column>
		
		<%-- 反馈部门 --%>
		<list:data-column col="fdSysUnitName" title="${lfn:message('km-supervise:kmSuperviseMain.fdSysUnit')}" escape="false">
            <c:out value="${kmSuperviseBack.fdSysUnit.fdName}" />
        </list:data-column>
        <%-- 进展情况 --%>
        <list:data-column col="docProgress" title="${lfn:message('km-supervise:kmSuperviseBack.docProgress')}">
			<c:out value="${kmSuperviseBack.docProgress}" />
		</list:data-column>
		<%-- 困难及措施 --%>
        <list:data-column col="docDifficulty" title="${lfn:message('km-supervise:kmSuperviseBack.docDifficulty')}">
			<c:out value="${kmSuperviseBack.docDifficulty}" />
		</list:data-column>
		<%-- 状态 --%>
		<list:data-column col="fdStatus" title="${lfn:message('km-supervise:kmSuperviseBack.fdStatus')}">
			<c:out value="${kmSuperviseBack.fdStatus}" />
		</list:data-column>
		
		<list:data-column col="docStatus" title="${lfn:message('km-supervise:kmSuperviseBack.docStatus')}">
			<c:choose>
				<c:when test="${kmSuperviseBack.docStatus=='10' }">
					<bean:message key="status.draft"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseBack.docStatus=='20' }">
					<bean:message key="status.examine"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseBack.docStatus=='11' }">
					<bean:message key="status.refuse"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseBack.docStatus=='30' || kmSuperviseMain.docStatus=='40' }">
					<bean:message key="status.publish"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseBack.docStatus=='00' }">
					<bean:message key="status.discard"></bean:message>
				</c:when>
			</c:choose>
		</list:data-column>
		
		<list:data-column col="href" escape="false">
			/km/supervise/km_supervise_back/kmSuperviseBack.do?method=view&fdId=${kmSuperviseBack.fdId}
		</list:data-column>
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }"></list:data-paging>

</list:data>