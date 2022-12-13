<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmAssetApplyInventory" list="${queryPage.list}" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>
		
		<list:data-column col="docSubject" title="${ lfn:message('km-asset:kmAssetApplyInventory.docSubject') }" escape="false">
			<span class="com_subject"><c:out value="${kmAssetApplyInventory.docSubject}"/></span>
		</list:data-column>
		<list:data-column property="fdDescription" title="${ lfn:message('km-asset:kmAssetApplyInventory.fdDescription') }">
		</list:data-column>
		<list:data-column col="docStatus" title="${ lfn:message('km-asset:kmAssetApplyInventory.docStatus') }">
			<sunbor:enumsShow
				value="${kmAssetApplyInventory.docStatus}"
				enumsType="common_status" />
		</list:data-column>
		<list:data-column property="docCreateTime" title="${ lfn:message('km-asset:kmAssetApplyInventory.docCreateTime') }">
		</list:data-column>
		<list:data-column property="fdNo" title="${ lfn:message('km-asset:kmAssetApplyInventory.fdNo') }">
		</list:data-column>
		<list:data-column headerStyle="width:100px" col="fdCreateDate" title="${ lfn:message('km-asset:kmAssetApplyBase.fdCreateDate') }">
		    <kmss:showDate value="${kmAssetApplyInventory.fdCreateDate}" type="date"/>
		     <kmss:showDate value="${kmAssetApplyInventory.fdCreateDate}" type="time"/>
		</list:data-column> 
		<list:data-column col="docCreator.fdName" title="${ lfn:message('km-asset:kmAssetApplyInventory.docCreator') }">
			<c:out value="${kmAssetApplyInventory.docCreator.fdName}" />
		</list:data-column>
		 
		<list:data-column col="fdTask.docSubject" title="${ lfn:message('km-asset:kmAssetApplyInventory.fdTask') }">
			<c:out value="${kmAssetApplyInventory.fdTask.docSubject}" />
		</list:data-column>
		<list:data-column col="fdApplyTemplate.fdName" title="${ lfn:message('km-asset:kmAssetApplyInventory.fdApplyTemplate') }">
			<c:out value="${kmAssetApplyInventory.fdApplyTemplate.fdName}" />
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging page="${queryPage}" />
</list:data>