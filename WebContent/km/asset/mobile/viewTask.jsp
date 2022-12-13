<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="head">
		<mui:min-file name="mui-asset-view-task.css"/>
		<mui:min-file name="mui-imeeting.js"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/asset/mobile/resource/css/view.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/zone/mobile/resource/list.css"></link>
		<mui:min-file name="mui-zone-list.css"/>
		<mui:min-file name="mui-asset.js"/>
	    <mui:min-file name="index.css"/>
	    <style type="text/css"> 
	    .muiAssetCardList a{
	    background: #fff;
	    }
	    .muiCateItem{
	    background: #fff;
	    }
	    </style>
	</template:replace>
	<template:replace name="title">
		<c:if test="${not empty kmAssetApplyTaskForm.docSubject}">
			<c:out value="${ kmAssetApplyTaskForm.docSubject}"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="content">
	
		<div id="scrollView"  class="white"
			data-dojo-type="mui/view/DocScrollableView"
			data-dojo-mixins="mui/list/_ViewPushAppendMixin">
			
			<div class="muiImeetingInfoBanner">
				<dl class="txtInfoBar">
					<dt>
						<xform:text property="docSubject"></xform:text>
					</dt>
				</dl>
				<div class="figureBar">
					<%--主持人头像--%>
					<span class="figure">
						<img src="<person:headimageUrl contextPath="true" personId="${kmAssetApplyTaskForm.docCreatorId}" size="m" />" alt="" />
					</span> 
					<%--主持人--%>
					<span class="name">
						<xform:text property="docCreatorName"></xform:text>
					</span>
					<span class="tagBar figureTag" ><i class="mui mui-voice"></i></span>
				</div>
						<c:if test="${'1' eq kmAssetApplyTaskForm.fdStatus}">
			 			<div class="muiMeetingStatusTag muiMeetingHolding">
							<bean:message bundle="km-asset" key="enumeration_km_asset_apply_task_fd_status_1"/>
						</div>
			 			</c:if>
			 			<c:if test="${'2' eq kmAssetApplyTaskForm.fdStatus}">
			 			<div class="muiMeetingStatusTag muiMeetingHolding">
							<bean:message bundle="km-asset" key="enumeration_km_asset_apply_task_fd_status_2"/>
						</div>
			 			</c:if>
			 			<c:if test="${'3' eq kmAssetApplyTaskForm.fdStatus}">
			 			<div class="muiMeetingStatusTag muiMeetingHolding">
							<bean:message bundle="km-asset" key="enumeration_km_asset_apply_task_fd_status_3"/>
						</div>
			 			</c:if>
			 			<c:if test="${'4' eq kmAssetApplyTaskForm.fdStatus}">
			 			<div class="muiMeetingStatusTag muiMeetingHolding">
							<bean:message bundle="km-asset" key="enumeration_km_asset_apply_task_fd_status_4"/>
						</div>
			 			</c:if>
			 		
				<span class="tagBar rightTag" onclick="window.dialPhone('${mobileNo}');">
					<i class="mui mui-tel"></i>
				</span>
			</div>
				<div data-dojo-type="mui/fixed/Fixed" id="fixed">
					<div data-dojo-type="mui/fixed/FixedItem" class="ImeetingFixedItem">
						<%--切换页签--%>
						<div class="muiHeader">
							<div
								data-dojo-type="mui/nav/MobileCfgNavBar" 
								data-dojo-props="scrollDir:'',defaultUrl:'/km/asset/mobile/view_nav.jsp?fdStatus=${kmAssetApplyTaskForm.fdStatus }' ">
							</div>
						</div>
					</div>
				</div>
				
				<div id="taskView" data-dojo-type="dojox/mobile/View">
				<c:if test="${kmAssetApplyTaskForm.fdStatus ne '3' }">
					<div class="muiMeetingFeedbackHeader white">
					
						<bean:message bundle="km-asset" key="mobile.kmAssetApplyTask.criteria"/>
						
							<div data-dojo-type="km/asset/mobile/js/list/CriteriaButtonGroup"
								 data-dojo-props="icon:'mui mui-filter',label:'<bean:message bundle="km-asset"  key="mobile.kmAssetApplyTask.criteria"/>',align:'left'">
								 
								<div data-dojo-type="km/asset/mobile/js/list/CriteriaButton"
					    			 data-dojo-props="criteriaType:''">
					    			<bean:message bundle="km-asset"  key="mobile.kmAssetApplyTask.criteria.all"/>	 
					    		</div>
					    			 
					    		<div data-dojo-type="km/asset/mobile/js/list/CriteriaButton"
					    			 data-dojo-props="criteriaType:'my',fdAssignUser:'${kmAssetApplyTaskForm.fdAssignUser }',personnelIds:'${kmAssetApplyTaskForm.kmAssignPersonnelIds }',taskCreator:'${kmAssetApplyTaskForm.docCreatorId }'">
					    			<bean:message bundle="km-asset"  key="mobile.kmAssetApplyTask.criteria.my"/>	 
					    		</div>
					    			 
					    	</div>
					    	
					</div>
				</c:if>
							<ul 
					    		data-dojo-type="km/asset/mobile/js/list/FeedbackJsonStoreList"  class="muiAssetCardList muiList"
					    		data-dojo-mixins="km/asset/mobile/js/list/AssetCardItemListMixin"
					    		data-dojo-props="url:'/km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=manageList&fdTaskId=${kmAssetApplyTaskForm.fdId}&inventoryType=todoInventory',lazy:false">
							</ul>
				</div>
				<div id="taskEndView" data-dojo-type="dojox/mobile/View">
							<ul 
					    		data-dojo-type="km/asset/mobile/js/list/FeedbackJsonStoreList"  class="muiAssetCardList muiList"
					    		data-dojo-mixins="km/asset/mobile/js/list/AssetCardItemListMixin"
					    		data-dojo-props="url:'/km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=manageList&fdTaskId=${kmAssetApplyTaskForm.fdId}&inventoryType=hasBeenInventory',lazy:false">
							</ul>
				</div>
				<div id="profitView" data-dojo-type="dojox/mobile/View">
							<ul 
					    		data-dojo-type="km/asset/mobile/js/list/FeedbackJsonStoreList"  class="muiAssetCardList muiList"
					    		data-dojo-mixins="km/asset/mobile/js/list/AssetCardItemListMixin"
					    		data-dojo-props="url:'/km/asset/km_asset_apply_task_detail/kmAssetApplyTaskDetail.do?method=manageList&fdTaskId=${kmAssetApplyTaskForm.fdId}&inventoryType=Overage',lazy:false">
							</ul>
				</div>
				<div id="PersonView" data-dojo-type="dojox/mobile/View">
							<ul 
					    		data-dojo-type="km/asset/mobile/js/list/FeedbackJsonStoreList"  class="muiAssetCardList muiList"
					    		data-dojo-mixins="km/asset/mobile/js/list/AssetCardPersonnelListMixin"
					    		data-dojo-props="url:'/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=viewPersonnel&fdId=${kmAssetApplyTaskForm.fdId}',lazy:false">
							</ul>
				</div>
			
		</div>
	</template:replace>
</template:include>
<script>
	require(['dojo/topic',
	         'dojo/ready',
	         'dijit/registry',
	         'dojox/mobile/TransitionEvent',
	         'dojo/request',
	         'dojo/query',
	         'dojo/dom-construct',
	         'dojo/dom-style',
	         'dojo/dom-geometry',
	         'mui/util',
	         'mui/dialog/BarTip',
	         'mui/dialog/Tip'
	         ],function(topic,ready,registry,TransitionEvent,request,query,domConstruct,domStyle,domGeometry,util,BarTip,Tip){
		
		window.openLink = function(url){
			window.open(url,'_self');
		};
		
		
		//拨打主持人号码
		window.dialPhone=function(mobileNo){
			if(mobileNo){
				window.open('tel:'+mobileNo);
			}else{
				Tip.fail({
					text:'<bean:message bundle="km-asset"  key="mobile.kmAsset.phone.notnull"/>'
				});
			}
		};
	});
	$(document).ready(function(){
		var ul = $('ul[data-dojo-type="km/asset/mobile/resource/js/OverflowTabBar"]');
		if(ul.length&&ul.length>0){
			$('div[data-dojo-type="mui/panel/AccordionPanel"]').css('margin','0px');
		}
	});
</script>