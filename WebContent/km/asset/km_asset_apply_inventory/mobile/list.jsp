<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmAssetApplyInventory" list="${queryPage.list}" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>
		<%--状态--%>
		<list:data-column col="status" title="${ lfn:message('km-asset:kmAssetApplyInventory.docStatus') }" escape="false">
			<c:choose>
				<c:when test="${kmAssetApplyInventory.docStatus=='00'}">
					<span class="muiProcessStatusBorder muiProcessDiscard">${ lfn:message('km-review:status.discard')}</span>
				</c:when>
				<c:when test="${kmAssetApplyInventory.docStatus=='10'}">
					<span class="muiProcessStatusBorder muiProcessDraft">${ lfn:message('km-review:status.draft') } </span>
				</c:when>
				<c:when test="${kmAssetApplyInventory.docStatus=='11'}">
					<span class="muiProcessStatusBorder muiProcessRefuse">${ lfn:message('km-review:status.refuse')}</span>
				</c:when>
				<c:when test="${kmAssetApplyInventory.docStatus=='20'}">
					<span class="muiProcessStatusBorder muiProcessExamine">${ lfn:message('km-review:status.append') }</span>
				</c:when>
				<c:when test="${kmAssetApplyInventory.docStatus=='30'}">
					<span class="muiProcessStatusBorder muiProcessPublish">${ lfn:message('km-review:status.publish') }</span>
				</c:when>
				<c:when test="${kmAssetApplyInventory.docStatus=='31'}">
					<span class="muiProcessStatusBorder muiProcessPublish">${ lfn:message('km-review:status.feedback') }</span>
				</c:when>
			</c:choose>
		</list:data-column>		
		<%-- 主题 --%>	
		<list:data-column col="label" title="${lfn:message('km-asset:kmAssetApplyInventory.docSubject')}">
		    <c:out value="${kmAssetApplyInventory.docSubject}"/>
		</list:data-column>
		 <%-- 创建者--%>
		<list:data-column col="creator" title="${ lfn:message('km-asset:kmAssetBuyBase.fdCreator') }" >
		         <c:out value="${kmAssetApplyInventory.docCreator.fdName}"/>
		</list:data-column>		
		 <%-- 创建者头像 --%>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl  personId="${kmAssetApplyInventory.docCreator.fdId}" size="m" />
		</list:data-column>		
		 <%-- 当前节点--%>
	 	<list:data-column col="summary" title="${ lfn:message('km-review:sysWfNode.processingNode.currentProcessor') }" escape="false">
	        <kmss:showWfPropertyValues idValue="${kmAssetApplyInventory.fdId}" propertyName="summary" />
      	</list:data-column>
		<list:data-column property="docStatus" title="${ lfn:message('km-asset:kmAssetApplyInventory.docStatus') }">
		</list:data-column>
		<list:data-column col="created" title="${lfn:message('km-asset:kmAssetApplyInventory.docCreateTime')}">
	        <kmss:showDate value="${kmAssetApplyInventory.docCreateTime}" type="date"></kmss:showDate>
      	</list:data-column>
		<list:data-column property="fdNo" title="${ lfn:message('km-asset:kmAssetApplyInventory.fdNo') }">
		</list:data-column>
		<list:data-column property="fdAssetStatus" title="${ lfn:message('km-asset:kmAssetApplyInventory.fdAssetStatus') }">
		</list:data-column>
		<list:data-column property="fdText" title="${ lfn:message('km-asset:kmAssetApplyInventory.fdText') }">
		</list:data-column>
		<list:data-column col="href" escape="false">
			/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=view&fdId=${kmAssetApplyInventory.fdId}
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno}"
		pageSize="${queryPage.rowsize}" totalSize="${queryPage.totalrows}">
	</list:data-paging>
</list:data>	
