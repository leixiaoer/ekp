<%--参与调查index页面--%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.list" spa="true" rwd="true">
	<%-- 标签页标题 --%>
	<template:replace name="head">
		<link rel="stylesheet" type="text/css"
			href="${ LUI_ContextPath}/km/pindagate/vote.css">
		<script>
		seajs.use(['theme!module']);
		</script>
	</template:replace>
	<template:replace name="title">
		<c:out value="${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
	</template:replace>
	<template:replace name="nav">
		<%-- 新建按钮 --%>
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title"
				value="${ lfn:message('km-pindagate:module.km.pindagate') }"></ui:varParam>
			<ui:varParam name="button">
				 [
						{
							"text": "",
							"href":"javascript:void(0);",
							"icon": "km_pindagate"
						}
				] 
			</ui:varParam>
		</ui:combin>
		<c:if test="${ not empty param.key}">
			<c:set var="key" value="${param.key }"></c:set>
		</c:if>
		<c:if test="${ empty param.key}">
			<c:set var="key" value="participate"></c:set>
		</c:if>
		<div class="lui_list_nav_frame">
			<ui:accordionpanel>
				<c:import url="/km/pindagate/import/nav.jsp" charEncoding="UTF-8">
					<c:param name="key" value="${ key}"></c:param>
					<c:param name="criteria" value="participateCriteria"></c:param>
				</c:import>
			</ui:accordionpanel>
		</div>
	</template:replace>
	<template:replace name="content">
	    <ui:tabpanel id="kmPindagatePanel" layout="sys.ui.tabpanel.list"  cfg-router="true">
	    <ui:content id="kmPindagateContent" title="${ lfn:message('km-pindagate:kmPindagate.tree.participate') }" cfg-route="{path:'/joinAll'}">
		<ui:iframe id="pinadagateJoinIframe" cfg-takeHash="true" src="${LUI_ContextPath }/km/pindagate/km_pindagate_ui/joinIndex.jsp"></ui:iframe>
		</ui:content>
		 <ui:content id="kmPindagateUiContent"  title="${ lfn:message('km-pindagate:kmPindagate.tree.set') }"  cfg-route="{path:'/mydocMine'}">
	 	 	<ui:iframe id="pinadagateMyDocIframe" cfg-takeHash="true" src="${LUI_ContextPath }/km/pindagate/km_pindagate_ui/index.jsp"></ui:iframe>
	 	 </ui:content>
	 	  <ui:content id="kmPindagateResultContent"  title="${ lfn:message('km-pindagate:kmPindagate.tree.result') }"  cfg-route="{path:'/indagating'}">
	 	 	<ui:iframe id="pinadagateResultIframe" cfg-takeHash="true" src="${LUI_ContextPath }/km/pindagate/km_pindagate_ui/resultIndex.jsp"></ui:iframe>
	 	 </ui:content>
		</ui:tabpanel>		
	</template:replace>
   	<template:replace name="script">
   		<%-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 --%>
      	<script type="text/javascript">
      		seajs.use(['lui/framework/module'],function(Module){
      			Module.install('kmPindagate',{
 					//模块多语言
 					$lang : {	
 						listApproval : '${lfn:message("list.approval")}',
 						listApproved : '${lfn:message("list.approved")}'
 					},
 					//搜索标识符
 					$search : 'com.landray.kmss.km.pindagate.model.KmPindagateMain'
  				});
      		});
      	</script>
      	<script type="text/javascript" src="${LUI_ContextPath}/km/pindagate/resource/index.js"></script>
	</template:replace>
</template:include>