<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
 
<list:data>
	<list:data-columns var="kmAssetApplyRepair" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column headerStyle="width:80px" col="fdSubclassModelname" title="${ lfn:message('km-asset:kmAssetApplyBase.fdSubclassModelname') }" escape="false">
		    <c:out value="${kmAssetApplyRepair.fdSubclassModelname}"/>
		</list:data-column>
		<list:data-column col="docSubject" title="${ lfn:message('km-asset:kmAssetApplyBase.docSubject') }" style="text-align:left" escape="false">
			<span class="com_subject"><c:out value="${kmAssetApplyRepair.docSubject}"/></span>
		</list:data-column>
		<list:data-column headerStyle="width:120px" property="fdNo" title="${ lfn:message('km-asset:kmAssetApplyBase.fdNo') }">
		</list:data-column>
		<list:data-column headerStyle="width:60px" col="fdCreator.fdName" title="${ lfn:message('km-asset:kmAssetApplyBase.fdCreator') }" escape="false">
		  <ui:person personId="${kmAssetApplyRepair.fdCreator.fdId}" personName="${kmAssetApplyRepair.fdCreator.fdName}"></ui:person>
		</list:data-column>
		<list:data-column headerStyle="width:100px" col="fdStartDate" title="${ lfn:message('km-asset:kmAssetApplyRepair.fdStartDate') }">
		    <kmss:showDate value="${kmAssetApplyRepair.fdStartDate}" type="date"/>
		     <kmss:showDate value="${kmAssetApplyRepair.fdStartDate}" type="time"/>
		</list:data-column> 
		<list:data-column headerStyle="width:100px" col="fdEndDate" title="${ lfn:message('km-asset:kmAssetApplyRepair.fdEndDate') }">
		    <kmss:showDate value="${kmAssetApplyRepair.fdEndDate}" type="date"/>
		     <kmss:showDate value="${kmAssetApplyRepair.fdEndDate}" type="time"/>
		</list:data-column> 
		<list:data-column headerStyle="width:100px" col="fdCreateDate" title="${ lfn:message('km-asset:kmAssetApplyBase.fdCreateDate') }">
		    <kmss:showDate value="${kmAssetApplyRepair.fdCreateDate}" type="date"/>
		     <kmss:showDate value="${kmAssetApplyRepair.fdCreateDate}" type="time"/>
		</list:data-column> 
		<list:data-column headerStyle="width:60px" col="docStatus" title="${ lfn:message('km-asset:kmAssetApplyBase.docStatus') }">
		    <sunbor:enumsShow value="${kmAssetApplyRepair.docStatus}" enumsType="common_status" />
		</list:data-column>
		<list:data-column headerStyle="width:80px" col="nodeName" title="${ lfn:message('km-review:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues idValue="${kmAssetApplyRepair.fdId}" propertyName="nodeName" />
		</list:data-column>
		<%--资产盘点任务--%>
		<list:data-column headerStyle="width:80px" col="fdTask" title="${ lfn:message('km-asset:kmAssetApplyBase.fdTask') }" escape="false">
			<kmss:showWfPropertyValues idValue="${kmAssetApplyRepair.fdTask}" propertyName="nodeName" />
		</list:data-column>
		<list:data-column headerStyle="width:100px" col="handlerName" title="${ lfn:message('km-review:sysWfNode.processingNode.currentProcessor') }" escape="false">
		    <kmss:showWfPropertyValues idValue="${kmAssetApplyRepair.fdId}" propertyName="handlerName" />
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
