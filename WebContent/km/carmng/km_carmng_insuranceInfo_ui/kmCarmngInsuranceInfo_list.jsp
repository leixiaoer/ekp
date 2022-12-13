<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngInsuranceInfo" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>

		<list:data-column headerClass="width40" col="fdVehiclesInfo.fdNo" title="${ lfn:message('km-carmng:kmCarmngInsuranceInfo.fdVehiclesInfoId') }" escape="false" style="text-align:center;min-width:60px">
			<span class="com_subject"><c:out value="${kmCarmngInsuranceInfo.fdVehiclesInfo.fdNo}"/></span>
		</list:data-column>
		<list:data-column headerClass="width100" col="fdProductBrand" title="${ lfn:message('km-carmng:kmCarmngInsuranceInfo.fdProductBrand')}" escape="false">
			<c:out value="${kmCarmngInsuranceInfo.fdProductBrand}"/>
		</list:data-column>
		<list:data-column headerClass="width50" col="fdRegisterTime" title="${ lfn:message('km-carmng:kmCarmngInsuranceInfo.fdRegisterTime')}" escape="false">
			<kmss:showDate value="${kmCarmngInsuranceInfo.fdRegisterTime}" type="date"/>
		</list:data-column>
		<list:data-column headerClass="width50" col="fdInsuranceStartTime" title="${ lfn:message('km-carmng:kmCarmngInsuranceInfo.fdInsuranceStartTime')}" escape="false">
			<kmss:showDate value="${kmCarmngInsuranceInfo.fdInsuranceStartTime}" type="date"/>
		</list:data-column>
		<list:data-column headerClass="width50" col="fdInsuranceEndTime" title="${ lfn:message('km-carmng:kmCarmngInsuranceInfo.fdInsuranceEndTime')}" escape="false">
			<kmss:showDate value="${kmCarmngInsuranceInfo.fdInsuranceEndTime}" type="date" />
		</list:data-column>
		
		<list:data-column headerClass="width50" col="docCreateTime" title="${ lfn:message('km-carmng:kmCarmngInsuranceInfo.docCreateTime')}" escape="false">
			<kmss:showDate value="${kmCarmngInsuranceInfo.docCreateTime}" type="datetime" />
		</list:data-column>
		
		<list:data-column headerClass="width60" col="fdInsurancePrice" title="${ lfn:message('km-carmng:kmCarmngInsuranceInfo.fdInsurancePrice')}" escape="false">
			<kmss:showNumber value="${kmCarmngInsuranceInfo.fdInsurancePrice}" pattern="#,##0.00#"></kmss:showNumber>
			<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</list:data-column>
		<list:data-column headerClass="width60" col="fdInsuranceFee" title="${ lfn:message('km-carmng:kmCarmngInsuranceInfo.fdInsuranceFee')}" escape="false">
			<kmss:showNumber value="${kmCarmngInsuranceInfo.fdInsuranceFee}" pattern="#,##0.00#"></kmss:showNumber>
			<bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</list:data-column>
		<list:data-column headerClass="width100" col="fdInsuranceNo" title="${ lfn:message('km-carmng:kmCarmngInsuranceInfo.fdInsuranceNo')}" escape="false">
			<c:out value="${kmCarmngInsuranceInfo.fdInsuranceNo}"/>
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>