<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="geesunOitemsBudgerApplication" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="docSubject" title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.docSubject') }" style="text-align:left"  escape="false">
			<span class="com_subject"><c:out value="${geesunOitemsBudgerApplication.docSubject}" /></span>
		</list:data-column>
		<list:data-column headerStyle="width:100px" col="fdTemplate.fdTempletType" title="${ lfn:message('geesun-oitems:geesunOitems.tree.application.type') }">
		   <sunbor:enumsShow value="${geesunOitemsBudgerApplication.fdTemplate.fdTempletType}" enumsType="geesunOitemsBudgerApplication_fdType"/>
		</list:data-column>
		<list:data-column headerStyle="width:60px" col="docCreator.fdName" title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.docCreatorId') }" escape="false">
		    <ui:person personId="${geesunOitemsBudgerApplication.docCreator.fdId}" personName="${geesunOitemsBudgerApplication.docCreator.fdName}"></ui:person>
		</list:data-column>
		<list:data-column headerStyle="width:80px" col="docCreateTime" title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.docCreateTime') }">
		    <kmss:showDate value="${geesunOitemsBudgerApplication.docCreateTime}" type="date" />
		</list:data-column>
		<list:data-column headerStyle="width:80px" col="fdOutTime" title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.fdOutTime') }">
		    <kmss:showDate value="${geesunOitemsBudgerApplication.fdOutTime}" type="date" />
		</list:data-column>
		<list:data-column headerStyle="width:60px" col="docStatus" title="${ lfn:message('geesun-oitems:geesunOitemsGetApplication.docStatus') }">
			<sunbor:enumsShow value="${geesunOitemsBudgerApplication.docStatus}" enumsType="geesunOitems_docStatus"/>
		</list:data-column>
		<list:data-column headerClass="width100" col="nodeName" title="${ lfn:message('geesun-oitems:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues  var="nodevalue" idValue="${geesunOitemsBudgerApplication.fdId}" propertyName="nodeName" />
			    <div class="textEllipsis width100" title="${nodevalue}">
			        <c:out value="${nodevalue}"></c:out>
			    </div>
		</list:data-column>
		<list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('geesun-oitems:sysWfNode.processingNode.currentProcessor') }" escape="false">
		   <kmss:showWfPropertyValues  var="handlerValue" idValue="${geesunOitemsBudgerApplication.fdId}" propertyName="handlerName" />
			    <div class="textEllipsis width80" style="font-weight:bold;" title="${handlerValue}">
			        <c:out value="${handlerValue}"></c:out>
			    </div>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" 
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }"> 
	</list:data-paging>
</list:data>
