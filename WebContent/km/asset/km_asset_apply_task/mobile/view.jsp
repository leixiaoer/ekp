<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-asset:module.km.asset') }"/>
	</template:replace>
	<template:replace name="content">
		<div data-dojo-type="mui/view/DocScrollableView" id="kmAssetApplyTaskForm">
			<div class="muiDocFrame">
				<div class="muiDocSubject">
					<c:out value="${kmAssetApplyTaskForm.docSubject}"/>
				</div>
				<div class="muiDocInfo">
					<span> <c:out value="${kmAssetApplyTaskForm.docCreateTime  }" />
					</span>
				</div>
				<c:if
					test="${kmAssetApplyTaskForm.fdDescription!=null && kmAssetApplyTaskForm.fdDescription!='' }">
					<div class="muiDocSummary">
						<div class="muiDocSummarySign">摘要</div>
						<c:out value="${kmAssetApplyTaskForm.fdDescription}" />
					</div>
				</c:if>
					<br/>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmAssetApplyTaskForm"></c:param>
						<c:param name="fdKey" value="attachment"></c:param>
					</c:import> 
					<br/>	
			</div>
			<c:if test="${kmAssetApplyTaskForm.docStatus >= '30' }">
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
				  <li data-dojo-type="mui/back/BackButton"></li>
				   <li data-dojo-type="mui/tabbar/TabBarButtonGroup" data-dojo-props="icon1:'mui mui-more'">
				    	<div data-dojo-type="mui/back/HomeButton"></div>
				    </li>
				</ul>
			</c:if>
			<c:if test="${kmAssetApplyTaskForm.docStatus < '30' }">
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
				  <li data-dojo-type="mui/back/BackButton"></li>
				  <li data-dojo-type="mui/tabbar/TabBarButtonGroup" data-dojo-props="icon1:'mui mui-more'">
				    	<div data-dojo-type="mui/back/HomeButton"></div>
				  </li>
				</ul>
			</c:if>
		</div>
	</template:replace>
</template:include>
