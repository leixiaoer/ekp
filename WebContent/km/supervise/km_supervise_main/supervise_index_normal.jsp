<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" bodyClass="lui_list_content_body">
    <template:block name="head">
    	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
    </template:block>
	<template:replace name="body">
		<div class="lui_supervise_wrap lui_supervise_worker" id="lui_supervise_wrap">
		    <!-- 督办-员工布局-左 starts -->
		    <div class="lui_supervise_left">
		    	<div class="lui_supervise_left_wrap">
		        <!-- 督办-员工布局-左-上 starts -->
		        	<kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
		        	<div class="lui_supervise_leftT">
			        	<div class="lui_supervise_leftT_panel" onclick="addDoc()">
				            <div>
				              <p class="lui_supervise_leftT_panel_content">新建督办</p>
				            </div>
			          	</div>
		        	</div>
		        	</kmss:authShow>
		        <!-- 督办-员工布局-左-上 ends -->
		
		        <!-- 督办-员工布局-左-中 starts -->
		        <ui:dataview>
					<ui:source type="AjaxJson">
						{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getNormalPanel"}
					</ui:source>
					<ui:render type="Template">
						<c:import url="/km/supervise/km_supervise_main/import/normal_panel.jsp" charEncoding="UTF-8"></c:import>
					</ui:render>
					<script>
						var panelType = {
							fdType:"myCharge"
						}
						function loadData(type,node){
							panelType["fdType"] = type;
							var indexListFrame = document.getElementById("indexListFrame").getElementsByTagName("IFRAME")[0];
							var newSrc = "${LUI_ContextPath}/km/supervise/km_supervise_main/import/index_list_frame.jsp?fdType="+panelType["fdType"];
							indexListFrame.src = newSrc;
							var $n = $(node).find('.lui_slpi_tit').addClass('lui_text_primary');
							$(node).siblings().find('.lui_slpi_tit').removeClass('lui_text_primary');
						} 
					</script>
			    </ui:dataview>
		        <!-- 督办-员工布局-左-中 ends -->
		      </div>
		    </div>
		    <div class="lui_supervise_center">
				<div class="lui_sclp_wrap">
	       			<div>
						<ui:iframe id="indexListFrame" src="${LUI_ContextPath}/km/supervise/km_supervise_main/import/index_list_frame.jsp?fdType=myCharge"></ui:iframe>
					</div>
				</div>
			</div>
		</div>
		<script>
		seajs.use(['lui/jquery','lui/dialog'],function($,dialog){
			var cateId= '';
			//新建督办
	    	window.addDoc = function() {
	    		dialog.categoryForNewFile(
	    				'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
	    				'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}',false,null,null,cateId,null,null,true,null,{"fdType":"10"});
	    	}
		});
		</script>
	</template:replace>	
</template:include>