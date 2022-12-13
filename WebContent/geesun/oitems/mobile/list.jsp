<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="geesunOitemsBudgerApplication" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		<list:data-column col="status" title="${ lfn:message('geesun-oitems:geesunOitemsGetApplication.docStatus') }" escape="false">
			<c:choose>
				<c:when test="${geesunOitemsBudgerApplication.docStatus=='00'}">
					<span class="muiProcessStatusBorder muiProcessDiscard">${ lfn:message('status.discard')}</span>
				</c:when>
				<c:when test="${geesunOitemsBudgerApplication.docStatus=='10'}">
					<span class="muiProcessStatusBorder muiProcessDraft">${ lfn:message('status.draft') } </span>
				</c:when>
				<c:when test="${geesunOitemsBudgerApplication.docStatus=='11'}">
					<span class="muiProcessStatusBorder muiProcessRefuse">${ lfn:message('status.refuse')}</span>
				</c:when>
				<c:when test="${geesunOitemsBudgerApplication.docStatus=='20'}">
					<span class="muiProcessStatusBorder muiProcessExamine">${ lfn:message('status.examine') }</span>
				</c:when>
				<c:when test="${geesunOitemsBudgerApplication.docStatus=='30'}">
					<span class="muiProcessStatusBorder muiToReceive">${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.fdOutStatus0') }</span>
				</c:when>
				<c:when test="${geesunOitemsBudgerApplication.docStatus=='31'}">
					<span class="muiProcessStatusBorder muiProcessPublish">${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.fdOutStatus1') }</span>
				</c:when>
			</c:choose>
		</list:data-column>
	    <%-- 主题--%>	
		<list:data-column col="label" title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.docSubject') }" escape="false">
			<c:out value="${geesunOitemsBudgerApplication.docSubject}"/>
		</list:data-column>
		 <%-- 创建者--%>
		<list:data-column col="creator" title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.docCreatorId') }" >
		         <c:out value="${geesunOitemsBudgerApplication.docCreator.fdName}"/>
		</list:data-column>
		 <%-- 创建者头像--%>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl personId="${geesunOitemsBudgerApplication.docCreator.fdId}" size="m" />
		</list:data-column>
		 <%-- 发布时间--%>
	 	<list:data-column col="created" title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.docCreateTime') }">
	        <kmss:showDate value="${geesunOitemsBudgerApplication.docCreateTime}" type="date"></kmss:showDate>
      	</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		        /geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=view&fdId=${geesunOitemsBudgerApplication.fdId}
		</list:data-column>
		 <%-- 创建时间--%>
	 	<list:data-column col="summary" title="${ lfn:message('km-review:sysWfNode.processingNode.currentProcessor') }" escape="false">
	        <kmss:showWfPropertyValues idValue="${geesunOitemsBudgerApplication.fdId}" propertyName="summary" />
      	</list:data-column>
    </list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
