<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngInfringeInfo" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column headerClass="width60" col="fdVehiclesInfo.fdNo" title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.fdVehiclesInfoId') }" escape="false" style="text-align:center;min-width:200px">
			<span class="com_subject"><c:out value="${kmCarmngInfringeInfo.fdVehiclesInfo.fdNo}"/></span>
		</list:data-column>
		<list:data-column headerClass="width100" col="fdInfringeTime" title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringeTime')}" escape="false">
			<kmss:showDate value="${kmCarmngInfringeInfo.fdInfringeTime}" type="datetime" />
		</list:data-column>
		<list:data-column headerClass="width100" col="docCreateTime" title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.docCreateTime')}" escape="false">
			<kmss:showDate value="${kmCarmngInfringeInfo.docCreateTime}" type="datetime" />
		</list:data-column>
		<list:data-column headerClass="width100" col="fdInfringeFee" title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringeFee')}" escape="false">
			<kmss:showNumber value="${kmCarmngInfringeInfo.fdInfringeFee}" pattern="#,##0.00#"></kmss:showNumber>
			<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</list:data-column>
		<list:data-column headerClass="width200" col="fdInfringeSite" title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringeSite')}" escape="false">
			<span title="${kmCarmngInfringeInfo.fdInfringeSite}" class="textEllipsis" style="display:inline-block;width:200px">
				<c:out value="${kmCarmngInfringeInfo.fdInfringeSite}"/>
	        </span>
		</list:data-column>
		<list:data-column headerClass="width60" col="fdInfringePersonName" title="${ lfn:message('km-carmng:kmCarmngInfringeInfo.fdInfringePerson')}" escape="false">
			<c:out value="${kmCarmngInfringeInfo.fdInfringePersonName}"/>
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>