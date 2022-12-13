<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmCarmngApplication" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		<list:data-column col="type" escape="false">
		   apply
		</list:data-column >
		<list:data-column col="status" title="${ lfn:message('sys-news:sysNewsMain.docStatus') }" escape="false">
		    <c:if test="${kmCarmngApplication.docStatus < 30 }">	
			    <c:choose>
					<c:when test="${kmCarmngApplication.docStatus=='00'}">
						<span class="muiProcessStatusBorder muiProcessDiscard"><sunbor:enumsShow value="${kmCarmngApplication.docStatus}" enumsType="common_status"/></span>
					</c:when>
					<c:when test="${kmCarmngApplication.docStatus=='10'}">
						<span class="muiProcessStatusBorder muiProcessDraft"><sunbor:enumsShow value="${kmCarmngApplication.docStatus}" enumsType="common_status"/></span>
					</c:when>
					<c:when test="${kmCarmngApplication.docStatus=='11'}">
						<span class="muiProcessStatusBorder muiProcessRefuse"><sunbor:enumsShow value="${kmCarmngApplication.docStatus}" enumsType="common_status"/></span>
					</c:when>
					<c:when test="${kmCarmngApplication.docStatus=='20'}">
						<span class="muiProcessStatusBorder muiProcessExamine"><sunbor:enumsShow value="${kmCarmngApplication.docStatus}" enumsType="common_status"/></span>
					</c:when>
				</c:choose>
			</c:if>	
			<%--通过--%>
			<c:if test="${kmCarmngApplication.docStatus == 30 && kmCarmngApplication.fdIsDispatcher != 2  && kmCarmngApplication.fdIsDispatcher != 3 && kmCarmngApplication.fdIsDispatcher != 4}">	
				<span class="muiProcessStatusBorder muiProcessPublish"><bean:message bundle="km-carmng" key="kmCarmng.tree.publish"/></span>
			</c:if>
			<%--发车--%>
			<c:if test="${kmCarmngApplication.fdIsDispatcher == 2 }">	
				<span class="muiProcessStatusBorder muiProcessPublish"><bean:message bundle="km-carmng" key="kmCarmng.tree.publish2"/></span>
			</c:if>
			<%--完成--%>
			<c:if test="${kmCarmngApplication.fdIsDispatcher == 3 }">	
				<span class="muiProcessStatusBorder muiProcessPublish"><bean:message bundle="km-carmng" key="kmCarmng.tree.publish3"/></span>
			</c:if>
			<%--完成--%>
			<c:if test="${kmCarmngApplication.fdIsDispatcher == 4 }">	
				<span class="muiProcessStatusBorder muiProcessPublish"><bean:message bundle="km-carmng" key="kmCarmng.tree.publish4"/></span>
			</c:if>
		</list:data-column>
	    <%-- 主题--%>	
		<list:data-column col="label" title="${ lfn:message('km-carmng:kmCarmngApplication.docSubject') }" escape="false">
		         <c:out value="${kmCarmngApplication.docSubject}"/>
		</list:data-column>
		 <%-- 创建者--%>
		<list:data-column col="creator" title="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationPerson')}" >
		         <c:out value="${kmCarmngApplication.fdApplicationPerson.fdName}"/>
		</list:data-column>
		 <%-- 创建者头像--%>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl contextPath="true" personId="${kmCarmngApplication.fdApplicationPerson.fdId}" size="m" />
		</list:data-column>
		 <%-- 创建时间--%>
	 	<list:data-column col="created" title="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationTime')}">
	        <kmss:showDate value="${kmCarmngApplication.docCreateTime}" type="date"></kmss:showDate>
      	</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		        /km/carmng/km_carmng_application/kmCarmngApplication.do?method=view&fdId=${kmCarmngApplication.fdId}
		</list:data-column>
		 <%-- 创建时间--%>
	 	<list:data-column col="summary" title="${ lfn:message('km-review:sysWfNode.processingNode.currentProcessor') }" escape="false">
	        <kmss:showWfPropertyValues idValue="${kmCarmngApplication.fdId}" propertyName="summary" />
      	</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>