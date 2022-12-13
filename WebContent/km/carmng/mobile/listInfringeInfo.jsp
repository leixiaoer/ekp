<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngInfringeInfo" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
        <list:data-column col="type" escape="false">
		   infringe
		</list:data-column>
		<list:data-column col="fdInfringeTime" title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringeTime')}" escape="false">
			<kmss:showDate value="${kmCarmngInfringeInfo.fdInfringeTime}" type="datetime" />
		</list:data-column>
		<list:data-column  col="fdVehiclesNo"  title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.fdVehiclesInfoId') }" escape="false">
			<c:out value="${kmCarmngInfringeInfo.fdVehiclesInfo.fdNo}"/>
		</list:data-column>
		<list:data-column  col="fdInfringeFee" title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringeFee')}"   escape="false">
			<kmss:showNumber value="${kmCarmngInfringeInfo.fdInfringeFee}" pattern="#,##0.00#"></kmss:showNumber><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</list:data-column>
		<list:data-column  col="fdInfringeSite" title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringeSite')}"  escape="false">
			<c:out value="${kmCarmngInfringeInfo.fdInfringeSite}"/>
		</list:data-column>
		<list:data-column  col="fdHost" title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringePerson')}"  escape="false">
			<c:out value="${kmCarmngInfringeInfo.fdInfringePersonName}"/>
		</list:data-column>
		 <%-- 创建者头像--%>
		<list:data-column col="hostsrc" escape="false">
			    <person:headimageUrl contextPath="true" personId="${kmCarmngInfringeInfo.fdInfringePersonId}" size="m" />
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>