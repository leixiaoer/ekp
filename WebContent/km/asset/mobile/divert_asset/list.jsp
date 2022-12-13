<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmAssetDivertBase" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		<%--状态--%>
		<list:data-column col="status" title="${ lfn:message('km-asset:kmAsset.docStatus') }" escape="false">
			<c:choose>
				<c:when test="${kmAssetDivertBase.docStatus=='00'}">
					<span class="muiProcessStatusBorder muiProcessDiscard">${ lfn:message('km-review:status.discard')}</span>
				</c:when>
				<c:when test="${kmAssetDivertBase.docStatus=='10'}">
					<span class="muiProcessStatusBorder muiProcessDraft">${ lfn:message('km-review:status.draft') } </span>
				</c:when>
				<c:when test="${kmAssetDivertBase.docStatus=='11'}">
					<span class="muiProcessStatusBorder muiProcessRefuse">${ lfn:message('km-review:status.refuse')}</span>
				</c:when>
				<c:when test="${kmAssetDivertBase.docStatus=='20'}">
					<span class="muiProcessStatusBorder muiProcessExamine">${ lfn:message('km-review:status.append') }</span>
				</c:when>
				<c:when test="${kmAssetDivertBase.docStatus=='30'}">
					<span class="muiProcessStatusBorder muiProcessPublish">${ lfn:message('km-review:status.publish') }</span>
				</c:when>
				<c:when test="${kmAssetDivertBase.docStatus=='31'}">
					<span class="muiProcessStatusBorder muiProcessPublish">${ lfn:message('km-review:status.feedback') }</span>
				</c:when>
			</c:choose>
		</list:data-column>
	    <%-- 主题--%>	
		<list:data-column col="label" title="${ lfn:message('km-asset:kmAssetDivertBase.docSubject') }" escape="false">
		         <c:out value="${kmAssetDivertBase.docSubject}"/>
		</list:data-column>
		 <%-- 创建者--%>
		<list:data-column col="creator" title="${ lfn:message('km-asset:kmAssetDivertBase.fdCreator') }" >
		         <c:out value="${kmAssetDivertBase.docCreator.fdName}"/>
		</list:data-column>
		 <%-- 创建者头像--%>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl  personId="${kmAssetDivertBase.docCreator.fdId}" size="m" />
		</list:data-column>
		 <%-- 创建时间--%>
	 	<list:data-column col="created" title="${ lfn:message('km-asset:kmAssetDivertBase.fdCreateDate') }">
	        <kmss:showDate value="${kmAssetDivertBase.docCreateTime}" type="date"></kmss:showDate>
      	</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		     /km/asset/km_asset_apply_divert/kmAssetApplyDivert.do?method=view&fdId=${kmAssetDivertBase.fdId}
		</list:data-column>
		 <%-- 当前节点--%>
	 	<list:data-column col="summary" title="${ lfn:message('km-review:sysWfNode.processingNode.currentProcessor') }" escape="false">
	        <kmss:showWfPropertyValues idValue="${kmAssetDivertBase.fdId}" propertyName="summary" />
      	</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>