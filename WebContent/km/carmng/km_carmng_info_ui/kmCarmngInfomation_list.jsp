<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngInfomation" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>

		<list:data-column col="fdNo" title="${ lfn:message('km-carmng:kmCarmngInfomation.fdNo') }" escape="false" style="text-align:left;min-width:200px">
			<c:out value="${kmCarmngInfomation.fdNo}"/>
		</list:data-column>
		<list:data-column headerClass="width100" col="docSubject" title="${ lfn:message('km-carmng:kmCarmngInfomation.docSubject')}" escape="false">
			<c:out value="${kmCarmngInfomation.docSubject}"/>
		</list:data-column>
		<list:data-column headerClass="width100" col="fdVehichesType.fdName" title="${ lfn:message('km-carmng:kmCarmngInfomation.fdVehichesType')}" escape="false">
			<c:out value="${kmCarmngInfomation.fdVehichesType.fdName}"/>
		</list:data-column>
		<list:data-column headerClass="width40" col="fdSeatNumber" title="${ lfn:message('km-carmng:kmCarmngInfomation.fdSeatNumber')}" escape="false">
			<c:out value="${kmCarmngInfomation.fdSeatNumber}"/>
		</list:data-column>
		<list:data-column headerClass="width100" col="docCreateTime" title="${ lfn:message('km-carmng:kmCarmngInfomation.docCreateTime')}" escape="false">
			<kmss:showDate value="${kmCarmngInfomation.docCreateTime}" />
		</list:data-column>
		<list:data-column headerClass="width120" col="fdMotorcade.fdName" title="${ lfn:message('km-carmng:kmCarmngInfomation.fdMotorcadeId')}" escape="false">
			<c:out value="${kmCarmngInfomation.fdMotorcade.fdName}"/>
		</list:data-column>
		<list:data-column headerClass="width60" col="fdDriverName" title="${ lfn:message('km-carmng:kmCarmngInfomation.fdDriverName')}" escape="false">
			<c:out value="${kmCarmngInfomation.fdDriverName}"/>
		</list:data-column>
		<list:data-column headerClass="width40" col="docStatus" title="${ lfn:message('km-carmng:kmCarmngInfomation.docStatus')}" escape="false">
			<sunbor:enumsShow value="${kmCarmngInfomation.docStatus}" enumsType="kmCarmngInformation_status"/>
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>