<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!listview']);	
		</script>
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
        <div class="lui_sclp_item">
			<div class="lui_sclp_item_wrap">
		        <ui:dataview>
					<ui:source type="AjaxJson">
						{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getItemTab&fdType=${JsParam.fdType}"}
					</ui:source>
					<ui:render type="Template">
						<c:choose>
							<c:when test="${param.fdType eq 'myCharge'}">
								<c:import url="/km/supervise/km_supervise_main/import/normal_item_tab_my_charge.jsp" charEncoding="UTF-8"></c:import>
							</c:when>
							<c:when test="${param.fdType eq 'myUndertake'}">
								<c:import url="/km/supervise/km_supervise_main/import/normal_item_tab_my_undertake.jsp" charEncoding="UTF-8"></c:import>
							</c:when>
							<c:when test="${param.fdType eq 'leadConcern'}">
								<c:import url="/km/supervise/km_supervise_main/import/normal_item_tab_leader_concern.jsp" charEncoding="UTF-8"></c:import>
							</c:when>
							<c:when test="${param.fdType eq 'myConcern'}">
								<c:import url="/km/supervise/km_supervise_main/import/normal_item_tab_my_concern.jsp" charEncoding="UTF-8"></c:import>
							</c:when>
							<c:when test="${param.fdType eq 'myManage'}">
								<c:import url="/km/supervise/km_supervise_main/import/normal_item_tab_my_manage.jsp" charEncoding="UTF-8"></c:import>
							</c:when>
						</c:choose>
					</ui:render>
					<script>
						window.curStatus = "all";
						function changeStatus(fdType,fdStatus,node){
							window.curStatus = fdStatus;
							var id = $(node).parent().parent().parent().siblings().attr('id');
							$(node).addClass('sclpitl_item_active lui_text_primary').siblings().removeClass('sclpitl_item_active lui_text_primary');
							LUI(id).source.setUrl('/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getSuperviseDatas&fdType='+fdType+'&fdStatus='+fdStatus);
							LUI(id).source.get();
						}
					</script>
			    </ui:dataview>
			    <ui:dataview>
					<ui:source type="AjaxJson">
						{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getSuperviseDatas&fdType=${JsParam.fdType}&fdStatus=all'}
					</ui:source>
					<ui:render type="Template">
						<c:choose>
							<c:when test="${param.fdType eq 'myCharge'}">
								<c:import url="/km/supervise/km_supervise_main/import/index_list_my_charge.jsp" charEncoding="UTF-8"></c:import>
							</c:when>
							<c:when test="${param.fdType eq 'myUndertake'}">
								<c:import url="/km/supervise/km_supervise_main/import/index_list_my_undertake.jsp" charEncoding="UTF-8"></c:import>
							</c:when>
							<c:when test="${param.fdType eq 'leadConcern'}">
								<c:import url="/km/supervise/km_supervise_main/import/index_list_leader_concern.jsp" charEncoding="UTF-8"></c:import>
							</c:when>
							<c:when test="${param.fdType eq 'myConcern'}">
								<c:import url="/km/supervise/km_supervise_main/import/index_list_my_concern.jsp" charEncoding="UTF-8"></c:import>
							</c:when>
							<c:when test="${param.fdType eq 'myManage'}">
								<c:import url="/km/supervise/km_supervise_main/import/index_list_my_manage.jsp" charEncoding="UTF-8"></c:import>
							</c:when>
						</c:choose>
					</ui:render>
					<script>
						function viewDoc(href){
							Com_OpenWindow('${LUI_ContextPath}'+href);
						}
						
						function getStatus() {
							if(window.curStatus == "all") {
								return "";
							} else if(window.curStatus == "delay") {
								return "&fdStatus=30";
							} else if(window.curStatus == "soonDelay") {
								return "&fdStatus=20";
							} else if(window.curStatus == "concern") {
								return "";
							} else if(window.curStatus == "notBack") {
								return "&myStatus=notBack";
							} else if(window.curStatus == "delayNotBack") {
								return "&myStatus=delayNotBack";
							}
							return "";
						}
						function showMore(href){
							href = href + getStatus();
							var url = top.location.href;
							var modelIndex = url.indexOf("/km/supervise");
							if(modelIndex == -1){
								window.open('${LUI_ContextPath}'+href, '_blank');
							}else{
								var index = url.indexOf("index.jsp");
								top.location.href = '${LUI_ContextPath}'+href;
								if(index == -1){
									top.location.reload();
								} 
							}
						}
					</script>
				</ui:dataview>
        	</div>
        </div>
	</template:replace>
</template:include>	


