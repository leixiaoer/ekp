<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<list:data>
	<list:data-columns var="kmCarmngApplication" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="type" escape="false">
		   useDispatcher
		</list:data-column>
		<%-- 主题--%>
		<list:data-column col="label" title="${ lfn:message('km-carmng:kmCarmngApplication.docSubject')}" escape="false">
			<c:out value="${kmCarmngApplication.docSubject}"/>
		</list:data-column>
		<%-- 用车时间--%>
		<list:data-column col="fdStartTime" title="${ lfn:message('km-carmng:kmCarmng.fdUseTime')}"  escape="false">
			<kmss:showDate value="${kmCarmngApplication.fdStartTime}" type="datetime"></kmss:showDate>
			</list:data-column>
		<list:data-column col="fdEndTime" title="${ lfn:message('km-carmng:kmCarmng.fdUseTime')}"  escape="false">
			<kmss:showDate value="${kmCarmngApplication.fdEndTime}" type="datetime"></kmss:showDate>
		</list:data-column>
		<%-- 随车人数--%>
		<list:data-column col="fdUserNumber" title="${ lfn:message('km-carmng:kmCarmngApplication.fdUserNumber')}"  escape="false">
		   <c:out value="${kmCarmngApplication.fdUserNumber}"/>
		</list:data-column>
		<%-- 车队名称--%>
		<list:data-column col="fdMotorcadeFdName" title="${ lfn:message('km-carmng:kmCarmngApplication.fdMotorcadeId')}"  escape="false">
		 	<c:out value="${kmCarmngApplication.fdMotorcade.fdName}"/>
		</list:data-column>
		<%-- 创建者头像--%>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl contextPath="true" personId="${kmCarmngApplication.fdApplicationPerson.fdId}" size="m" />
		</list:data-column>
		 <%-- 创建者--%>
		<list:data-column col="creator" title="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationPerson')}" escape="false">
		         <c:out value="${kmCarmngApplication.fdApplicationPerson.fdName}"/>
		</list:data-column>
		 <%-- 创建时间--%>
	 	<list:data-column col="created" title="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationTime')}">
	        <kmss:showDate value="${kmCarmngApplication.docCreateTime}" type="date"></kmss:showDate>
      	</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		        /km/carmng/km_carmng_application/kmCarmngApplication.do?method=view&fdId=${kmCarmngApplication.fdId}
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>