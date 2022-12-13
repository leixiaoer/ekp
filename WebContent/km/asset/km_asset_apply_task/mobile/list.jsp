<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmAssetApplyTask" list="${queryPage.list}" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>
		<!-- 主题-->	
		<list:data-column col="label" title="${lfn:message('km-asset:kmAssetApplyTask.docSubject')}">
		    <c:out value="${kmAssetApplyTask.kmAssetApplyTask.docSubject}"/>
		</list:data-column>
		<list:data-column col="summary" title="${lfn:message('km-asset:kmAssetApplyTask.fdDescription')}">
		    <c:out value="${kmAssetApplyTask.kmAssetApplyTask.fdDescription}"/>
		</list:data-column>
		<list:data-column property="docStatus" title="${ lfn:message('km-asset:kmAssetApplyTask.docStatus') }">
		</list:data-column>
		<list:data-column col="created" title="${lfn:message('km-asset:kmAssetApplyTask.docCreateTime')}">
	        <kmss:showDate value="${kmAssetApplyTask.kmAssetApplyTask.docCreateTime}" type="date"></kmss:showDate>
      	</list:data-column>
		<list:data-column property="fdAssignUser" title="${ lfn:message('km-asset:kmAssetApplyTask.fdAssignUser') }">
		</list:data-column>
		<list:data-column property="fdPurchaseTime" title="${ lfn:message('km-asset:kmAssetApplyTask.fdPurchaseTime') }">
		</list:data-column>
		<list:data-column property="fdStartDate" title="${ lfn:message('km-asset:kmAssetApplyTask.fdStartDate') }">
		</list:data-column>
		<list:data-column property="fdEndDate" title="${ lfn:message('km-asset:kmAssetApplyTask.fdEndDate') }">
		</list:data-column>
		<list:data-column property="fdStatus" title="${ lfn:message('km-asset:kmAssetApplyTask.fdStatus') }">
		</list:data-column>
		<list:data-column col="href" escape="false">
			/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=view&fdId=${kmAssetApplyTask.fdId}
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno}"
		pageSize="${queryPage.rowsize}" totalSize="${queryPage.totalrows}">
	</list:data-paging>
</list:data>	
