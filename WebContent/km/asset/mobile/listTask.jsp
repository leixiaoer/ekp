<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmAssetApplyTask" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		<%--状态--%>
		<list:data-column col="status" title="${ lfn:message('sys-news:sysNewsMain.docStatus') }" escape="false">
						<c:if test="${'1' eq kmAssetApplyTask.fdStatus}">
			 				<span class="muiProcessStatusBorder muiTaskAssetStatus1">${ lfn:message('km-asset:enumeration_km_asset_apply_task_fd_status_1') }</span>
			 			</c:if>
			 			<c:if test="${'2' eq kmAssetApplyTask.fdStatus}">
			 				<span class="muiProcessStatusBorder muiTaskAssetStatus2">${ lfn:message('km-asset:enumeration_km_asset_apply_task_fd_status_2') }</span>
			 			</c:if>
			 			<c:if test="${'3' eq kmAssetApplyTask.fdStatus}">
			 				<span class="muiProcessStatusBorder muiTaskAssetStatus3">${ lfn:message('km-asset:enumeration_km_asset_apply_task_fd_status_3') }</span>
			 			</c:if>
			 			<c:if test="${'4' eq kmAssetApplyTask.fdStatus}">
			 				<span class="muiProcessStatusBorder muiTaskAssetStatus3">${ lfn:message('km-asset:enumeration_km_asset_apply_task_fd_status_4') }</span>
			 			</c:if>
		</list:data-column>
	    <%-- 主题--%>	
		<list:data-column col="label" title="${ lfn:message('km-asset:kmAssetApplyTask.docSubject') }" escape="false">
		         <c:out value="${kmAssetApplyTask.docSubject}"/>
		</list:data-column>
		 <%-- 创建者--%>
		<list:data-column col="creator" title="${ lfn:message('km-asset:kmAssetApplyTask.fdCreator') }" >
		         <c:out value="${kmAssetApplyTask.docCreator.fdName}"/>
		</list:data-column>
		 <%-- 创建者头像--%>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl  personId="${kmAssetApplyTask.docCreator.fdId}" size="m" />
		</list:data-column>
		 <%-- 创建时间--%>
	 	<list:data-column col="created" title="${ lfn:message('km-asset:kmAssetApplyTask.fdCreateDate') }">
	        <kmss:showDate value="${kmAssetApplyTask.docCreateTime}" type="date"></kmss:showDate>
      	</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		    /km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=view&fdId=${kmAssetApplyTask.fdId}
		</list:data-column>
		 <%-- 当前节点--%>
	 	<list:data-column col="summary" title="${ lfn:message('km-review:sysWfNode.processingNode.currentProcessor') }" escape="false">
	        <kmss:showWfPropertyValues idValue="${kmAssetApplyTask.fdId}" propertyName="summary" />
      	</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>