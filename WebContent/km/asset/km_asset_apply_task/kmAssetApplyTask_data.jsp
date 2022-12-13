<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page  import="com.landray.kmss.util.UserUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmAssetApplyTask" list="${queryPage.list}" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>
		<list:data-column col="docSubject" title="${ lfn:message('km-asset:kmAssetApplyTask.docSubject') }" style="text-align:left" escape="false">
			<span class="com_subject"><c:out value="${kmAssetApplyTask.docSubject}"/></span>
		</list:data-column>
		<list:data-column property="fdDescription" title="${ lfn:message('km-asset:kmAssetApplyTask.fdDescription') }">
		</list:data-column>
		<list:data-column col="docStatus" title="${ lfn:message('km-asset:kmAssetApplyTask.docStatus') }">
			<sunbor:enumsShow value="${kmAssetApplyTask.docStatus}" enumsType="common_status" />
		</list:data-column>
		<list:data-column col="docCreateTime" title="${ lfn:message('km-asset:kmAssetApplyTask.docCreateTime') }">
			<kmss:showDate value="${kmAssetApplyTask.docCreateTime}" type="datetime"/>
		</list:data-column>
		<list:data-column headerStyle="width:100px" col="fdCreateDate" title="${ lfn:message('km-asset:kmAssetApplyBase.fdCreateDate') }">
		    <kmss:showDate value="${kmAssetApplyTask.fdCreateDate}" type="date"/>
		     <kmss:showDate value="${kmAssetApplyTask.fdCreateDate}" type="time"/>
		</list:data-column> 
		<list:data-column col="fdStartDate" title="${ lfn:message('km-asset:kmAssetApplyTask.fdStartDate') }">
		<kmss:showDate value="${kmAssetApplyTask.fdStartDate}" type="datetime"/>
		</list:data-column> 
		<list:data-column col="fdEndDate" title="${ lfn:message('km-asset:kmAssetApplyTask.fdEndDate') }">
		<kmss:showDate value="${kmAssetApplyTask.fdEndDate}" type="datetime"/>
		</list:data-column>
		<list:data-column col="fdStatus" title="${ lfn:message('km-asset:kmAssetApplyTask.fdStatus') }">
			<c:if test="${kmAssetApplyTask.fdStatus eq '1'}">${ lfn:message('km-asset:enumeration_km_asset_apply_task_fd_status_1') }</c:if>
			<c:if test="${kmAssetApplyTask.fdStatus eq '2'}">${ lfn:message('km-asset:enumeration_km_asset_apply_task_fd_status_2') }</c:if>
			<c:if test="${kmAssetApplyTask.fdStatus eq '3'}">${ lfn:message('km-asset:enumeration_km_asset_apply_task_fd_status_3') }</c:if>
		</list:data-column>
		<list:data-column col="fdAssetCategory.fdName" title="${ lfn:message('km-asset:kmAssetApplyTask.fdAssetCategory') }">
			<c:out value="${kmAssetApplyTask.fdAssetCategory.fdName}" />
		</list:data-column>
		<list:data-column col="fdAssetAddress.fdAddress" title="${ lfn:message('km-asset:kmAssetApplyTask.fdAssetAddress') }">
			<c:out value="${kmAssetApplyTask.fdAssetAddress.fdAddress}" />
		</list:data-column>
		<list:data-column col="fdApplyTemplate.fdName" title="${ lfn:message('km-asset:kmAssetApplyTask.fdApplyTemplate') }">
			<c:out value="${kmAssetApplyTask.fdApplyTemplate.fdName}" />
		</list:data-column>
		<list:data-column col="docCreator.fdName" title="${ lfn:message('km-asset:kmAssetApplyTask.docCreator') }">
			<c:out value="${kmAssetApplyTask.docCreator.fdName}" />
		</list:data-column>
		<list:data-column col="fdDept.fdName" title="${ lfn:message('km-asset:kmAssetApplyTask.fdDept') }">
			<c:out value="${kmAssetApplyTask.fdDept.fdName}" />
		</list:data-column>
		<list:data-column headerClass="width100" col="nodeName" title="${ lfn:message('km-asset:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues  var="nodevalue" idValue="${kmAssetApplyTask.fdId}" propertyName="nodeName" />
			    <div class="textEllipsis width100" title="${nodevalue}">
			        <c:out value="${nodevalue}"></c:out>
			    </div>
		</list:data-column>
		<list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('km-asset:sysWfNode.processingNode.currentProcessor') }" escape="false">
		   <kmss:showWfPropertyValues  var="handlerValue" idValue="${kmAssetApplyTask.fdId}" propertyName="handlerName" />
			    <div class="textEllipsis width80" style="font-weight:bold;" title="${handlerValue}">
			        <c:out value="${handlerValue}"></c:out>
			    </div>
		</list:data-column>
		<list:data-column headerClass="width80" col="fdNotifyType" title="${ lfn:message('km-asset:kmAssetApplyTask.fdNotifyType') }" escape="false">
			        <c:if test="${fn:indexOf(kmAssetApplyTask.fdNotifyType,'todo')>-1 }">
							<c:out value="${ lfn:message('km-asset:kmAssetApplyTask.notify.todo') }"/>;
					</c:if>
					<c:if test="${fn:indexOf(kmAssetApplyTask.fdNotifyType,'email')>-1 }">
							<c:out value="${ lfn:message('km-asset:kmAssetApplyTask.notify.email') }"/>;
					</c:if>
					<c:if test="${fn:indexOf(kmAssetApplyTask.fdNotifyType,'mobile')>-1 }">
							<c:out value="${ lfn:message('km-asset:kmAssetApplyTask.notify.mobile') }"/>;
					</c:if>
			           
		</list:data-column>
		<list:data-column  col="oper" title="${ lfn:message('list.operation') }" escape="false">
		<% 
		 request.setAttribute("fdUserId",UserUtil.getUser().getFdId());
		%>
			 	<c:choose>
			 		<c:when test="${'30' eq  kmAssetApplyTask.docStatus}">
			 		<c:if test="${kmAssetApplyTask.docCreator.fdId == fdUserId }">
			 			<%-- 开始盘点 --%>
			 			<c:if test="${'1' eq kmAssetApplyTask.fdStatus}">
			 				<a style="color: #30abe4;" href="javascript:startInventory('${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=inventory&fdId=${kmAssetApplyTask.fdId}','${kmAssetApplyTask.fdId}');">${ lfn:message('km-asset:kmAssetApplyTask.startInventory') }</a>
			 			</c:if>
			 			<%-- 盘点完成 --%>
			 			<c:if test="${'2' eq kmAssetApplyTask.fdStatus}">
			 				<a style="color: #30abe4;" href="javascript:complateInventory('${kmAssetApplyTask.fdId}');">${ lfn:message('km-asset:kmAssetApplyTask.complateInventory') }</a>
			 			</c:if>
			 		</c:if>
			 		</c:when>
			 		<c:otherwise>
			 			
			 		</c:otherwise>
			 	</c:choose>
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging page="${queryPage}" />
</list:data>