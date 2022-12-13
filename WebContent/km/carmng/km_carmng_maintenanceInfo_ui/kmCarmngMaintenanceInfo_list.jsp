<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngMaintenanceInfo" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>

		<list:data-column headerClass="width60" col="fdVehiclesInfo.fdNo"  title="${ lfn:message('km-carmng:kmCarmngMaintenanceInfo.fdVehiclesInfoId') }" escape="false" style="text-align:center;min-width:200px">
			<span class="com_subject"><c:out value="${kmCarmngMaintenanceInfo.fdVehiclesInfo.fdNo}"/></span>
		</list:data-column>
		<list:data-column headerClass="width80" col="fdMaintenanceTime" title="${ lfn:message('km-carmng:kmCarmngMaintenanceInfo.fdMaintenanceTime')}" escape="false">
			<kmss:showDate value="${kmCarmngMaintenanceInfo.fdMaintenanceTime}" type="date"/>
		</list:data-column>
		<list:data-column headerClass="width80" col="fdMaintenanceFee" title="${ lfn:message('km-carmng:kmCarmngMaintenanceInfo.fdMaintenanceFee')}" escape="false">
			<c:out value="${kmCarmngMaintenanceInfo.fdMaintenanceFee}"/><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</list:data-column>
		<list:data-column headerClass="width60" col="fdPersonName" title="${ lfn:message('km-carmng:kmCarmngMaintenanceInfo.fdPersonId')}" escape="false">
			<c:out value="${kmCarmngMaintenanceInfo.fdPersonName}"/>
		</list:data-column>
		<list:data-column headerClass="width80" col="fdRepairFee" title="${ lfn:message('km-carmng:kmCarmngMaintenanceInfo.fdRepairFee')}" escape="false">
			<kmss:showNumber value="${kmCarmngMaintenanceInfo.fdRepairFee}" pattern="#,##0.00#"></kmss:showNumber><bean:message key="kmCarmngRegisterInfo.fee.unit" bundle="km-carmng"/>
		</list:data-column>
		<list:data-column headerClass="width60" col="docCreator.fdName" title="${ lfn:message('km-carmng:kmCarmngMaintenanceInfo.docCreatorId')}" escape="false">
			<c:out value="${kmCarmngMaintenanceInfo.docCreator.fdName}"/>
		</list:data-column>
		<list:data-column headerClass="width100" col="docCreateTime" title="${ lfn:message('km-carmng:kmCarmngMaintenanceInfo.docCreateTime')}" escape="false">
			<kmss:showDate value="${kmCarmngMaintenanceInfo.docCreateTime}"></kmss:showDate>
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>