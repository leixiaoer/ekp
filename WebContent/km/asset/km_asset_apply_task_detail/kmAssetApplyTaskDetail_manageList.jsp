<%@page import="com.landray.kmss.km.asset.model.KmAssetApplyTaskDetail"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.km.asset.util.AssetTaskUtil"%>
<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="inventoryType" value="${(empty param.inventoryType) ? '' : (param.inventoryType)}" scope="page" />
<list:data>
	<list:data-columns var="kmAssetApplyTaskDetail" list="${queryPage.list }" custom="false">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column headerClass="width100" col="fdStatus" title="${ lfn:message('km-asset:kmAssetApplyTaskDetail.fdStatus') }" escape="false">
			<c:if test="${kmAssetApplyTaskDetail.fdStatus eq '1' }">
				<c:choose>
					<c:when test="${'3' eq kmAssetApplyTask.fdStatus}">
						${ lfn:message('km-asset:kmAssetApplyTask.export.sheet_0') }
					</c:when>
					<c:otherwise>
						${ lfn:message('km-asset:enumeration_km_asset_apply_task_detail_fd_status_1') }
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${kmAssetApplyTaskDetail.fdStatus eq '2' }">
				${ lfn:message('km-asset:enumeration_km_asset_apply_task_detail_fd_status_2') }
			</c:if>
			<c:if test="${kmAssetApplyTaskDetail.fdStatus eq '3' }">
				${ lfn:message('km-asset:enumeration_km_asset_apply_task_detail_fd_status_3') }
			</c:if>
			<c:if test="${kmAssetApplyTaskDetail.fdStatus eq '4' }">
				${ lfn:message('km-asset:enumeration_km_asset_apply_task_detail_fd_status_4') }
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width100" col="fdAssetCard.fdAssetStatus" title="${ lfn:message('km-asset:kmAssetCard.fdAssetStatus') }" escape="false">
			<xform:select value="${kmAssetApplyTaskDetail.fdAssetCard.fdAssetStatus}" property="fdAssetStatus" showStatus="view">
				<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
			</xform:select>
		</list:data-column> 
		<list:data-column headerClass="width130" col="fdAssetCard.fdCode" title="${ lfn:message('km-asset:kmAssetCard.fdCode') }" escape="false">
			<c:out value="${kmAssetApplyTaskDetail.fdAssetCard.fdCode}" />
		</list:data-column> 
		<list:data-column headerClass="width150" col="fdName" title="${ lfn:message('km-asset:kmAssetApplyTaskDetail.fdName') }" escape="false" style="text-align:left">
			<c:out value="${kmAssetApplyTaskDetail.fdName}" />
		</list:data-column> 
		<list:data-column headerClass="width100" col="fdAssetCard.fdAssetCategory" title="${ lfn:message('km-asset:kmAssetCard.fdAssetCategory') }" escape="false">
			<c:out value="${kmAssetApplyTaskDetail.fdAssetCard.fdAssetCategory.fdName}" />
		</list:data-column> 
		<list:data-column headerClass="width100" col="fdAssetCard.fdStandard" title="${ lfn:message('km-asset:kmAssetCard.fdStandard') }" escape="false">
			<c:out value="${kmAssetApplyTaskDetail.fdAssetCard.fdStandard}" />
		</list:data-column> 
		<list:data-column headerClass="width120" col="operation" title="${ lfn:message('list.operation') }" escape="false">
			<c:if test="${inventoryType eq 'todoInventory' }">
				<%
					if(AssetTaskUtil.checkPermission("pd",pageContext.getRequest().getAttribute("kmAssetApplyTask"),pageContext.getAttribute("kmAssetApplyTaskDetail"))){
				%>
					<a style="color: #30abe4;" href="javascript:createInventory('KmAssetApplyInventoryDoc','${kmAssetApplyTask.fdId}','${kmAssetApplyTaskDetail.fdId}','${kmAssetApplyTaskDetail.fdAssetCard.fdId}');">${lfn:message('km-asset:kmAssetApplyTask.inventory')}</a>
				<%	
					}
				%>
				&nbsp;
				<%
					if(AssetTaskUtil.checkPermission("pk",pageContext.getRequest().getAttribute("kmAssetApplyTask"),pageContext.getAttribute("kmAssetApplyTaskDetail"))){
				%>
				<a style="color: #30abe4;" href="javascript:createInventory('KmAssetApplyDealDoc','${kmAssetApplyTask.fdId}','${kmAssetApplyTaskDetail.fdId}','${kmAssetApplyTaskDetail.fdAssetCard.fdId}');">${lfn:message('km-asset:enumeration_km_asset_apply_task_detail_fd_status_3')}</a>
				<%	
					}
				%>
			</c:if>
			<c:if test="${inventoryType eq 'hasBeenInventory' }">
				<a style="color: #30abe4;" href="javascript:viewInventory('${kmAssetApplyTask.fdId}','${kmAssetApplyTaskDetail.fdId}','${kmAssetApplyTaskDetail.fdAssetCard.fdId}','${kmAssetApplyTaskDetail.fdOprUrlRecord}');">${lfn:message('km-asset:kmAssetApplyTask.inventroySituation')}</a>
			</c:if>
			<c:if test="${inventoryType eq 'Overage' }">
				<%
					if(AssetTaskUtil.checkPermission("py",pageContext.getRequest().getAttribute("kmAssetApplyTask"),pageContext.getAttribute("kmAssetApplyTaskDetail"))){
				%>
				<a style="color: #30abe4;" href="javascript:viewInventory('${kmAssetApplyTask.fdId}','${kmAssetApplyTaskDetail.fdId}','${kmAssetApplyTaskDetail.fdAssetCard.fdId}','${kmAssetApplyTaskDetail.fdOprUrlRecord}');">${lfn:message('km-asset:kmAssetCard.detail')}</a>
				<c:if test="${kmAssetApplyTask.fdStatus ne '3' }">
				&nbsp;
				<a style="color: #30abe4;" href="javascript:deleteInventory('${kmAssetApplyTask.fdId}','${kmAssetApplyTaskDetail.fdId}','${kmAssetApplyTaskDetail.fdAssetCard.fdId}');">${lfn:message('button.delete')}</a>
				</c:if>
				<%	
					}
				%>
			</c:if>
		</list:data-column> 
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
					  pageSize="${queryPage.rowsize }" 
					  totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>