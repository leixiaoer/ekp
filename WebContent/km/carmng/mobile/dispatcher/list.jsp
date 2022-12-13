<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngDispatchersInfo" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="type" escape="false">
		   useRegister
		</list:data-column>
		<list:data-column  col="fdAppNames"  title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdApplicationIds') }" escape="false" >
			 <c:out value="${kmCarmngDispatchersInfo.fdApplicationNames}"/>
		</list:data-column>
		<%-- 车牌号码--%>
		<list:data-column  col="fdCarInfoNames"  title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdCarInfoId') }" escape="false" >
			 <c:out value="${kmCarmngDispatchersInfo.fdCarInfoNames}"/>
		</list:data-column>
		<%-- 用车时间--%>
		<list:data-column col="fdStartTime" title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdStartTime')}"  escape="false">
			<kmss:showDate value="${kmCarmngDispatchersInfo.fdStartTime}" />
		</list:data-column>
		<%-- 调度时间--%>
		<list:data-column col="created" title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.docCreateTimee')}"  escape="false">
			<kmss:showDate value="${kmCarmngDispatchersInfo.docCreateTime}" />
		</list:data-column>	
		<%-- 状态--%>
		<list:data-column col="status" title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdFlag')}"  escape="false">
			<sunbor:enumsShow value="${kmCarmngDispatchersInfo.fdFlag}"  enumsType="kmCarmngDispatchersInfo_fdFlag" />	
		</list:data-column>
		<list:data-column col="fdFlag" title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdFlag')}"  escape="false">
			<c:out value="${kmCarmngDispatchersInfo.fdFlag}"/>	
		</list:data-column>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl  contextPath="true" personId="${kmCarmngDispatchersInfo.docCreator.fdId}" size="m" />
		</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		    /km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=view&fdId=${kmCarmngDispatchersInfo.fdId}
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>