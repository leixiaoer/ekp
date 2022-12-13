<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmOitemsBudgerApplication" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="docSubject" title="${ lfn:message('km-oitems:kmOitemsBudgerApplication.docSubject') }" style="text-align:left"  escape="false">
			<span class="com_subject"><c:out value="${kmOitemsBudgerApplication.docSubject}" /></span>
		</list:data-column>
		<list:data-column headerStyle="width:100px" col="fdTemplate.fdTempletType" title="${ lfn:message('km-oitems:kmOitems.tree.application.type') }">
		   <sunbor:enumsShow value="${kmOitemsBudgerApplication.fdTemplate.fdTempletType}" enumsType="kmOitemsBudgerApplication_fdType"/>
		</list:data-column>
		<list:data-column headerStyle="width:60px" col="docCreator.fdName" title="${ lfn:message('km-oitems:kmOitemsBudgerApplication.docCreatorId') }" escape="false">
		    <ui:person personId="${kmOitemsBudgerApplication.docCreator.fdId}" personName="${kmOitemsBudgerApplication.docCreator.fdName}"></ui:person>
		</list:data-column>
		<list:data-column headerStyle="width:80px" col="docCreateTime" title="${ lfn:message('km-oitems:kmOitemsBudgerApplication.docCreateTime') }">
		    <kmss:showDate value="${kmOitemsBudgerApplication.docCreateTime}" type="date" />
		</list:data-column>
		<list:data-column headerStyle="width:80px" col="fdOutTime" title="${ lfn:message('km-oitems:kmOitemsBudgerApplication.fdOutTime') }">
		    <kmss:showDate value="${kmOitemsBudgerApplication.fdOutTime}" type="date" />
		</list:data-column>
		<list:data-column headerStyle="width:60px" col="docStatus" title="${ lfn:message('km-oitems:kmOitemsGetApplication.docStatus') }">
			<sunbor:enumsShow value="${kmOitemsBudgerApplication.docStatus}" enumsType="kmOitems_docStatus"/>
		</list:data-column>
		<list:data-column headerClass="width100" col="nodeName" title="${ lfn:message('km-oitems:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues  var="nodevalue" idValue="${kmOitemsBudgerApplication.fdId}" propertyName="nodeName" />
			    <div class="textEllipsis width100" title="${nodevalue}">
			        <c:out value="${nodevalue}"></c:out>
			    </div>
		</list:data-column>
		<list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('km-oitems:sysWfNode.processingNode.currentProcessor') }" escape="false">
		   <kmss:showWfPropertyValues  var="handlerValue" idValue="${kmOitemsBudgerApplication.fdId}" propertyName="handlerName" />
			    <div class="textEllipsis width80" style="font-weight:bold;" title="${handlerValue}">
			        <c:out value="${handlerValue}"></c:out>
			    </div>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" 
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }"> 
	</list:data-paging>
</list:data>